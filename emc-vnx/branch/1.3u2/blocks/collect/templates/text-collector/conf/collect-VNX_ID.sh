#!/bin/bash

# configuration
export NAS_DB=/nas
export CELERRA_BIN=/nas/bin
export EXECDIR="$(dirname "${0}")"
export SCRIPTNAME="$(basename "${0}")"

VNX_ID_SH="${SCRIPTNAME#*-}"
VNX_ID="${VNX_ID_SH%.sh}"

export INTERVAL="${1}"
export CLEANUP="$(( ${INTERVAL} * 2 ))"

export WORKDIR="${2}/${VNX_ID}"

mkdir -p "${WORKDIR}"

# cleanup and relaunch ourself asynchronously
if [ "${EXEC_MODE}" != "sync" ]
then
  # kill stalled processes
  find "${WORKDIR}" -name '.[0-9]*' -mmin "+${CLEANUP}" -printf '%f\n' \
    | sed 's/^.//' | xargs -I'{}' kill -TERM -'{}'

  # go async
  export EXEC_MODE="sync"
  exec setsid "${0}" "${@}"
else
  # skip the two first arguments (INTERVAL and WORKDIR)
  shift 2
fi

# install cleanup hook
export MARKER="${WORKDIR}/.${$}"
cleanup() {
  rm -f "${MARKER}"
  kill -TERM "-${$}"
}
trap cleanup EXIT
touch "${MARKER}"

# list movers
celerra_movers() {
#   "${CELERRA_BIN}/server_uptime" ALL | sed 's/\([^:]\) :.*/\1/'
#  "${CELERRA_BIN}/nas_server" -info -all |grep "name\|type" | sed '$!N;s/\n/ /' | grep nas | awk -F' ' '{print $3}'
  "${CELERRA_BIN}/nas_server" -info -all | awk 'BEGIN { RS="\n\n"; FS="\n"}  {if ($4 ~ /nas/){ split($2,a,"= "); print a[2]} }'
#  "${CELERRA_BIN}/nas_server" -info -all | awk -F'[ \t:=]+' '$1=="name" {name=$2} $1=="type" && $2=="nas" {print name}' 
}

# collect stats
celerra_stats() {
  local mover="${1}"
  local stat="${2}"
  local top="${3}"

  local prefix="${mover}@${stat}@${top:+"${top}@"}"
  local dest="${WORKDIR}/${prefix}$(date +%s).csv"

  # remove stalled files
  #find "${WORKDIR}" -name "${prefix}*" -mmin "+${CLEANUP}" | xargs rm -f

  # collect stats
  local extra_opts=();
  if [ -z "${top}" ]
  then
    extra_opts=( "-format" "csv" )
  else
    extra_opts=( "-format" "text" "-titles" "never" )
  fi
  perl "${EXECDIR}/server_stats" "${mover}" -monitor "${stat}" "${extra_opts[@]}" \
    -interval "$((${INTERVAL}*60))" -count 1 -terminationsummary no -type diff \
    -file "${dest}.tmp" > /dev/null 2>&1

  if [ -z "${top}" ]
  then
  # mark file as ready for collecting
     mv "${dest}.tmp" "${dest}"
  else
  # reformat topN files
     cat "${dest}.tmp" | perl "${EXECDIR}/parseUser.pl" "${stat}" > "${dest}"
     # rm -f "${dest}.tmp"
  fi
}

# collect stats for each movers
for mover in $(celerra_movers)
do
  for (( i=1 ; i <= "${#}" ; i++ ))
  do
    metric="${!i%/*}"
    top="${!i#*/}"
    [ "${!i}" = "${top}" ] && top=""
    celerra_stats "${mover}" "${metric}" ${top:+${top}} &
  done

 # celerra_stats "${mover}" "nfs.totalCalls" &
 # celerra_stats "${mover}" "cifs.client/top" &
 # celerra_stats "${mover}" "nfs.client/top" &

done

# wait for completion
wait


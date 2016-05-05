#!/bin/bash

# include build-ng-utils, borrowed from APG build system
export __BUILD_NG_ROOT="$(cd "$(dirname "${0}")"; pwd)"
source "${__BUILD_NG_ROOT}"/build-ng-utils || exit 1

WANT_JAVA_6
requires WORKSPACE JOB_NAME
export SP_HOME="$(cd "${__BUILD_NG_ROOT}/../.."; pwd)"

# remove previous build
rm -Rf pkg

# build SP or SPB
if [ -f "${WORKSPACE}/sp.properties" ]
then
  # build branches
  find "${WORKSPACE}/../branch" -mindepth 1 -maxdepth 1 | while read branch
  do
    "${JAVA_HOME}/bin/java" -D"solutionpack.builder.solutionpacks.root=${SP_HOME}" \
      -jar "${SP_HOME}/_tools/solutionpack-builder/build-solutionpack-cli.jar" "${branch}" "${JOB_NAME%-sp}"
  done
  # build trunk
  "${JAVA_HOME}/bin/java" -jar "${SP_HOME}/_tools/solutionpack-builder/build-solutionpack-cli.jar" "${WORKSPACE}" "${JOB_NAME%-sp}"
elif [ -f "${WORKSPACE}/spb.properties" ]
then
  # build branches
  find "${WORKSPACE}/../../../branch" -mindepth 3 -maxdepth 3 -name "$(basename "${WORKSPACE}")" | while read branch
  do
    "${JAVA_HOME}/bin/java" -D"solutionpack.builder.solutionpacks.root=${SP_HOME}" \
      -jar "${SP_HOME}/_tools/solutionpack-builder/build-solutionpack-cli.jar" "${branch}" "${JOB_NAME%-spb}"
  done
  # build trunk
  "${JAVA_HOME}/bin/java" -jar "${SP_HOME}/_tools/solutionpack-builder/build-solutionpack-cli.jar" "${WORKSPACE}" "${JOB_NAME%-spb}"
else
  exit 1
fi

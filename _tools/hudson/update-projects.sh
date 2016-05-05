#!/bin/bash

# include build-ng-utils, borrowed from APG build system
export __BUILD_NG_ROOT="$(cd "$(dirname "${0}")"; pwd)"
source "${__BUILD_NG_ROOT}"/build-ng-utils || exit 1

# xmlstar cli might be called xmlstarlet or xml
if [ -x /usr/bin/xml ]
then
  alias xmlstarlet=xml
fi

requires HUDSON_HOME
export SP_HOME="$(cd "${__BUILD_NG_ROOT}/../.."; pwd)"

# create project configuration (usage: createProjectConfig <project> <workspace>
createProjectConfig() {
  local project="${1}";
  local workspace="${2}";
  local type="${1##*-}"
  local name="${1%-*}"
  
  # create project if necessary
  mkdir -p "${HUDSON_HOME}/jobs/${project}" || die
  
  # create or refresh project configuration
  [ -f "${HUDSON_HOME}/jobs/${project}/config.xml" ] && mv "${HUDSON_HOME}/jobs/${project}/config.xml" "${HUDSON_HOME}/jobs/${project}/config.xml.bak"
  local SVN_URL="$(svn info "${workspace}" | grep '^URL: ' | awk '{print $2}')"
  cat > "${HUDSON_HOME}/jobs/${project}/config.xml" <<EOF
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <customWorkspace>${workspace}</customWorkspace>
  <builders>
    <hudson.tasks.Shell>
      <command>${__BUILD_NG_ROOT}/build-project.sh</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers class="vector">
    <hudson.tasks.ArtifactArchiver>
      <artifacts>pkg/*.pkg</artifacts>
      <latestOnly>false</latestOnly>
    </hudson.tasks.ArtifactArchiver>
    <hudson.tasks.Mailer>
      <recipients>apgdev@watch4net.com</recipients>
      <dontNotifyEveryUnstableBuild>false</dontNotifyEveryUnstableBuild>
      <sendToIndividuals>false</sendToIndividuals>
    </hudson.tasks.Mailer>
    <hudson.plugins.chucknorris.CordellWalkerRecorder>
        <factGenerator/>
    </hudson.plugins.chucknorris.CordellWalkerRecorder>
    <jenkins.plugins.publish__over__ssh.BapSshPublisherPlugin>
      <consolePrefix>SSH: </consolePrefix>
      <delegate>
        <publishers>
          <jenkins.plugins.publish__over__ssh.BapSshPublisher>
            <configName>w4n-pl-cvs01.int.watch4net.net</configName>
            <verbose>false</verbose>
            <transfers>
              <jenkins.plugins.publish__over__ssh.BapSshTransfer>
                <remoteDirectory></remoteDirectory>
                <sourceFiles>pkg/*.pkg</sourceFiles>
                <excludes></excludes>
                <removePrefix></removePrefix>
                <remoteDirectorySDF>false</remoteDirectorySDF>
                <flatten>false</flatten>
                <cleanRemote>false</cleanRemote>
                <noDefaultExcludes>false</noDefaultExcludes>
                <makeEmptyDirs>false</makeEmptyDirs>
                <patternSeparator>[, ]+</patternSeparator>
                <execCommand></execCommand>
                <execTimeout>120000</execTimeout>
                <usePty>false</usePty>
              </jenkins.plugins.publish__over__ssh.BapSshTransfer>
            </transfers>
            <useWorkspaceInPromotion>false</useWorkspaceInPromotion>
            <usePromotionTimestamp>false</usePromotionTimestamp>
          </jenkins.plugins.publish__over__ssh.BapSshPublisher>
        </publishers>
        <continueOnError>false</continueOnError>
        <failOnError>true</failOnError>
        <alwaysPublishFromMaster>false</alwaysPublishFromMaster>
        <masterNodeName>master</masterNodeName>
        <hostConfigurationAccess class="jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin" reference="../.."/>
      </delegate>
    </jenkins.plugins.publish__over__ssh.BapSshPublisherPlugin>
  </publishers>
  <buildWrappers>
    <org.jfrog.hudson.generic.ArtifactoryGenericConfigurator>
      <details>
        <artifactoryName>http://pld-imgapprd01.isus.emc.com:8081/artifactory</artifactoryName>
        <repositoryKey>watch4net-prerelease-local</repositoryKey>
        <snapshotsRepositoryKey>watch4net-prerelease-local</snapshotsRepositoryKey>
      </details>
      <deployPattern>pkg/*.pkg=&gt;com/watch4net/${type}/${name}</deployPattern>
      <resolvePattern></resolvePattern>
      <matrixParams></matrixParams>
      <deployBuildInfo>false</deployBuildInfo>
      <includeEnvVars>false</includeEnvVars>
      <discardOldBuilds>false</discardOldBuilds>
      <discardBuildArtifacts>false</discardBuildArtifacts>
    </org.jfrog.hudson.generic.ArtifactoryGenericConfigurator>
  </buildWrappers>
  <scm class="hudson.scm.SubversionSCM">
    <locations>
      <hudson.scm.SubversionSCM_-ModuleLocation>
        <remote>${SVN_URL}</remote>
        <local>.</local>
      </hudson.scm.SubversionSCM_-ModuleLocation>
    </locations>
    <useUpdate>true</useUpdate>
  </scm>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <triggers class="vector">
    <hudson.triggers.TimerTrigger>
      <spec>@midnight</spec>
    </hudson.triggers.TimerTrigger>
  </triggers>
  <logRotator>
    <daysToKeep>30</daysToKeep>
    <numToKeep>-1</numToKeep>
    <artifactDaysToKeep>-1</artifactDaysToKeep>
    <artifactNumToKeep>3</artifactNumToKeep>
  </logRotator>
  <keepDependencies>false</keepDependencies>
  <properties>
    <hudson.security.AuthorizationMatrixProperty>
      <permission>hudson.model.Item.Build:CN=Aventail-VPN-FullAccess,CN=Users,DC=int,DC=watch4net,DC=net</permission>
      <permission>hudson.model.Item.Read:CN=Aventail-VPN-FullAccess,CN=Users,DC=int,DC=watch4net,DC=net</permission>
    </hudson.security.AuthorizationMatrixProperty>
    <hudson.plugins.trac.TracProjectProperty>
      <tracWebsite>http://w4n-pl-cvs01.int.watch4net.net/trac/Watch4NetRP/</tracWebsite>
    </hudson.plugins.trac.TracProjectProperty>
  </properties>
  <description></description>
  <actions class="java.util.concurrent.CopyOnWriteArrayList"/>
</project>
EOF
  if [ -f "${HUDSON_HOME}/jobs/${project}/config.xml.bak" ]
  then
    # possibly updated project
    diff -bq "${HUDSON_HOME}/jobs/${project}/config.xml.bak" "${HUDSON_HOME}/jobs/${project}/config.xml" > /dev/null || echo -e "U\t${project}"
  else
    # new project
    echo -e "A\t${project}"
  fi
}

# find buildable SPs or SPBs
find "${SP_HOME}" -maxdepth 1 -mindepth 1 | while read spdir
do
  workspace="${spdir}/trunk"
  if [ -f "${workspace}/sp.properties" ]
  then
    createProjectConfig "$(basename "${spdir}")-sp" "${workspace}"
  elif [ -d "${workspace}/blocks" ]
  then
    find "${workspace}/blocks" -maxdepth 1 -mindepth 1 | while read spbdir
    do
      if [ -f "${spbdir}/spb.properties" ]
      then
        createProjectConfig "$(basename "${spbdir}")-spb" "${spbdir}"
      fi
    done
  fi
done

# detect deleted SPs or SPBs
find "${HUDSON_HOME}/jobs" -maxdepth 1 -mindepth 1 \( -name "*-sp" -o -name "*-spb" \) -printf "%f\n" | while read project
do
  workspace="$(xmlstarlet sel -t -v '/project/customWorkspace' "${HUDSON_HOME}/jobs/${project}/config.xml")"
  case "${project}" in
    *sp)
      [ -f "${workspace}/sp.properties" ] && continue
      ;;
    *spb)
      [ \! -f "${workspace}/../../sp.properties" -a -f "${workspace}/spb.properties" ] && continue
      ;;
    *)
      continue
  esac
  rm -Rf "${HUDSON_HOME}/jobs/${project}"

  # deleted project
  echo -e "D\t${project}"
done

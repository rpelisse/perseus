#!/bin/bash

readonly WORKSPACE=$(readlink -m  -n "${1}")
readonly M2_HOME=${M2_HOME:-"${HOME}/.m2"}

if [ -z "${WORKSPACE}" ]; then
  echo "Provided workspace to mount and build from"
  exit 1
fi

if [ ! -d "${JAVA_HOME}" ]; then
  echo Invalid JAVA_HOME: ${JAVA_HOME}
  exit 2
fi

if [ ! -d "${MAVEN_HOME}" ]; then
  echo Invalid MAVEN_HOME:${MAVEN_HOME}
  exit 3
fi

readonly DOCKER_IMAGE=${DOCKER_IMAGE:-'builder:latest'}

readonly DOCKER_JAVAZI_MOUNT=${DOCKER_JAVAZI_MOUNT:-'/usr/share/javazi-1.8/:/usr/share/javazi-1.8/:ro'}
readonly DOCKER_WORKSPACE_MOUNT="${WORKSPACE}:/workspace:rw"
readonly DOCKER_MAVEN_HOME_MOUNT="${MAVEN_HOME}:/maven:rw"
readonly DOCKER_MAVEN_M2_HOME_MOUNT="${M2_HOME}:/workspace/.m2:rw"
readonly DOCKER_JAVA_HOME_MOUNT="${JAVA_HOME}:/java:ro"

if [ "$(getenforce | grep -e Enforcing -c)" -gt 0 ]; then
  echo "SELinux is enabled - please disable it to allow docker to mount the workspace"
  exit 4
fi

docker run --user builder --workdir /workspace -ti \
          -e MAVEN_HOME='/maven' -e JAVA_HOME='/java' -e LOCAL_REPO_DIR="/workspace/.m2/repository" \
           -v "${DOCKER_WORKSPACE_MOUNT}" \
           -v "${DOCKER_MAVEN_HOME_MOUNT}" -v "${DOCKER_MAVEN_M2_HOME_MOUNT}" \
           -v "${DOCKER_JAVAZI_MOUNT}" -v "${DOCKER_JAVA_HOME_MOUNT}" "${DOCKER_IMAGE}" '/bin/bash'

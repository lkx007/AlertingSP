#!/bin/bash

exec java -jar "$(dirname "${0}")/lib/test-solutionpack-cli.jar" "${@}"

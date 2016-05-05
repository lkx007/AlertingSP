@echo off
rmdir /S /Q output > NUL
java -jar "lib\test-solutionpack-cli.jar" -i test -a answers.json %1 output

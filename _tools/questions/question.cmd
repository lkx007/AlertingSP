@echo off
rmdir /S /Q output > NUL
java -jar "lib\test-solutionpack-cli.jar" -i test -a answers.json -q %1\questions.txt -d %1\spb.properties %1 output

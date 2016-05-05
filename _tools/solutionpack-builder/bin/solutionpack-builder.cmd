@echo off

PUSHD "%~dp0\.."

java -cp "lib/*;." com.watch4net.apg.solutionpack.builder.SolutionPackBuilder %*

POPD
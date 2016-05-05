#!/bin/sh
rm -rf doc/
rdoc -o doc/api lib
rdoc -o doc/tests tests

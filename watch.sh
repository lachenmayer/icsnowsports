#!/usr/bin/env bash

SRC_DIR=.

sass --watch $SRC_DIR/css:$SRC_DIR/bin/css &
sass_pid=${!}
coffee -w -o $SRC_DIR/bin/js -c $SRC_DIR/js &
coffee_pid=${!}
wait $sass_pid $coffee_pid

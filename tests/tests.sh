#!/bin/bash

export FOO="world"

../entrypoint.sh . "input.txt" "output.txt.subst"
[[ "$(cat ./output.txt.subst)" = "Hello world" ]]

../entrypoint.sh . "" "" "*.txt" ".subst"
[[ "$(cat ./input.txt.subst)" = "Hello world" ]]

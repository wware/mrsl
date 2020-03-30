#!/bin/bash

X=$(swipl -s test.pl -g go -g halt)

test() {
    if [[ "$X" == *"$1"* ]]
    then
        echo good
    else
        echo bad
        exit 1
    fi
}

test joe
test ralf
exit 0

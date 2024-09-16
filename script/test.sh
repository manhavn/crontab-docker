#!/bin/bash
# shellcheck disable=SC2164
# shellcheck disable=SC2086
cd "$(dirname "$0")"

echo "test script ok $(date)" >> ${PWD}/test.log

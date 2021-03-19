#!/bin/sh

# basic validity checks
echo "checking JSON validity"
find . -not -path './node_modules/*' -not  -path './package*' -type f -name '*.json' | while read json; do echo $json ; jq --exit-status . $json > /dev/null || exit 1; done

# check for HTML entities
echo "checking for HTML entities"
grep -F '&#' *.json && exit 1

# key mismatch checks
echo "checking for mismatched keysets, i.e. missing or superfluous keys"
find . -type f  -iname "*.json" -not -path './src/*' | while read json; do echo $json ; python3 bin/check_expected_keys.py $json || exit 1; done

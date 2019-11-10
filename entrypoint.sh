#!/bin/bash

set -eo pipefail

if [ $(echo ${GITHUB_REPOSITORY} | wc -c) -eq 1 ] ; then
  echo -e "\033[31mRepository cannot be empty\033[0m"
  exit 1
fi

if [ $(echo ${INPUT_TITLE} | wc -c) -eq 1 ] ; then
  echo -e "\033[31mMilestone title cannot be empty\033[0m"
  exit 1
fi

if [ $(echo ${INPUT_DESCRIPTION} | wc -c) -gt 1 ] ; then
  jq -nc \
  --arg title ${INPUT_TITLE} \
  --arg description ${INPUT_DESCRIPTION} \
  '{
    "title": $title,
    "state": "open",
    "description": $description
  }' \
  > /workdir/payload.json
else
  jq -nc \
  --arg title ${INPUT_TITLE} \
  '{
    "title": $title,
    "state": "open"
  }' \
  > /workdir/payload.json
fi

cat /workdir/payload.json

curl --request POST \
  --url https://api.github.com/repos/${GITHUB_REPOSITORY}/milestones \
  --header "Authorization: Bearer ${GITHUB_TOKEN}" \
  --header 'Content-Type: application/json' \
  --data "$(cat /workdir/payload.json)" \
  -o /workdir/response.json \
  -s

sleep 3

cat /workdir/response.json

printf "::set-output name=number::%s" $(cat /workdir/response.json | jq .number)

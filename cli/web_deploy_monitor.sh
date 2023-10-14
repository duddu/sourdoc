#!/bin/bash

set -e
set -u
: "${COMMIT:?Variable not set or empty}"

VERSION_URL="https://sourdoc.duddu.dev/version.json"
SECONDS=0

echo "Follow the deploy pipeline at https://dashboard.render.com/static/srv-ckkutdqv7m0s73cts10g/events"

until [ "$(curl -s $VERSION_URL | jq -r '.build_number')" == "$COMMIT" ] && echo "🚀 Web deploy completed"
do
  if (( SECONDS > 300 ))
  then
     echo "🛑 Timeout reached, giving up"
     exit 1
  fi

  echo "Deploy not completed. Waiting..."
  sleep 10
done

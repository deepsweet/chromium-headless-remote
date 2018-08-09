#!/bin/sh

fc-cache -f -v

dumb-init -- /usr/bin/chromium-browser \
  --disable-background-networking \
  --disable-background-timer-throttling \
  --disable-default-apps \
  --disable-extensions \
  --disable-sync \
  --disable-translate \
  --headless \
  --hide-scrollbars \
  --ignore-certificate-errors \
  --ignore-certificate-errors-spki-list \
  --ignore-ssl-errors \
  --metrics-recording-only \
  --mute-audio \
  --no-sandbox \
  --no-first-run \
  --remote-debugging-address=0.0.0.0 \
  --remote-debugging-port=9222 \
  --safebrowsing-disable-auto-update \
  --use-gl=disabled \
  --user-data-dir=/tmp
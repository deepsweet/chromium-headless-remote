#!/bin/sh

if [ "$(ls -A /home/chromium/.fonts/)" ]; then
  fc-cache -f -v
fi

/usr/bin/chromium-browser \
  --disable-background-networking \
  --disable-background-timer-throttling \
  --disable-breakpad \
  --disable-client-side-phishing-detection \
  --disable-default-apps \
  --disable-dev-shm-usage \
  --disable-extensions \
  --disable-sync \
  --disable-translate \
  --disable-popup-blocking \
  --disable-prompt-on-repost \
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
  --user-data-dir=/home/chromium/

FROM alpine:3.7

RUN echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache apk-tools@edge chromium@edge nss@edge dumb-init && \
    addgroup -S chromium && \
    adduser -S -g chromium chromium && \
    chown -R chromium:chromium /home/chromium

USER chromium

EXPOSE 9222

ENTRYPOINT [ \
  "dumb-init", \
  "--", \
  "/usr/bin/chromium-browser", \
  "--disable-background-networking", \
  "--disable-background-timer-throttling", \
  "--disable-default-apps", \
  "--disable-extensions", \
  "--disable-sync", \
  "--disable-translate", \
  "--headless", \
  "--hide-scrollbars", \
  "--ignore-certificate-errors", \
  "--ignore-certificate-errors-spki-list", \
  "--ignore-ssl-errors", \
  "--metrics-recording-only", \
  "--mute-audio", \
  "--no-sandbox", \
  "--no-first-run", \
  "--remote-debugging-address=0.0.0.0", \
  "--remote-debugging-port=9222", \
  "--safebrowsing-disable-auto-update", \
  "--use-gl=disabled", \
  "--user-data-dir=/tmp" \
]

FROM alpine:3.7

RUN echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache apk-tools@edge chromium@edge~68 nss dumb-init fontconfig && \
    addgroup -S chromium && \
    adduser -S -g chromium chromium && \
    chown -R chromium:chromium /home/chromium && \
    mkdir /home/chromium/.fonts

VOLUME ["/home/chromium/.fonts"]

COPY entrypoint.sh /home/chromium

USER chromium

EXPOSE 9222

ENTRYPOINT ["dumb-init", "--", "/bin/sh", "/home/chromium/entrypoint.sh"]

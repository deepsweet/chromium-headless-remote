FROM ubuntu:bionic

ARG CHROMIUM_VERSION=80.0.3987.87\*

RUN apt-get update && \
    apt-get --no-install-recommends --yes install \
        chromium-browser=${CHROMIUM_VERSION} \
        dumb-init \
        fontconfig \
    && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd chromium && \
    useradd --create-home --gid chromium chromium && \
    chown --recursive chromium:chromium /home/chromium/

VOLUME ["/home/chromium/.fonts"]

COPY --chown=chromium:chromium entrypoint.sh /home/chromium/

USER chromium

EXPOSE 9222

ENTRYPOINT ["dumb-init", "--", "/bin/sh", "/home/chromium/entrypoint.sh"]

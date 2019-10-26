FROM ubuntu:bionic

# Run `make show-versions` to see latest versions
# Pick one that's higher than one below and paste here.
# Because actual package versions are long: '77.0.3865.90-0ubuntu0.18.04.1'
# we use wildcard.
# Match the value here to that assigned to TAGS variable inside Makefile.
# Commit both changes, run `make push-tags` and wait for Docker Hub to build new images.
ARG CHROMIUM_VERSION=77.0.3865.90\*

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

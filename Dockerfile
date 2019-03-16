FROM ubuntu:disco

RUN apt-get update && \
    apt-get --no-install-recommends --yes install chromium-browser=72\* dumb-init fontconfig && \
    groupadd chromium && \
    useradd --create-home --gid chromium chromium && \
    chown --recursive chromium:chromium /home/chromium/

VOLUME ["/home/chromium/.fonts"]

COPY --chown=chromium:chromium entrypoint.sh /home/chromium/

USER chromium

EXPOSE 9222

ENTRYPOINT ["dumb-init", "--", "/bin/sh", "/home/chromium/entrypoint.sh"]

FROM debian:bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl tar coreutils bash \
    libgomp1 libstdc++6 \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 10001 -s /bin/bash lm
USER lm
ENV HOME=/home/lm

RUN LMS_NO_MODIFY_PATH=1 sh -c "curl -fsSL https://lmstudio.ai/install.sh | sh"
ENV PATH="${HOME}/.lmstudio/bin:${PATH}"

COPY --chown=lm:lm entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 1234
ENTRYPOINT ["/entrypoint.sh"]

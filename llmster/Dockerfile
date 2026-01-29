FROM debian:bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl tar coreutils bash \
  && rm -rf /var/lib/apt/lists/*

# Non-root user; LM Studio installs under $HOME/.lmstudio/bin [page:1]
RUN useradd -m -u 10001 -s /bin/bash lm
USER lm
ENV HOME=/home/lm

# Install llmster/lms (headless installer) [page:1]
RUN LMS_NO_MODIFY_PATH=1 sh -c "curl -fsSL https://lmstudio.ai/install.sh | sh"

# Ensure lms is always available without profile edits [page:1]
ENV PATH="${HOME}/.lmstudio/bin:${PATH}"

COPY --chown=lm:lm entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 1234
ENTRYPOINT ["/entrypoint.sh"]

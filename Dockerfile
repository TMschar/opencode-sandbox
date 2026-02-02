FROM debian:stable-slim

WORKDIR /workspace

# Install curl and wget (not included in slim image)
RUN <<EOF
    apt update
    apt upgrade -y
    apt install -y curl wget ca-certificates unzip
EOF

RUN <<EOF
    curl -fsSL https://opencode.ai/install | bash
    curl -fsSL https://bun.com/install | bash
EOF

ENV OPENCODE_CONFIG_DIR=/workspace/opencode
ENV PATH="/root/.opencode/bin:${PATH}" 
ENV PATH="/root/.bun/bin:${PATH}"

COPY ./opencode /workspace/opencode

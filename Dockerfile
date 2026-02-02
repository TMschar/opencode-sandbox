FROM debian:stable-slim

WORKDIR /workspace

# Install curl and wget (not included in slim image)
RUN <<EOF
    apt update
    apt upgrade -y
    apt install -y curl wget ca-certificates unzip ripgrep
EOF

RUN <<EOF
    curl -fsSL https://opencode.ai/install | bash
    curl -fsSL https://bun.com/install | bash
    curl -o- https://fnm.vercel.app/install | bash
EOF

ENV OPENCODE_CONFIG_DIR=/workspace/opencode
ENV PATH="/root/.opencode/bin:${PATH}"
ENV PATH="/root/.bun/bin:${PATH}"

RUN <<EOF
    export PATH="/root/.fnm:\$PATH"
    eval "\$(fnm env --shell bash)"
    fnm install 24
    fnm use 24
    corepack enable pnpm

    # Add fnm setup to .bashrc for persistence
    echo 'export PATH="$HOME/.fnm:$PATH"' >> /root/.bashrc
    echo 'eval "$(fnm env --shell bash)"' >> /root/.bashrc
EOF

COPY ./secrets/mcp-auth.json /root/.local/share/opencode/mcp-auth.json

COPY ./opencode /workspace/opencode

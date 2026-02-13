FROM debian:stable-slim

WORKDIR /workspace

ENV HOME=/root

RUN <<EOF
    apt update
    apt upgrade -y
    apt install -y curl wget ca-certificates unzip ripgrep fd-find git zstd python3-pip
EOF

ENV OPENCODE_CONFIG_DIR=/workspace/opencode
ENV PATH="/root/.opencode/bin:/root/.bun/bin:/root/.local/share/fnm:/usr/local/bin:${PATH}"

RUN <<EOF
    curl -fsSL https://opencode.ai/install | bash
    curl -fsSL https://bun.com/install | bash
    curl -fsSL https://fnm.vercel.app/install | bash
    pip3 install apprise

    # Remove the auto-generated fnm config from .bashrc (it uses 'fnm env' without --shell)
    sed -i '/# fnm/,/fi/d' /root/.bashrc
    
    echo '' >> /root/.bashrc
    echo '# fnm configuration' >> /root/.bashrc
    echo 'export PATH="/root/.local/share/fnm:$PATH"' >> /root/.bashrc
    echo 'eval "$(fnm env --shell bash)"' >> /root/.bashrc
    
    ln -sf /root/.local/share/fnm/fnm /usr/local/bin/fnm
    
    export PATH="/root/.local/share/fnm:$PATH"
    eval "$(fnm env --shell bash)"
    
    fnm install 24
    fnm use 24
    fnm default 24
    
    corepack enable pnpm
    
    NODE_PATH=$(which node)
    NPM_PATH=$(which npm)
    NPX_PATH=$(which npx)
    PNPM_PATH=$(which pnpm 2>/dev/null || echo "")
    
    ln -sf "$NODE_PATH" /usr/local/bin/node
    ln -sf "$NPM_PATH" /usr/local/bin/npm
    ln -sf "$NPX_PATH" /usr/local/bin/npx
    [ -n "$PNPM_PATH" ] && ln -sf "$PNPM_PATH" /usr/local/bin/pnpm
    
    node --version
    npm --version
    npx --version
    fnm --version
EOF

COPY ./opencode /workspace/opencode
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /workspace/project

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

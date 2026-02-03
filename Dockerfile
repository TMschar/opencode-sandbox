FROM debian:stable-slim

WORKDIR /workspace

ENV HOME=/root

RUN <<EOF
    apt update
    apt upgrade -y
    apt install -y curl wget ca-certificates unzip ripgrep fd-find git
EOF

ENV OPENCODE_CONFIG_DIR=/workspace/opencode
ENV PATH="/root/.opencode/bin:/root/.bun/bin:/root/.local/share/fnm:/usr/local/bin:${PATH}"

RUN <<EOF
    curl -fsSL https://opencode.ai/install | bash
    curl -fsSL https://bun.com/install | bash
    
    # Install fnm
    curl -fsSL https://fnm.vercel.app/install | bash
    
    # Remove the auto-generated fnm config from .bashrc (it uses 'fnm env' without --shell)
    sed -i '/# fnm/,/fi/d' /root/.bashrc
    
    # Add proper fnm config with explicit shell
    echo '' >> /root/.bashrc
    echo '# fnm configuration' >> /root/.bashrc
    echo 'export PATH="/root/.local/share/fnm:$PATH"' >> /root/.bashrc
    echo 'eval "$(fnm env --shell bash)"' >> /root/.bashrc
    
    # Create symlink for fnm
    ln -sf /root/.local/share/fnm/fnm /usr/local/bin/fnm
    
    # Initialize fnm for this build session
    export PATH="/root/.local/share/fnm:$PATH"
    eval "$(fnm env --shell bash)"
    
    # Install and use Node 24
    fnm install 24
    fnm use 24
    fnm default 24
    
    # Enable corepack
    corepack enable pnpm
    
    # Get the Node binary path and create symlinks
    NODE_PATH=$(which node)
    NPM_PATH=$(which npm)
    PNPM_PATH=$(which pnpm 2>/dev/null || echo "")
    
    # Create symlinks for node tools in /usr/local/bin so they're always available
    ln -sf "$NODE_PATH" /usr/local/bin/node
    ln -sf "$NPM_PATH" /usr/local/bin/npm
    [ -n "$PNPM_PATH" ] && ln -sf "$PNPM_PATH" /usr/local/bin/pnpm
    
    # Verify
    node --version
    npm --version
    fnm --version
EOF

COPY ./secrets/mcp-auth.json /root/.local/share/opencode/mcp-auth.json

COPY ./opencode /workspace/opencode

WORKDIR /workspace/project

CMD ["bash"]

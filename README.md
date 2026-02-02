# OpenCode Sandbox

A Docker-based sandbox environment for running [OpenCode](https://opencode.ai).

## Prerequisites

- Docker installed and running

## Setup

Build the Docker image:

```bash
docker build -t opencode-sandbox .
```

## Add to PATH (optional)

To use `oc` from anywhere, add the `bin` directory to your PATH:

```bash
# Add to ~/.bashrc or ~/.zshrc
export PATH="/path/to/opencode-sb/bin:$PATH"
```

Then reload your shell or run `source ~/.bashrc` (or `~/.zshrc`, or `~/.fishorwhatever`).

## Usage

Start a new sandbox container:

```bash
oc <name>
```

Mount your current directory to work on local files:

```bash
oc <name> --mount
```

### Examples

```bash
oc my-project           # Start container named 'opencode-my-project'
oc feature-auth --mount # Start with current directory mounted to /workspace/project
```

### Examples

```bash
./bin/oc my-project           # Start container named 'opencode-my-project'
./bin/oc feature-auth --mount # Start with current directory mounted to /workspace/project
```

### Notes

- If a container with the same name exists, it will re-attach to it
- Containers persist after exit; run `docker container prune` to clean up

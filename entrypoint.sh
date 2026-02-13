#!/bin/bash

# Start Ollama server in the background (if installed)
if command -v ollama &>/dev/null; then
    echo "Starting Ollama server..."
    ollama serve &
    # Wait a moment for the server to start
    sleep 2
fi

if [ $# -gt 0 ]; then
    echo "Executing: $@"
    "$@"
    exit_code=$?
    echo "Command completed with exit code $exit_code"

    if command -v apprise &>/dev/null; then
        apprise -b "Opencode task completed with exit code $exit_code" "$APPRISE_URL"
    else
        echo "⚠️ Warning: Apprise not installed - notifications skipped"
    fi
    exec sleep infinity
else
    exec bash
fi

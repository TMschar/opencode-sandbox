#!/bin/bash

# Start Ollama server in the background (if installed)
if command -v ollama &>/dev/null; then
    echo "Starting Ollama server..."
    ollama serve &
    # Wait a moment for the server to start
    sleep 2
fi

# Execute the command passed to the container (or bash by default)
exec "${@:-bash}"

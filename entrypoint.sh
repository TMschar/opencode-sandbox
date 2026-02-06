#!/bin/bash

# Start Ollama server in the background
ollama serve &

# Wait a moment for the server to start
sleep 2

# Execute the command passed to the container (or bash by default)
exec "${@:-bash}"

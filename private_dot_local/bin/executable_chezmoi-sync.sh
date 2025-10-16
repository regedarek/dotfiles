#!/bin/bash

# Chezmoi auto-sync script
# This script commits local changes, pushes them, pulls changes from remote, and applies them

# Set PATH to include Homebrew
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# Log file location
LOG_FILE="$HOME/.local/share/chezmoi/sync.log"
mkdir -p "$(dirname "$LOG_FILE")"

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "Starting chezmoi bidirectional sync..."

# Get chezmoi source directory
SOURCE_DIR=$(chezmoi source-path)

# Change to source directory
cd "$SOURCE_DIR" || exit 1

# Check if there are any changes to commit
if [[ -n $(git status --porcelain) ]]; then
    log "Local changes detected, committing..."
    
    # Add all changes
    git add -A >> "$LOG_FILE" 2>&1
    
    # Commit with timestamp
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    if git commit -m "Auto-sync: $TIMESTAMP" >> "$LOG_FILE" 2>&1; then
        log "Changes committed successfully"
        
        # Push to remote
        if git push >> "$LOG_FILE" 2>&1; then
            log "Changes pushed to remote successfully"
        else
            log "ERROR: Failed to push changes to remote"
        fi
    else
        log "Nothing to commit or commit failed"
    fi
else
    log "No local changes to commit"
fi

# Pull from remote and apply changes (non-interactive mode)
log "Pulling from remote and applying changes..."
if chezmoi update --no-tty -v >> "$LOG_FILE" 2>&1; then
    log "Chezmoi sync completed successfully"
else
    log "ERROR: Chezmoi sync failed with exit code $?"
fi

log "---"

# Zed Configuration Guide

## 🔄 Managing Settings with Chezmoi

### Quick Update Workflow

When you modify Zed settings (keymap, settings.json, etc.):

```bash
# 1. Backup (optional)
cp ~/.config/zed/keymap.json ~/.config/zed/keymap.json.backup

# 2. Add to chezmoi
chezmoi add ~/.config/zed/keymap.json

# 3. Commit and push
cd $(chezmoi source-path)
git add -A
git commit -m "Update Zed config: describe your changes"
git push
```

### One-Line Update

```bash
chezmoi add ~/.config/zed/keymap.json && cd $(chezmoi source-path) && git add -A && git commit -m "Update Zed config" && git push
```

### Check Status

```bash
chezmoi status  # See modified files
cd $(chezmoi source-path) && git diff  # Review changes
```

### macOS Launch Agent (Auto-sync)

Automatically sync dotfiles with chezmoi every hour using a Launch Agent.

#### Create the sync script

`~/bin/chezmoi-auto-sync.sh`:
```bash
#!/bin/bash
# Auto-sync dotfiles with chezmoi

# Pull latest changes from remote
cd $(chezmoi source-path)
git pull origin main

# Apply changes
chezmoi apply

# Log the sync
echo "$(date): Chezmoi auto-sync completed" >> ~/Library/Logs/chezmoi-sync.log
```

Make executable: `chmod +x ~/bin/chezmoi-auto-sync.sh`

#### Create Launch Agent

`~/Library/LaunchAgents/com.user.chezmoi.plist`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.chezmoi</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>-c</string>
        <string>~/bin/chezmoi-auto-sync.sh</string>
    </array>
    <key>StartInterval</key>
    <integer>3600</integer>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
```

#### Load the Launch Agent

```bash
# Load and start
launchctl load ~/Library/LaunchAgents/com.user.chezmoi.plist

# Unload (to stop)
launchctl unload ~/Library/LaunchAgents/com.user.chezmoi.plist

# Check status
launchctl list | grep chezmoi

# View sync log
tail -f ~/Library/Logs/chezmoi-sync.log
```

### Restore on New Machine

```bash
chezmoi init https://github.com/regedarek/dotfiles.git
chezmoi apply
```

---

## 📋 View Zed Logs

### Real-time Monitoring

```bash
# Follow logs in real-time
tail -f ~/Library/Logs/Zed/Zed.log

# Filter for errors only
tail -f ~/Library/Logs/Zed/Zed.log | grep -i error

# Filter for agent activity
tail -f ~/Library/Logs/Zed/Zed.log | grep -i agent
```

### View Recent Logs

```bash
# Last 100 lines
tail -100 ~/Library/Logs/Zed/Zed.log

# Last 100 lines with errors
tail -100 ~/Library/Logs/Zed/Zed.log | grep ERROR

# Open in editor
zed ~/Library/Logs/Zed/Zed.log
```

---

## ⌨️ Current Keybindings

- `ctrl-l` → Toggle AI agent panel
- `ctrl-h` → Toggle project panel (files)
- `ctrl-g` → Toggle git panel
- `ctrl-p` → Toggle project panel (alternative)
- `ctrl-t` → Toggle terminal panel
- `ctrl-a` → Toggle right dock

---

## 🔧 Agent Configuration

Location: `~/.config/zed/settings.json`

```json
{
  "agent": {
    "default_model": {
      "provider": "copilot_chat",
      "model": "claude-sonnet"
    },
    "always_allow_tool_actions": true
  }
}
```

### Reset Agent Threads

If agent stops responding or behaves incorrectly:

```bash
# 1. Quit Zed completely
# Press Cmd+Q or: killall Zed

# 2. Delete corrupted conversation history
rm ~/Library/Application\ Support/Zed/threads/threads.db

# 3. Restart Zed
open -a Zed
```

### Quick Reset Script

Save as `~/bin/reset-zed-agent`:

```bash
#!/bin/bash
killall Zed 2>/dev/null
rm ~/Library/Application\ Support/Zed/threads/threads.db
echo "✅ Agent threads reset. Restart Zed."
```

Make executable: `chmod +x ~/bin/reset-zed-agent`

---

## 📁 Important Paths

```
~/.config/zed/settings.json                              # Settings
~/.config/zed/keymap.json                                # Keybindings
~/Library/Logs/Zed/Zed.log                              # Debug logs
~/Library/Application Support/Zed/threads/threads.db     # Agent history
```

---

## 📚 Resources

- Zed Docs: https://zed.dev/docs
- Dotfiles: https://github.com/regedarek/dotfiles
- Chezmoi: https://www.chezmoi.io
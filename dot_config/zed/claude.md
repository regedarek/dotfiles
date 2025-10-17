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

### macOS Launcher Setup

Set up Zed as the default editor for chezmoi:

```bash
# Add to your shell config (~/.zshrc or ~/.bashrc)
export EDITOR="zed --wait"

# Or set chezmoi config
chezmoi edit-config
# Add: edit.command = "zed"
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
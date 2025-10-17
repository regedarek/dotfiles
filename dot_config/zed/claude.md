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

### Restore on New Machine

```bash
chezmoi init https://github.com/regedarek/dotfiles.git
chezmoi apply
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

### Troubleshooting

If agent stops responding:

```bash
# Delete corrupted conversation history
rm ~/Library/Application\ Support/Zed/threads/threads.db

# Restart Zed (Cmd+Q, then reopen)
```

### Check Logs

```bash
tail -100 ~/Library/Logs/Zed/Zed.log | grep -i error
```

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
# Claude AI Agent in Zed - Complete Guide

**Last Updated:** October 16, 2025 - 17:01  
**Status:** ✅ FIXED - Root cause identified and resolved

---

## 🔍 ROOT CAUSE ANALYSIS (SOLVED!)

### The Problem
The 400 Bad Request errors were caused by **corrupted conversation state** in the SQLite database, not authentication or model name issues.

### Error Details
```
ERROR: messages.10.content.0: unexpected `tool_use_id` found in `tool_result` blocks: toolu_01HN9xhebKhu4LQkyWsyzW7C. 
Each `tool_result` block must have a corresponding `tool_use` block in the previous message.
```

### Why It Happened
1. An initial tool execution failed
2. The conversation history corrupted in `threads.db`
3. Every subsequent request sent orphaned tool results
4. API rejected them with 400 errors
5. The cycle repeated endlessly

---

## ✅ THE FIX (PERMANENT SOLUTION)

### Step 1: Delete Corrupted Conversation History

```bash
# Stop Zed first (Cmd+Q)

# Delete the corrupted threads database
rm ~/Library/Application\ Support/Zed/threads/threads.db

# Restart Zed
```

### Step 2: Restart Zed
- Quit Zed completely: `Cmd+Q`
- Reopen Zed
- Try the agent - it should work now!

### Why This Works
- `threads.db` stores all agent conversation history
- Corrupted entries cause malformed API requests
- Deleting it resets conversation state
- Zed recreates it fresh on next start
- New conversations start clean

---

## 📋 Current Configuration (CORRECT)

### Settings Location
`~/.config/zed/settings.json`

### ✅ Correct Agent Configuration
```json
{
  "agent": {
    "default_model": {
      "provider": "copilot_chat",
      "model": "claude-sonnet"
    },
    "always_allow_tool_actions": true,
    "model_parameters": []
  }
}
```

**Note:** Model name is `claude-sonnet` (not `claude-sonnet-4.5`)

### Available Models for copilot_chat
- ✅ `claude-sonnet` - Recommended
- ✅ `gpt-4o`
- ✅ `gpt-4o-mini`
- ✅ `o1-preview`
- ✅ `o1-mini`

---

## 🔧 Troubleshooting Steps (For Future)

### If You Get 400 Errors Again

**Step 1: Check the error message in logs**
```bash
tail -100 ~/Library/Logs/Zed/Zed.log | grep "400 Bad Request"
```

**Step 2: If it mentions `tool_use_id` mismatch:**
```bash
# Delete corrupted database
rm ~/Library/Application\ Support/Zed/threads/threads.db

# Quit and restart Zed
```

**Step 3: If it's a different error:**
- Check your Copilot authentication: `Cmd+Shift+P` → `copilot: sign in`
- Verify model name is correct in settings
- Check GitHub Copilot subscription: https://github.com/settings/copilot

### Check Agent Status
```bash
# View recent agent activity
tail -100 ~/Library/Logs/Zed/Zed.log | grep -i agent

# Check for errors
tail -100 ~/Library/Logs/Zed/Zed.log | grep -i error

# Look for 400 errors specifically
tail -200 ~/Library/Logs/Zed/Zed.log | grep "400 Bad Request"
```

---

## 📊 Understanding the Logs

### Successful Agent Call
```
INFO [agent2::agent] Received prompt request for session: [uuid]
INFO [agent2::thread] Thread::send called with model: Claude Sonnet
```

### Failed Agent Call (tool_use_id issue)
```
ERROR [agent2::thread] Turn execution failed: Failed to connect to API: 400 Bad Request 
{"error":{"message":"unexpected `tool_use_id` found in `tool_result` blocks..."}}
```

### User Cancellation (Normal, ignore)
```
INFO [agent2::agent] Cancelling on session: [uuid]
```

### Harmless Warnings (Ignore)
```
ERROR [settings_ui] No directory name found for settings file
WARN [language] unrecognized capture name in Ruby outline TreeSitter query
```

---

## 🎯 Quick Diagnosis Script

Run this to diagnose agent issues:

```bash
#!/bin/bash
echo "=== ZED AGENT DIAGNOSTICS ==="
echo ""

echo "1. Check for 400 Bad Request errors:"
tail -100 ~/Library/Logs/Zed/Zed.log | grep "400 Bad Request" && echo "❌ Found errors" || echo "✅ No 400 errors"
echo ""

echo "2. Check for tool_use_id issues:"
tail -200 ~/Library/Logs/Zed/Zed.log | grep "tool_use_id" && echo "⚠️ Found tool_use_id issues" || echo "✅ No tool_use_id issues"
echo ""

echo "3. Current Agent Config:"
cat ~/.config/zed/settings.json | jq '.agent'
echo ""

echo "4. Recent agent activity:"
tail -50 ~/Library/Logs/Zed/Zed.log | grep agent | tail -5
echo ""

echo "=== END DIAGNOSTICS ==="
```

---

## 💡 Key Files and Locations

### Important Paths
```
~/.config/zed/settings.json              # Agent configuration
~/Library/Logs/Zed/Zed.log              # Debug logs
~/Library/Application Support/Zed/threads/threads.db  # Conversation history (can be deleted)
```

### Backups Created
```bash
# Threads database backup
~/Library/Application Support/Zed/threads/threads.db.backup-YYYYMMDD-HHMMSS

# Settings backup
~/.config/zed/settings.json.backup-YYYYMMDD-HHMMSS
```

---

## 🚀 Best Practices

### To Prevent Issues

1. **Keep conversation history fresh** - Delete old threads.db if agent gets slow
2. **Restart Zed after major changes** - Updates, provider changes, etc.
3. **Monitor logs** - Check logs when issues occur
4. **Have backup provider** - Consider having Anthropic API key ready
5. **Update Zed regularly** - Fixes and improvements are released frequently

### If You Have Critical Work

Switch to Anthropic as backup:

```json
{
  "agent": {
    "default_model": {
      "provider": "anthropic",
      "model": "claude-sonnet-4-5"
    }
  }
}
```

Then add your Anthropic API key in Zed settings.

---

## 📝 GitHub Token Scopes

### Current Token Scopes (For MCP Server)
- ✅ `repo` - Repository operations
- ✅ `workflow` - Workflow management
- ✅ `write:packages` - Package management
- ✅ `delete:packages` - Package deletion
- ✅ `project` - Project management

### Important Notes
- ❌ Don't modify the `copilot` scope - not used by MCP
- ✅ Your token scopes are correct!
- The GitHub token is ONLY for MCP server, NOT Copilot auth

---

## 🔄 Quick Reference Commands

### Emergency Fixes

```bash
# Fix 1: Reset conversation history
rm ~/Library/Application\ Support/Zed/threads/threads.db

# Fix 2: Verify settings
cat ~/.config/zed/settings.json | jq '.agent'

# Fix 3: Check recent errors
tail -100 ~/Library/Logs/Zed/Zed.log | grep ERROR

# Fix 4: Re-authenticate Copilot
# In Zed: Cmd+Shift+P → "copilot: sign in"
```

---

## 🐛 Known Issues and Fixes

| Issue | Cause | Fix |
|-------|-------|-----|
| 400 Bad Request with tool_use_id | Corrupted threads.db | Delete `threads.db`, restart Zed |
| 400 Bad Request (other) | Copilot auth expired | Re-authenticate: Cmd+Shift+P → copilot: sign in |
| Agent won't respond | Model name incorrect | Change to `claude-sonnet` |
| Settings UI errors | Harmless | Ignore |
| Ruby outline warnings | Language server issue | Ignore |

---

## 📚 Additional Resources

### Zed Documentation
- Agent/Assistant: https://zed.dev/docs/assistant
- Copilot: https://zed.dev/docs/assistant#github-copilot
- Settings: https://zed.dev/docs/configuring-zed

### API Documentation
- Anthropic: https://docs.anthropic.com/
- GitHub Copilot: https://docs.github.com/copilot

### Get Help
- Zed Discord: https://discord.gg/zed
- GitHub Issues: https://github.com/zed-industries/zed/issues

---

## ✨ Success Indicators

Your agent is working correctly when:
- ✅ No ERROR messages in logs
- ✅ Agent responds to requests within 5-10 seconds
- ✅ Tool calls execute successfully
- ✅ No 400 Bad Request errors
- ✅ Session IDs increment normally (different UUIDs each time)

---

## 🔐 Security Notes

- Your GitHub token is in plaintext in `settings.json`
- Consider using environment variables:
  ```json
  {
    "context_servers": {
      "mcp-server-github": {
        "settings": {
          "github_personal_access_token": "${GITHUB_TOKEN}"
        }
      }
    }
  }
  ```
- Regenerate token if exposed
- Use minimal required scopes (you're already doing this!)

---

## 📝 Changelog

### October 16, 2025 - 17:01
- **FIXED:** Root cause identified as corrupted `threads.db`
- **Added:** Permanent fix procedure
- **Updated:** Model name to `claude-sonnet`
- **Created:** Comprehensive troubleshooting guide

### October 16, 2025 - 16:50
- Initial diagnostics recorded
- Identified tool_use_id mismatch errors
- Started investigation

---

## 🔄 Managing Zed Settings with Chezmoi

### Overview
Your Zed configuration is managed with **chezmoi** and backed up to your dotfiles repository at `github.com:regedarek/dotfiles.git`.

### Quick Update Workflow

When you modify Zed settings (keymap, settings.json, etc.):

```bash
# 1. Backup the current file (optional but recommended)
cp ~/.config/zed/keymap.json ~/.config/zed/keymap.json.backup

# 2. Add the updated file to chezmoi
chezmoi add ~/.config/zed/keymap.json

# 3. Navigate to chezmoi source directory and commit
cd $(chezmoi source-path)
git status  # Review changes

# 4. View the diff to confirm changes
git diff dot_config/zed/private_keymap.json

# 5. Commit with descriptive message
git add dot_config/zed/private_keymap.json
git commit -m "Update Zed keymap: add ctrl-h/ctrl-l navigation"

# 6. Push to dotfiles repo
git push
```

### Tracked Zed Files

Currently tracked in chezmoi:
- `~/.config/zed/keymap.json` → `dot_config/zed/private_keymap.json`
- `~/.config/zed/settings.json` → `dot_config/zed/private_settings.json` (if tracked)

### One-Line Update Command

```bash
# Quick update: backup, add, commit, and push
chezmoi add ~/.config/zed/keymap.json && \
cd $(chezmoi source-path) && \
git add -A && \
git commit -m "Update Zed config" && \
git push
```

### Restoring Settings on a New Machine

```bash
# Initialize chezmoi with your dotfiles
chezmoi init https://github.com/regedarek/dotfiles.git

# Apply the dotfiles
chezmoi apply

# Your Zed settings are now restored!
```

### Adding New Zed Files to Chezmoi

To track a new Zed configuration file:

```bash
# Example: tracking settings.json
chezmoi add ~/.config/zed/settings.json

# Commit and push
cd $(chezmoi source-path)
git add dot_config/zed/private_settings.json
git commit -m "Add Zed settings.json to dotfiles"
git push
```

### Check Chezmoi Status

```bash
# See which Zed files have been modified
chezmoi status

# Example output:
# MM .config/zed/keymap.json  (Modified, needs to be added)
```

### Important Notes

- **Private files**: Chezmoi uses `private_` prefix for sensitive files
- **Always backup**: Create `.backup` files before major changes
- **Commit messages**: Use descriptive messages for easy tracking
- **Review diffs**: Always check `git diff` before committing

### Current Keybindings (Latest)

Tracked in dotfiles:
- `ctrl-l` → Toggle AI agent panel focus
- `ctrl-h` → Toggle project panel (files) focus
- `ctrl-g` → Toggle git panel focus
- `ctrl-p` → Toggle project panel (alternative)
- `ctrl-t` → Toggle terminal panel focus

---

**Last Fix Applied:** Delete corrupted `threads.db` and restart Zed  
**Status:** ✅ Agent should be working now!

Update this file when you discover new issues or solutions!

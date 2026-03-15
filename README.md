# pokalai — LinkedIn Content Assistant *(puh-KAH-leh)*

A portable LinkedIn posting assistant driven entirely by natural language commands to Claude. No scripts. No dashboards. Just Claude reading its instructions and acting.

## What this is

You tell Claude what you're interested in. Claude finds the best sources, monitors them daily, drafts posts grounded in real content, and publishes directly to LinkedIn via browser automation. Your post history is tracked so it never repeats an angle.

Everything lives in plain markdown files you can read, edit, and version control.

---

## Requirements

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed (`claude` command available)
- Playwright MCP server enabled in Claude Code settings (for LinkedIn browser automation)
- A LinkedIn account

### Enable Playwright MCP (one-time)

In your Claude Code settings (`~/.claude/settings.json`), add:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

---

## Setup (3 steps)

**1. Clone the repo**
```bash
git clone https://github.com/yourusername/pokalai.git
cd pokalai
```

**2. Open a terminal in the repo directory**
```bash
cd /path/to/pokalai
```

**3. Run the initialize command with your topics**
```bash
claude -p "initialize pokalai with interests about ITSM, ITIL and service management"
```

Replace the topics with whatever you actually care about. Claude will:
- Save your topics
- Find relevant sources (subreddits, blogs, newsletters, LinkedIn voices)
- Run an initial digest so you're ready to post immediately
- Print a summary of what it found

---

## Daily use

**Post to LinkedIn:**
```bash
claude -p "post to linkedin"
```
Claude drafts a post based on today's digest, checks your post history to avoid repeating angles, and publishes it. You'll be prompted to log in if the LinkedIn session has expired.

**Refresh your digest manually:**
```bash
claude -p "daily refresh"
```

**See what you posted this week:**
```bash
claude -p "what did we post this week"
```

**Find new sources:**
```bash
claude -p "gather more sources"
```

---

## Customizing your style

Edit `config/style-guide.md` directly, or tell Claude:
```bash
claude -p "update my style — I want shorter posts, max 100 words, no questions at the end"
```

---

## Managing topics

```bash
claude -p "add topic IT asset management"
claude -p "remove topic ITIL"
```

---

## Optional: Daily automation via Apple Shortcuts

To automatically refresh your digest every morning without opening a terminal:

1. Open **Shortcuts** on macOS
2. Create a new shortcut → Add action → **Run Shell Script**
3. Paste this script (replace the path):
   ```bash
   cd /path/to/pokalai && claude -p "daily refresh" --allowedTools "Read,Write,WebFetch,WebSearch"
   ```
4. Set a daily schedule in the shortcut's settings

For fully automated daily posting, change `daily refresh` to `post to linkedin` — but review `state/posts.md` occasionally to make sure the angles stay fresh.

---

## File reference

**Tracked by git** (the agent, safe to share):

| File | What it is |
|------|-----------|
| `CLAUDE.md` | Claude's standing instructions (read automatically every session) |
| `README.md` | This file |

**Gitignored** (your personal instance, stays local):

| File | What it is |
|------|-----------|
| `instance/config/topics.md` | Your interests |
| `instance/config/style-guide.md` | Tone and format preferences |
| `instance/config/sources.md` | Sources Claude monitors |
| `instance/state/daily-digest.md` | Today's findings |
| `instance/state/posts.md` | Full post history |
| `instance/state/weekly-log.md` | Action log |

The `instance/` folder is created by the `initialize` command and is listed in `.gitignore` — your topics, sources, and post history never get committed. All files are plain markdown and can be read and edited directly.

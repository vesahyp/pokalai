# pokalai — LinkedIn Content Assistant

_(puh-KAH-leh)_

A LinkedIn posting assistant driven by natural language commands to Claude.

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

### Configuring permissions

`.claude/settings.json` is committed to this repo and pre-configures Claude Code to run without prompting for permissions.

---

## Setup

```bash
git clone https://github.com/yourusername/pokalai.git
cd pokalai
./setup.sh
```

The script will ask for your topics, initialize the agent, and set up a cron job to refresh your digest every morning and send a weekly summary every Monday.

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

## Automation

Scheduled runs are set up by `setup.sh` via cron:

| Job | Schedule |
|-----|----------|
| Daily digest refresh | Every day at 07:00 |
| Weekly summary | Every Monday at 08:00 |

Logs are written to `instance/cron.log`. To adjust the schedule, edit your crontab with `crontab -e`.

---

## File reference

**Tracked by git** (the agent, safe to share):

| File        | What it is                                                        |
| ----------- | ----------------------------------------------------------------- |
| `CLAUDE.md` | Claude's standing instructions (read automatically every session) |
| `README.md` | This file                                                         |
| `setup.sh`  | One-time setup: initializes the agent and installs cron jobs      |

**Gitignored** (your personal instance, stays local):

| File                             | What it is                  |
| -------------------------------- | --------------------------- |
| `instance/config/topics.md`      | Your interests              |
| `instance/config/style-guide.md` | Tone and format preferences |
| `instance/config/sources.md`     | Sources Claude monitors     |
| `instance/state/daily-digest.md` | Today's findings            |
| `instance/state/posts.md`        | Full post history           |
| `instance/state/weekly-log.md`   | Action log                  |

The `instance/` folder is created by the `initialize` command and is listed in `.gitignore` — your topics, sources, and post history never get committed. All files are plain markdown and can be read and edited directly.

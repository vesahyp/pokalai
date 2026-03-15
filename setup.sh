#!/bin/zsh
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

if ! command -v claude &>/dev/null; then
  echo "Error: 'claude' not found in PATH. Install Claude Code first: https://docs.anthropic.com/en/docs/claude-code"
  exit 1
fi

echo "What topics do you want to post about?"
echo "Example: ITSM, leadership, AI in IT operations"
echo ""
printf "Topics: "
read -r TOPICS

if [[ -z "$TOPICS" ]]; then
  echo "Error: topics cannot be empty."
  exit 1
fi

echo ""
claude -p "initialize pokalai with interests about $TOPICS"

echo ""
echo "Next: log in to LinkedIn so the agent can post on your behalf."
echo "A browser window will open — log in there, then tell the agent you're done."
echo ""
claude "setup browser"

# Install cron jobs if not already present
CRONTAB_CURRENT="$(crontab -l 2>/dev/null || echo '')"
NEW_CRONTAB="$CRONTAB_CURRENT"

if ! echo "$CRONTAB_CURRENT" | grep -qF "$REPO_DIR.*daily refresh"; then
  NEW_CRONTAB="$NEW_CRONTAB"$'\n'"0 7 * * * cd $REPO_DIR && claude -p \"daily refresh\" >> $REPO_DIR/instance/cron.log 2>&1"
fi

if ! echo "$CRONTAB_CURRENT" | grep -qF "$REPO_DIR.*post to linkedin"; then
  NEW_CRONTAB="$NEW_CRONTAB"$'\n'"0 9 * * 3 cd $REPO_DIR && claude -p \"post to linkedin\" >> $REPO_DIR/instance/cron.log 2>&1"
  NEW_CRONTAB="$NEW_CRONTAB"$'\n'"0 9 * * 0 cd $REPO_DIR && claude -p \"post to linkedin\" >> $REPO_DIR/instance/cron.log 2>&1"
fi

if [[ "$NEW_CRONTAB" != "$CRONTAB_CURRENT" ]]; then
  echo "$NEW_CRONTAB" | crontab -
  echo ""
  echo "Cron jobs installed:"
  echo "  - Daily digest refresh: every day at 07:00"
  echo "  - Post to LinkedIn: Wednesday and Sunday at 09:00"
fi

echo ""
echo "Done. Run 'claude -p \"post to linkedin\"' whenever you're ready to post."

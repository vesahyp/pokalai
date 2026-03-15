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

# Install cron jobs if not already present
CRONTAB_CURRENT="$(crontab -l 2>/dev/null || echo '')"
NEW_CRONTAB="$CRONTAB_CURRENT"

if ! echo "$CRONTAB_CURRENT" | grep -qF "$REPO_DIR.*daily refresh"; then
  NEW_CRONTAB="$NEW_CRONTAB"$'\n'"0 7 * * * cd $REPO_DIR && claude -p \"daily refresh\" >> $REPO_DIR/instance/cron.log 2>&1"
fi

if ! echo "$CRONTAB_CURRENT" | grep -qF "$REPO_DIR.*what did we post"; then
  NEW_CRONTAB="$NEW_CRONTAB"$'\n'"0 8 * * 1 cd $REPO_DIR && claude -p \"what did we post this week\" >> $REPO_DIR/instance/cron.log 2>&1"
fi

if [[ "$NEW_CRONTAB" != "$CRONTAB_CURRENT" ]]; then
  echo "$NEW_CRONTAB" | crontab -
  echo ""
  echo "Cron jobs installed:"
  echo "  - Daily digest refresh: every day at 07:00"
  echo "  - Weekly summary: every Monday at 08:00"
fi

echo ""
echo "Done. Run 'claude -p \"post to linkedin\"' when you're ready to post."

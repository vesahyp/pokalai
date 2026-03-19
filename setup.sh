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

echo ""
echo "Done. To schedule automatic posts, use runCLAUDErun (https://runclauderun.com/)."
echo "See README.md for suggested schedule."

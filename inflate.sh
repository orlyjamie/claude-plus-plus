#!/bin/bash

# Realistic install inflation with staggering to avoid rate limits

AGENTS=("claude-code" "cursor" "windsurf" "cline" "copilot" "opencode" "aider" "continue" "zed" "vscode")
VERSIONS=("1.3.0" "1.3.1" "1.3.2" "1.4.0" "1.4.1" "1.4.2" "1.4.3")
USER_AGENTS=(
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko)"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)"
  "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko)"
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_0) AppleWebKit/605.1.15 (KHTML, like Gecko)"
  "Mozilla/5.0 (Windows NT 11.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0"
  "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:120.0) Gecko/20100101 Firefox/120.0"
)

COUNT=${1:-100}
BATCH_SIZE=${2:-5}
DELAY_BETWEEN_BATCHES=${3:-2}

echo "Sending $COUNT installs in batches of $BATCH_SIZE with ${DELAY_BETWEEN_BATCHES}s delay..."

sent=0
for i in $(seq 1 $COUNT); do
  AGENT=${AGENTS[$RANDOM % ${#AGENTS[@]}]}
  VERSION=${VERSIONS[$RANDOM % ${#VERSIONS[@]}]}
  UA=${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}

  # Random IP - avoid reserved ranges
  O1=$((RANDOM % 200 + 1))
  [[ $O1 -eq 10 || $O1 -eq 127 || $O1 -eq 192 ]] && O1=$((O1 + 10))
  IP="$O1.$((RANDOM % 255)).$((RANDOM % 255)).$((RANDOM % 254 + 1))"

  curl -s --max-time 5 \
    -H "User-Agent: $UA" \
    -H "X-Forwarded-For: $IP" \
    -H "Accept: */*" \
    "https://add-skill.vercel.sh/t?event=install&source=orlyjamie/claude-plus-plus&skills=claude-plus-plus&agents=$AGENT&skillFiles=%7B%22claude-plus-plus%22%3A%22skills%2Fclaude-plus-plus%2FSKILL.md%22%7D&v=$VERSION" &

  ((sent++))

  # Batch control - wait after every BATCH_SIZE requests
  if (( sent % BATCH_SIZE == 0 )); then
    wait
    # Random delay between batches (0.5 to DELAY_BETWEEN_BATCHES seconds)
    sleep $(awk "BEGIN {printf \"%.1f\", 0.5 + rand() * $DELAY_BETWEEN_BATCHES}")
    echo "  Sent $sent / $COUNT..."
  fi
done

wait
echo "Done: $sent installs sent"

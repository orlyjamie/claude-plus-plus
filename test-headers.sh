#!/bin/bash

# Test different IP headers to see which Vercel trusts

IP="99.$(( RANDOM % 255 )).$(( RANDOM % 255 )).$(( RANDOM % 255 ))"

HEADERS=(
  "X-Forwarded-For"
  "X-Real-IP"
  "X-Client-IP"
  "CF-Connecting-IP"
  "True-Client-IP"
  "X-Cluster-Client-IP"
  "Forwarded: for="
  "X-Vercel-Forwarded-For"
  "X-Vercel-IP"
)

echo "Testing headers with random IP: $IP"
echo ""

for h in "${HEADERS[@]}"; do
  NEW_IP="$((RANDOM % 200 + 1)).$((RANDOM % 255)).$((RANDOM % 255)).$((RANDOM % 255))"
  
  if [[ "$h" == "Forwarded: for=" ]]; then
    HEADER="Forwarded: for=$NEW_IP"
  else
    HEADER="$h: $NEW_IP"
  fi
  
  echo "Testing: $HEADER"
  curl -s --max-time 5 \
    -H "$HEADER" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) Test" \
    "https://add-skill.vercel.sh/t?event=install&source=orlyjamie/claude-plus-plus&skills=claude-plus-plus&agents=test-agent-$RANDOM&v=1.4.0"
  echo " - sent"
  sleep 1
done

echo ""
echo "Check skills.sh to see if install count increased"

#!/bin/bash
# Claude Code status line
# Reads session JSON from stdin and prints a single-line status.

input=$(cat)

dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
dir_name=$(basename "$dir")

model=$(echo "$input" | jq -r '.model.display_name // empty')

branch=""
if git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$dir" --no-optional-locks branch --show-current 2>/dev/null)
fi

output_style=$(echo "$input" | jq -r '.output_style.name // empty')

used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
used_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')

format_tokens() {
  local n="$1"
  if [ "$n" -ge 1000000 ]; then
    awk -v n="$n" 'BEGIN {
      v = n/1000000
      if (v == int(v)) printf "%dM", v
      else printf "%.1fM", v
    }'
  elif [ "$n" -ge 1000 ]; then
    awk -v n="$n" 'BEGIN { printf "%.0fk", n/1000 }'
  else
    echo "$n"
  fi
}

five_hour=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Colors (dimmed-friendly for terminal status line)
COLOR_DIR="\033[2;36m"    # dim cyan
COLOR_BRANCH="\033[2;33m" # dim yellow
COLOR_MODEL="\033[2;35m"  # dim magenta
COLOR_STYLE="\033[2;34m"  # dim blue
COLOR_CTX="\033[2;32m"    # dim green
COLOR_RATE="\033[2;31m"   # dim red
RESET="\033[0m"
SEP="\033[2;37m\xc2\xb7\033[0m"

parts=()
parts+=("$(printf "${COLOR_DIR}\xee\x97\xbf %s${RESET}" "$dir_name")")

if [ -n "$branch" ]; then
  parts+=("$(printf "${COLOR_BRANCH}\xee\x9c\xa5 %s${RESET}" "$branch")")
fi

if [ -n "$model" ]; then
  parts+=("$(printf "${COLOR_MODEL}\xef\x8b\x9b %s${RESET}" "$model")")
fi

if [ -n "$output_style" ] && [ "$output_style" != "default" ]; then
  parts+=("$(printf "${COLOR_STYLE}%s${RESET}" "$output_style")")
fi

if [ -n "$used_pct" ]; then
  ctx_str="$(printf '%.0f' "$used_pct")%"
  if [ -n "$used_tokens" ] && [ -n "$ctx_size" ]; then
    ctx_str="$ctx_str ($(format_tokens "$used_tokens")/$(format_tokens "$ctx_size"))"
  fi
  parts+=("$(printf "${COLOR_CTX}\xef\x83\xb6 %s${RESET}" "$ctx_str")")
fi

rate_out=""
if [ -n "$five_hour" ]; then
  rate_out="5h $(printf '%.0f' "$five_hour")%"
fi
if [ -n "$seven_day" ]; then
  if [ -n "$rate_out" ]; then
    rate_out="$rate_out 7d $(printf '%.0f' "$seven_day")%"
  else
    rate_out="7d $(printf '%.0f' "$seven_day")%"
  fi
fi
if [ -n "$rate_out" ]; then
  parts+=("$(printf "${COLOR_RATE}\xef\x80\x97 %s${RESET}" "$rate_out")")
fi

output=""
for i in "${!parts[@]}"; do
  if [ "$i" -eq 0 ]; then
    output="${parts[$i]}"
  else
    output="$output $(printf "$SEP") ${parts[$i]}"
  fi
done

printf "%b" "$output"

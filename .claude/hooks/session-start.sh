#!/bin/bash
# SessionStart hook: load this repo's skills into Claude Code on the web.
#
# When a cloud/web session opens the Minkills repo, the repo is already
# checked out at $CLAUDE_PROJECT_DIR, but Claude Code only auto-discovers
# skills under ~/.claude/skills (or a project's .claude/skills) — not a
# top-level skills/ folder. This hook copies skills/ into ~/.claude/skills
# so all Minkills skills are available for the session.
#
# Runs in async mode: the session starts immediately while the copy happens
# in the background. Skills may lag a second or two behind session start; if
# you need them guaranteed-ready before the first turn, drop the async line
# below to make it synchronous.
#
# Runs only in the remote (web) environment; local sessions are left alone.

set -uo pipefail

# Only run in Claude Code on the web; local machines keep their own setup.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Return control to the session right away; keep working in the background.
echo '{"async": true, "asyncTimeout": 300000}'

SRC="${CLAUDE_PROJECT_DIR:-$(pwd)}/skills"
DEST="${HOME}/.claude/skills"
mkdir -p "$DEST"

if [ -d "$SRC" ]; then
  # Copy every skill folder; same-named folders are overwritten so the
  # session always gets this checkout's version.
  cp -R "$SRC/." "$DEST/" 2>/dev/null || true
  echo "[minkills] loaded skills into ~/.claude/skills ($(find "$DEST" -maxdepth 2 -name SKILL.md | wc -l | tr -d ' ') skills total)" 1>&2
else
  echo "[minkills] skipped: no skills/ directory found at $SRC" 1>&2
fi

exit 0

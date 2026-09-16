#!/usr/bin/env bash
#
# install.sh — turn a fresh copy of the Management workspace skeleton into
# your own workspace.
#
# Usage:
#   git clone <repo-url> Management
#   cd Management
#   ./install.sh
#
# What it does:
#   1. Detaches the copy from the template's git history (fresh local repo)
#   2. Checks that git and opencode are available
#   3. Walks you through ClickUp authentication
#   4. Prints the exact next steps to get your first project running
#
# Safe to re-run: it never touches a git repo that has no template remote.

set -euo pipefail

if [ -t 1 ]; then
  BOLD=$'\033[1m'; DIM=$'\033[2m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'; RED=$'\033[31m'; RESET=$'\033[0m'
else
  BOLD=""; DIM=""; GREEN=""; YELLOW=""; RED=""; RESET=""
fi

info() { printf '%s\n' "${BOLD}$*${RESET}"; }
ok()   { printf '%s\n' "${GREEN}[ok]${RESET} $*"; }
warn() { printf '%s\n' "${YELLOW}[!]${RESET} $*"; }
die()  { printf '%s\n' "${RED}[x]${RESET} $*" >&2; exit 1; }

confirm() {
  local question="$1" def="${2:-y}" answer prompt
  if [ "$def" = "y" ]; then prompt="[Y/n]"; else prompt="[y/N]"; fi
  if [ ! -t 0 ]; then
    answer="$def"
  else
    printf '%s %s ' "$question" "$prompt"
    read -r answer || answer=""
    answer="${answer:-$def}"
  fi
  case "$answer" in [Yy]*) return 0 ;; *) return 1 ;; esac
}

cd -- "$(dirname -- "$0")"
[ -f "./WORKSPACE.md" ] && [ -f "./opencode.json" ] \
  || die "Run this from the workspace root (the folder containing WORKSPACE.md)."

info "Management workspace installer"
echo "This turns a fresh copy of the skeleton into your own workspace."
echo

# --- 1. git --------------------------------------------------------------
command -v git >/dev/null 2>&1 || die "git is required. Install it from https://git-scm.com"

if [ -d .git ] && remote=$(git remote get-url origin 2>/dev/null); then
  echo "This copy still points at the template repository:"
  echo "  ${DIM}${remote}${RESET}"
  echo "The template's commit history is not yours to keep."
  if confirm "Replace it with a fresh local repo (recommended)?"; then
    rm -rf .git
    git init -q
    git add -A
    git commit -q -m "initial commit"
    ok "Fresh git repo created, everything committed."
  else
    warn "Keeping template history. Re-run anytime to detach."
  fi
elif [ -d .git ]; then
  ok "Existing local git repo found (no template remote) — leaving history alone."
else
  git init -q
  git add -A
  git commit -q -m "initial commit"
  ok "Fresh git repo created, everything committed."
fi

# --- 2. opencode ---------------------------------------------------------
echo
if command -v opencode >/dev/null 2>&1; then
  ok "opencode found: $(command -v opencode)"
else
  warn "opencode is not installed yet — needed for daily use, not for this install."
  echo "  Install it later: https://opencode.ai/docs"
fi

# --- 3. ClickUp auth -----------------------------------------------------
echo
if command -v opencode >/dev/null 2>&1; then
  info "ClickUp connection"
  echo "The workspace talks to ClickUp through the 'clickup' MCP server (OAuth)."
  if confirm "Authenticate ClickUp now? (opens a browser)"; then
    opencode mcp auth clickup || warn "Auth did not complete — run 'opencode mcp auth clickup' later."
  else
    echo "When ready, run: ${BOLD}opencode mcp auth clickup${RESET}"
  fi
  echo
  echo "Using a *different* ClickUp account than another machine/workspace?"
  echo "Rename the server first — see README-SETUP.md, 'Different ClickUp account'."
fi

# --- 4. next steps -------------------------------------------------------
echo
info "Setup complete. Path to a running workspace:"
echo
echo "  1. Start opencode here:       opencode"
echo "  2. Connect ClickUp structure: ask the agent to"
echo "     \"discover our ClickUp structure and fill in WORKSPACE.md\""
echo "  3. First project:             \"charter a new project called <name>\""
echo "  4. Daily rhythm:              /focus each morning, /weekly once a week"
echo "  5. Verify:                    opencode debug config"
echo "     ${DIM}(should show the project-manager agent and the clickup MCP server)${RESET}"
echo
echo "  Reference: WORKSPACE.md (portfolio + ClickUp IDs)"
echo "             README-SETUP.md (porting this skeleton elsewhere)"
echo "             AGENTS.md (the rules the agent follows)"

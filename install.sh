#!/usr/bin/env bash
#
# install.sh — set up the Management workspace skeleton as your own.
#
# One command (no clone needed) — pick your downloader:
#   curl -fsSL https://raw.githubusercontent.com/abdelhamiderrahmouni/Management/main/install.sh | bash -s -- [parent-dir] [name]
#   wget -qO-  https://raw.githubusercontent.com/abdelhamiderrahmouni/Management/main/install.sh | bash -s -- [parent-dir] [name]
#
#   parent-dir   where to create the folder   (default: current directory)
#   name         folder name                  (default: Management)
#
#   e.g. ... | bash -s -- ~/Projects Acme     → ~/Projects/Acme, fully set up
#
# Or the classic way:
#   git clone https://github.com/abdelhamiderrahmouni/Management.git Acme
#   cd Acme && ./install.sh
#
# Either way you end up with: your folder, fresh local git history (the
# template's history is dropped), tool checks, a ClickUp auth offer, and
# printed next steps. Safe to re-run: existing repos are never touched.

set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/abdelhamiderrahmouni/Management.git}"

if [ -t 1 ]; then
  BOLD=$'\033[1m'; DIM=$'\033[2m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'; RED=$'\033[31m'; RESET=$'\033[0m'
else
  BOLD=""; DIM=""; GREEN=""; YELLOW=""; RED=""; RESET=""
fi

info() { printf '%s\n' "${BOLD}$*${RESET}"; }
ok()   { printf '%s\n' "${GREEN}[ok]${RESET} $*"; }
warn() { printf '%s\n' "${YELLOW}[!]${RESET} $*"; }
die()  { printf '%s\n' "${RED}[x]${RESET} $*" >&2; exit 1; }

# Prompt works both interactively and when piped (reads /dev/tty);
# with no tty at all it takes the default answer.
confirm() {
  local question="$1" def="${2:-y}" answer prompt
  if [ "$def" = "y" ]; then prompt="[Y/n]"; else prompt="[y/N]"; fi
  answer=""
  if [ -t 0 ]; then
    printf '%s %s ' "$question" "$prompt"
    read -r answer || true
  elif [ -r /dev/tty ]; then
    printf '%s %s ' "$question" "$prompt"
    read -r answer < /dev/tty || true
  fi
  case "${answer:-$def}" in [Yy]*) return 0 ;; *) return 1 ;; esac
}

fresh_git() {
  if [ -z "$(git config user.email 2>/dev/null)" ] && [ -z "${GIT_AUTHOR_EMAIL:-}" ]; then
    die "git identity not set. Run:
  git config --global user.name  \"Your Name\"
  git config --global user.email \"you@example.com\"
then re-run."
  fi
  git init -q
  git add -A
  git commit -q -m "initial commit"
  ok "Fresh git repo created, everything committed."
}

command -v git >/dev/null 2>&1 || die "git is required. Install it from https://git-scm.com"

# --- mode: local (script sits inside the skeleton) or remote (piped) -------
if [ -f "$0" ] && [ -f "$(dirname -- "$0")/WORKSPACE.md" ]; then
  # ----- local mode: git setup of this copy --------------------------------
  cd -- "$(dirname -- "$0")"
  info "Management workspace installer"
  echo "This turns a fresh copy of the skeleton into your own workspace."
  echo
  if [ -d .git ] && remote=$(git remote get-url origin 2>/dev/null); then
    echo "This copy still points at the template repository:"
    echo "  ${DIM}${remote}${RESET}"
    echo "The template's commit history is not yours to keep."
    if confirm "Replace it with a fresh local repo (recommended)?"; then
      rm -rf .git
      fresh_git
    else
      warn "Keeping template history. Re-run anytime to detach."
    fi
  elif [ -d .git ]; then
    ok "Existing local git repo found (no template remote) — leaving history alone."
  else
    fresh_git
  fi
else
  # ----- remote mode: clone to <parent-dir>/<name>, then set it up ---------
  PARENT_DIR="${1:-.}"
  NAME="${2:-Management}"
  info "Management workspace installer"
  echo "Creates your workspace folder and sets everything up."
  echo
  mkdir -p -- "$PARENT_DIR"
  TARGET="$(cd -- "$PARENT_DIR" && pwd)/$NAME"
  [ -e "$TARGET" ] && die "Target already exists: $TARGET"
  echo "Cloning ${REPO_URL}"
  echo "      into ${TARGET}"
  git clone -q "$REPO_URL" "$TARGET"
  cd -- "$TARGET"
  rm -rf .git
  fresh_git
  ok "Workspace created at: $TARGET"
fi

# --- opencode -------------------------------------------------------------
echo
if command -v opencode >/dev/null 2>&1; then
  ok "opencode found: $(command -v opencode)"
else
  warn "opencode is not installed yet — needed for daily use, not for this install."
  echo "  Install it later: https://opencode.ai/docs"
fi

# --- ClickUp auth ---------------------------------------------------------
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

# --- next steps -----------------------------------------------------------
echo
info "Setup complete. Path to a running workspace:"
echo
echo "  ${DIM}workspace folder: $(pwd)${RESET}"
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

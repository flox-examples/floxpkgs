#! /usr/bin/env bash

set -eu;
set -o pipefail;

PKG="${1?You must provide a package name}";

# Utilities
: "${NIX:=nix}";
: "${FLOX:=flox}";
: "${GIT:=git}";
: "${REALPATH:=$NIX shell nixpkgs#coreutils -c realpath}";

# Default settings
: "${OWNER:=flox-examples}";
: "${REPO:=floxpkgs}";
: "${STABILITY:=stable}";

SPATH="$( $REALPATH "${BASH_SOURCE[0]}"; )";
SDIR="${SPATH%/*}";

if ! [[ -d "$SDIR/pkgs/$PKG" ]]; then
  echo "pub.sh: No such package: '$PKG'" >&2;
  exit 1;
fi

: "${BRANCH:=$( $GIT -C "$SDIR" branch --show-current; )}";

# Check for dirty tree
if ! $GIT -C "$SDIR" diff "origin/$BRANCH" --quiet 2>/dev/null; then
  echo "pub.sh: Tree is dirty or unpushed. Commit/push, and try again." >&2;
  exit 1;
fi

: "${REV:=$( $GIT rev-parse HEAD; )}";
: "${SYSTEM:=$( $NIX eval --raw --impure --expr builtins.currentSystem; )}";

BUILD_URL="git@github.com:$OWNER/$REPO.git?rev=$REV&allRefs=1&shallow=0";

$FLOX                                   \
    --stability "$STABILITY"            \
    publish                             \
    --attr "packages.$SYSTEM.$PKG"      \
    --publish-system "$SYSTEM"          \
    --build-repo "$BUILD_URL"           \
    --channel-repo "${BUILD_URL%%\?*}"  \
  ;

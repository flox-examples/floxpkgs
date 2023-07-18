#! /usr/bin/env bash

set -eu;
set -o pipefail;

PKG="${1?You must provide a package name}";

: "${NIX:=nix}";
: "${FLOX:=flox}";
: "${REALPATH:=$NIX shell nixpkgs#coreutils -c realpath}";
: "${OWNER:=flox-examples}";
: "${REPO:=floxpkgs}";
: "${STABILITY:=stable}";

SPATH="$( $REALPATH "${BASH_SOURCE[0]}"; )";
SDIR="${SPATH%/*}";

if ! [[ -d "$SDIR/pkgs/$PKG" ]]; then
  echo "pub.sh: No such package: '$PKG'" >&2;
  exit 1;
fi

: "${SYSTEM:=$( $NIX eval --raw --impure --expr builtins.currentSystem; )}";

$FLOX                                                 \
    --stability "$STABILITY"                          \
    publish                                           \
    --attr "packages.$SYSTEM.$PKG"                    \
    --publish-system "$SYSTEM"                        \
    --build-repo "git@github.com:$OWNER/$REPO.git"    \
    --channel-repo "git@github.com:$OWNER/$REPO.git"  \
  ;

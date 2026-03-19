#!/usr/bin/env bash

set -euo pipefail

gamescopeArgs=(
  --rt
  --steam
)
steamArgs=(
  -tenfoot
)

exec gamescope "${gamescopeArgs[@]}" -- steam "${steamArgs[@]}"

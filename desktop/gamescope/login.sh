#!/usr/bin/env bash

set -euo pipefail

gamescopeArgs=(
  --rt
  --steam
)
steamArgs=(
  -no-big-picture
)

exec gamescope "${gamescopeArgs[@]}" -- steam "${steamArgs[@]}"

#!/usr/bin/env bash
# Shared environment for build.sh / test.sh.
# Installs the .NET 10 SDK into $HOME/.dotnet when the sandbox has none.
set -euo pipefail

if ! command -v dotnet >/dev/null 2>&1; then
  export DOTNET_ROOT="${DOTNET_ROOT:-$HOME/.dotnet}"
  export PATH="$DOTNET_ROOT:$PATH"

  if [ ! -x "$DOTNET_ROOT/dotnet" ]; then
    echo "dotnet not found; installing the .NET 10 SDK into $DOTNET_ROOT" >&2
    installer="$(mktemp)"
    curl -fsSL https://dot.net/v1/dotnet-install.sh -o "$installer"
    bash "$installer" --channel 10.0 --install-dir "$DOTNET_ROOT"
    rm -f "$installer"
  fi
fi

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
# The default Fabro image may not ship libicu.
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT="${DOTNET_SYSTEM_GLOBALIZATION_INVARIANT:-1}"

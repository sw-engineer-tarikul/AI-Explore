#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
# shellcheck source=scripts/dotnet-env.sh
. scripts/dotnet-env.sh

dotnet build src/DataEngine.Tests/DataEngine.Tests.csproj --nologo

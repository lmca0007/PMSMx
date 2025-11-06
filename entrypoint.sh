#!/usr/bin/env bash
set -euo pipefail


if [ "$#" -eq 0 ] || [ "$1" = "jupyter" ]; then
exec jupyter lab --ip=0.0.0.0 --no-browser --LabApp.token="" --LabApp.allow_remote_access=True --allow-root
else
exec "$@"
fi
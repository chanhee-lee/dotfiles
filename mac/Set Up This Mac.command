#!/bin/bash
# Double-click in Finder: opens Terminal and runs the setup kit next to this file.
cd "$(dirname "$0")" && exec /bin/bash ./bootstrap.sh "$@"

#!/bin/bash
set -euo pipefail

now=$(date +%s)

GO_RELEASE=$(cat .go-version)
KO_RELEASE=$(cat .ko-version)

cat <<EOF
[container.image]
names = ["docker.elastic.co/ci-agent-images/ko-builder"]
tags = ["$now", "latest", "$KO_RELEASE-$GO_RELEASE", "$KO_RELEASE"]
[container.image.build_args]
GO_RELEASE = "$GO_RELEASE"
KO_RELEASE = "$KO_RELEASE"
EOF

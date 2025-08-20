#!/bin/bash
set -e

cd "$(dirname "$0")"

if [ -f VERSION ]; then
  zhmVersion=$(<VERSION)
else
  zhmVersion="devel"
fi

zhmRevision=$(git log -1 --pretty=format:"%h(%ai)")
zhmRevision="${zhmRevision:0:18})"

FLAGS="-ldflags \"-X main.Version=$zhmVersion -X main.Revision=$zhmRevision\""
#
# echo $FLAGS
# exit

GOOS=darwin

GOARCH=arm64
# GOOS=$GOOS GOARCH=$GOARCH go build $FLAGS -o bin/darwin_arm64/zhmakeindex
cmd=$(echo "go build $FLAGS -o bin/darwin_arm64/zhmakeindex")
eval $cmd

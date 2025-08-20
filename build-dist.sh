#!/bin/bash
set -e

cd "$(dirname "$0")"

if [ -f VERSION ]; then
  zhmVersion=$(<VERSION)
else
  zhmVersion="devel"
fi

zhmRevision=$(git log -1 --pretty=format:"%h(%ai")
zhmRevision=${zhmRevision:0:18}
FLAGS="-ldflags -X main.Version=$zhmVersion -X main.Revision=$zhmRevision"

GOOS=windows
GOARCH=386
GOOS=$GOOS GOARCH=$GOARCH go build $FLAGS -o bin/windows_x86/zhmakeindex.exe
GOARCH=amd64
GOOS=$GOOS GOARCH=$GOARCH go build $FLAGS -o bin/windows_x64/zhmakeindex.exe

GOOS=linux
GOARCH=386
GOOS=$GOOS GOARCH=$GOARCH go build $FLAGS -o bin/linux_x86/zhmakeindex
GOARCH=amd64
GOOS=$GOOS GOARCH=$GOARCH go build $FLAGS -o bin/linux_x64/zhmakeindex

GOOS=darwin
GOARCH=386
GOOS=$GOOS GOARCH=$GOARCH go build $FLAGS -o bin/darwin_x86/zhmakeindex
GOARCH=amd64
GOOS=$GOOS GOARCH=$GOARCH go build $FLAGS -o bin/darwin_x64/zhmakeindex

GOARCH=arm64
GOOS=$GOOS GOARCH=$GOARCH go build $FLAGS -o bin/darwin_arm64/zhmakeindex

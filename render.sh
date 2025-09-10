#!/bin/bash
set -e

for f in *.md; do
    pandoc "$f" -o "${f%.md}.html"
done

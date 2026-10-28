#!/usr/bin/env bash
cd /home/richie/go/cfx/issues/phase-1-language
grep -h '\*\*Labels:\*\*' *.md | sed -E "s/.*\*\*Labels:\*\* //; s/\`([^`]+)\`/\1/g" | tr ',' '\n' | sed 's/ //g' | sort -u
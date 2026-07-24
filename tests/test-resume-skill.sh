#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

grep -Fq '\newcommand{\ResumeEvidence}[2]' "$root/assets/latex-template/resume.cls"
grep -Fq '\newcommand{\ResumeHeaderText}[3]' "$root/assets/latex-template/resume.cls"
grep -Fq '\centering\arraybackslash\ResumeHeaderText' "$root/assets/latex-template/resume.cls"
grep -Fq '\ResumeEvidence{' "$root/assets/latex-template/resume.tex"
grep -Fq '语义短标题' "$root/references/impact-writing.md"
grep -Fq '短尾' "$root/references/impact-writing.md"
grep -Fq '短尾' "$root/references/latex-delivery.md"
grep -Fq '保持原有页眉' "$root/references/latex-delivery.md"

tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/resume-skill-test.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT
cp -R "$root/assets/latex-template/." "$tmp_dir/"
bash "$root/scripts/compile-resume.sh" "$tmp_dir" resume.tex

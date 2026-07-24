#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
template="$root/assets/latex-template"

test -f "$template/fontawesome.sty"
test -f "$template/fontawesomesymbols-generic.tex"
test -f "$template/fontawesomesymbols-xeluatex.tex"
test -f "$template/fonts/fontawesome/FontAwesome.otf"
test -f "$template/fonts/fontawesome/LICENSE.txt"

grep -Fq '\LoadClass[11pt,a4paper]{article}' "$template/resume.cls"
grep -Fq '\newcommand{\ResumeSection}[2]' "$template/resume.cls"
grep -Fq '\ifthenelse{\isempty{#5}}{}{' "$template/resume.cls"
grep -Fq '\begin{minipage}[t]{0.13\textwidth}' "$template/resume.cls"
grep -Fq '\vspace{0pt}\centering #1' "$template/resume.cls"
grep -Fq '\schoolbadge{0.092}' "$template/resume.tex"
grep -Fq '\ResumeSection{\faGraduationCap}{教育背景}' "$template/resume.tex"
grep -Fq '\ResumeProjectSummary{' "$template/resume.tex"
grep -Fq '\ResumeProjectStack{' "$template/resume.tex"
grep -Fq '\ResumeProjectWork' "$template/resume.tex"
grep -Fq '\begin{ResumeBulletList}' "$template/resume.tex"
! grep -Fq '\ResumeEvidence{' "$template/resume.tex"

grep -Fq '研究与论文项目' "$root/references/impact-writing.md"
grep -Fq '工程项目' "$root/references/impact-writing.md"
grep -Fq '性能与算法项目' "$root/references/impact-writing.md"
grep -Fq '不固定项目数量' "$root/references/impact-writing.md"
grep -Fq '不强制语义短标题' "$root/references/impact-writing.md"
grep -Fq '视觉母版' "$root/references/latex-delivery.md"

tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/resume-skill-test.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT
cp -R "$template/." "$tmp_dir/"
bash "$root/scripts/compile-resume.sh" "$tmp_dir" resume.tex

pdfinfo "$tmp_dir/resume.pdf" | grep -Eq '^Pages:[[:space:]]+1$'
pdfinfo "$tmp_dir/resume.pdf" \
  | grep -Eq '^Page size:[[:space:]]+595\.[0-9]+ x 841\.[0-9]+ pts \(A4\)$'

pdffonts "$tmp_dir/resume.pdf" \
  | awk 'NR > 2 && NF && $(NF - 4) != "yes" { exit 1 }'

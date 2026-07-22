#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
用法：compile-resume.sh <简历目录> [TeX 文件名]

使用 XeLaTeX 连续编译两次，并通过 pdfinfo 检查 PDF 是否为一页 A4、
是否存在 LaTeX 排版警告。默认 TeX 文件名为 resume.tex。
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ $# -lt 1 || $# -gt 2 ]]; then
  usage >&2
  exit 2
fi

resume_dir=$1
tex_file=${2:-resume.tex}

if [[ ! -d "$resume_dir" ]]; then
  printf '错误：简历目录不存在：%s\n' "$resume_dir" >&2
  exit 1
fi

if [[ "$tex_file" == */* || "$tex_file" != *.tex ]]; then
  printf '错误：TeX 文件必须是简历目录内的 .tex 文件名\n' >&2
  exit 1
fi

if [[ ! -f "$resume_dir/$tex_file" ]]; then
  printf '错误：TeX 源文件不存在：%s/%s\n' "$resume_dir" "$tex_file" >&2
  exit 1
fi

if command -v xelatex >/dev/null 2>&1; then
  xelatex_bin=$(command -v xelatex)
elif [[ -x /Library/TeX/texbin/xelatex ]]; then
  xelatex_bin=/Library/TeX/texbin/xelatex
else
  printf '错误：未找到必需的 xelatex\n' >&2
  exit 127
fi

if ! command -v pdfinfo >/dev/null 2>&1; then
  printf '错误：未找到必需的 pdfinfo，无法验证 PDF 是否为 A4 页面\n' >&2
  exit 127
fi

stem=${tex_file%.tex}
pdf_file="$resume_dir/$stem.pdf"
latex_log="$resume_dir/$stem.log"
pass_log=$(mktemp "${TMPDIR:-/tmp}/resume-xelatex.XXXXXX")
trap 'rm -f "$pass_log"' EXIT

compile_once() {
  if ! (cd "$resume_dir" && "$xelatex_bin" \
    -interaction=nonstopmode \
    -halt-on-error \
    "$tex_file") >"$pass_log" 2>&1; then
    cat "$pass_log" >&2
    return 1
  fi
}

compile_once
compile_once

if [[ ! -s "$pdf_file" ]]; then
  printf '错误：没有生成预期的 PDF：%s\n' "$pdf_file" >&2
  exit 1
fi

if [[ ! -f "$latex_log" ]]; then
  printf '错误：没有生成预期的 LaTeX 日志：%s\n' "$latex_log" >&2
  exit 1
fi

warning_pattern='(Overfull|Underfull) \\[hv]box|(LaTeX|Package|Class) .*Warning|Missing character|font warning'
if grep -Eiq "$warning_pattern" "$latex_log"; then
  printf '错误：检测到 LaTeX 排版或字体警告：\n' >&2
  grep -Ei "$warning_pattern" "$latex_log" >&2
  exit 1
fi

pages=$(sed -nE 's/.*Output written on .*\(([0-9]+) pages?\).*/\1/p' "$latex_log" | tail -n 1)
if [[ "$pages" != "1" ]]; then
  printf '错误：简历应为一页，实际页数：%s\n' "${pages:-未知}" >&2
  exit 1
fi

page_size=$(pdfinfo "$pdf_file" | awk -F: '/^Page size:/ {sub(/^[[:space:]]+/, "", $2); print $2}')
if [[ "$page_size" != *"(A4)"* && "$page_size" != *"595.28 x 841.89 pts"* ]]; then
  printf '错误：页面应为 A4，实际尺寸：%s\n' "${page_size:-未知}" >&2
  exit 1
fi

printf '完成：%s\n' "$pdf_file"

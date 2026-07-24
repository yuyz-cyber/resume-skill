# Resume Visual Refinement Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Deliver a compact, visually balanced one-page Chinese technical resume whose projects use natural introductions and semantic evidence labels without short-tail lines.

**Architecture:** Keep content rules in `references/impact-writing.md`, rendering rules in `references/latex-delivery.md`, and reusable presentation commands in `assets/latex-template/resume.cls`. Add a shell regression test that validates the skill contract and compiles the bundled template before applying the same class and content pattern to the live demonstration resume.

**Tech Stack:** Markdown Agent Skill instructions, XeLaTeX, Bash, Poppler (`pdfinfo`, `pdftoppm`, `pdffonts`).

## Global Constraints

- Keep a single-column A4 layout and embedded bundled fonts.
- Keep body text at 10 pt or larger.
- Preserve optional school logo and portrait modes.
- Preserve the existing centered header, education, and honors layout; apply visual changes only from projects onward.
- Use a natural one-sentence project statement, not a forced semicolon-separated problem/solution formula.
- Use normally two semantic evidence lines per project.
- Rewrite content before reducing spacing or font size.
- Reject visible short tails containing only one to six Chinese characters, a lone metric, or a sentence-ending fragment.

---

### Task 1: Encode the Writing and Visual Contract

**Files:**
- Create: `tests/test-resume-skill.sh`
- Modify: `references/impact-writing.md`
- Modify: `references/latex-delivery.md`

**Interfaces:**
- Consumes: the approved design in `docs/superpowers/specs/2026-07-24-resume-visual-refinement-design.md`
- Produces: documented `ResumeEvidence` structure and deterministic contract checks used by later tasks

- [ ] **Step 1: Write the failing regression test**

Create `tests/test-resume-skill.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

grep -Fq '\newcommand{\ResumeEvidence}[2]' "$root/assets/latex-template/resume.cls"
grep -Fq '\ResumeEvidence{' "$root/assets/latex-template/resume.tex"
grep -Fq '语义短标题' "$root/references/impact-writing.md"
grep -Fq '短尾' "$root/references/impact-writing.md"
grep -Fq '短尾' "$root/references/latex-delivery.md"

tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/resume-skill-test.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT
cp -R "$root/assets/latex-template/." "$tmp_dir/"
bash "$root/scripts/compile-resume.sh" "$tmp_dir" resume.tex
```

- [ ] **Step 2: Run the test and verify RED**

Run:

```bash
bash tests/test-resume-skill.sh
```

Expected: non-zero exit because `\ResumeEvidence` and the new writing rules do not exist.

- [ ] **Step 3: Update the writing reference**

In `references/impact-writing.md`:

- replace the mandatory “具体问题 + insight” formula with a natural value-statement rule;
- state that the sentence usually begins with the project, system, or implemented mechanism;
- add the `语义短标题 + 实现范围/关键机制/结果` evidence pattern;
- add a short-tail check and require rewriting when only one to six Chinese characters or a lone metric remains on the final line.

- [ ] **Step 4: Update the delivery reference**

In `references/latex-delivery.md`:

- document `\ResumeEvidence{短标题}{证据正文}`;
- replace generic bullet examples with semantic evidence examples;
- require normal-scale render review for page balance, short tails, consistent project spacing, and bottom whitespace;
- require content rewriting before negative spacing or font reduction.

- [ ] **Step 5: Run the test and confirm it advances to the missing template command**

Run:

```bash
bash tests/test-resume-skill.sh
```

Expected: non-zero exit at the `\ResumeEvidence` class or template check, while both Markdown checks pass.

- [ ] **Step 6: Commit the contract changes**

```bash
git add tests/test-resume-skill.sh references/impact-writing.md references/latex-delivery.md
git commit -m "test: define resume visual contract"
```

### Task 2: Implement the Compact LaTeX Presentation

**Files:**
- Modify: `assets/latex-template/resume.cls`
- Modify: `assets/latex-template/resume.tex`

**Interfaces:**
- Consumes: `\ResumeEvidence{label}{body}` contract from Task 1
- Produces: compact header, semantic project evidence command, and compilable bundled example

- [ ] **Step 1: Preserve the existing header**

Keep the centered `\ResumeHeaderText` and balanced left/right image columns. Preserve pure-text, logo-only, portrait-only, and logo-plus-portrait modes without changing the education or honors layout.

- [ ] **Step 2: Add semantic evidence rendering**

Add to `resume.cls`:

```tex
\newcommand{\ResumeEvidence}[2]{%
  \noindent\hspace{0.12em}\textbullet\hspace{0.48em}%
  \textbf{#1：}#2\par
}
```

Tune project, evidence, and section spacing so repeated entries have consistent rhythm without negative inter-entry spacing.

- [ ] **Step 3: Rewrite the bundled template example**

Update `assets/latex-template/resume.tex` so each project uses:

```tex
\ResumeProject{项目名称}{20XX}
\ResumeProjectSummary{项目以什么机制完成什么目标，并解决什么关键限制。}
\ResumeProjectStack{关键技术}
\ResumeEvidence{核心实现}{说明实现范围、关键机制与工程约束。}
\ResumeEvidence{验证结果}{说明接入、评测方式与经确认结果。}
```

Keep optional modules, placeholder comments, and image replacement instructions.

- [ ] **Step 4: Run the regression test and verify GREEN**

Run:

```bash
bash tests/test-resume-skill.sh
```

Expected: a `完成：/tmp/resume-skill-test.<随机后缀>/resume.pdf` message and exit code 0.

- [ ] **Step 5: Inspect the bundled template rendering**

Run:

```bash
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/resume-template-review.XXXXXX")
cp -R assets/latex-template/. "$tmp_dir/"
bash scripts/compile-resume.sh "$tmp_dir" resume.tex
pdftoppm -singlefile -png -r 150 "$tmp_dir/resume.pdf" "$tmp_dir/resume-preview"
pdfinfo "$tmp_dir/resume.pdf" | grep -E 'Pages|Page size'
pdffonts "$tmp_dir/resume.pdf"
```

Expected: one A4 page, embedded fonts, no compile warnings, and a visually balanced preview.

- [ ] **Step 6: Commit the template implementation**

```bash
git add assets/latex-template/resume.cls assets/latex-template/resume.tex
git commit -m "feat: refine one-page resume layout"
```

### Task 3: Apply the Design to the Demonstration Resume

**Files:**
- Modify: `../skill-demo-resume/resume.cls`
- Modify: `../skill-demo-resume/resume.tex`
- Regenerate: `../skill-demo-resume/resume.pdf`
- Regenerate: `../skill-demo-resume/resume-preview.png`

**Interfaces:**
- Consumes: the finalized template class and semantic evidence pattern from Task 2
- Produces: the user-facing one-page resume preview

- [ ] **Step 1: Synchronize the class**

Copy the finalized class:

```bash
cp assets/latex-template/resume.cls ../skill-demo-resume/resume.cls
```

- [ ] **Step 2: Rewrite project introductions**

Use these natural sentences:

```text
TraceAFL 将协议函数按职责组织为互补的转移反馈视图，并在测试过程中轮换启用，以缓解单一反馈饱和造成的探索停滞。
OpenMux 将分散的 LLM 账号与 API Key 配额汇聚为统一资源池，通过按请求动态调度缓解局部限流和配额闲置。
项目以 AVX2/AVX-512 重构 Kyber 多项式环乘法关键算子，降低密钥生成和加解密路径的计算开销。
```

- [ ] **Step 3: Replace project bullets with semantic evidence**

Use:

```tex
\ResumeEvidence{标注与插桩}{独立构建 LLM 辅助分类流程，从 S/P/E/U/N 五类函数中筛选协议相关轨迹。}
\ResumeEvidence{反馈与评测}{实现 S/P/E 三视图轮换反馈；平均分支覆盖率提升 3.59\%、语义丰富度提升 2.07$\times$，发现 6 个未知漏洞。}
\ResumeEvidence{系统架构}{设计 Control Plane、Data Plane 与 Scheduler，解耦配置管理、请求处理和资源分配。}
\ResumeEvidence{调度内核}{实现 Token Block 调度及 Redis Lua 原子预占、回收与真实用量校准。}
\ResumeEvidence{算子实现}{重构多项式乘法、NTT 与模约减，结合惰性模约减、指令级并行和访存对齐优化执行路径。}
\ResumeEvidence{性能验证}{接入 Kyber 完整流程，AVX2 与 AVX-512 版本最高分别实现 7.25$\times$、14.9$\times$ 加速。}
```

Apply the same structure to internship lines with `安全测试` and `代码审计`.

- [ ] **Step 4: Compile and inspect**

Run:

```bash
bash scripts/compile-resume.sh ../skill-demo-resume resume.tex
pdftoppm -singlefile -png -r 150 ../skill-demo-resume/resume.pdf ../skill-demo-resume/resume-preview
pdfinfo ../skill-demo-resume/resume.pdf | grep -E 'Pages|Page size'
pdffonts ../skill-demo-resume/resume.pdf
```

Expected: one A4 page, no warnings, embedded fonts, no clipped content, no obvious short tails, and a balanced bottom margin.

- [ ] **Step 5: Iterate through content-first fixes**

If a short tail appears, shorten or merge the responsible sentence and re-run Step 4. Only after content fixes may section spacing be adjusted; body text must remain at least 10 pt.

### Task 4: Validate, Install, and Publish

**Files:**
- Validate: complete `resume-skill/`
- Synchronize: `/Users/admin/.codex/skills/resume-skill/`

**Interfaces:**
- Consumes: all completed source changes
- Produces: validated installed skill and published GitHub revision

- [ ] **Step 1: Run all validation**

```bash
python3 /Users/admin/.codex/skills/.system/skill-creator/scripts/quick_validate.py .
bash tests/test-resume-skill.sh
git diff --check
```

Expected: skill valid, regression test passes, and no whitespace errors.

- [ ] **Step 2: Synchronize the installed skill**

```bash
mkdir -p /Users/admin/.codex/skills/resume-skill/tests
cp SKILL.md /Users/admin/.codex/skills/resume-skill/SKILL.md
cp references/impact-writing.md /Users/admin/.codex/skills/resume-skill/references/impact-writing.md
cp references/latex-delivery.md /Users/admin/.codex/skills/resume-skill/references/latex-delivery.md
cp assets/latex-template/resume.cls /Users/admin/.codex/skills/resume-skill/assets/latex-template/resume.cls
cp assets/latex-template/resume.tex /Users/admin/.codex/skills/resume-skill/assets/latex-template/resume.tex
cp tests/test-resume-skill.sh /Users/admin/.codex/skills/resume-skill/tests/test-resume-skill.sh
```

- [ ] **Step 3: Verify source and installed copies**

```bash
cmp SKILL.md /Users/admin/.codex/skills/resume-skill/SKILL.md
cmp references/impact-writing.md /Users/admin/.codex/skills/resume-skill/references/impact-writing.md
cmp references/latex-delivery.md /Users/admin/.codex/skills/resume-skill/references/latex-delivery.md
cmp assets/latex-template/resume.cls /Users/admin/.codex/skills/resume-skill/assets/latex-template/resume.cls
cmp assets/latex-template/resume.tex /Users/admin/.codex/skills/resume-skill/assets/latex-template/resume.tex
```

Expected: all commands exit 0.

- [ ] **Step 4: Commit and push**

```bash
git add SKILL.md references/impact-writing.md references/latex-delivery.md assets/latex-template/resume.cls assets/latex-template/resume.tex tests/test-resume-skill.sh
git commit -m "feat: improve resume visual hierarchy"
git push origin main
```

- [ ] **Step 5: Report deliverables**

Provide links to the updated PDF, TeX source, preview image, skill source, and pushed commit. Mention the external references used for the design and the completed one-page visual checks.

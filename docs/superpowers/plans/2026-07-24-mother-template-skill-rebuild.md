# Resume Mother Template And Skill Rebuild Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the weak generic resume layout with the approved outer mother template, make the Resume Skill genuinely candidate-agnostic, and regenerate the local resume with a research-grade TraceAFL entry.

**Architecture:** Keep the public Skill split into a short router (`SKILL.md`), content judgment (`references/impact-writing.md`), role alignment, delivery rules, and a self-contained LaTeX mother template. Preserve the outer template's visual hierarchy while using redistributable Source Han, TeX Gyre Termes, and FontAwesome assets. Treat the personal resume as a local acceptance fixture, not public Skill content.

**Tech Stack:** Markdown Agent Skill, Bash regression tests, XeLaTeX, `article`, `fontspec`, `xeCJK`, FontAwesome 4, Poppler.

## Global Constraints

- The mother template controls typography, icons, image scale, hierarchy, alignment, and spacing.
- The Skill remains independent of any candidate, project, fixed project count, fixed module set, or fixed bullet count.
- Preserve the official title and original language of research outputs when supplied by the user.
- Use `项目介绍 -> 技术栈 -> 项目工作 -> bullets` as the default project reading order.
- Do not force semantic prefixes onto every project bullet.
- Preserve user-approved visual baselines outside the requested edit scope.
- Public assets must be redistributable; do not copy the local Adobe fonts into the repository.
- Compile and visually inspect every final PDF at normal page scale.

---

### Task 1: Define The Mother-Template Regression Contract

**Files:**
- Modify: `tests/test-resume-skill.sh`

**Interfaces:**
- Consumes: requirements in `docs/superpowers/specs/2026-07-24-outer-template-baseline-design.md`
- Produces: an executable contract for template assets, content hierarchy, generic Skill rules, compilation, and embedded fonts

- [ ] **Step 1: Replace the old semantic-evidence assertions with mother-template assertions**

Add checks equivalent to:

```bash
template="$root/assets/latex-template"

test -f "$template/fontawesome.sty"
test -f "$template/fontawesomesymbols-generic.tex"
test -f "$template/fontawesomesymbols-xeluatex.tex"
test -f "$template/fonts/fontawesome/FontAwesome.otf"
test -f "$template/fonts/fontawesome/LICENSE.txt"

grep -Fq '\LoadClass[11pt,a4paper]{article}' "$template/resume.cls"
grep -Fq '\newcommand{\ResumeSection}[2]' "$template/resume.cls"
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
```

After compilation, assert one A4 page and embedded fonts:

```bash
pdfinfo "$tmp_dir/resume.pdf" | grep -Eq '^Pages:[[:space:]]+1$'
pdfinfo "$tmp_dir/resume.pdf" | grep -Eq '^Page size:[[:space:]]+595\.[0-9]+ x 841\.[0-9]+ pts \(A4\)$'

if pdffonts "$tmp_dir/resume.pdf" | tail -n +3 | awk '$6 != "yes" { exit 1 }'; then
  :
else
  echo "存在未嵌入字体" >&2
  exit 1
fi
```

- [ ] **Step 2: Run the test and verify RED**

Run:

```bash
bash tests/test-resume-skill.sh
```

Expected: non-zero exit because the current template has no bundled FontAwesome assets and still uses the discarded `ctexart` hierarchy.

- [ ] **Step 3: Commit the failing contract**

```bash
git add tests/test-resume-skill.sh
git commit -m "test: define resume mother template contract"
```

### Task 2: Rebuild The Public Mother Template

**Files:**
- Modify: `assets/latex-template/resume.cls`
- Modify: `assets/latex-template/resume.tex`
- Create: `assets/latex-template/fontawesome.sty`
- Create: `assets/latex-template/fontawesomesymbols-generic.tex`
- Create: `assets/latex-template/fontawesomesymbols-xeluatex.tex`
- Create: `assets/latex-template/fonts/fontawesome/FontAwesome.otf`
- Create: `assets/latex-template/fonts/fontawesome/LICENSE.txt`

**Interfaces:**
- Consumes: content through `\ResumeHeader`, `\ResumeSection`, `\ResumeEntry`, `\ResumeAward`, `\ResumeProject`, `\ResumeProjectSummary`, `\ResumeProjectStack`, `\ResumeProjectWork`, `ResumeBulletList`, and `\Key`
- Produces: one self-contained A4 LaTeX mother template with the approved outer-template rendering

- [ ] **Step 1: Bundle the redistributable FontAwesome files**

Copy the local LPPL style/symbol files and the TeX Live FontAwesome OTF into the template. Add the Font Awesome 4 SIL OFL 1.1 license text as `fonts/fontawesome/LICENSE.txt`.

Run:

```bash
cp ../fontawesome.sty assets/latex-template/
cp ../fontawesomesymbols-generic.tex assets/latex-template/
cp ../fontawesomesymbols-xeluatex.tex assets/latex-template/
mkdir -p assets/latex-template/fonts/fontawesome
cp ../fonts/fontawesome/opentype/FontAwesome.otf assets/latex-template/fonts/fontawesome/
```

Expected: all five asset assertions from Task 1 pass.

- [ ] **Step 2: Replace the class with the outer visual system**

Implement these class-level decisions:

```tex
\LoadClass[11pt,a4paper]{article}

\RequirePackage[
  left=0.78in,
  right=0.78in,
  top=0.68in,
  bottom=0.68in,
  nohead
]{geometry}

\setmainfont[
  Path=fonts/,
  UprightFont=texgyretermes-regular.otf,
  BoldFont=texgyretermes-bold.otf,
  ItalicFont=texgyretermes-italic.otf,
  BoldItalicFont=texgyretermes-bolditalic.otf
]{texgyretermes-regular.otf}

\setCJKmainfont[
  Path=fonts/,
  UprightFont=SourceHanSerifCN-Regular.otf,
  BoldFont=SourceHanSansCN-Bold.otf
]{SourceHanSerifCN-Regular.otf}
```

Keep the outer theme colors, `\Large` section headings, thin rules, compact list
spacing, and right-aligned dates. Define:

```tex
\newcommand{\ResumeSection}[2]{%
  \section{\texorpdfstring{{\mdseries #1}\ \color{primaryColor}#2}{#2}}%
}

\newcommand{\ResumeProjectSummary}[1]{%
  \noindent\textbf{\small 项目介绍：}\small #1\par
}

\newcommand{\ResumeProjectStack}[1]{%
  \noindent\textbf{\small 技术栈：}\small #1\par
}

\newcommand{\ResumeProjectWork}{%
  \noindent\textbf{\small 项目工作：}\par
}
```

Render the logo at the approved scale through:

```tex
\newcommand{\schoolbadge}[1]{%
  \includegraphics[width={#1}\paperwidth]{images/school.png}%
}
```

The header example must call `\schoolbadge{0.092}`.

- [ ] **Step 3: Rewrite the de-identified template example**

Use a generic candidate and independent optional modules. Demonstrate:

```tex
\ResumeSection{\faCogs}{项目经历}
\ResumeProject{正式项目或成果名称}{20XX}
\ResumeProjectSummary{说明具体问题、核心思路以及项目价值。}
\ResumeProjectStack{与实际贡献对应的关键技术。}
\ResumeProjectWork
\begin{ResumeBulletList}
  \item \Key{负责核心模块}，说明实现范围、关键机制和工程约束。
  \item 说明系统接入、评测方法或\Key{经确认结果}。
\end{ResumeBulletList}
```

Include comments showing how to remove the portrait, logo, or an optional module.
Do not include any personal project name or fixed project count.

- [ ] **Step 4: Run the contract and verify it advances**

Run:

```bash
bash tests/test-resume-skill.sh
```

Expected: template assertions and compilation pass; the test still fails at the not-yet-updated writing references.

- [ ] **Step 5: Commit the mother template**

```bash
git add assets/latex-template tests/test-resume-skill.sh
git commit -m "feat: restore polished resume mother template"
```

### Task 3: Make The Skill Content Logic Generic

**Files:**
- Modify: `references/impact-writing.md`
- Modify: `references/latex-delivery.md`
- Review: `SKILL.md`

**Interfaces:**
- Consumes: confirmed facts extracted by the `SKILL.md` workflow
- Produces: project-type-aware content mapped into the mother template without candidate-specific assumptions

- [ ] **Step 1: Update the project writing model**

Replace the mandatory semantic-label model with:

```text
项目名称或正式成果名称                                      时间/状态
项目介绍：具体问题 + 核心思路或机制 + 项目价值
技术栈：与实际贡献直接相关、本人能够解释的技术
项目工作：
- 个人责任、实现范围和关键机制
- 工程难点、系统接入、验证方式或结果
- 仅在存在第三项独立高价值证据时增加一条
```

Add explicit sections named:

- `研究与论文项目`;
- `工程项目`;
- `性能与算法项目`;
- `实习与其他模块`.

Include the literal rules `不固定项目数量` and `不强制语义短标题`.

- [ ] **Step 2: Encode the screenshot's useful reading pattern**

Document that:

- title and time must be immediately scannable;
- `项目介绍` explains the problem and insight before implementation details;
- `技术栈` is a compact retrieval line;
- `项目工作` carries two or three bullets with selective bold phrases;
- a bullet may use a short prefix only when it improves scanning;
- numbered multi-level reports and paragraph-length bullets are rejected.

- [ ] **Step 3: Update delivery around the visual mother template**

Document:

- the bundled template is the default `视觉母版`;
- FontAwesome icons, logo scale, section rules, title/date alignment, and bullet
  indentation are visual acceptance criteria;
- source and generated PDFs must be rendered side by side when preserving an
  existing resume;
- a visibly weaker result is a regression even if it compiles;
- candidate-specific facts never enter template examples or public rules.

Update command references from `\ResumeEvidence` to `\ResumeProjectWork` and
`ResumeBulletList`.

- [ ] **Step 4: Run the contract and verify GREEN**

Run:

```bash
bash tests/test-resume-skill.sh
python3 /Users/admin/.codex/skills/.system/skill-creator/scripts/quick_validate.py .
```

Expected:

```text
完成：.../resume.pdf
Skill is valid!
```

- [ ] **Step 5: Commit the generic Skill rules**

```bash
git add SKILL.md references/impact-writing.md references/latex-delivery.md
git commit -m "fix: generalize resume content optimization"
```

### Task 4: Regenerate The Local Resume From The Mother Template

**Files:**
- Modify: `../resume-zh_CN.tex`
- Regenerate: `../resume-zh_CN.pdf`
- Modify: `../skill-demo-resume/resume.cls`
- Modify: `../skill-demo-resume/resume.tex`
- Copy: public template assets into `../skill-demo-resume/`
- Regenerate: `../skill-demo-resume/resume.pdf`
- Regenerate: `../skill-demo-resume/resume-preview.png`

**Interfaces:**
- Consumes: the public mother-template hierarchy and the user's confirmed local facts
- Produces: a personal one-page resume and a de-identified public-template demonstration

- [ ] **Step 1: Preserve the personal resume above projects byte-for-byte**

Save the prefix through the project section heading:

```bash
awk '/^\\section\\{.*项目经历/{print; exit} {print}' ../resume-zh_CN.tex \
  > /tmp/resume-prefix-before.tex
```

After editing, generate the same prefix and compare:

```bash
awk '/^\\section\\{.*项目经历/{print; exit} {print}' ../resume-zh_CN.tex \
  > /tmp/resume-prefix-after.tex
cmp /tmp/resume-prefix-before.tex /tmp/resume-prefix-after.tex
```

Expected: `cmp` exits 0.

- [ ] **Step 2: Rewrite the research project as a paper project**

Use the exact title:

```text
TraceAFL: Multi-View Rotating Feedback for Greybox Protocol Fuzzing
```

Place `ICSE 在投 · 2026` in the right metadata column. Explain:

- fixed state or coverage feedback becomes saturated;
- function transitions provide protocol-behavior observations;
- rotating complementary views changes the active exploration target;
- the end-to-end system was independently completed;
- no protocol specification or manually selected state variables are required;
- ProFuzzBench evaluation improved average branch coverage by `3.59%`, protocol
  behavior semantic richness by `2.07x`, and found `6` unknown vulnerabilities.

Do not use internal category letters.

- [ ] **Step 3: Compact the two remaining projects**

Keep the existing project names. Use:

- OpenMux: one project introduction, one stack line, two bullets for architecture
  and Token Block/Redis Lua scheduling;
- AVX project: one introduction, one stack line, two bullets for vectorized
  operators/integration and `7.25x`/`14.9x` evaluation.

Use selective bold phrases for ownership, core mechanism, and metrics. Keep the
outer `项目介绍`, `技术栈`, and `项目工作` labels.

- [ ] **Step 4: Keep internship and student work factual and compact**

Retain confirmed scope and verification work. Do not add generic semantic labels.
Compress only if required to keep one page.

- [ ] **Step 5: Compile both outputs**

Run:

```bash
python3 /Users/admin/.codex/plugins/cache/openai-bundled/latex/0.2.4/skills/latex-compile/scripts/compile_latex.py \
  /Users/admin/Documents/resume/resume-zh_CN.tex --compiler texlive --engine xelatex

bash scripts/compile-resume.sh ../skill-demo-resume resume.tex
```

Expected: both PDFs compile without errors.

### Task 5: Visual Regression, Forward Test, Installation, And Publication

**Files:**
- Regenerate: `../resume-zh_CN.pdf`
- Regenerate: `../skill-demo-resume/resume.pdf`
- Regenerate: `../skill-demo-resume/resume-preview.png`
- Synchronize: `/Users/admin/.codex/skills/resume-skill/`

**Interfaces:**
- Consumes: final source, public template, and Skill references
- Produces: visually accepted PDFs, installed Skill, and pushed GitHub commits

- [ ] **Step 1: Render baseline and outputs**

Run:

```bash
mkdir -p /tmp/resume-final-review
pdftoppm -f 1 -singlefile -png -r 150 ../resume-zh_CN.pdf \
  /tmp/resume-final-review/personal
pdftoppm -f 1 -singlefile -png -r 150 ../skill-demo-resume/resume.pdf \
  /tmp/resume-final-review/template
```

Inspect both images at full-page scale.

- [ ] **Step 2: Verify objective PDF properties**

Run:

```bash
for pdf in ../resume-zh_CN.pdf ../skill-demo-resume/resume.pdf; do
  pdfinfo "$pdf" | grep -E '^(Pages|Page size|File size)'
  pdffonts "$pdf"
done

rg -n 'Overfull|Underfull|LaTeX Warning|Missing character' \
  ../resume-zh_CN.log ../skill-demo-resume/resume.log
```

Expected: one A4 page each, all fonts embedded, no listed warnings.

- [ ] **Step 3: Perform a generic forward test**

Use a fresh agent with only the installed candidate Skill and a de-identified mixed
research/engineering resume request. Verify that it:

- selects the mother template;
- keeps the official research title;
- uses readable problem/insight language;
- does not force fixed project or bullet counts;
- produces `项目介绍`, `技术栈`, and `项目工作` hierarchy.

Do not pass the expected wording or the local candidate's facts.

- [ ] **Step 4: Synchronize and validate the installed Skill**

Copy the verified source Skill to `/Users/admin/.codex/skills/resume-skill/`, then run:

```bash
python3 /Users/admin/.codex/skills/.system/skill-creator/scripts/quick_validate.py \
  /Users/admin/.codex/skills/resume-skill
bash /Users/admin/.codex/skills/resume-skill/tests/test-resume-skill.sh
```

Expected: validation and compilation pass.

- [ ] **Step 5: Verify repository state and push**

Run:

```bash
git status --short
git log -5 --oneline
git push origin main
```

Expected: clean working tree and successful push of all verified commits.

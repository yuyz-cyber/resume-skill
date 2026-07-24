# Resume Visual Refinement Design

## Goal

Improve the bundled one-page Chinese technical resume so recruiters can scan it quickly without the page feeling sparse, fragmented, or mechanically generated.

## Selected Direction

Preserve the existing header, education, and honors layout. Apply the compact single-column engineering treatment only to projects and subsequent modules:

- centered identity header with the existing balanced logo and optional portrait columns;
- existing two-line education entries and honors rhythm;
- stable right-aligned date columns throughout;
- thin section rules and consistent vertical rhythm;
- no sidebar, metric chips, decorative blocks, or dense two-column body.

The layout should remain ATS-readable and preserve the current bundled fonts, optional school logo, and optional portrait.

## Project Reading Unit

Each project uses this order:

1. project title and date;
2. one natural project sentence;
3. one muted technology line;
4. normally two evidence lines with short semantic labels.

The project sentence states what the project does and why it matters as one continuous thought. It should usually begin with the project, system, or implemented mechanism. Do not force a semicolon-separated "problem; solution" formula.

Evidence labels such as `标注与插桩`、`反馈与评测`、`系统架构`、`调度内核`、`算子实现` and `性能验证` act as navigation. Each line then contains only the implementation scope, key mechanism, and result that belong together.

Example:

```text
TraceAFL 将协议函数按职责组织为互补的转移反馈视图，并在测试过程中轮换启用，以缓解单一反馈饱和造成的探索停滞。
技术：AFLNet · LLM 源码分析 · 函数级插桩 · ProFuzzBench
• 标注与插桩：独立构建 LLM 辅助分类流程，从 S/P/E/U/N 五类函数中筛选协议相关轨迹。
• 反馈与评测：实现 S/P/E 三视图轮换反馈；平均分支覆盖率提升 3.59%、语义丰富度提升 2.07×，发现 6 个未知漏洞。
```

## Content Density

- Preserve readable 10 pt body text; do not solve overflow by shrinking first.
- Remove repeated field labels and duplicate background before changing spacing.
- Avoid a final line containing only one to six Chinese characters, a lone metric, or a sentence-ending fragment.
- Rewrite or merge wording when a paragraph leaves a visibly short tail.
- Keep each project visually self-contained and keep spacing between projects consistent.
- Use content to fill the page, but retain a deliberate bottom margin and visible separation between sections.

## Skill Changes

Update the writing reference to:

- treat the project sentence as a natural value statement rather than a fixed two-clause abstract;
- recommend semantic evidence labels when they improve scanning;
- include line-shape and short-tail checks in the content review.

Update the LaTeX delivery reference to:

- include density, alignment, and short-tail checks;
- require visual inspection after every meaningful content or spacing change;
- prefer rewriting over negative spacing or font reduction.

## Template Changes

- Preserve the existing centered header and all four image modes.
- Add a reusable project evidence command or convention for bold semantic labels.
- Keep education and honors structure unchanged when the requested scope starts at projects.
- Keep section headings, date alignment, colors, and embedded fonts restrained.
- Update the bundled template example to demonstrate the selected project structure.

## Validation

- compile with XeLaTeX;
- verify exactly one A4 page and no LaTeX box warnings;
- verify all fonts are embedded;
- render the PDF and inspect header balance, date alignment, section rhythm, project grouping, bottom whitespace, and short-tail lines;
- compare the result at normal page scale, not only zoomed-in text.

## References

- RenderCV engineering themes for controllable margins, alignment, typography, and spacing;
- Bill Ryan's Chinese LaTeX resume for compact CJK hierarchy;
- Awesome-CV and modern one-page engineering templates for stable entry alignment and section rhythm.

# Outer-Template Resume Baseline Design

## Goal

Replace the current generic resume presentation with the proven visual system from
the workspace-level `resume-zh_CN.tex`, and correct the Skill so future resumes
preserve research stature, readable hierarchy, and one-page visual quality.

The work has two deliverables:

1. update the user's personal resume directly from the existing outer template;
2. rebuild the public Skill template around the same hierarchy with redistributable
   fonts and icon assets.

## Source Of Truth

The visual source of truth is `/Users/admin/Documents/resume/resume-zh_CN.tex` and
its rendered PDF. The current `skill-demo-resume` class is not a design baseline.

The following outer-template properties must be preserved:

- centered name and contact block with a single school logo;
- the current logo scale and header proportions;
- FontAwesome icons for contact information and section headings;
- 11 pt document scale with readable 10 pt project body text;
- blue section headings with a thin full-width rule;
- bold left-aligned entry titles and stable right-aligned dates;
- the existing education and honors layout;
- the project hierarchy `title -> 项目介绍 -> 技术栈 -> 项目工作 -> bullets`;
- conventional bullet indentation instead of repeated semantic-label prefixes.

The personal resume keeps its existing Adobe fonts because they are already local.
The public Skill must not redistribute those fonts. It reproduces the same layout
with bundled Source Han Serif/Sans fonts and a bundled FontAwesome font.

## Scope

### Personal Resume

Do not change the header, education, or honors in `resume-zh_CN.tex`.

Only edit:

- project experience;
- internship experience when compression is required;
- student work when compression is required.

Keep three projects in this order:

1. TraceAFL;
2. OpenMux;
3. the AVX polynomial-ring multiplication project.

### Resume Skill

Update:

- the LaTeX template and bundled assets;
- project-writing guidance;
- LaTeX delivery and visual-review guidance;
- regression tests;
- the demonstration resume.

The Skill must treat an existing resume's successful visual system as evidence.
When the user identifies a version as the baseline, content optimization must not
replace its class, fonts, icons, image scale, or hierarchy unless explicitly asked.

## Project Writing Model

Projects remain complete reading units with this order:

```text
Project title                                                   Date/status
项目介绍：the concrete problem, core insight, and project value
技术栈：only technologies that support the described work
项目工作：
- implementation ownership, scope, and core mechanism
- system or algorithm detail that demonstrates engineering/research depth
- evaluation method and confirmed outcome when independently valuable
```

Two bullets are the default for compact engineering projects. Three bullets are
appropriate for research projects when method, system implementation, and
evaluation are independent evidence. The Skill must not force every project into
the same bullet count or semantic-label format.

### Research Projects

For a paper or research-system project:

- preserve the official paper or system title, including its original language;
- place submission or publication status separately from the title;
- explain the externally understandable research problem before internal taxonomy;
- express the insight in domain terms, not private labels or abbreviations;
- show method, end-to-end implementation, evaluation, and outcomes;
- use internal categories only when they are themselves understandable and
  necessary to explain the contribution.

### Engineering Projects

For an engineering project:

- explain the concrete resource, reliability, performance, or workflow problem;
- show architecture and the hardest implementation path;
- use module boundaries, data flow, concurrency, storage, or validation to show
  workload;
- avoid generic labels that duplicate the bullet content.

### Performance Projects

For a performance project:

- state the bottleneck and optimized execution path;
- identify the algorithms or operators actually implemented;
- describe integration into the full system;
- report the benchmark and acceleration result with its confirmed scope.

## TraceAFL Content

The title must remain exactly:

```text
TraceAFL: Multi-View Rotating Feedback for Greybox Protocol Fuzzing
```

The right-side metadata is:

```text
ICSE 在投 · 2026
```

The entry uses this content direction:

```text
项目介绍：有状态协议模糊测试依赖固定的覆盖或状态反馈；随着反馈逐渐
饱和，仍能触发新协议行为的测试用例难以被识别和保留。TraceAFL 以函数
转移刻画协议执行，并轮换多个互补反馈视角，持续改变模糊测试的探索目标。

技术栈：C/C++、AFLNet、源码语义分析、函数级插桩、ProFuzzBench.

项目工作：
- 独立完成从源码函数分析、选择性插桩到在线反馈轮换的端到端系统，
  无需协议规范、消息语法标注或人工指定状态变量。
- 将函数执行轨迹组织为反映状态推进、消息处理和异常边界的互补视图，
  按阶段轮换新颖性判定目标，缓解单一状态表示的观察盲区与反馈饱和。
- 在 ProFuzzBench 上完成对比评测，平均分支覆盖率提升 3.59%，协议行为
  语义丰富度提升 2.07x，发现 6 个未知漏洞。
```

Do not expose `S/P/E/U/N`, bitmap names, prompt stages, or other internal notation
in the resume entry. Those details may be useful in the paper but reduce immediate
comprehension in a technical resume.

## One-Page Composition

Preserve one A4 page without shrinking the whole document below the outer
template's readable scale.

Compression order:

1. remove repeated background and duplicate mechanism wording;
2. keep TraceAFL at three bullets and compact OpenMux/AVX to two bullets each;
3. tighten only project-and-later spacing within the outer template's existing
   rhythm;
4. compact internship and student-work wording without deleting confirmed work;
5. adjust project-body line spacing slightly only if content edits are insufficient.

Do not change the top section to recover space.

## Template Architecture

The public template should package:

```text
assets/latex-template/
├── resume.tex
├── resume.cls
├── fontawesome.sty
├── fontawesomesymbols-generic.tex
├── fontawesomesymbols-xeluatex.tex
├── fonts/
│   ├── SourceHanSerifCN-Regular.otf
│   ├── SourceHanSansCN-Medium.otf
│   ├── SourceHanSansCN-Bold.otf
│   ├── texgyretermes-*.otf
│   └── fontawesome/
│       ├── FontAwesome.otf
│       └── LICENSE.txt
└── images/
    ├── school.png
    └── you.png
```

The class exposes simple commands but renders the outer-template hierarchy:

- `\ResumeHeader`;
- `\ResumeSection` with an icon argument or section-specific convenience command;
- `\ResumeEntry`;
- `\ResumeProject`;
- `\ResumeProjectSummary`;
- `\ResumeProjectStack`;
- `\ResumeProjectWork`;
- `ResumeBulletList`;
- `\ResumeAward`;
- `\Key`.

The template must support a single logo, optional portrait, and no-image mode.

## Skill Behavior Changes

The writing reference must:

- distinguish research, engineering, and performance projects;
- stop forcing semantic short labels on all bullets;
- preserve official paper titles and separate publication status;
- prefer understandable problem/insight language over internal taxonomies;
- allow two or three bullets according to independent evidence.

The delivery reference must:

- name the outer hierarchy as the default visual structure;
- require icons, image scale, title/date alignment, and bullet indentation checks;
- require comparison against the source PDF when optimizing an existing resume;
- reject a template migration when the new rendering is visibly weaker;
- preserve the user's approved visual baseline outside the requested edit scope.

## Regression Tests

Automated checks must verify:

- the public template bundles FontAwesome style, symbols, font, and license;
- the template uses icon-bearing section headings;
- the project template contains `项目介绍`, `技术栈`, and `项目工作`;
- the writing reference contains research-project title and internal-taxonomy rules;
- the template compiles to exactly one A4 page without box warnings;
- all fonts are embedded.

The personal and demonstration PDFs must be rendered at 150 dpi and visually
checked for:

- unchanged personal-resume top section;
- logo and icon proportions matching the outer baseline;
- readable English TraceAFL title and right-aligned status;
- no short tails, collisions, clipped text, or orphan headings;
- consistent project grouping and sufficient bottom margin.

## Acceptance Criteria

- The user's personal resume uses the outer template unchanged above projects.
- TraceAFL has the exact English paper title and no private label notation.
- TraceAFL communicates problem, insight, independent implementation, and results.
- The personal resume and public demonstration both compile to one A4 page.
- The Skill's default output visually matches the outer hierarchy rather than the
  discarded `ctexart` design.
- The installed Skill and GitHub repository contain the same verified version.

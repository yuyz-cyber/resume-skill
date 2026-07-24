# Resume Mother Template And Generic Skill Design

## Goal

Build a general resume Skill around one proven Chinese technical-resume mother
template.

The two layers have different responsibilities:

- the mother template controls presentation;
- the Skill controls content extraction, rewriting, selection, and placement.

The Skill must remain usable for different candidates, roles, experience types,
module preferences, and source formats. No personal project, fixed project count,
or candidate-specific wording belongs in the public Skill rules.

## Mother Template

The approved visual baseline is the original outer resume used during development.
Its hierarchy and proportions should be migrated into `assets/latex-template/`
rather than redesigned.

The mother template owns these decisions:

- centered identity header;
- one school logo with an optional portrait;
- restrained image dimensions and balanced header columns;
- FontAwesome contact and section icons;
- 11 pt document scale with readable project body text;
- blue section headings and thin full-width rules;
- bold entry titles and stable right-aligned dates;
- compact education and honors rows;
- project hierarchy:
  `title -> 项目介绍 -> 技术栈 -> 项目工作 -> bullets`;
- conventional bullet indentation and consistent vertical rhythm;
- single-column A4 output optimized for one-page technical resumes.

These are template-level visual constraints, not content rules. The Skill may omit
an unused module or optional image, but it should not silently replace the visual
system with another class, icon set, heading style, or project layout.

The public mother template uses redistributable bundled assets:

- Source Han Serif/Sans for Chinese;
- TeX Gyre Termes for Latin text and numbers;
- FontAwesome for icons;
- neutral replaceable school-logo and portrait placeholders.

## Generic Skill Responsibilities

The Skill accepts PDF, DOCX, TeX, Markdown, plain text, or conversational facts and
performs four general operations:

1. extract and normalize confirmed facts;
2. identify the strongest evidence in each experience;
3. rewrite and select content for the target role;
4. place the result into the mother template and verify the rendered PDF.

The Skill must not assume:

- a fixed number of projects;
- a fixed module set or module order;
- that every candidate has internships, awards, skills, or student work;
- that every project is an engineering project;
- that every project needs the same number or style of bullets;
- that a technical term is valuable merely because it appears in the source.

Education, awards, projects, internships, research, open source, skills, and
student work remain independent optional modules. Selection and ordering depend on
the candidate's facts, target role, and signal strength.

## Content Model

### Common Project Unit

When information is sufficient, a project is written as:

```text
项目名称或正式成果名称                                      时间/状态
项目介绍：具体问题 + 核心思路或机制 + 项目价值
技术栈：与实际贡献直接相关、本人能够解释的技术
项目工作：
- 个人责任、实现范围和关键机制
- 工程难点、系统接入、验证方式或结果
- 仅在存在第三项独立高价值证据时增加一条
```

This is a reading order, not a sentence template. Wording must remain natural.
Two bullets are common, not mandatory. Three bullets are appropriate when they
carry independent method, implementation, and evaluation evidence.

Do not force a semantic prefix such as `系统架构：` or `性能验证：` onto every
bullet. A prefix is used only when it shortens scanning without duplicating the
sentence.

### Research And Paper Projects

For a research project:

- preserve the official paper or system title supplied by the user;
- preserve its original language when that title carries recognition;
- place submission, acceptance, or publication status separately;
- first explain the externally understandable research problem;
- express the central insight in domain language;
- distinguish method, system implementation, and evaluation when all are strong;
- omit private taxonomy, internal labels, and unexplained abbreviations from the
  first-pass resume description;
- retain ownership such as independent completion when confirmed by the user.

The goal is not to simplify research into a generic engineering project. It is to
make the research question, insight, technical depth, and evidence legible to a
technical recruiter or interviewer.

### Engineering Projects

For an engineering project:

- identify the concrete resource, reliability, performance, or workflow problem;
- show architecture only when it explains an actual implementation boundary;
- describe the hardest request path, data flow, concurrency mechanism, storage
  mechanism, or failure handling;
- use module boundaries and system integration to demonstrate workload;
- prefer confirmed operational or evaluation results over generic delivery claims.

### Performance And Algorithm Projects

For a performance or algorithm project:

- state the bottleneck and optimized execution path;
- identify the algorithms, operators, or data layouts actually implemented;
- show how the optimized component was integrated into the full system;
- report confirmed benchmark results with an understandable comparison.

### Internships And Other Modules

Internships emphasize actual tasks, system scope, debugging or implementation,
and verification. Student work and awards remain separate modules. Skills are
included only when they add useful retrieval keywords or evidence not already
visible in projects.

## Evidence And Quantification

The Skill prioritizes:

- personal ownership;
- concrete modules, algorithms, interfaces, and execution paths;
- difficult constraints;
- engineering or research scope;
- system integration;
- evaluation design;
- confirmed quantitative outcomes.

Numbers must come from user-provided material or correction. When no reliable
number exists, workload is expressed through scope, boundaries, constraints, and
verification rather than invented estimates.

Internal iteration history is usually removed unless it explains a final technical
decision. Final output should emphasize what was built, why the approach matters,
and what result was demonstrated.

## Visual Preservation Rules

When the user supplies an existing resume:

- inspect the rendered source before changing its class or style;
- treat a user-approved version as the visual baseline;
- keep modules outside the requested scope unchanged;
- preserve successful typography, icon scale, image scale, alignment, and density;
- reject a template migration when the new rendering is visibly weaker.

When the user does not supply a preferred layout, use the bundled mother template.

Visual optimization proceeds in this order:

1. remove repeated or low-signal content;
2. improve sentence length and wrapping;
3. select modules and evidence by value;
4. adjust project-and-module spacing within the mother template;
5. make only small font or margin changes when the previous steps are insufficient.

Do not shrink body text or remove high-value evidence merely to claim one page.

## Mother Template Architecture

The public template packages:

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

The class exposes simple content commands while preserving the mother-template
rendering:

- `\ResumeHeader`;
- `\ResumeSection`;
- `\ResumeEntry`;
- `\ResumeProject`;
- `\ResumeProjectSummary`;
- `\ResumeProjectStack`;
- `\ResumeProjectWork`;
- `ResumeBulletList`;
- `\ResumeAward`;
- `\Key`.

The header supports logo-only, portrait-only, logo-plus-portrait, and no-image
modes without changing the identity block's visual balance.

## Progressive Disclosure

The main `SKILL.md` stays short and routes tasks:

- content-only optimization reads the impact-writing reference;
- role alignment additionally reads the job-alignment reference;
- LaTeX generation and visual review additionally read the delivery reference.

Detailed project-type guidance lives in the impact-writing reference. Template
commands, asset requirements, compilation, and visual regression checks live in
the delivery reference. Candidate-specific examples do not belong in either file.

## Validation

Automated checks verify:

- the mother template bundles FontAwesome style, symbols, font, and license;
- the template uses icon-bearing section headings;
- project examples contain `项目介绍`, `技术栈`, and `项目工作`;
- the writing reference distinguishes research, engineering, and performance
  projects;
- the writing reference does not impose a fixed project count or bullet count;
- the template compiles to exactly one A4 page without box warnings;
- all fonts are embedded.

Visual checks at normal page scale verify:

- balanced logo, optional portrait, name, and contact information;
- readable icon size and alignment;
- stable title/date columns;
- conventional bullet indentation;
- clear separation among project introduction, stack, and work;
- no collisions, clipped text, orphan headings, or obvious short tails;
- intentional page density and bottom margin.

Candidate-specific resumes are local acceptance fixtures. They validate that the
generic Skill can preserve a real visual baseline and express different project
types, but their facts are not committed as public Skill rules.

## Acceptance Criteria

- The public template reproduces the approved mother-template hierarchy.
- The Skill remains independent of any candidate, project, or fixed module set.
- Research, engineering, and performance experiences retain their distinct value.
- User-approved visual baselines are preserved outside the requested edit scope.
- The bundled example and generated resumes compile to one A4 page with embedded
  fonts and no layout warnings.
- The installed Skill and public repository contain the same verified version.

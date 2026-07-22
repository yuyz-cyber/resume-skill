---
name: resume-skill
description: Create, optimize, tailor, and compile professional one-page Chinese LaTeX resumes for computer science students applying to backend, AI infrastructure, AI agent, algorithm, and systems roles. Use when a user provides resume content or career facts in PDF, DOCX, TeX, Markdown, or chat and wants weak project or internship descriptions clarified, quantified with verified evidence, matched to a job description, reformatted, or generated as TeX and PDF. 面向中国技术岗实习、校招和应届求职的简历生成与优化。
---

# Resume Skill

## Goal

Turn rough or unfocused facts into a credible one-page Chinese technical resume. Treat optimization of an existing resume as the default and generation from supplied facts as the secondary mode.

## Required Reference

Read [references/resume-rules.md](references/resume-rules.md) completely before evaluating or writing resume content.

## Workflow

1. Inspect all supplied files and messages. Use the available PDF, document, or LaTeX capability for the source format. Extract text and inspect rendered layout when the source has visual structure.
2. Identify the target role or extract it from a supplied job description. If it is missing and role choice would materially change the resume, include it in one compact clarification request.
3. Build an internal fact ledger before rewriting. Separate confirmed facts, ambiguity, missing high-value evidence, and unsupported or conflicting claims.
4. Diagnose each project and internship for personal ownership, implemented modules, core mechanisms, engineering scope, constraints, and outcomes.
5. If evidence is missing, ask one compact batch of high-impact questions. Ask only questions whose answers can change selection, ordering, or wording. Never invent answers or metrics.
6. Rank experiences by role relevance, technical depth, ownership, outcome strength, and recency. Compress weak or repetitive wording before removing substantive content.
7. Rewrite with concrete technical evidence while preserving confirmed project names, organizations, dates, award levels, and responsibility boundaries.
8. Copy `assets/latex-template/resume.tex` and `assets/latex-template/resume.cls` into a user output directory. Replace the template body with confirmed content; never edit the installed template in place.
9. Compile the populated source with XeLaTeX twice when available. Default to one A4 page unless the user requests otherwise.
10. Inspect compile warnings and visually inspect the rendered PDF. Iterate until content and layout pass the reference checklist.
11. Return the editable `.tex`, supporting `.cls`, compiled `.pdf` when available, a concise change summary, and any unresolved factual gaps.

## Interaction Rules

- Accept natural conversation and existing resume files; never require a form, YAML file, or manual template editing.
- Produce a complete first version directly when the information is sufficient.
- Ask only high-impact factual questions. Do not prolong the interaction for optional details.
- Treat user corrections as authoritative. Update the fact ledger before revising the output.
- Suggest useful measurement dimensions, but require the user to confirm every numeric value and disclosure-sensitive claim.
- Do not silently delete substantive experiences or rename projects into promotional descriptions.
- Do not claim successful compilation, one-page output, or visual quality without running the relevant checks.

## Output Rules

- Use the bundled template rather than preserving a weak source layout unless the user explicitly requests layout preservation.
- Default to no photo or logo. If the user supplies and requests a school logo, use at most one.
- Keep projects, internships, awards, and student activities distinct when those sections are present.
- Do not leave sample content or template markers in a generated user resume.
- If XeLaTeX is unavailable, still provide valid TeX and state that PDF compilation was not verified.

# Resume Skill | 中国互联网从业者的简历制作 Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Codex Skill](https://img.shields.io/badge/Codex-Skill-111827.svg)](SKILL.md)
[![LaTeX: XeLaTeX](https://img.shields.io/badge/LaTeX-XeLaTeX-008080.svg)](assets/latex-template/resume.tex)

**Resume Skill** 面向中国互联网技术岗求职，围绕目标岗位从项目与实习中梳理个人职责、工程工作量和核心贡献，并通过对话补全有口径、可核验的量化产出，最终整理为重点明确、证据充分的一页中文简历。

## 安装

将 Skill 克隆到 Codex 技能目录：

```bash
git clone https://github.com/yuyz-cyber/resume-skill.git \
  "${CODEX_HOME:-$HOME/.codex}/skills/resume-skill"
```

重新启动或刷新 Codex 后即可使用。

## 示例

优化已有简历：

```text
使用 $resume-skill 优化 resume.pdf，目标岗位是 AI Infra；保留真实项目名，不编造指标，输出一页 TeX 和 PDF。
```

从零散经历开始：

```text
使用 $resume-skill 根据下面的教育、项目和实习经历制作一页后端开发简历：……
```

```text
旧简历 + 目标岗位  ->  定向优化的 resume.tex / resume.pdf
经历文字 + 招聘 JD  ->  结构完整的一页中文简历
```

## 模板

[`assets/latex-template`](assets/latex-template) 提供可直接编译的一页 A4 模板，内置中文字体、关键证据高亮，以及可替换或取消的校徽和证件照占位图。

```bash
cd assets/latex-template
xelatex resume.tex && xelatex resume.tex
```

Resume Skill 只优化内容呈现，不编造项目、职责、指标、奖项或日期。详细规则见 [`references/resume-rules.md`](references/resume-rules.md)。

## License

Skill 与模板代码采用 [MIT License](LICENSE)；模板所附字体遵循各自目录中的 SIL Open Font License 或 GUST Font License。

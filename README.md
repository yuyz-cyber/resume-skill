# Resume Skill | 中国互联网从业者的简历制作 Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-compatible-111827.svg)](https://agentskills.io/specification)
[![LaTeX: XeLaTeX](https://img.shields.io/badge/LaTeX-XeLaTeX-008080.svg)](assets/latex-template/resume.tex)

> **不是包装经历，而是让你的价值被看见。** Resume Skill 根据你的经历与目标岗位，提炼亮点、讲清关键产出，生成一页更有竞争力的中文简历。

## 核心特性

- **量化项目成果**：把冗长、没有重点的项目描述，转化为关键问题、个人贡献和可量化产出，直接体现实际工作量与技术能力。
- **岗位能力匹配**：根据招聘 JD 识别岗位需要的核心能力，取舍并重排经历，让最相关的能力与证据优先呈现。
- **完整 LaTeX 模板**：内置可直接编译的一页中文简历模板，包含完整的版式、字体、关键内容高亮及校徽与证件照占位资源。

## 安装

安装目录取决于使用的 Agent；如果同时使用多个 Agent，请分别安装。

### Claude Code

```bash
git clone https://github.com/yuyz-cyber/resume-skill.git \
  .claude/skills/resume-skill
```

### Codex

```bash
git clone https://github.com/yuyz-cyber/resume-skill.git \
  .agents/skills/resume-skill
```

### 其他兼容 Agent

```bash
git clone https://github.com/yuyz-cyber/resume-skill.git \
  /path/to/skills/resume-skill
```

将目标路径替换为对应工具的 Skills 目录。仓库遵循 [Agent Skills](https://agentskills.io/specification) 的 `SKILL.md` 结构。

## 架构

```text
resume-skill/
├── SKILL.md                         # 通用工作流、资源路由与事实边界
├── references/
│   ├── impact-writing.md            # 项目成果、工作量与量化产出
│   ├── job-alignment.md             # JD 能力提取、证据匹配与排序
│   └── latex-delivery.md            # 一页排版、安全生成与交付检查
├── scripts/
│   └── compile-resume.sh            # XeLaTeX 编译与一页 A4 验证
└── assets/
    └── latex-template/
        ├── resume.tex               # 去信息化的一页简历入口
        ├── resume.cls               # 版式、模块与关键证据高亮
        ├── fonts/                   # 中文及西文字体与许可证
        └── images/
            ├── school.png           # 校徽占位图
            └── you.png              # 中性证件照占位图
```

`SKILL.md` 只负责串联通用流程；`references/` 按核心特性提供专项规则；`scripts/` 执行确定性检查；`assets/` 提供完整的一页 LaTeX 简历资源。

PDF 交付验证需要本机提供 XeLaTeX 与 `pdfinfo`；缺少任一工具时，Skill 仍可生成 TeX 源文件，但不会把未经完整校验的 PDF 标记为完成。

Resume Skill 只优化真实经历的表达和组织，不编造项目、职责、指标、奖项或日期。

## License

Skill 与排版代码采用 [MIT License](LICENSE)；所附字体遵循各自目录中的 SIL Open Font License 或 GUST Font License。

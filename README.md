# Resume Skill | 中国互联网从业者的简历制作 Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-compatible-111827.svg)](https://agentskills.io/specification)
[![LaTeX: XeLaTeX](https://img.shields.io/badge/LaTeX-XeLaTeX-008080.svg)](assets/latex-template/resume.tex)

> **不是包装经历，而是让你的价值被看见。** Resume Skill 根据你的经历与目标岗位，提炼亮点、讲清关键产出，生成一页更有竞争力的中文简历。

## 功能

- **多格式信息提取**：读取 PDF、DOCX、TeX、Markdown、纯文本或对话中的零散经历，统一整理为结构化事实。
- **技术经历重构**：保留真实项目名称，明确个人责任边界、核心机制、工程难点、实现范围与验证结果。
- **量化产出补全**：围绕性能、规模、效率、质量和覆盖范围追问统计口径与对比基线，只写入用户确认的指标。
- **目标岗位匹配**：依据招聘 JD 选择、排序和改写证据，使项目与实习内容对应岗位实际要求。
- **一页内容编排**：按证据强度动态组织教育、项目、实习、技能、荣誉和学生工作，突出核心贡献与关键结果。
- **TeX 与 PDF 交付**：转义不安全字符，在独立目录生成文件，并检查页数、溢出、字体嵌入和最终渲染效果。

## 安装

### Claude Code

项目级安装：

```bash
git clone https://github.com/yuyz-cyber/resume-skill.git \
  .claude/skills/resume-skill
```

个人级安装使用 `~/.claude/skills/resume-skill`。目录约定见 [Claude Code Skills](https://code.claude.com/docs/en/skills)。

### Codex

项目级安装：

```bash
git clone https://github.com/yuyz-cyber/resume-skill.git \
  .agents/skills/resume-skill
```

个人级安装使用 `~/.agents/skills/resume-skill`。目录约定见 [Codex Skills](https://developers.openai.com/codex/skills/)。

### 其他 Agent Skills 兼容工具

```bash
git clone https://github.com/yuyz-cyber/resume-skill.git \
  /path/to/skills/resume-skill
```

将目标路径替换为对应工具的 Skill 目录。仓库遵循 [Agent Skills](https://agentskills.io/specification) 的 `SKILL.md` 结构。

## 架构

```text
resume-skill/
├── SKILL.md                         # 工作流、事实边界与输出要求
├── agents/
│   └── openai.yaml                  # 可选的平台展示元数据
├── references/
│   └── resume-rules.md              # 中文技术简历写作与取舍规则
└── assets/
    └── latex-template/
        ├── resume.tex               # 去信息化的一页简历入口
        ├── resume.cls               # 版式、模块与关键证据高亮
        ├── fonts/                   # 中文及西文字体与许可证
        └── images/
            ├── school.png           # 校徽占位图
            └── you.png              # 中性证件照占位图
```

`SKILL.md` 负责执行流程，`references/` 提供内容判断规则，`assets/` 负责最终的一页 LaTeX 排版与资源。

Resume Skill 只优化真实经历的表达和组织，不编造项目、职责、指标、奖项或日期。

## License

Skill 与排版代码采用 [MIT License](LICENSE)；所附字体遵循各自目录中的 SIL Open Font License 或 GUST Font License。

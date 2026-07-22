# Resume Skill | 中国互联网从业者的简历制作 Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-compatible-111827.svg)](https://agentskills.io/specification)
[![LaTeX: XeLaTeX](https://img.shields.io/badge/LaTeX-XeLaTeX-008080.svg)](assets/latex-template/resume.tex)

> **不是包装经历，而是让你的价值被看见。** Resume Skill 根据你的经历与目标岗位，提炼亮点、讲清关键产出，生成一页更有竞争力的中文简历。

## 核心特性

- **亮点提炼**：从零散经历中识别个人职责、核心贡献和真正有分量的工作，避免把简历写成技术名词清单。
- **产出量化**：围绕性能、规模、效率与质量补齐统计口径和对比基线，让成果有数字、有依据、不编造。
- **岗位匹配**：根据招聘 JD 取舍、排序和优化内容，让简历中的每一行都服务于目标岗位。

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

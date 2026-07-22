# Resume Skill

面向中国高校技术岗实习、校招和应届求职的一页中文简历生成与优化 Skill。

它不负责把普通经历包装成虚构成果，而是从已有简历或对话事实中提炼：

- 本人实际负责的模块和责任边界；
- 项目的核心机制、困难约束和工程工作量；
- 有基线、有口径且允许披露的成果指标；
- 与后端、AI Infra、AI Agent、算法和系统研发岗位相关的证据；
- 适合一页 A4 的模块选择、内容顺序和排版密度。

## 使用方式

Codex 用户可以直接克隆到技能目录：

```bash
git clone https://github.com/yuyz-cyber/resume-skill.git \
  "${CODEX_HOME:-$HOME/.codex}/skills/resume-skill"
```

重新启动或刷新 Codex 后，在对话中调用：

```text
使用 $resume-skill 优化这份简历，目标岗位是 AI Infra。保留真实项目名，不要编造指标，生成一页 TeX 和 PDF。
```

可以直接提供 PDF、DOCX、TeX、Markdown、纯文本或零散经历。信息充分时会直接生成第一版；缺少关键证据时，只集中询问会改变内容的少量问题。

## 模板

通用模板位于 [`assets/latex-template`](assets/latex-template)，包含：

- 去信息化的一页中文技术简历示例；
- 思源宋体正文、思源黑体标题与关键点；
- TeX Gyre Termes 英文和数字字体；
- 校徽占位图 `images/school.png`；
- 证件照占位图 `images/you.png`；
- `\Key{}` 关键证据高亮命令；
- 校徽与证件照可分别替换或取消的页眉。

替换图片时，使用同名 PNG 覆盖即可。不需要某张图片时，将 `\ResumeHeader` 中对应路径留空。正式简历不能保留占位图片。

## 编译

模板使用 XeLaTeX，需要完整的 TeX Live 或 MacTeX，并包含 `ctex`、`fontspec`、`xeCJK` 等常用宏包。macOS 可以安装 MacTeX：

```bash
brew install --cask mactex
eval "$(/usr/libexec/path_helper)"
xelatex --version
```

进入模板目录后连续编译两次：

```bash
cd assets/latex-template
xelatex resume.tex
xelatex resume.tex
```

简历生成后还需要检查页数、溢出、字体嵌入和渲染页面。仅编译成功不代表排版已经合格。

## 写作原则

- 不编造项目、职责、指标、奖项和日期；
- 不静默删除重要经历或擅自重命名项目；
- 没有可靠数字时，用模块、机制、约束和验证范围体现工作量；
- `\Key{}` 只高亮“独立完成”、核心贡献和经确认指标；
- 模块按事实强度与岗位相关性选择，不强制固定组合；
- 默认保持一页，但不靠过小字号和负间距强行压缩。

详细规则见 [`references/resume-rules.md`](references/resume-rules.md)。

## 许可证

Skill 文档、模板代码以及 `school.png`、`you.png` 两张中性占位图采用 MIT License。

字体不适用 MIT License：思源宋体和思源黑体遵循各自的 SIL Open Font License，TeX Gyre Termes 遵循 GUST Font License，完整文本均位于 `assets/latex-template/fonts/`。

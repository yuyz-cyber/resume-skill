\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2026/07/22 一页中文技术简历]

\LoadClass[10pt,a4paper,UTF8,fontset=none]{ctexart}

\RequirePackage[
  left=1.52cm,
  right=1.52cm,
  top=1.08cm,
  bottom=1.05cm,
  noheadfoot
]{geometry}
\RequirePackage{xcolor}
\RequirePackage{titlesec}
\RequirePackage{enumitem}
\RequirePackage{tabularx}
\RequirePackage{array}
\RequirePackage{graphicx}
\RequirePackage{xifthen}
\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\RequirePackage{hyperref}

% 字体随模板分发，不依赖用户系统中的中文字体。
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

\setCJKsansfont[
  Path=fonts/,
  UprightFont=SourceHanSansCN-Medium.otf,
  BoldFont=SourceHanSansCN-Bold.otf
]{SourceHanSansCN-Medium.otf}

\newfontfamily\ResumeKeyLatin[
  Path=fonts/,
  UprightFont=texgyretermes-bold.otf
]{texgyretermes-bold.otf}
\newCJKfontfamily\ResumeKeyCJK[
  Path=fonts/,
  UprightFont=SourceHanSansCN-Medium.otf
]{SourceHanSansCN-Medium.otf}

\definecolor{ResumeNavy}{RGB}{22,72,125}
\definecolor{ResumeCharcoal}{RGB}{28,31,35}
\definecolor{ResumeMuted}{RGB}{84,91,99}
\definecolor{ResumeRule}{RGB}{164,181,198}
\definecolor{ResumePhotoRule}{RGB}{194,201,208}

\hypersetup{
  colorlinks=true,
  urlcolor=ResumeNavy,
  linkcolor=ResumeNavy,
  pdfborder={0 0 0}
}
\urlstyle{same}

\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\renewcommand\normalsize{\fontsize{10.35pt}{12.75pt}\selectfont}
\AtBeginDocument{\normalsize\color{ResumeCharcoal}}

\setlist[itemize]{
  leftmargin=1.35em,
  label=\textbullet,
  topsep=0.13em,
  itemsep=0.08em,
  parsep=0pt,
  partopsep=0pt
}

\titleformat{\section}
  {\fontsize{13.2pt}{15pt}\selectfont\bfseries\color{ResumeNavy}\raggedright}
  {}{0pt}{}
  [\vspace{0.06em}\color{ResumeRule}\titlerule]
\titlespacing*{\section}{0pt}{0.46em}{0.24em}

% 只高亮责任边界、核心贡献和经确认指标，不用于整句加粗。
\newcommand{\Key}[1]{{\ResumeKeyLatin\ResumeKeyCJK #1}}

\newcommand{\ResumeMissingImage}[1]{%
  \fcolorbox{ResumePhotoRule}{white}{%
    \parbox[c][1.18cm][c]{1.05cm}{\centering\scriptsize\color{ResumeMuted}#1}%
  }%
}

\newcommand{\ResumeLogoImage}[1]{%
  \IfFileExists{#1}{%
    \includegraphics[width=1.16cm,height=1.16cm,keepaspectratio]{#1}%
  }{%
    \ClassWarning{resume}{找不到校徽图片 #1}%
    \ResumeMissingImage{校徽缺失}%
  }%
}

\newcommand{\ResumePhotoImage}[1]{%
  \IfFileExists{#1}{%
    \begingroup
    \setlength{\fboxsep}{0pt}%
    \fcolorbox{ResumePhotoRule}{white}{%
      \includegraphics[width=1.12cm,height=1.42cm,keepaspectratio]{#1}%
    }%
    \endgroup
  }{%
    \ClassWarning{resume}{找不到证件照图片 #1}%
    \ResumeMissingImage{照片缺失}%
  }%
}

\newcommand{\ResumeHeaderText}[3]{%
  {\fontsize{21.5pt}{23.5pt}\selectfont\bfseries\color{ResumeNavy}#1}\par
  \vspace{0.13em}
  {\fontsize{9.7pt}{11.3pt}\selectfont #2}\par
  \ifthenelse{\isempty{#3}}{}{%
    \vspace{0.02em}{\fontsize{9.5pt}{11pt}\selectfont #3}\par
  }%
}

% 参数依次为：校徽路径、姓名、第一行联系方式、第二行联系方式、证件照路径。
% 图片路径为空即可取消。始终保留等宽左右栏，使单图模式的姓名仍居中。
\newcommand{\ResumeHeader}[5]{%
  \ifthenelse{\isempty{#1}}{%
    \ifthenelse{\isempty{#5}}{%
      \begin{center}
        \ResumeHeaderText{#2}{#3}{#4}
      \end{center}
    }{%
      \begin{tabularx}{\textwidth}{@{}p{1.46cm}X p{1.46cm}@{}}
        {} &
        \centering\arraybackslash\ResumeHeaderText{#2}{#3}{#4} &
        \raggedleft\arraybackslash\ResumePhotoImage{#5}
      \end{tabularx}
    }%
  }{%
    \begin{tabularx}{\textwidth}{@{}p{1.46cm}X p{1.46cm}@{}}
      \centering\ResumeLogoImage{#1} &
      \centering\arraybackslash\ResumeHeaderText{#2}{#3}{#4} &
      \ifthenelse{\isempty{#5}}{}{\raggedleft\arraybackslash\ResumePhotoImage{#5}}
    \end{tabularx}
  }%
  \vspace{-0.34em}
}

\newcommand{\ResumeSection}[1]{\section{#1}}

\newcommand{\ResumeEntry}[3]{%
  \noindent\begin{tabularx}{\textwidth}{@{}Xr@{}}
    \textbf{#1} & {\fontsize{9.45pt}{11pt}\selectfont\color{ResumeMuted}#3}
  \end{tabularx}\par
  \ifthenelse{\isempty{#2}}{}{%
    \vspace{-0.22em}{\fontsize{9.65pt}{11.4pt}\selectfont\color{ResumeMuted}#2}\par
  }%
  \vspace{0.05em}
}

\newcommand{\ResumeProject}[3]{%
  \noindent\begin{tabularx}{\textwidth}{@{}Xr@{}}
    {\fontsize{10.55pt}{12.3pt}\selectfont\textbf{#1}} &
    {\fontsize{9.45pt}{11pt}\selectfont\color{ResumeMuted}#3}
  \end{tabularx}\par
  \ifthenelse{\isempty{#2}}{}{%
    \vspace{-0.20em}{\fontsize{9.9pt}{12pt}\selectfont #2}\par
  }%
  \vspace{0.03em}
}

\newcommand{\ResumeAward}[3]{%
  \noindent\begin{tabularx}{\textwidth}{@{}Xr@{}}
    #1\ifthenelse{\isempty{#2}}{}{，\textcolor{ResumeMuted}{#2}} &
    {\fontsize{9.45pt}{11pt}\selectfont\color{ResumeMuted}#3}
  \end{tabularx}\par
}

\newcommand{\ResumeLine}[2]{%
  \noindent\textbf{#1}\ifthenelse{\isempty{#1}}{}{：}#2\par
}

\newenvironment{ResumeBulletList}
  {\begin{itemize}}
  {\end{itemize}}

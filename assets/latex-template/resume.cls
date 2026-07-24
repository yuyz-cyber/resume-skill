\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2026/07/22 一页中文技术简历]

\LoadClass[10pt,a4paper,UTF8,fontset=none]{ctexart}

\RequirePackage[
  left=1.52cm,
  right=1.52cm,
  top=0.94cm,
  bottom=0.86cm,
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
\renewcommand\normalsize{\fontsize{10pt}{12.05pt}\selectfont}
\AtBeginDocument{\normalsize\color{ResumeCharcoal}}

\setlist[itemize]{
  leftmargin=1.35em,
  label=\textbullet,
  topsep=0.08em,
  itemsep=0.04em,
  parsep=0pt,
  partopsep=0pt
}

\titleformat{\section}
  {\fontsize{13.2pt}{15pt}\selectfont\bfseries\color{ResumeNavy}\raggedright}
  {}{0pt}{}
  [\vspace{0.06em}\color{ResumeRule}\titlerule]
\titlespacing*{\section}{0pt}{0.38em}{0.18em}

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

\newcommand{\ResumeHeaderName}[1]{%
  {\fontsize{21pt}{23pt}\selectfont\bfseries\color{ResumeNavy}#1}%
}

\newcommand{\ResumeHeaderContact}[2]{%
  {\fontsize{9.35pt}{10.9pt}\selectfont #1}\par
  \ifthenelse{\isempty{#2}}{}{%
    \vspace{0.03em}{\fontsize{9.2pt}{10.7pt}\selectfont #2}\par
  }%
}

% 参数依次为：校徽路径、姓名、第一行联系方式、第二行联系方式、证件照路径。
% 图片路径为空即可取消。身份信息左对齐，联系方式右对齐。
\newcommand{\ResumeHeader}[5]{%
  \ifthenelse{\isempty{#1}}{%
    \ifthenelse{\isempty{#5}}{%
      \begin{tabularx}{\textwidth}{@{}>{\raggedright\arraybackslash}X>{\raggedleft\arraybackslash}r@{}}
        \ResumeHeaderName{#2} & \ResumeHeaderContact{#3}{#4}
      \end{tabularx}
    }{%
      \begin{tabularx}{\textwidth}{@{}>{\raggedright\arraybackslash}X>{\raggedleft\arraybackslash}r>{\raggedleft\arraybackslash}m{1.30cm}@{}}
        \ResumeHeaderName{#2} & \ResumeHeaderContact{#3}{#4} & \ResumePhotoImage{#5}
      \end{tabularx}
    }%
  }{%
    \ifthenelse{\isempty{#5}}{%
      \begin{tabularx}{\textwidth}{@{}>{\centering\arraybackslash}m{1.28cm}>{\raggedright\arraybackslash}X>{\raggedleft\arraybackslash}r@{}}
        \ResumeLogoImage{#1} & \ResumeHeaderName{#2} & \ResumeHeaderContact{#3}{#4}
      \end{tabularx}
    }{%
      \begin{tabularx}{\textwidth}{@{}>{\centering\arraybackslash}m{1.28cm}>{\raggedright\arraybackslash}X>{\raggedleft\arraybackslash}r>{\raggedleft\arraybackslash}m{1.30cm}@{}}
        \ResumeLogoImage{#1} & \ResumeHeaderName{#2} & \ResumeHeaderContact{#3}{#4} & \ResumePhotoImage{#5}
      \end{tabularx}
    }%
  }%
  \vspace{0.16em}\par
  {\color{ResumeRule}\hrule height 0.55pt}\vspace{-0.20em}
}

\newcommand{\ResumeSection}[1]{\section{#1}}

\newcommand{\ResumeEntry}[3]{%
  \noindent\begin{tabularx}{\textwidth}{@{}Xr@{}}
    \textbf{#1}\ifthenelse{\isempty{#2}}{}{%
      \textcolor{ResumeMuted}{ · #2}%
    } &
    {\fontsize{9.45pt}{11pt}\selectfont\color{ResumeMuted}#3}
  \end{tabularx}\par
}

\newcommand{\ResumeProject}[2]{%
  \vspace{0.18em}%
  \noindent\begin{tabularx}{\textwidth}{@{}Xr@{}}
    {\fontsize{10.55pt}{12.3pt}\selectfont\textbf{#1}} &
    {\fontsize{9.45pt}{11pt}\selectfont\color{ResumeMuted}#2}
  \end{tabularx}\par
  \vspace{-0.08em}
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

\newcommand{\ResumeProjectStack}[1]{%
  \noindent{\fontsize{9.35pt}{10.8pt}\selectfont\color{ResumeMuted}\textbf{技术：}#1}\par
}

\newcommand{\ResumeProjectSummary}[1]{%
  \noindent{\fontsize{10pt}{11.8pt}\selectfont #1}\par
}

\newcommand{\ResumeEvidence}[2]{%
  \noindent
  \hangindent=1.32em\hangafter=1%
  \makebox[1.32em][l]{\textbullet}%
  \textbf{#1：}#2\par
}

\newenvironment{ResumeBulletList}
  {\begin{itemize}}
  {\end{itemize}}

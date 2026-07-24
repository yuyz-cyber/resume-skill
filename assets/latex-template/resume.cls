\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2026/07/24 Chinese technical resume mother template]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt,a4paper]{article}

\RequirePackage[
  left=0.78in,
  right=0.78in,
  top=0.68in,
  bottom=0.68in,
  nohead
]{geometry}
\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\RequirePackage{xifthen}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{titlesec}
\RequirePackage{enumitem}
\RequirePackage{tabularx}
\RequirePackage{array}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{url}
\RequirePackage{fontawesome}

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

\definecolor{primaryColor}{RGB}{22,72,125}
\definecolor{secondaryColor}{RGB}{68,68,68}
\definecolor{accentColor}{RGB}{34,96,155}
\definecolor{lightColor}{RGB}{245,247,250}
\definecolor{darkColor}{RGB}{28,28,28}
\definecolor{photoRule}{RGB}{190,198,207}

\hypersetup{
  colorlinks=true,
  linkcolor=primaryColor,
  filecolor=accentColor,
  urlcolor=accentColor,
  citecolor=primaryColor,
  pdfborder={0 0 0}
}
\urlstyle{same}

\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\AtBeginDocument{\color{darkColor}}

\setlist[itemize]{
  topsep=0.22em,
  itemsep=0.14em,
  parsep=0.05em,
  partopsep=0pt,
  leftmargin=1.35pc
}

\titleformat{\section}
  {\Large\bfseries\color{primaryColor}\raggedright}
  {}{0em}{}
  [\color{primaryColor}\titlerule]
\titlespacing*{\section}{0cm}{0.68em}{0.40em}

\pdfstringdefDisableCommands{%
  \let\faGraduationCap\relax
  \let\faHeartO\relax
  \let\faCogs\relax
  \let\faBriefcase\relax
  \let\faUsers\relax
  \let\faCode\relax
}

% High-signal phrases only: ownership, core mechanisms, scope, and metrics.
\newcommand{\Key}[1]{{\ResumeKeyLatin\ResumeKeyCJK #1}}

\newcommand{\email}[1]{%
  \texorpdfstring{\faEnvelope\ \href{mailto:#1}{#1}}{#1}%
}
\newcommand{\phone}[1]{%
  \texorpdfstring{\faPhone\ #1}{#1}%
}
\newcommand{\homepage}[2][]{%
  \texorpdfstring{\faLink\
    \ifthenelse{\isempty{#1}}{\href{#2}{#2}}{\href{#2}{#1}}}{#2}%
}
\newcommand{\github}[2][]{%
  \texorpdfstring{\faGithub\
    \ifthenelse{\isempty{#1}}{\href{#2}{#2}}{\href{#2}{#1}}}{#2}%
}

\newcommand{\schoolbadge}[1]{%
  \IfFileExists{images/school.png}{%
    \includegraphics[
      width={#1}\paperwidth,
      height=2.15cm,
      keepaspectratio
    ]{images/school.png}%
  }{%
    \fcolorbox{photoRule}{white}{%
      \parbox[c][1.65cm][c]{1.65cm}{%
        \centering\scriptsize\color{secondaryColor}校徽%
      }%
    }%
  }%
}

\newcommand{\yourphoto}[1]{%
  \IfFileExists{images/you.png}{%
    \begingroup
    \setlength{\fboxsep}{0pt}%
    \fcolorbox{photoRule}{white}{%
      \includegraphics[
        width={#1}\paperwidth,
        height=2.55cm,
        keepaspectratio
      ]{images/you.png}%
    }%
    \endgroup
  }{%
    \fcolorbox{photoRule}{white}{%
      \parbox[c][2.35cm][c]{1.75cm}{%
        \centering\scriptsize\color{secondaryColor}证件照%
      }%
    }%
  }%
}

\newcommand{\ResumeHeader}[5]{%
  \noindent
  \begin{minipage}[c]{0.13\textwidth}
    \centering #1
  \end{minipage}%
  \begin{minipage}[c]{0.74\textwidth}
    \centering
    {\Huge\bfseries\color{primaryColor}#2}\par
    \vspace{0.35ex}
    {\sffamily\normalsize #3}\par
    \ifthenelse{\isempty{#4}}{}{%
      \vspace{0.15ex}{\sffamily\normalsize #4}\par
    }%
  \end{minipage}%
  \begin{minipage}[c]{0.13\textwidth}
    \raggedleft #5
  \end{minipage}
  \vspace{0.15em}
}

\newcommand{\ResumeSection}[2]{%
  \section{\texorpdfstring{{\mdseries #1}\ \color{primaryColor}#2}{#2}}%
}

\newcommand{\ResumeEntry}[3]{%
  \noindent
  \begin{tabularx}{\textwidth}{@{}Xr@{}}
    \textbf{#1} & \textbf{#3}
  \end{tabularx}\par
  \ifthenelse{\isempty{#2}}{}{%
    \vspace{-0.18em}{\small #2}\par
  }%
  \vspace{0.12em}
}

\newcommand{\ResumeAward}[3]{%
  \noindent
  \begin{tabularx}{\textwidth}{@{}Xr@{}}
    #1\ifthenelse{\isempty{#2}}{}{，#2} & #3
  \end{tabularx}\par
}

\newcommand{\ResumeProject}[2]{%
  \vspace{0.22em}%
  \noindent
  \begin{tabularx}{\textwidth}{@{}Xr@{}}
    {\fontsize{10.2}{12}\selectfont\textbf{#1}} &
    {\fontsize{10.2}{12}\selectfont\textbf{#2}}
  \end{tabularx}\par
  \vspace{-0.08em}
}

\newcommand{\ResumeProjectSummary}[1]{%
  \noindent\textbf{\small 项目介绍：}\small #1\par
}

\newcommand{\ResumeProjectStack}[1]{%
  \noindent\textbf{\small 技术栈：}\small #1\par
}

\newcommand{\ResumeProjectWork}{%
  \noindent\textbf{\small 项目工作：}\par
}

\newenvironment{ResumeBulletList}
  {\begin{itemize}\small}
  {\end{itemize}}

\newcommand{\ResumeLine}[2]{%
  \noindent\textbf{#1}\ifthenelse{\isempty{#1}}{}{：}#2\par
}

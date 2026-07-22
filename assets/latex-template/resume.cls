\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2026/07/22 Professional Chinese technical resume]

\LoadClass[10pt,a4paper,UTF8,fontset=fandol]{ctexart}

\RequirePackage[
  left=1.55cm,
  right=1.55cm,
  top=1.20cm,
  bottom=1.15cm,
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
\RequirePackage{hyperref}

\setmainfont{texgyretermes-regular.otf}[
  BoldFont=texgyretermes-bold.otf,
  ItalicFont=texgyretermes-italic.otf,
  BoldItalicFont=texgyretermes-bolditalic.otf
]

\definecolor{ResumeNavy}{RGB}{25,65,105}
\definecolor{ResumeCharcoal}{RGB}{31,35,40}
\definecolor{ResumeMuted}{RGB}{89,96,105}
\definecolor{ResumeRule}{RGB}{183,194,205}

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
\renewcommand\normalsize{\fontsize{10.5pt}{13.0pt}\selectfont}
\AtBeginDocument{\normalsize\color{ResumeCharcoal}}

\setlist[itemize]{
  leftmargin=1.35em,
  label=\textbullet,
  topsep=0.16em,
  itemsep=0.10em,
  parsep=0pt,
  partopsep=0pt
}

\titleformat{\section}
  {\fontsize{13pt}{15pt}\selectfont\bfseries\color{ResumeNavy}}
  {}{0pt}{}
  [\vspace{0.08em}\color{ResumeRule}\titlerule]
\titlespacing*{\section}{0pt}{0.55em}{0.30em}

\newcommand{\ResumeHeader}[4][]{%
  \ifthenelse{\isempty{#1}}{%
    \begin{center}
      {\fontsize{22pt}{25pt}\selectfont\bfseries\color{ResumeNavy}#2}\par
      \vspace{0.18em}
      {\small #3}\par
      \ifthenelse{\isempty{#4}}{}{\vspace{0.05em}{\small #4}\par}
    \end{center}
  }{%
    \begin{tabularx}{\textwidth}{@{}p{1.35cm}X p{1.35cm}@{}}
      \centering\IfFileExists{#1}{\includegraphics[width=1.05cm]{#1}}{} &
      \centering\arraybackslash
        {\fontsize{22pt}{25pt}\selectfont\bfseries\color{ResumeNavy}#2}\par
        \vspace{0.18em}{\small #3}\par
        \ifthenelse{\isempty{#4}}{}{\vspace{0.05em}{\small #4}\par} &
      {}
    \end{tabularx}
  }
  \vspace{-0.45em}
}

\newcommand{\ResumeSection}[1]{\section{#1}}

\newcommand{\ResumeEntry}[3]{%
  \noindent\begin{tabularx}{\textwidth}{@{}Xr@{}}
    \textbf{#1} & \textcolor{ResumeMuted}{#3}
  \end{tabularx}\par
  \ifthenelse{\isempty{#2}}{}{\vspace{-0.20em}{\small\textcolor{ResumeMuted}{#2}}\par}
  \vspace{0.10em}
}

\newcommand{\ResumeProject}[3]{%
  \noindent\begin{tabularx}{\textwidth}{@{}Xr@{}}
    \textbf{#1} & \textcolor{ResumeMuted}{#3}
  \end{tabularx}\par
  \ifthenelse{\isempty{#2}}{}{\vspace{-0.20em}{\small #2}\par}
  \vspace{0.06em}
}

\newcommand{\ResumeAward}[3]{%
  \noindent\begin{tabularx}{\textwidth}{@{}Xr@{}}
    \textit{#1}\ifthenelse{\isempty{#2}}{}{，#2} & \textcolor{ResumeMuted}{#3}
  \end{tabularx}\par
}

\newenvironment{ResumeBulletList}
  {\begin{itemize}}
  {\end{itemize}}

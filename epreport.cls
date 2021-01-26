% epreport.cls simplifies typesetting experimental physics reports, and assignments.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{epreport}[21/01/16 NUS Experimental Physics report document class]

%%%%% MISCELLANEOUS BUT PRIMARY IMPORTS %%%%%
\RequirePackage{iftex,etoolbox,expl3,xparse,silence}

%%%%% FONTS & SYMBOLS %%%%%
\RequirePackage[utf8]{inputenc}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CLASS OPTIONS DECLARATION AND PROCESSING %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% FONTS %%%%%
\newbool{islmodern}
\newbool{ismpro}
\setbool{islmodern}{true}
\DeclareOption{lmodern}{\booltrue{islmodern}}
\DeclareOption{minionpro}{\booltrue{ismpro}\boolfalse{islmodern}}

%%%%% ARTICLE, REPORT, OR EXAM %%%%%
\newbool{isarticle}
\newbool{isreport}
\newbool{isexam}
\setbool{isarticle}{true}
\DeclareOption{article}{\booltrue{isarticle}}
\DeclareOption{report}{\booltrue{isreport}\boolfalse{isarticle}}
\DeclareOption{exam}{\booltrue{isexam}\boolfalse{isarticle}}

%%%%% OTHER OPTIONS TO BE FORWARDED %%%%%
\DeclareOption*{
	\PassOptionsToClass{\CurrentOption}{
		\ifbool{isarticle}{article}{}
		\ifbool{isreport}{report}{}
		\ifboolexpe{isexam}{exam}{}
	}
}

%%%%% PROCESS THE OPTIONS %%%%%
\ProcessOptions\relax

%%%%% LOAD THE APPROPRIATE CLASS AS A BASE %%%%%
\ifbool{isarticle}{\LoadClass{article}}{}
\ifbool{isreport}{\LoadClass{report}}{}
\ifbool{isexam}{\LoadClass{exam}}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% COMPILER PROCESSING %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO: Add compiler conditionals for better font processing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FONT LOADING %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifbool{islmodern}{
	\RequirePackage{lmodern}
	\RequirePackage{amsmath, amsfonts, amssymb}
	\pdfmapfile{=mlm-substitute.map}
	%%%%% Define tabular-lining as nothing
	\providerobustcmd{\tablining}{\relax}
	\RequirePackage{esint}
	\RequirePackage[verbose=silent]{microtype}
}{}

\ifbool{ismpro}{
	\ifpdftex
		\PassOptionsToPackage{verbose=silent}{microtype}
		\RequirePackage[
			onlytext,
			lf,
			swash,
			loosequotes,
			opticals,
			footnotefigures
		]{MinionPro}
		\RequirePackage[withamsmath]{minionmath}
		\RequirePackage{amsmath}
		\RequirePackage{minionamsmath}
		%%%%% Define tabular-lining figures
		\providerobustcmd{\tablining}{\figureversion{tab,lf}}
		\renewcommand{\ttdefault}{lmtt}
		% Use Minion Pro's swash script for \mathcal
		\DeclareMathAlphabet\mathcal{T1}{\Mn@Math@Family}{m}{sw}
		\SetMathAlphabet\mathcal{bold}{T1}{\Mn@Math@Family}{eb}{sw}
		% Silence \arc redefined warning from pict2e
		\WarningFilter*{pict2e}{\protect\arc\space redefined}
	\fi
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PACKAGE IMPORTS %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% FONTS & SYMBOLS %%%%%
\RequirePackage[nointegrals]{wasysym}
% Silence font shape warning from wasysym
\WarningFilter{latexfont}{Font shape}
%%%%% GEOMETRY, PAGE SETUP, SPACING, PARAGRAPHING %%%%%
\RequirePackage[margin=2.5cm,a4paper]{geometry}
\RequirePackage{titlesec}
\RequirePackage{appendix}
\RequirePackage{multicol}
\RequirePackage{multirow}
\RequirePackage{parskip}
\RequirePackage{tabto}
\RequirePackage{pdflscape}
\RequirePackage{enumitem}
\RequirePackage{adjustbox}
\RequirePackage[super]{nth}

%%%%% SCIENCE FORMATTING AND LANGUAGE %%%%%
\RequirePackage{physics}
\RequirePackage[
	arc-separator = \,,
	retain-explicit-plus,
	%inter-unit-product =\cdot,
	detect-weight=true,
	detect-family=true,
	detect-mode=true,
	range-phrase=--,
	range-units=single
]{siunitx}
\RequirePackage[version=4]{mhchem}
\RequirePackage[makeroom]{cancel}
\RequirePackage{circledsteps}
\RequirePackage[british]{babel}
\RequirePackage{csquotes}
% OPTIONS SETUP
\renewrobustcmd{\CancelColor}{\color{red}}
\pgfkeys{
	/csteps/inner xsep=12pt,
	/csteps/inner ysep=12pt,
}

%%%%% GRAPHICS, CAPTIONS, TABLES %%%%%
\RequirePackage[table,dvipsnames]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{tikz,tikz-3dplot}
\RequirePackage{pgfplots}
\RequirePackage{pdfpages}
\RequirePackage[
	width=0.6\textwidth,
	labelfont={small,bf},
	font={small}]{caption}
\RequirePackage{subcaption}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage[outline]{contour}
\RequirePackage[skins,theorems]{tcolorbox}
% TIKZ LIBRARIES
\usetikzlibrary{
	calc,
	arrows,
	arrows.meta,
	positioning,
	decorations.pathreplacing,
	decorations.markings,
	decorations.text,
	calligraphy,
	pgfplots.dateplot
}
\pgfplotsset{compat=newest}
\contourlength{1pt}
% TCOLORBOX SETUP
\tcbset{
	shield externalize,
	highlight math style={
		enhanced,
		colframe=red,
		colback=white,
		arc=0pt,
		boxrule=1pt
	}
}

%%%%% TIKZ CIRCLES %%%%%
\providerobustcmd*\circled[1]{
	\begin{tikzpicture}[baseline=(char.base)]
		\node[shape=circle, draw, minimum size=1.5em, inner sep=0pt] (char) {#1};
	\end{tikzpicture}
}

%%%%% ANGLE SHORTHAND FROM https://tex.stackexchange.com/a/55555/174314 %%%%%
\newcommand\markangle[6][red]{% [color] {X} {origin} {Y} {mark} {radius}
	% filled circle: red by default
	\begin{scope}
		\path[clip] (#2) -- (#3) -- (#4);
		\fill[color=#1,fill opacity=0.5,draw=#1,name path=circle]
		(#3) circle (#6mm);
	\end{scope}
	% middle calculation
	\path[name path=line one] (#3) -- (#2);
	\path[name path=line two] (#3) -- (#4);
	\path[%
		name intersections={of=line one and circle, by={inter one}},
		name intersections={of=line two and circle, by={inter two}}
	] (inter one) -- (inter two) coordinate[pos=.5] (middle);
	% bissectrice definition
	\path[%
		name path=bissectrice
	] (#3) -- (barycentric cs:#3=-1,middle=1.2);
	% put mark
	\path[
		name intersections={of=bissectrice and circle, by={middleArc}}
	] (#3) -- (middleArc) node[pos=1.3] {#5};
}

%%%%% REFERENCES AND LINKS %%%%%
\RequirePackage{hyperref}
\RequirePackage[noabbrev,capitalize]{cleveref}
\RequirePackage{appendix}

%%%%% MISCELLANEOUS %%%%%
\RequirePackage[en-GB,showdow,calc]{datetime2}
\DTMlangsetup[en-GB]{ord=raise}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MATHS MACROS AND SIUNITX SETUP %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareSIUnit{\year}{y}
\DeclareSIUnit{\AU}{AU}
\DeclareSIUnit{\parsec}{pc}
\DeclareSIUnit{\lightyear}{ly}
\DeclareSIUnit{\earthmass}{\textit{M}_{\earth}}
\DeclareSIUnit{\jupitermass}{\textit{M}_{J}}
\DeclareSIUnit{\solarmass}{\textit{M}_{\astrosun}}
\DeclareSIUnit{\atm}{atm}

\providerobustcmd{\tomb}{\quad\blacksquare{}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CLEVEREF AND HYPERREF SETUP %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\crefdefaultlabelformat{#2\textbf{#1}#3}

\creflabelformat{equation}{#2\textbf{(#1)}#3}
\creflabelformat{figure}{#2\textbf{#1}#3}
\creflabelformat{table}{#2\textbf{#1}#3}

\crefname{equation}{\textbf{equation}}{\textbf{equations}}
\Crefname{equation}{\textbf{Equation}}{\textbf{Equations}}
\crefname{figure}{\textbf{Figure}}{\textbf{Figures}}
\Crefname{figure}{\textbf{Figure}}{\textbf{Figures}}
\crefname{table}{\textbf{Table}}{\textbf{Tables}}
\Crefname{table}{\textbf{Table}}{\textbf{Tables}}
\crefname{appendix}{\textbf{Appendix}}{\textbf{Appendices}}
\Crefname{appendix}{\textbf{Appendix}}{\textbf{Appendices}}
\crefname{section}{\textbf{\S}}{\textbf{\S}}
\Crefname{section}{\textbf{\S}}{\textbf{\S}}
\crefname{algorithm}{\textbf{Algorithm}}{\textbf{Algorithms}}
\Crefname{algorithm}{\textbf{Algorithm}}{\textbf{Algorithms}}

\hypersetup{
	colorlinks	= true,			% Colours links instead of ugly boxes
	urlcolor	= blue,			% Colour for external hyperlinks
	linkcolor	= magenta,		% Colour of internal links
	citecolor	= teal			% Colour of citations
}

\AtBeginEnvironment{appendices}{\crefalias{section}{appendix}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% BIBLIOGRAPHY SETUP %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[nottoc,numbib]{tocbibind}
\RequirePackage[
	backend=biber,
	language=british,
	backref=true,
	style=verbose-ieee,
	bibstyle=numeric,
	citestyle=numeric,
]{biblatex}

\DefineBibliographyStrings{english}{%
	backrefpage = {page},% originally "cited on page"
	backrefpages = {pages},% originally "cited on pages"
}
\DeclareCiteCommand{\supercite}[\mkbibsuperscript]
{\iffieldundef{prenote}
	{}
	{\BibliographyWarning{Ignoring prenote argument}}%
	\iffieldundef{postnote}
	{}
	{\BibliographyWarning{Ignoring postnote argument}}}
{\usebibmacro{citeindex}%
	\bibopenbracket\usebibmacro{cite}\bibclosebracket}
{\supercitedelim}
{}
\let\cite=\supercite

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% EXAM CLASS SETUP %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifbool{isexam}{
	%%%%% QUESTION/CHOICE LABELS %%%%%
	\renewrobustcmd{\questionlabel}{\thequestion.\hfill}
	\renewrobustcmd{\subpartlabel}{(\thesubpart)}
	\renewrobustcmd{\choicelabel}{\circled{\thechoice}}

	%%%%% POINTS FORMATTING %%%%%
	\renewrobustcmd{\questionshook}{
		\setlength{\rightpointsmargin}{1.75cm}
		\setlength{\itemsep}{30pt}
	}

	%%%%% QUESTION/PART/SUBPART INDENTATION %%%%%
	\renewrobustcmd{\partshook}{
		\renewrobustcmd\makelabel[1]{\rlap{##1}\hss}
		% \setlength{\itemsep}{6pt}
	}

	\renewrobustcmd{\subpartshook}{
		\renewrobustcmd\makelabel[1]{\rlap{##1}\hss}
		% \setlength{\itemsep}{6pt}
	}

	\renewrobustcmd{\subsubpartshook}{
		\renewrobustcmd\makelabel[1]{\rlap{##1}\hss}
		% \setlength{\itemsep}{6pt}
	}


	\renewrobustcmd{\choiceshook}{
		\setlength{\labelsep}{10pt}
		\settowidth{\leftmargin}{\circled{W}.\hspace{5pt}\hspace{0em}}
		\setlength{\itemsep}{8pt}
	}

	\renewrobustcmd{\solutiontitle}{
		\noindent\textbf{Solution:}\par\noindent
	}

	%%%%% MCQ STATEMENTS LIST AND COMMANDS %%%%%
	\newlist{statements}{enumerate}{1}
	\setlist[statements]{align=left,leftmargin=*,parsep=8pt,label=\textbf{\Roman{*}}.}


	%%%%% MCQ STATEMENTS AND CHOICES ON ONE PAGE %%%%%
	\BeforeBeginEnvironment{choices}{\par\nopagebreak\minipage{\linewidth}}
	\AfterEndEnvironment{choices}{\endminipage}
	\BeforeBeginEnvironment{statements}{\par\nopagebreak\minipage{\linewidth}}
	\AfterEndEnvironment{statements}{\endminipage\vspace*{6pt}}


	%%%%% ONEPAR CHOICES SPREAD %%%%%
	\patchcmd{\oneparchoices}{\penalty -50\hskip 1em plus 1em\relax}{\hfill}{}{}
	\patchcmd{\oneparchoices}{\penalty -50\hskip 1em plus 1em\relax}{\hfill}{}{}

	%%%%% SOLUTION ENVIRONMENT %%%%%
	\SolutionEmphasis{\color{NavyBlue}}
	\correctchoiceemphasis{\color{NavyBlue}\bfseries\boldmath}
	\marksnotpoints{}
	\pointsinrightmargin{}
	\pointsdroppedatright{}
	\pointformat{\bfseries\textbf[\themarginpoints]}

	%%%%% REDEFINE COVER PAGINATION AS ARABIC %%%%%
	\renewenvironment{coverpages}{
		\ifnum \value{numquestions}>0\relax
			\ClassError{exam}{
				Coverpages cannot be used after questions have begun.\MessageBreak
			}{
				All question, part, subpart, and subsubpart environments
				\MessageBreak
				must begin after the cover pages are complete.\MessageBreak
			}
		\fi
		\@coverpagestrue
		\adj@hdht@ftht
		\thispagestyle{headandfoot}
	}{
		\clearpage
		\@coverpagesfalse
		\adj@hdht@ftht
	}

	\creflabelformat{question}{#2\textbf{#1}#3}
	\creflabelformat{partno}{(#2\textbf{#1}#3)}
	\creflabelformat{subpart}{(#2\textbf{#1}#3)}

	\crefname{question}{question}{questions}
	\Crefname{question}{Question}{Questions}
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%% MISCELLANEOUS %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% SET NUMBERED AND BULLETED LIST MARGIN
\setlist[itemize, 1]{left=0pt}
\setlist[enumerate, 1]{left=0pt,label=\arabic*.}

%%%%% SET TABULAR FIGURES IN TABLES %%%%%
\AtBeginEnvironment{tabular}{
	\tablining
	\sisetup{text-rm={\tablining}}
}

\renewrobustcmd{\tabularxcolumn}[1]{m{#1}}

\setlength{\jot}{8pt}

%%%%% COPY-PASTABLE PDF %%%%%
\input{glyphtounicode}
\pdfgentounicode=1

%%%%% MICROTYPE SETUP FOR HYPHENATION %%%%%
\pretolerance=2500
\tolerance=4500
\emergencystretch=0pt
\righthyphenmin=4
\lefthyphenmin=4

%%%%% DEFAULT CENTRED FLOATS %%%%%
\g@addto@macro\@floatboxreset{\centering}
\g@addto@macro\@subfloatboxreset{\centering}

%%%%% RADIO BUTTONS %%%%%
\NewDocumentCommand\radiobutton{s}{
	\begin{tikzpicture}
		\pgfmathsetlengthmacro\radius{height("X")/2}
		\draw[radius=\radius] circle;
		\IfBooleanTF#1{\fill[radius=.6*\radius] circle;}{}
	\end{tikzpicture}
}

%%%%%% PROVIDE RELEVANT COMMANDS %%%%%
\newrobustcmd*{\@module}{}
\newrobustcmd*{\@matricno}{}
\providerobustcmd*{\module}[1]{\renewcommand\@module{\textbf{#1}}}
\providerobustcmd*{\matricno}[1]{\renewcommand\@matricno{\textbf{#1}}}

%%%%% CUSTOM TITLE %%%%%
\ifbool{isarticle}{
	\renewrobustcmd{\@maketitle}[1]{
		\newpage
		\null
		\begin{center}
			\let \footnote \thanks
			{\LARGE \@module \\ \@title \par}
			\vskip 1.5em
				{\large
					\lineskip .5em
					\begin{tabular}[t]{c}
						\@author \\
						\@matricno
					\end{tabular}\par}
			\vskip 1em
				{\large \@date}
		\end{center}
		\par
		\vskip 1.5em
	}
}{}

\ifbool{isexam}{
	\renewrobustcmd{\@maketitle}[1]{
		\newpage
		\null
		\begin{center}
			\let \footnote \thanks
			{\LARGE \@module \\ \@title \par}
			\vskip 1.5em
				{\large
					\lineskip .5em
					\begin{tabular}[t]{c}
						\@author \\
						\@matricno
					\end{tabular}\par}
			\vskip 1em
				{\large \@date}
		\end{center}
		\par
		\vskip 1.5em
	}
}{}

\ifbool{isreport}{
	\ifbool{@titlepage}{
		\renewcommand\maketitle{
			\begin{titlepage}%
				\let\footnotesize\small
				\let\footnoterule\relax
				\let \footnote \thanks
				\null\vfil
				\vskip 60\p@
				\begin{center}%
					{\Huge \@module \\ \@title \par}%
					\vskip 3em%
						{\Large
							\lineskip .75em%
							\begin{tabular}[t]{c}%
								\@author \\
								\@matricno
							\end{tabular}\par}%
					\vskip 1.5em%
						{\Large \@date \par}%       % Set date in \large size.
				\end{center}\par
				\@thanks
				\vfil\null
			\end{titlepage}%
			\setcounter{footnote}{0}%
			\global\let\thanks\relax
			\global\let\maketitle\relax
			\global\let\@thanks\@empty
			\global\let\@author\@empty
			\global\let\@date\@empty
			\global\let\@title\@empty
			\global\let\title\relax
			\global\let\author\relax
			\global\let\date\relax
			\global\let\and\relax
		}
	}{
		\renewrobustcmd{\@maketitle}[1]{
			\newpage
			\null
			\begin{center}
				\let \footnote \thanks
				{\LARGE \@module \\ \@title \par}
				\vskip 1.5em
					{\Large
						\lineskip .5em
						\begin{tabular}[t]{c}
							\@author \\
							\@matricno
						\end{tabular}\par}
				\vskip 1em
					{\Large \@date}
			\end{center}
			\par
			\vskip 1.5em
		}
	}
}{}

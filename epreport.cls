% epreport.cls is based on the report class, and simplifies typesetting experimental physics reports.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{epreport}[21/01/16 NUS Experimental Physics report document class]

%%%%% MISCELLANEOUS BUT PRIMARY IMPORTS %%%%%
\RequirePackage{iftex,etoolbox,expl3,xparse}

%%%%% FONTS & SYMBOLS %%%%%
\RequirePackage[utf8]{inputenc}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CLASS OPTIONS DECLARATION AND PROCESSING %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newbool{islmodern}
\newbool{ismpro}
\setbool{islmodern}{true}
%%%%% FONTS %%%%%
\DeclareOption{lmodern}{\booltrue{islmodern}}
\DeclareOption{minionpro}{\booltrue{ismpro}\boolfalse{islmodern}}

%%%%% OTHER OPTIONS TO BE FORWARDED %%%%%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

%%%%% PROCESS THE OPTIONS %%%%%
\ProcessOptions\relax

%%%%% LOAD THE ARTICLE CLASS AS A BASE %%%%%
\LoadClass{article}

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
	%%%%% Define tabular-lining as nothing
	\providerobustcmd{\tablining}{\relax}
	\RequirePackage{esint}
}{}

\ifbool{ismpro}{
	\ifpdftex
		\RequirePackage[
			onlytext,
			minionint,
			lf,
			swash,
			opticals,
			footnotefigures
		]{MinionPro}
		\usepackage[withamsmath]{minionmath}
		\usepackage{amsmath}
		\usepackage{minionamsmath}
		%%%%% Define tabular-lining figures
		\providerobustcmd{\tablining}{\figureversion{tab,lf}}
		\renewcommand{\ttdefault}{lmtt}
		% Use Minion Pro's swash script for \mathcal
		\DeclareMathAlphabet\mathcal{T1}{\Mn@Math@Family}{m}{sw}
		\SetMathAlphabet\mathcal{bold}{T1}{\Mn@Math@Family}{eb}{sw}
	\fi
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PACKAGE IMPORTS %%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% FONTS & SYMBOLS %%%%%
\RequirePackage[nointegrals]{wasysym}
\RequirePackage{microtype}

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
	justification=centering,
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

%%%%% REFERENCES AND LINKS %%%%%
\RequirePackage{hyperref}
\RequirePackage[noabbrev]{cleveref}

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
	urlcolor	= NavyBlue,		% Colour for external hyperlinks
	linkcolor	= Magenta,		% Colour of internal links
	citecolor	= Aquamarine	% Colour of citations
}

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
	bibstyle=numeric-comp,
	citestyle=numeric-comp,
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


% PROVIDE RELEVANT COMMANDS
\newrobustcmd*{\@module}{}
\newrobustcmd*{\@matricno}{}
\providerobustcmd*{\module}[1]{\renewcommand\@module{\textbf{#1}}}
\providerobustcmd*{\matricno}[1]{\renewcommand\@matricno{\textbf{#1}}}

% REDUCE SPACE ABOVE TITLE
\renewrobustcmd{\@maketitle}[1]{
	\newpage
	\null
	\vspace{-1cm}
	\begin{center}
		\let \footnote \thanks
		{\LARGE \@module \par \@title \par}
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

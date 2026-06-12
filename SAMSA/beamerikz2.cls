% A class allowing to create purely TikZ-based Beamer presentations.
%
% author: Michal Skrzypczak
% http://www.mimuw.edu.pl/~mskrzypczak
% e-mail: mskrzypczak@mimuw.edu.pl
%
% With help of dr Szczepan Hummel and comments from dr Filip Mazowiecki!
%
% Propagate with preservation of the above info.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{beamerikz2}[2023/08/30 BeamerikZ 2 class]

% OPTIONS =====================================================================

% what mode is being used (the name: FINAL, READY, BRIEF, SHORT, or DRAFT
\newcommand{\bzUseMode}{FINAL}

% should the grid be used: TRUE or FALSE
\newcommand{\bzUseGrid}{FALSE}
% should the Powered by note be visible: TRUE or FALSE
\newcommand{\bzUseThanks}{TRUE}

% is the current frame in [show] mode: TRUE or FALSE
\newcommand{\bzUseShow}{FALSE}
% is the current box in range: TRUE or FALSE
\newcommand{\bzUseRange}{FALSE}
% is the current frame in [plain] mode: TRUE or FALSE
\newcommand{\bzUsePlain}{FALSE}

% aspect ratio of the beamer presentation
% paper size - width
\newcommand{\bzPaperW}{206mm}
% paper size - height
\newcommand{\bzPaperH}{170mm}
% paper size
\newcommand{\bzPageWidth}{20}

% which font should be used by Beamer
\newcommand{\bzUseFont}{17pt}
% what is the size of the used font
\newcommand{\bzUseScale}{17}
% what is the width of the lines
\newcommand{\bzUseWidth}{1.2pt}

% ready - compile everything, add compile time to the first plain frame
\DeclareOption{ready}{
	\renewcommand{\bzUseMode}{READY}
	\renewcommand{\bzUseGrid}{FALSE}
}

% final - compile everything, no compile time
\DeclareOption{final}{
	\renewcommand{\bzUseMode}{FINAL}
	\renewcommand{\bzUseGrid}{FALSE}
}

% short - compile all the frames in preview mode (one slide per frame),
%		do not show grid on any frame
\DeclareOption{short}{
	\renewcommand{\bzUseMode}{SHORT}
	\renewcommand{\bzUseGrid}{FALSE}
}

% draft - compile all the frames,
%		those with parameter [show] in full step-by-step manner,
%		others in preview mode (one slide per frame),
%		show grid on all frames
%		show slide counter on [show] frames
\DeclareOption{draft}{
	\renewcommand{\bzUseMode}{DRAFT}
	\renewcommand{\bzUseGrid}{TRUE}
}


% brief - compile only [show] frames (in full step-by-step manner),
%		others are replaced by a [HIDDEN] slide (one slide per frame),
%		show grid on all frames
%		show slide counter on [show] frames
\DeclareOption{brief}{
	\renewcommand{\bzUseMode}{BRIEF}
	\renewcommand{\bzUseGrid}{TRUE}
}


% small - make the font have smaller size
\DeclareOption{small}{
	\renewcommand{\bzUseFont}{14pt}
	\renewcommand{\bzUseScale}{14}
	\renewcommand{\bzUseWidth}{1.0pt}
}

% basic - make the font have normal size
\DeclareOption{basic}{
	\renewcommand{\bzUseFont}{17pt}
	\renewcommand{\bzUseScale}{17}
	\renewcommand{\bzUseWidth}{1.2pt}
}
  
% large - make the font bigger than usually
\DeclareOption{large}{
	\renewcommand{\bzUseFont}{20pt}
	\renewcommand{\bzUseScale}{20}
	\renewcommand{\bzUseWidth}{1.4pt}
}
  
% plain - do not show Powered by BeamerikZ on the first plain frame
\DeclareOption{plain}{
	\renewcommand{\bzUseThanks}{FALSE}
}
  
% wide - use 16:9 aspect ratio for the presentation
\DeclareOption{wide}{
	\renewcommand{\bzPaperW}{266mm}
	\renewcommand{\bzPaperH}{170mm}
	\renewcommand{\bzPageWidth}{26}
}

% showgrid - show grid on all frames
\DeclareOption{showgrid}{
	\renewcommand{\bzUseGrid}{TRUE}
}

\ProcessOptions*\relax

% PACKAGES, GEOMETRY ==========================================================

\LoadClass[a4paper]{article}

\RequirePackage{geometry}
\RequirePackage{environ}
\RequirePackage{tikz}
\RequirePackage{xspace}
\RequirePackage{xsavebox}
\RequirePackage[yyyymmdd,hhmmss]{datetime}
\RequirePackage{xargs}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{totcount}

\RequirePackage{amssymb}
\RequirePackage{amsmath}

\pagestyle{plain}

 \geometry{
 	paperwidth=\bzPaperW,
 	paperheight=\bzPaperH,
 	nomarginpar,
	left=3mm,
	top=3mm,
	bottom=3mm,
	right=3mm
 }
 
\setlength{\lineskip}{0cm}
\setlength{\parindent}{0cm}
\setlength{\leftskip}{0cm}
\setlength{\parskip}{0cm}
\setlength{\jot}{0cm}
\hangafter=0

\tikzset{every picture/.style={line width=\bzUseWidth}}

\newtotcounter{bzFall}
\regtotcounter{bzFall}

\newcommand{\insertframenumber}{\bzF}
\newcommand{\inserttotalframenumber}{\total{bzFall}}

% DOCUMENT SETUP ==============================================================

% stores the title of a given presentation (visible in the footline)
\newcommand{\bzTitle}{}

% stores the list of authors of a given presentation (visible in the footline)
% do not use \and here!
\newcommand{\bzAuthor}{}
  
% sets the title / author of a given presentation
% you may use Latex code inside, like \sBzTitle{\bf Something}
\newcommand{\sBzTitle} [1]{\renewcommand{\bzTitle} {#1}}
\newcommand{\sBzAuthor}[1]{\renewcommand{\bzAuthor}{#1}}

% COLOURS =====================================================================

\definecolor{bzDBlue}{RGB}{3, 63, 99}
\definecolor{bzPurple}{RGB}{139, 30, 63}
\definecolor{bzOrange}{RGB}{234, 140, 85}
\definecolor{bzBlack}{RGB}{13,55,70}
\definecolor{bzGreen}{RGB}{13,168,67}
\definecolor{bzBlue}{RGB}{18,76,183}
\definecolor{bzRed}{RGB}{248,51,60}
\definecolor{bzWhite}{RGB}{255,255,255}
\definecolor{bzGray}{RGB}{173,175,178}

\newcommand{\bzCtext}{bzBlack}
\newcommand{\bzCemph}{bzDBlue}
\newcommand{\bzChigh}{bzPurple}
\newcommand{\bzCname}{bzOrange}
\newcommand{\bzCback}{bzWhite}
  
% TiKZ LIBRARIES ==============================================================

\usetikzlibrary{calc}
\usetikzlibrary{positioning}
\usetikzlibrary{fit}
\usetikzlibrary{backgrounds}
\usetikzlibrary{decorations.pathmorphing}
\usetikzlibrary{decorations.pathreplacing}
\usetikzlibrary{decorations.markings}
\usetikzlibrary{decorations}
\usetikzlibrary{arrows}
\usetikzlibrary{arrows.meta}
\usetikzlibrary{patterns}
\usetikzlibrary{shapes}

% ARITHMETIC ==================================================================

% These commands perform immidetely the arithmetical computetion given in
% the second argument % and store the result in the first argument, like:
% \bzEval{\x}{(1+\x)*\y+12.1}

% This is the general one, that works on floating point numbers
\newcommand{\bzEval}[2]{%
	\pgfmathparse{#2}%
	{\xdef#1{\pgfmathresult}}%
}

% This one returns the number rounded as an integer
\newcommand{\bzEvalInt}[2]{%
	\pgfmathparse{int(#2)}%
	{\xdef#1{\pgfmathresult}}%
}

% COUNTERS ====================================================================

% frame number counter
\bzEvalInt{\bzF}{1}
\newcommand{\iBzF}{\bzEvalInt{\bzF}{\bzF+1}}

% box number counter
\bzEvalInt{\bzB}{0}
\newcommand{\zBzB}{\bzEvalInt{\bzB}{0}}
\newcommand{\iBzB}{\bzEvalInt{\bzB}{\bzB+1}}

% slide number counter
\bzEvalInt{\bzS}{1}
\newcommand{\sBzS}[1]{\bzEvalInt{\bzS}{#1}}
\newcommand{\zBzS}{\bzEvalInt{\bzS}{1}}
\newcommand{\dBzS}[1][1]{\bzEvalInt{\bzS}{\bzS-(#1)}}
\newcommand{\iBzS}[1][1]{\bzEvalInt{\bzS}{\bzS+(#1)}}

% defines the line height for multiline nodes and step of \bzH counter
\bzEval{\bzHStep}{1.0}
\newcommand{\zBzHStep}{\bzEval{\bzHStep}{1.0}}
\newcommand{\sBzHStep}[1]{\bzEval{\bzHStep}{#1}}

% height - vertical align counter
\bzEval{\bzH}{0}
\newcommand{\sBzH}[1]{\bzEval{\bzH}{#1}}
\newcommand{\zBzH}{\bzEval{\bzH}{0.0}}
\newcommand{\iBzH}[1][\bzHStep]{\bzEval{\bzH}{\bzH-(#1)}}
\newcommand{\dBzH}[1][\bzHStep]{\bzEval{\bzH}{\bzH+(#1)}}

% indent - horizontal align counter
\bzEval{\bzI}{-\bzPageWidth*0.5}
\newcommand{\sBzI}[1]{\bzEval{\bzI}{#1}}
\newcommand{\zBzI}{\bzEval{\bzI}{-\bzPageWidth*0.5}}
\newcommand{\iBzI}[1][1.0]{\bzEval{\bzI}{\bzI+(#1)}}
\newcommand{\dBzI}[1][1.0]{\bzEval{\bzI}{\bzI-(#1)}}

\newcommand{\aBzI}[1][1.0]{
	\bzEval{\bzArg}{#1}%
	\bzEval{\bzI}{\bzI+\bzArg}}

\newcommand{\uBzI}[1]{
	\bzEval{\bzArg}{#1}%
	\bzEval{\bzI}{\bzI+\bzArg}}

% list numbering counter
\bzEvalInt{\bzL}{0}
\newcommand{\zBzL}{\bzEvalInt{\bzL}{0}}
\newcommand{\iBzL}[1][1]{\bzEvalInt{\bzL}{\bzL+(#1)}}

% node numbering counter
\bzEvalInt{\bzN}{0}
\newcommand{\zBzN}{\bzEvalInt{\bzN}{0}}
\newcommand{\iBzN}{\bzEvalInt{\bzN}{\bzN+1}}

% gives the label of a node of a given number
\newcommand{\bzLabel}[1]{beamerikzNode#1}

% PLACING CONTENT ON PAGE =====================================================

\newcommand{\bzPlaceOverlay}[1]{%
\begin{textblock*}{\bzPageWidth cm}(3mm,3mm)#1\end{textblock*}%
}

\newcommand{\bzTikzPicture}[1]{%
\makebox[\bzPageWidth cm][c]{%
\begin{tikzpicture}%
#1
\end{tikzpicture}}}

\newcommand{\bzTikzScope}[1]{%
\begin{scope}
\clip(-\bzPageWidth*0.5-0.5, 1.1) rectangle (+\bzPageWidth*0.5+0.5, -15.3);
#1
\end{scope}
}


% APPEARING AND DISAPPEARING OF THE CONTENT ===================================

% Shows the given content on slides in-between the given two numbers
% When an argument is skipped, taken as the first / last slide
\newcommand{\bzIn}[4][0]{
\bzEvalInt{\bzZbox}{#1}%
\ifthenelse{\equal{#2}{}}{\bzEvalInt{\bzSini}{0}}{\bzEvalInt{\bzSini}{#2}}%
\ifthenelse{\equal{#3}{}}{\bzEvalInt{\bzSfin}{0}}{\bzEvalInt{\bzSfin}{#3}}%
%
\expandafter\xdef\csname bzZbox-\bzF-\bzB \endcsname{\bzZbox}%
\expandafter\xdef\csname bzSini-\bzF-\bzB \endcsname{\bzSini}%
\expandafter\xdef\csname bzSfin-\bzF-\bzB \endcsname{\bzSfin}%
\begin{xlrbox}{bzBox-\bzB}%
\bzTikzPicture{%
\bzTikzScope{#4}%
}%
\end{xlrbox}%
\iBzB%
}

% shows the given content from that moment on and increases \bzS
\newcommand{\bzOn}[2][0]{\bzIn[#1]{\bzS}{}{#2}\iBzS}

% shows the given content in all steps
\newcommand{\bzAll}[2][0]{\bzIn[#1]{}{}{#2}}

% shows the given content for one step and increases \bzS
\newcommand{\bzOne}[2][0]{\bzIn[#1]{\bzS}{\bzS}{#2}\iBzS}

% shows the given content for two steps and increases \bzS
\newcommand{\bzTwo}[2][0]{\bzIn[#1]{\bzS}{\bzS+1}{#2}\iBzS}

% shows the given content for one steps and waits for it to vanish - 
% increases \bzS by two
\newcommand{\bzOnly}[2][0]{\bzIn[#1]{\bzS}{\bzS}{#2}\iBzS\iBzS}

% FRAME ELEMENTS ==============================================================

% shows the stylized logo of the package
\newcommand{\beamerikz}{{\normalfont \texttt{Beamer}i\textit{k}Z}\xspace}

% Should show all the intermediate slides
\newcommand{\bzShowAll}{1}

% is this the first plain frame in the presentation (counter)
\newcommand{\bzNumFF}{0}

% reset counters for a new frame
\newcommand{\bzResetFrame}{
\bzEvalInt{\bzSmax}{0}
\zBzB%
\zBzS%
\zBzHStep%
\zBzH%
\zBzI%
\zBzL%
\zBzN%
\color{\bzCtext}%
\fontsize{\bzUseFont}{\bzHStep cm}%
\selectfont%
}

% Shows the coordinate system of a frame
\newcommand{\bzGrid}{
	\path[draw, step=1.0, dashed, bzGray!40, thin]
		(-\bzPageWidth*0.5, -14.5) grid (+\bzPageWidth*0.5, 1);
  
	\path[draw, ultra thick, bzGray!70] (0, -14.5) -- (0, 1.0);

	\foreach \x in {-15,-10, -5, 0, 5, 10, 15} {
		\path[draw, thin, bzGray!40] (\x, -14.5) -- (\x, 1.0);
	}

	\path[draw, ultra thick, bzGray!60]
		(-\bzPageWidth*0.5, 0.0) -- (+\bzPageWidth*0.5, 0.0);

	\foreach \y in {0, -5, -10} {
		\path[draw, thin, bzGray!40]
			(-\bzPageWidth*0.5, \y) -- (+\bzPageWidth*0.5, \y);
	}
}

\newcommand{\bzShowScope}{
	\bzTikzScope{
	}
}

\newcommand{\bzShowGrid}{
	\ifthenelse{\equal{\bzUseGrid}{TRUE}}{
		\bzGrid
	}{}
}

\newcommand{\bzShowHidden}{
	\ifthenelse{\equal{\bzUseMode}{BRIEF} \AND \equal{\bzUseShow}{FALSE}}{
		\node[bzC, scale=2.0] at (0,-5) {[ HIDDEN ]};
	}{}
}

% Shows the compile information
\newcommand{\bzShowCompileInfo}{
	\ifthenelse{\equal{\bzUseMode}{READY} \AND \equal{\bzNumFF}{0}}{
		\bzOn{
			\node[scale=10/\bzUseScale, bzC] at (0, -15) {%
				\texttt{$\big[$\today\ %
				\currenttime\ %
				(\inserttotalframenumber)}$\big]$%
			};
		}
	}{}
}

% show footline of a slide - author, title, and frame number
\newcommand{\bzShowFootline}{
	\ifthenelse{\equal{\bzUsePlain}{FALSE}}{
		\node[scale=10/\bzUseScale, bzR] at (-0.5, -15.0) {\bzAuthor};
		\node[scale=10/\bzUseScale, bzL] at (+0.5, -15.0) {\bzTitle};
		\node[scale=10/\bzUseScale, bzR] at (+\bzPageWidth*0.5, -15.0)
			{\insertframenumber\, / \ \inserttotalframenumber};
	}{}
}

% show slide counter if the mode requires that (if grid is visible)
\newcommand{\bzShowSlideCount}[1]{
\ifthenelse{\equal{\bzUseShow}{TRUE} \AND %
	\(\equal{\bzUseMode}{DRAFT} \OR \equal{\bzUseMode}{BRIEF}\)}{
	\bzPlaceOverlay{\bzTikzPicture{\bzTikzScope{%
		\node[scale=10/\bzUseScale, bzL, text=gray] at (-\bzPageWidth*0.5, -15)
			{(#1)};
	}}}%
}{}%
}

% shows the powered by info
\newcommand{\bzShowPowered}{
	\ifthenelse{
		\equal{\bzUseThanks}{TRUE} \AND 
		\equal{\bzUsePlain}{TRUE} \AND 
		\equal{\bzNumFF}{0}}{
		\node[bzR, scale=9/\bzUseScale] at (+\bzPageWidth*0.5, -15)
			{\textbf{Powered by} \beamerikz};
	}{}
}

% FRAMES ======================================================================

\newcommand{\bzShowSlideZIndex}[1]{
\foreach \bzBrun in {0,...,\bzBmax} {%
	\bzEvalInt{\bzZbox}{\csname bzZbox-\bzF-\bzBrun\endcsname}%
	\ifthenelse{\equal{#1}{\bzZbox}}{
	\bzEvalInt{\bzSini}{\csname bzSini-\bzF-\bzBrun\endcsname}%
	\bzEvalInt{\bzSfin}{\csname bzSfin-\bzF-\bzBrun\endcsname}%
	\ifthenelse{%
		\(\bzSini=0 \OR \bzSini=\bzSrun \OR \bzSini<\bzSrun\) \AND%
		\(\bzSfin=0 \OR \bzSfin=\bzSrun \OR \bzSfin>\bzSrun\)}{%
		\renewcommand{\bzUseRange}{TRUE}%
	}{%
		\renewcommand{\bzUseRange}{FALSE}%
	}%
	\ifthenelse{%
		\(\equal{\bzUseMode}{READY} \AND \equal{\bzUseRange}{TRUE}\) \OR %
		\(\equal{\bzUseMode}{FINAL} \AND \equal{\bzUseRange}{TRUE}\) \OR %
		\(\equal{\bzUseMode}{SHORT}\) \OR %
		\(\equal{\bzUseMode}{DRAFT} \AND \equal{\bzUseRange}{TRUE}\) \OR 
		\(\equal{\bzUseMode}{DRAFT} \AND \equal{\bzUseRange}{FALSE} \AND %
										 \equal{\bzUseShow}{FALSE}\) \OR %
		\(\equal{\bzUseMode}{BRIEF} \AND \equal{\bzUseRange}{TRUE} \AND %
										 \equal{\bzUseShow}{TRUE}\)}{%
		\bzPlaceOverlay{\xusebox{bzBox-\bzBrun}}%
	}{%
	}%
	}{}%
}%
}

\newcommand{\bzShowSlide}{
\bzShowSlideZIndex{-1}%
\bzPlaceOverlay{\xusebox{bzBox}}%
\bzShowSlideZIndex{0}%
\bzShowSlideZIndex{1}%
\null\newpage%
}

\newcommand{\bzShowFrame}{
\bzResetFrame%
\ifthenelse{\equal{\bzUseMode}{BRIEF} \AND \equal{\bzUseShow}{FALSE}}{%
\bzPlaceOverlay{%
\bzTikzPicture{%
	\bzShowScope
	\bzShowHidden
	\bzShowFootline
}%
}%
\null\newpage%
}{%
\BODY%
\bzShowCompileInfo%
\begin{xlrbox}{bzBox}%
\bzTikzPicture{
	\bzShowScope
	\bzShowGrid
	\bzShowFootline
	\bzShowPowered
}%
\end{xlrbox}%
\bzEvalInt{\bzBmax}{\bzB-1}%
\bzEvalInt{\bzSmax}{max(\bzSmax,\bzS-1)}%
\ifthenelse{%
	\(\equal{\bzUseMode}{SHORT}\) \OR%
	\(\equal{\bzUseMode}{DRAFT} \AND \equal{\bzUseShow}{FALSE}\)}{%
	\bzEvalInt{\bzSrun}{0}%
	\bzShowSlide%
}{%
	\foreach \bzSrun in {1,...,\bzSmax} {
		\bzShowSlideCount{\bzSrun}%s
		\bzShowSlide%
	}%
}%
}%
}

% Shows a normal frame
% Optional argument [show] makes the frame visibile in all compile modes
\NewEnviron{bzFrame}[1][]{%
\ifthenelse{\equal{#1}{show}}{%
\renewcommand{\bzUseShow}{TRUE}%
}{%
\renewcommand{\bzUseShow}{FALSE}%
}%
\renewcommand{\bzUsePlain}{FALSE}%
\bzShowFrame%
\iBzF%
\stepcounter{bzFall}%
}

% Shows a plain frame (no bottom line)
% Optional argument [show] makes the frame visibile in all compile modes
% in ready compile mode the first plain frame gets compile information
\NewEnviron{bzPlainFrame}[1][]{%
\ifthenelse{\equal{#1}{show}}{%
\renewcommand{\bzUseShow}{TRUE}%
}{%
\renewcommand{\bzUseShow}{FALSE}%
}%
\renewcommand{\bzUsePlain}{TRUE}%
\bzShowFrame%
\bzEvalInt{\bzNumFF}{\bzNumFF+1}%
}

% NODE STYLES =================================================================

\tikzstyle{bzFlow} = [%
	execute at begin node=\setlength{\baselineskip}{\bzHStep cm},
	inner sep=0cm, node distance=0cm and 0cm, outer sep=0cm]

% text node extending to right (alignet left)
\tikzstyle{bzL} = [bzFlow, anchor=mid west, align=left]

% text node aligned centrally
\tikzstyle{bzC} = [bzFlow, anchor=mid     , align=center,%
			bzM/.default={0 cm - \bzI cm - \bzI}]

% text node extending to left (aligned right)
\tikzstyle{bzR} = [bzFlow, anchor=mid east, align=right]
				
\tikzset{bzM/.style args = {#1}{text width=#1 cm}}

\tikzset{bzM/.default={\bzPageWidth*0.5 cm - \bzI}}

% graphical node anchored at the center of the picture
\tikzstyle{bzG} = [bzFlow, anchor=center, align=center]

% DISPLAY STYLES ==============================================================

% only boldfaced text
\newcommand{\bo}[1]{\textbf{#1}}

% highlighted text
\newcommand{\hl}[1]{\textcolor{\bzChigh}{#1}}

% emphasized text
\newcommand{\el}[1]{\textcolor{\bzCemph}{#1}}

% highlighted and boldfaced
\newcommand{\hb}[1]{\hl{\bo{#1}}}

% emphasized and boldfaced
\newcommand{\eb}[1]{\el{\bo{#1}}}

% displays the given argument as names of authors (in brackets). If
% the argument is empty, displays nothing (not even the brackets).
\newcommand{\bzNames}[1]{%
	\ifthenelse{\equal{#1}{}}{%
	}{%
		\textcolor{\bzCname}{(#1)}}%
	}
	
% NODE STYLES =================================================================

% Styles of TikZ nodes corresponding to the above commands \hl etc

% Boldfaced node (does not affect mathematics)
\tikzstyle{bzBO} = [font = \bfseries]

% Highlighted node
\tikzstyle{bzHL} = [text = \bzChigh]

% Emphasised node
\tikzstyle{bzEL} = [text = \bzCemph]

% Boldfaced and highlighted
\tikzstyle{bzHB} = [bzBO, bzHL]

% Boldfaced and emphasised
\tikzstyle{bzEB} = [bzBO, bzEL]

% FRAME NODES =================================================================

% All the following commands go with variants BO, HL, HB, EL, and EB,
% that use the respective highlighting commands for the content.

% just a node, with no modification to the coordinates (but with a label)
\newcommand{\bzNode}[2][]{
	\iBzN
	\node[bzL, #1] (\bzLabel{\bzN}) at (\bzI, \bzH) {#2};
}

% text aligned immidately to left
\newcommand{\bzLeft}[2][]{
	\iBzN
	\node[bzL, #1] (\bzLabel{\bzN}) at (\bzI, \bzH) {#2};
	\iBzH
}

% text aligned to left, with an ident
\newcommand{\bzText}[2][]{
	\iBzN
	\iBzI
	\node[bzL, #1] (\bzLabel{\bzN}) at (\bzI, \bzH) {#2};
	\dBzI
	\iBzH
}

% the shape of the item dot
\newcommand{\bzItemDot}{$\bullet$}

% reset the dot to the standard shape
\newcommand{\zBzItemDot}{\renewcommand{\bzItemDot}{$\bullet$}}

% item of an itemized list, aligned to left, with an ident
\newcommand{\bzItem}[2][]{
	\iBzN
	\iBzI
	\node[bzC] at (\bzI-0.4, \bzH) {\bzItemDot};
	\node[bzL, #1] (\bzLabel{\bzN}) at (\bzI, \bzH) {#2};
	\dBzI
	\iBzH
}

% item of an enumerated list, aligned to left, with an ident
\newcommand{\bzList}[2][]{
	\iBzN
	\iBzL
	\iBzI
	\node[bzR] at (\bzI-0.15, \bzH) {\bf \bzL.};
	\node[bzL, #1] (\bzLabel{\bzN}) at (\bzI, \bzH) {#2};
	\dBzI
	\iBzH
}

% text aligned immidately to right
\newcommand{\bzRight}[2][]{
	\iBzN
	\node[bzR, #1] (\bzLabel{\bzN}) at (-\bzI, \bzH) {#2};
	\iBzH
}

% text aligned to center
\newcommand{\bzCenter}[2][]{
	\iBzN
	\node[bzC, #1] (\bzLabel{\bzN}) at (0, \bzH) {#2};
	\iBzH
}

% Continue last node to the right.
% You can also provide a number (retriven by \bzN) of a node as
% the last (third) optional argument.
% \bzH is not incremented
\newcommandx{\bzNext}[3][1, 3=\bzN]{
	\bzEvalInt{\bzLNumber}{#3}
	\iBzN
	\node[bzL, base right = of \bzLabel{\bzLNumber}, #1] (\bzLabel{\bzN}) {#2};
}

% Continue last node to the left. 
% You can also provide a number (retriven by \bzN) of a node as
% the last (third) optional argument.
% \bzH is not incremented
\newcommandx{\bzPrev}[3][1, 3=\bzN]{
	\bzEvalInt{\bzLNumber}{#3}
	\node[bzR, base left = of \bzLabel{\bzLNumber}, #1] {#2};
}

% BLOCKS ======================================================================

% Beamer-like block with rounded upper corners and sharp lower corners.
% The default layout is draw.
% You can disable it by using in the first optional argument [draw=none]
\newcommand{\bzBlock}[3][]{
	\path[draw, rounded corners=2mm, #1]% 
    	(-\bzPageWidth*0.5, \bzH)% 
	    [] |- (0.0, \bzH+#2)% 
    	[] -| (+\bzPageWidth*0.5, \bzH)% 
	    [sharp corners] |- (0.0, \bzH-#3)% 
	    [sharp corners] -| cycle;
}

% BRACES ======================================================================

\tikzstyle{bzBrace} = [draw,
	decoration={brace, amplitude=\bzUseScale * 0.15mm},
	decorate]

% upper brace
\tikzstyle{bzBraceU} = [bzBrace,
	decoration={mirror},
	every node/.style={anchor=mid     , yshift=\bzUseScale * -0.40mm}]

% right brace
\tikzstyle{bzBraceR} = [bzBrace,
	decoration={mirror},
	every node/.style={anchor=mid west, xshift=\bzUseScale * +0.10mm}]

% over brace
\tikzstyle{bzBraceO} = [bzBrace,
	decoration={},
	every node/.style={anchor=mid     , yshift=\bzUseScale * +0.35mm}]

% left brace
\tikzstyle{bzBraceL} = [bzBrace,
	decoration={},
	every node/.style={anchor=mid east, xshift=\bzUseScale * -0.10mm}]

% BRACES AROUND NODES =========================================================

% Place under-brace under the last node. 
% You can also provide a number (retriven by \bzN) of a node as
% the last (third) optional argument.
\newcommandx{\bzBraceU}[3][1, 3=\bzN]{
	\bzEvalInt{\bzLNumber}{#3}
	\path
		($(\bzLabel{\bzLNumber}.mid west) +
			(0,-\bzUseScale * 0.25mm)$)
		edge[bzBraceU] node[#1] {#2}
		($(\bzLabel{\bzLNumber}.mid east) +
			(0,-\bzUseScale * 0.25mm)$);
}


% Place right-brace next to the last node. 
% You can also provide a number (retriven by \bzN) of a node as
% the last (third) optional argument.
\newcommandx{\bzBraceR}[3][1, 3=\bzN]{
	\bzEvalInt{\bzLNumber}{#3}
	\path
		($(\bzLabel{\bzLNumber}.mid east) +
			(0,-\bzUseScale * 0.25mm)$)
		edge[bzBraceR] node[#1] {#2}
		($(\bzLabel{\bzLNumber}.north east) +
			(0,\bzUseScale * 0.12mm)$);
}


% Place over-brace above the last node. 
% You can also provide a number (retriven by \bzN) of a node as
% the last (third) optional argument.
\newcommandx{\bzBraceO}[3][1, 3=\bzN]{
	\bzEvalInt{\bzLNumber}{#3}
	\path
		($(\bzLabel{\bzLNumber}.mid west) +
			(0,\bzUseScale * 0.35mm)$)
		edge[bzBraceO] node[#1] {#2}
		($(\bzLabel{\bzLNumber}.mid east) +
			(0,\bzUseScale * 0.35mm)$);
}


% Place left-brace next to the last node. 
% You can also provide a number (retriven by \bzN) of a node as
% the last (third) optional argument.
\newcommandx{\bzBraceL}[3][1, 3=\bzN]{
	\bzEvalInt{\bzLNumber}{#3}
	\path
		($(\bzLabel{\bzLNumber}.mid west) +
			(0,-\bzUseScale * 0.25mm)$)
		edge[bzBraceL] node[#1] {#2}
		($(\bzLabel{\bzLNumber}.north west) +
			(0,\bzUseScale * 0.12mm)$);
}

% FRAME COMPONENTS ============================================================

% shows the given content on the background layer, behind the normal content
\newcommand{\bzUnder}[1]{
	%\begin{scope}[on background layer]
	#1
	%\end{scope}
}

% centered mathematical content
\newcommand{\bzEq}[1]{\ensuremath{\begin{aligned}[t]#1\end{aligned}}}

% multi-line content with automatical line-breaking
\newcommand{\bzBox}[2][]{
	\node[bzL, bzM, #1] at (\bzI, \bzH) {#2};
	\iBzH
}

% displays the abstract theorem
\newcommand{\bzThm}[4][]{
	\bzLeft{\hb{#2} \bzNames{#3}}
	\bzText[bzM, #1]{#4}
}

\newcommand{\bzTheorem}[3][]    {\bzThm[#1]{Theorem}{#2}{#3}}
\newcommand{\bzLemma}[3][]      {\bzThm[#1]{Lemma}{#2}{#3}}
\newcommand{\bzFact}[3][]       {\bzThm[#1]{Fact}{#2}{#3}}
\newcommand{\bzConjecture}[3][] {\bzThm[#1]{Conjecture}{#2}{#3}}
\newcommand{\bzDefinition}[3][] {\bzThm[#1]{Definition}{#2}{#3}}
\newcommand{\bzQuestion}[3][]   {\bzThm[#1]{Question}{#2}{#3}}
\newcommand{\bzProblem}[3][]    {\bzThm[#1]{Problem}{#2}{#3}}
\newcommand{\bzProposition}[3][]{\bzThm[#1]{Proposition}{#2}{#3}}
\newcommand{\bzCorollary}[3][]  {\bzThm[#1]{Corollary}{#2}{#3}}
\newcommand{\bzExercise}[3][]   {\bzThm[#1]{Exercise}{#2}{#3}}
\newcommand{\bzExample}[3][]    {\bzThm[#1]{Example}{#2}{#3}}

% displays proof of a theorem
\newcommand{\bzProof}[2][]{
	\bzLeft[bzBO]{Proof}
	\bzText[bzM, #1]{#2}
}

% displays QED symbol
\newcommand{\bzQed}[1][]{
	\bzRight[#1]{\ensuremath{\blacksquare}}
}

% displays horizontal line
\newcommand{\bzLine}[1][]{
	\draw[line cap=round, #1]
		(-\bzPageWidth*0.5, \bzH + 0.5) -- (+\bzPageWidth*0.5, \bzH + 0.5);
}

% END =========================================================================

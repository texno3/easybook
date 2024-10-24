% --------------------------------------------------------------------------
% the CNLTX bundle
%
%   LaTeX source code and output
%
% --------------------------------------------------------------------------
% Clemens Niederberger
% Web:    https://github.com/cgnieder/cnltx/
% E-Mail: contact@mychemistry.eu
% --------------------------------------------------------------------------
% Copyright 2013--2019 Clemens Niederberger
% Adaptation for easybook manuals by QuYi
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Clemens Niederberger.
% --------------------------------------------------------------------------
% If you have any ideas, questions, suggestions or bugs to report, please
% feel free to contact me.
% --------------------------------------------------------------------------
\RequirePackage{cnltx-base}
\ProvidesClass{cnltx-doc}[\cnltx@@date\space \cnltx@@version\space
 \cnltx@@info]

\cnltx@create@bundle@message*{doc}{Error}
\cnltx@create@bundle@message*{doc}{Warning}
\cnltx@create@bundle@message*{doc}{WarningNoLine}
\cnltx@create@bundle@message*{doc}{Info}

\newbool{cnltx@load@preamble}
\newbool{cnltx@add@index}
\newbool{cnltx@add@bib}
\newbool{cnltx@load@fonts}
\newbool{cnltx@microtype}
\newbool{cnltx@layout}

\booltrue{cnltx@layout}

\newcommand*\cnltx@scrartcl@options{}
\newcommand*\cnltx@babel@options{english}


\pgfkeys{
  cnltx-doc/.cd,
    scrartcl/.code         = \PassOptionsToClass{#1}{scrartcl} ,
    load-preamble--/.is if = cnltx@load@preamble ,
    load-fonts/.is if      = cnltx@load@fonts ,
    load-microtype/.is if  = cnltx@microtype ,
    load-preamble-/.code   =
      \booltrue{cnltx@load@preamble}
      \booltrue{cnltx@microtype} ,
    load-preamble/.code    =
      \booltrue{cnltx@load@preamble}
      \booltrue{cnltx@load@fonts}
      \booltrue{cnltx@microtype} ,
    add-index/.is if       = cnltx@add@index ,
    add-bib/.is if         = cnltx@add@bib ,
    load-preamble+/.code   =
      \booltrue{cnltx@load@preamble}
      \booltrue{cnltx@load@fonts}
      \booltrue{cnltx@microtype}
      \booltrue{cnltx@add@index}
      \booltrue{cnltx@add@bib} ,
    babel-options/.code    = \def\cnltx@babel@options{#1} ,
    adapt-layout/.is if    = cnltx@layout ,
    unknown/.code          =
      \edef\cnltx@scrartcl@options{\cnltx@scrartcl@options,\pgfkeyscurrentname}
}

\ProcessPgfOptions{/cnltx-doc}

\LoadClass[\cnltx@scrartcl@options]{scrartcl}


\newcommand*\cnltx@index@prologue{}
\newbool{cnltx@index@prologue}
\newlength\cnltx@index@space

\newcommand*\cnltx@index@setup{othercode=\footnotesize,level=\addsec}
\newcommand*\cnltx@makeindex@setup{columns=2,columnsep=1em}
\newcommand*\cnltx@index@style{cnltx.ist}

\pgfkeys{
  cnltx/.cd,
    index-prologue/.code  =
      \def\cnltx@index@prologue{#1}
      \booltrue{cnltx@index@prologue} ,
    index-space/.code     = \setlength\cnltx@index@space{#1} ,
    index-setup/.code     = \def\cnltx@index@setup{#1} ,
    makeindex-setup/.code = \def\cnltx@makeindex@setup{#1} ,
    index-style/.code     = \def\cnltx@index@style{#1}
}


\cnltx@load@modules{tools,example,translations}

\newcommand*\cnltx@caption@font{\normalfont\small\sffamily}
\newcommand*\cnltx@captionlabel@font{\cnltx@caption@font\scshape}

\pgfkeys{
  cnltx/.cd,
    caption-font/.code = \def\cnltx@caption@font{#1} ,
    caption-label-font/.code = \def\cnltx@captionlabel@font{\cnltx@caption@font#1}
}


\RequirePackage{unicode-math,fontspec}
\setmainfont{TeXGyreTermesX}[
  Extension      = .otf,
  UprightFont    = *-Regular,
  BoldFont       = *-Bold,
  ItalicFont     = *-Italic,
  BoldItalicFont = *-BoldItalic,
  SlantedFont    = *-Slanted,
  BoldSlantedFont= *-BoldSlanted]
\setsansfont{texgyreheros}[
  Extension      = .otf,
  UprightFont    = *-regular,
  BoldFont       = *-bold,
  ItalicFont     = *-italic,
  BoldItalicFont = *-bolditalic]
\setmonofont{lmmono10}[
  Extension      = .otf,
  UprightFont    = *-regular]
\setmathfont{LibertinusMath-Regular.otf}

\ifbool{cnltx@layout}{
  \renewcommand*\sectionformat{%
    \textcolor{cnltx}{\thesection\autodot}\enskip
  }
  \renewcommand*\subsectionformat{%
    \textcolor{cnltx}{\thesubsection\autodot}\enskip
  }
  \renewcommand*\subsubsectionformat{%
    \textcolor{cnltx}{\thesubsubsection\autodot}\enskip
  }
  \setkomafont{subsubsection}{\normalfont\normalsize\itshape}
  \renewcommand*\partformat{%
    \textcolor{cnltx}{\partname~\thepart\autodot}%
  }
  \renewcommand*\partformat{%
    \textcolor{cnltx}{\partname~\thepart\autodot}}
  \deffootnote{2em}{1em}{\llap{\thefootnotemark. }}%
  \RequirePackage{scrlayer-scrpage}
  \chead{\rightmark}
  \KOMAoptions{automark}
  \pagestyle{scrheadings}
  \setcapindent{1.5em}
  \setkomafont{caption}{\cnltx@caption@font}
  \setkomafont{captionlabel}{\cnltx@captionlabel@font}
}{}

\ifbool{cnltx@add@bib}{
  \RequirePackage[
    backend=biber,
    style=cnltx,
    sortlocale=en_US,
    indexing=cite]{biblatex}
  \addbibresource{cnltx.bib}
  \AtEndDocument{\printbibliography[heading=bibnumbered,title=参考文献]}
}{}

\ifbool{cnltx@add@index}{
  \AtEndPreamble{%
    \RequirePackage{imakeidx}
    \indexsetup{noclearpage,firstpagestyle=scrheadings}
    \expandafter\indexsetup\expandafter{\cnltx@index@setup}
    \expandafter\makeindex\expandafter
      [\cnltx@makeindex@setup,options={-s \cnltx@index@style}]
    \AtEndDocument{%
      \ifbool{cnltx@index@prologue}{%
        \indexprologue
          [\vspace{\cnltx@index@space}]
          {\noindent\cnltx@index@prologue}
      }{}%
      \renewcommand{\indexname}{索引}
      \def\imki@indexlevel{\section}
      \def\imki@indexheaders{}
      \printindex
    }%
  }
}{}
\AtBeginDocument{%
  \immediate\write\@auxout{%
    \unexpanded{%
      \ifx\texorpdfstring\@undefined^^J
        \providecommand\texorpdfstring[2]{#1}^^J
        \providecommand\pdfstringdefDisableCommands[1]{}^^J
        \providecommand\nohyperpage[1]{#1}^^J
      \fi
    }%
  }%
}

% --------------------------------------------------------------------------
% license information:
% define those differently:
\newcommand*\lppl{\cnltx@acronym{LPPL}{lppl}}
\newcommand*\LPPL{%
  \LaTeX{} Project Public License%
  \index{LPPL@{\cnltx@acronym@format lppl}}%
}

\newrobustcmd*\license{\@ifstar{\cnltx@license}{\cnltx@license\cnltx@par}}
\newcommand\cnltx@license[1][maintained]{%
  \GetTranslation{cnltx-license} ``#1.''%
}

% CTAN:
\newcommand*\ctan{\cnltx@acronym{CTAN}{ctan}}
\newcommand*\CTAN{%
  Comprehensive \TeX\ Archive Network%
  \index{CTAN@{\cnltx@acronym@format ctan}}%
}

% --------------------------------------------------------------------------
% package information:
\newrobustcmd*\cnltx@getfileinfo[2]{%
  \def\cnltx@tmpa##1 ##2 ##3\relax##4\relax{%
    \gdef\cnltx@package@date{##1}%
    \gdef\cnltx@package@version{##2}%
    \gdef\cnltx@package@info{##3}}%
  \edef\cnltx@tmpb{\csname ver@#1.#2\endcsname}%
  \expandafter\cnltx@tmpa\cnltx@tmpb\relax? ? \relax\relax}

\newcommand*\cnltx@package@name{??}
\newbool{cnltx@package@name}
\newcommand*\cnltx@package@date{??}
\newcommand*\cnltx@package@version{??}
\newcommand*\cnltx@package@info{??}
\newcommand*\cnltx@package@title{??}
\newcommand*\cnltx@title@format{\bfseries\scshape}
\newbool{cnltx@package@title}
\newbool{cnltx@build@title}
\newcommand*\cnltx@package@subtitle{??}
\newbool{cnltx@package@subtitle}
\newcommand*\cnltx@package@url{??}
\newbool{cnltx@package@url}
\newcommand*\cnltx@package@email{??}
\newbool{cnltx@package@email}
\newcommand*\cnltx@package@abstract{??}
\newbool{cnltx@package@abstract}
\newcommand*\cnltx@package@abstract@width{.75\linewidth}
\newcommand*\cnltx@package@abstract@format{\setlength\parskip{.333\baselineskip}}

\newrobustcmd*\cnltxpackagenameformat[1]{\textcolor{cnltx}{\textsc{#1}}}

\newrobustcmd*\cnltx@newpackagename[2]{%
  \newcommand*#1{\texorpdfstring{\cnltxpackagenameformat{#2}}{#2}}%
}
\newrobustcmd*\newpackagename{\cnltx@newpackagename}

% --------------------------------------------------------------------------
% authors:
\newcommand*\cnltx@package@author@list{}
\newcommand*\cnltx@package@author@pdflist{}
\newrobustcmd*\cnltx@new@author[1]{%
  \listadd\cnltx@package@author@list
    {\cnltx@read@name{#1}}%
  \listadd\cnltx@package@author@pdflist
    {\cnltx@extract@name{#1}}%
}

% writing the names and email addresses:
\newcommand*\cnltx@read@name[1]{%
  \cnltx@read@name@aux#1[]\q@stop
}
\protected\def\cnltx@read@name@aux#1[#2]\q@stop{%
  \cnltx@get@first@and@second@name#1 \q@stop
  \ifblank{#2}{}
    {\cnltx@write@author@email#2\q@stop}%
}
\def\cnltx@write@author@email#1][\q@stop{%
  \ifblank{#1}{}
    {\footnote{\email{#1}}}%
}
\protected\def\cnltx@get@first@and@second@name#1 #2\q@stop{%
  \ifblank{#2}
    {%
      \name*{#1}%
      \listgadd\cnltx@package@author@pdflist{#1}%
    }
    {%
      \name*{#1 #2}%
      \listgadd\cnltx@package@author@pdflist{#1 \trim@spaces{#2}}%
    }%
}

% getting the names for the pdf properties:
\newcommand*\cnltx@extract@name[1]{%
  \cnltx@extract@name@aux#1[]\q@stop
}
\def\cnltx@extract@name@aux#1[#2]\q@stop{%
  #1\ifblank{#2}{}{\cnltx@extract@name@aux@i#2\q@stop}, %
}
\def\cnltx@extract@name@aux@i#1][\q@stop{}

\newrobustcmd*\cnltx@package@authors{%
  \gdef\cnltx@author@sep{\gdef\cnltx@author@sep{\qquad}}%
  \forlistloop{\cnltx@author@sep}\cnltx@package@author@list
}


% --------------------------------------------------------------------------
% options:
\pgfkeys{
  cnltx/.cd,
    package/.code =
      \ifcsdef{#1}{}{\expandafter\newpackagename\csname#1\endcsname{#1}}
      \gdef\cnltx@package@name{#1}
      \@ifpackageloaded{#1}
        {\cnltx@getfileinfo{#1}{sty}}
        {\cnltx@doc@warning{Package `#1' is not loaded, yet!}}
      \booltrue{cnltx@package@name}
      \booltrue{cnltx@build@title} ,
    class/.code =
      \ifcsdef{#1}{}{\expandafter\newpackagename\csname#1\endcsname{#1}}
      \gdef\cnltx@package@name{#1}
      \@ifclassloaded{#1}
        {\cnltx@getfileinfo{#1}{cls}}
        {\cnltx@doc@warning{Class `#1' is not loaded, yet!}}
      \booltrue{cnltx@package@name}
      \booltrue{cnltx@build@title} ,
    name/.code =
      \ifcsdef{#1}{}{\expandafter\newpackagename\csname#1\endcsname{#1}}
      \gdef\cnltx@package@name{#1}
      \booltrue{cnltx@package@name}
      \booltrue{cnltx@build@title} ,
    title/.code =
      \gdef\cnltx@package@title{#1}
      \booltrue{cnltx@package@title} ,
    title-format/.code =
      \def\cnltx@title@format{#1} ,
    build-title/.is if = cnltx@build@title ,
    subtitle/.code =
      \gdef\cnltx@package@subtitle{#1}
      \booltrue{cnltx@package@subtitle} ,
    authors/.code =
      \gdef\cnltx@package@author@list{}
      \forcsvlist{\cnltx@new@author}{#1} ,
    date/.code = \gdef\cnltx@package@date{#1} ,
    version/.code = \gdef\cnltx@package@version{#1} ,
    info/.code = \gdef\cnltx@package@info{#1} ,
    url/.code =
      \gdef\cnltx@package@url{#1}
      \booltrue{cnltx@package@url} ,
    email/.code =
      \gdef\cnltx@package@email{#1}
      \booltrue{cnltx@package@email} ,
    abstract/.code =
      \gdef\cnltx@package@abstract{%
        \parbox{\cnltx@package@abstract@width}{%
          \cnltx@package@abstract@format
          #1%
        }%
      }
      \booltrue{cnltx@package@abstract} ,
    abstract-width/.code =
      \setlength\cnltx@package@abstract@width{#1} ,
    abstract-format/.code =
      \def\cnltx@package@abstract@format{#1}
}
% --------------------------------------------------------------------------
% command descriptions:
% #1: command in the list which places the item
% #2: formatting command taking one mandatory argument and a star form
\newrobustcmd*\cnltx@deflistitem[2]{%
  \protected\csdef{\cnltx@stripbs#1}{%
    \@ifstar
      {\csuse{\cnltx@stripbs#1@star}}
      {\csuse{\cnltx@stripbs#1@nostar}}%
  }%
  \protected\csdef{\cnltx@stripbs#1@star}##1{%
    \@ifnextchar[%]
      {\csuse{\cnltx@stripbs#1@star@opt}{##1}}
      {\csuse{\cnltx@stripbs#1@star@opt}{##1}[]}%
  }%
  \protected\csdef{\cnltx@stripbs#1@nostar}##1{%
    \@ifnextchar[%]
      {\csuse{\cnltx@stripbs#1@nostar@opt}{##1}}
      {\csuse{\cnltx@stripbs#1@nostar@opt}{##1}[]}%
  }%
  \protected\csdef{\cnltx@stripbs#1@star@opt}##1[##2]{%
    \ifblank{##2}
      {\item#2*{##1}}
      {\item#2*{##1}##2}%
    \cnltx@checkdefault{\hfill\newline}%
  }%
  \protected\csdef{\cnltx@stripbs#1@nostar@opt}##1[##2]{%
    \ifblank{##2}
      {\item#2{##1}}
      {\item#2{##1}##2}%
    \cnltx@checkdefault{\hfill\newline}%
  }%
}

\newcommand\cnltx@checkdefault[1]{%
  \@ifnextchar\Module
    {}
    {%
      \@ifnextchar\Default
        {}
        {%
          \@ifnextchar\default
            {}
            {
              \@ifnextchar\dtag{}{#1}
            }%
        }%
    }%
}



\newenvironment{cnltxlist}{}{}

\cnltx@deflistitem{\cnltx@command}{\cs}
  

% --------------------------------------------------------------------------
% option descriptions:
\newcommand*\@cnltx@option@item[1]{%
  \@ifstar
    {\@cnltx@option@item@aux@star{#1}}
    {\@cnltx@option@item@aux@nostar{#1}}%
}

\newcommand*\@cnltx@option@item@aux@star[1]{%
  \cnltx@ifdash
    {\@cnltx@option@item@aux{#1}*-}
    {\@cnltx@option@item@aux{#1}*{}}%
}
\newcommand*\@cnltx@option@item@aux@nostar[1]{%
  \cnltx@ifdash
    {\@cnltx@option@item@aux{#1}{}-}
    {\@cnltx@option@item@aux{#1}{}{}}%
}

\newrobustcmd*\@cnltx@option@item@aux[4]{%
  \@ifnextchar\bgroup
    {\@cnltx@option@two{#1#2#3}{#4}}
    {\@cnltx@option@one{#1#2#3}{#4}}%
}

\newcommand*\@cnltx@option@one[2]{%
  \item#1{#2}%
  \cnltx@checkdefault{\hfill\newline}%
}

\newcommand*\@cnltx@option@two[3]{%
  \item#1{#2}{#3}%
  \cnltx@checkdefault{\hfill\newline}%
}


% --------------------------------------------------------------------------
% environment descriptions:
\newcommand*\cnltx@environment{%
  \@ifstar
    {\cnltx@environment@star}
    {\cnltx@environment@nostar}%
}

\newcommand*\cnltx@environment@star[1]{%
  \@ifnextchar[
    {\cnltx@environment@star@opt{#1}}
    {\cnltx@environment@star@opt{#1}[]}%
}

\newcommand*\cnltx@environment@nostar[1]{%
  \@ifnextchar[
    {\cnltx@environment@nostar@opt{#1}}
    {\cnltx@environment@nostar@opt{#1}[]}%
}

\def\cnltx@environment@star@opt#1[#2]{%
  \ifblank{#2}
    {\item\beginenv*\code{\{}\env*{#1}\code{\}}}
    {\item\beginenv*\code{\{}\env*{#1}\code{\}}#2}%
  \cnltx@checkdefault{\hfill\newline}%
}
\def\cnltx@environment@nostar@opt#1[#2]{%
  \ifblank{#2}
    {\item\beginenv*\code{\{}\env{#1}\code{\}}}
    {\item\beginenv*\code{\{}\env{#1}\code{\}}#2}%
  \cnltx@checkdefault{\hfill\newline}%
}

% --------------------------------------------------------------------------
% default values:
\newrobustcmd*\cnltx@Default[1]{%
  \null\hfill
  \@ifnextchar\bgroup
    {\cnltx@Default@initial{#1}}
    {%
      \cnltx@ifbang
        {\cnltx@Default@required{#1}}
        {\cnltx@Default@empty{#1}}%
    }%
}

\newcommand*\cnltx@Default@initial[2]{%
  \llap{\GetTranslation{cnltx-default}: \code{#2}}%
  \ifblank{#1}{\newline}{}%
}

\newcommand*\cnltx@Default@required[1]{%
  \llap{(\GetTranslation{cnltx-required})}%
  \ifblank{#1}{\newline}{}%
}

\newcommand*\cnltx@Default@empty[1]{%
  \llap{(\GetTranslation{cnltx-empty})}%
  \ifblank{#1}{\newline}{}%
}

\newrobustcmd*\Default{%
  \@ifstar
    {\cnltx@Default{*}}
    {\cnltx@Default{}}%
}

\newrobustcmd*\expandable{\cnltx@expandable@ornot\cnltx@expandable}
\newrobustcmd*\unexpandable{\cnltx@expandable@ornot\cnltx@unexpandable}
\newrobustcmd*\expandablesymbol{\textcolor{expandable}{\expandablesign}}
\newrobustcmd*\unexpandablesymbol{\textcolor{unexpandable}{\expandablesign}}

\newrobustcmd*\cnltx@expandable@ornot[1]{%
  \let\cnltx@item\item
  \def\item{\cnltx@item#1\let\item\cnltx@item}%
}
\newrobustcmd\cnltx@expandable@note[1]{%
  \begingroup
    \reversemarginpar
    \marginnote{\hfill#1\space}%
  \endgroup
}
\newcommand*\cnltx@expandable{%
  \cnltx@expandable@note{\expandablesymbol}%
}
\newcommand*\cnltx@unexpandable{%
  \cnltx@expandable@note{\unexpandablesymbol}%
}

\newcommand*\expandablesign{\textasteriskcentered}

\pgfkeys{
  cnltx/.cd,
    expandable-sign/.code = \def\expandablesign{#1}
}

\newrobustcmd*\visualizespaces{%
  \begingroup
    \obeyspaces
    \begingroup\lccode`~=`\ %
    \lowercase{\endgroup\let~}\visiblespace
    \cnltx@visualizespaces@aux}
\newrobustcmd\cnltx@visualizespaces@aux[1]{%
    \edef\cnltx@x{#1}\scantokens\expandafter{\cnltx@x\noexpand}%
  \endgroup
}
\newcommand*\visiblespace{\allowbreak\textvisiblespace\allowbreak}


% --------------------------------------------------------------------------
% modules:
\newcommand*\cnltx@module@sep{\,>>\,}

\pgfkeys{
  cnltx/.cd,
    module-sep/.code = \def\cnltx@module@sep{#1}
}

\newrobustcmd*\cnltx@module[1]{%
  \cnltx@ifbang
    {\cnltx@write@module{#1}{}}
    {\cnltx@write@module{#1}{*}}%
}
\newcommand*\cnltx@write@module[3]{
  \cnltx@module@text{#2}{#3}%
  \ifblank{#1}{\cnltx@checkdefault{\hfill\newline}}{}%
}
\newcommand*\cnltx@module@text[2]{%
  \begingroup
    \reversemarginpar
    \marginnote{\hfill\llap{\module#1{#2}}\cnltx@module@sep}%
  \endgroup
}
  
\newrobustcmd*\Module{%
  \@ifstar
    {\cnltx@module{*}}
    {\cnltx@module{}}%
}

% --------------------------------------------------------------------------
% a environment for block quotes
\newcommand*\cnltx@quote@author@format{\itshape}
\newcommand*\cnltx@quote@format{\small\sffamily}

\pgfkeys{
  cnltx/.cd ,
    quote-format/.code        = \def\cnltx@quote@format{#1} ,
    quote-author-format/.code = \def\cnltx@quote@author@format{#1}
}

\newenvironment{cnltxquote}[1][]
  {%
    \def\cnltx@quote@option{#1}%
    \quote
    \cnltx@quote@format
  }
  {%
    \ifdefempty\cnltx@quote@option
      {}
      {%
        \unskip\nobreak\hfil\penalty50
        \hskip2em\hbox{}\nobreak\hfil
        {\normalfont\cnltx@quote@author@format\cnltx@quote@option}%
        \parfillskip0pt \finalhyphendemerits=0
        \par
      }%
    \endquote
  }
  \RequirePackage{multicol}
% --------------------------------------------------------------------------
% document title:
\AfterPackage{hyperref}{%
  \newrobustcmd*\cnltx@tableofcontents{%
    \begingroup
      \let\tocbasic@listhead\@gobble
      % \RaggedRight
      \tableofcontents
    \endgroup
  }%
  \AfterEndPreamble{%
    \ifbool{cnltx@build@title}{%
      \ifbool{cnltx@package@name}
        {\cnltx@title@information}
        {%
          \cnltx@doc@warning{%
            No package/class name given. Hence I won't create an
            automatic title%
          }%
        }%
    }{}%
  }%
}

\newrobustcmd*\cnltx@title@information{%
  \thispagestyle{plain}
  \begin{center}
    \ifbool{cnltx@load@preamble}{}
      {\renewcommand\thefootnote{\@fnsymbol\c@footnote}}%
    \Huge
    \scalebox{1.5}{%
      \begin{minipage}{.6\linewidth}
        \centering
        \color{cnltx}%
        \cnltx@title@format
        \ifbool{cnltx@package@title}
          {\cnltx@package@title}
          {\cnltx@package@name}%
      \end{minipage}%
    }%
    \par\vskip.5cm\relax
    \large
    \ifbool{cnltx@package@subtitle}
      {\cnltx@package@subtitle\par\vskip.5cm\relax}
      {}%
    \Large \cnltx@package@version \qquad \cnltx@package@date
    \par\vskip.5cm\relax
    \large
    \cnltx@package@info
    \par\vskip.5cm\relax
    \large
    \cnltx@package@authors
    \normalsize
    \ifbool{cnltx@package@url}
      {%
        \par\vskip.5cm\relax
        \url{\cnltx@package@url}%
      }{}%
    \ifbool{cnltx@package@email}
      {%
        \par\vskip.5cm\relax
        \email{\cnltx@package@email}%  
      }{}%
    \ifbool{cnltx@package@abstract}
      {%
        \par\vskip.5cm\relax
        \cnltx@package@abstract
      }{}%
  \end{center}
  \begin{multicols}{2}[{%
    \pdfbookmark[1]{目录}{toc}%
    \section*{目录}
    }]\cnltx@tableofcontents
  \end{multicols}%
}

% --------------------------------------------------------------------------
% versioning:
\RequirePackage[noadjust]{marginnote}
\RequirePackage{ragged2e}
\newcommand*\versionnoteformat{\footnotesize\sffamily\RaggedRight}

\pgfkeys{
  cnltx/.cd,
    version-note-format/.code = \renewcommand*\versionnoteformat{#1} ,
}

\newcommand\cnltx@version@note[1]{%
  \@bsphack
  \begingroup
    \reversemarginpar
    \marginnote
      {%
        \versionnoteformat
        \textcolor{versionnote}{#1}%
      }%
    \endgroup
  \@esphack
}

\newcommand*\cnltx@newnote{%
  \@ifstar
    {\cnltx@newnote@aux{*}}
    {\cnltx@newnote@aux{}}%
}
\newrobustcmd\cnltx@newnote@aux[2]{%
  \@ifnextchar[%]
    {\cnltx@newnote@aux@i{#1}{#2}}
    {\cnltx@newnote@aux@i{#1}{#2}[0]}%
}
\protected\def\cnltx@newnote@aux@i#1#2[#3]{%
  \@ifnextchar[%]
    {\cnltx@newnote@aux@ii{#1}{#2}{#3}}
    {\cnltx@newnote@aux@iii{#1}{#2}{#3}}%
}
\protected\long\def\cnltx@newnote@aux@ii#1#2#3[#4]#5{%
  \ifblank{#1}
    {\newrobustcmd#2[#3][#4]{\cnltx@version@note{#5}}}
    {\newrobustcmd*#2[#3][#4]{\cnltx@version@note{#5}}}%
}
\protected\long\def\cnltx@newnote@aux@iii#1#2#3#4{%
  \ifblank{#1}
    {\newrobustcmd#2[#3]{\cnltx@version@note{#4}}}
    {\newrobustcmd*#2[#3]{\cnltx@version@note{#4}}}%
}

\newrobustcmd\newnote{\cnltx@newnote}

\newnote*\sinceversion[1]{\GetTranslation{cnltx-introduced}~#1}
\newnote*\changedversion[1]{\GetTranslation{cnltx-changed}~#1}

% --------------------------------------------------------------------------
% hyperlinks:
\newrobustcmd*\CTANurl[2][macros/latex/contrib]{%
  on \ctan\ as \cnltx@weblink@font{#2}: \url{http://mirrors.ctan.org/#1/#2/}%
}

\newcommand*\cnltx@weblink@font[1]{\texttt{#1}}

\newrobustcmd*\email[1]{\cnltx@weblink@font{\href{mailto:#1}{#1}}}
\newrobustcmd*\website[1]{\cnltx@weblink@font{\href{http://#1/}{#1}}}
\newrobustcmd*\securewebsite[1]{\cnltx@weblink@font{\href{https://#1/}{#1}}}

\newrobustcmd*\needpackage[2][macros/latex/contrib]{%
  \pkg{#2}\footnote{\CTANurl[#1]{#2}}%
}

\newrobustcmd*\needclass[2][macros/latex/contrib]{%
  \cls{#2}\footnote{\CTANurl[#1]{#2}}%
}

\ifbool{cnltx@load@preamble}{%
  \AtEndPreamble{%
    \RequirePackage{hyperref}%
    \pdfstringdefDisableCommands{%
      \def\cnltx@name[#1]#2{#1 #2, }%
      \def\cnltxpackagenameformat#1{#1}%
    }%
    \hypersetup
      {
        colorlinks         = true,
        allcolors          = link ,
        plainpages         = false,
        bookmarksopen      = true,
        bookmarksopenlevel = 1,
        bookmarksnumbered  = true,
        pdfauthor          = {\forlistloop{}\cnltx@package@author@pdflist},
        pdftitle           =
          {\cnltx@package@name\space\cnltx@package@version\space Manual},
        pdfsubject         = {\cnltx@package@info},
        pdfstartview       = FitH
      }%
  }%
}{}%

\endinput

% --------------------------------------------------------------------------
HISTORY:

2013/09/08 v0.1   - first working version
2013/09/10 v0.2   - added optional argument to \license
                  - \newname got moved to `cnltx-tools'
                  - added possibility for internationalization
                  - new macros \needpackage and \needclass
                  - option for formatting the document title
2013/09/12 v0.3   - new class options `add-index', `load-preamble+' and
                    `scrartcl'
                  - new options `index-prologue' and `index-space'
                  - new file `cnltx.ist'
                  - added \Module
                  - added optional ! to the \Default command
                  - add safety net: provide necessary commands in the aux-file
                    if they're not defined at begin document
2013/09/12 v0.3a  - automatic preamble detects xelatex and lualatex and selects
                    the fonts accordingly
2013/09/15 v0.4   - possiblity to add an email address for each author, written
                    as footnote; they get symbols if the `load-preamble'
                    options is not used
                  - fixed bug in index setup mechanism
                  - added biblatex entry type `package' and biblatex style
                    `cnltx'
2013/09/20 v0.5   - new commands \expandable and \unexpandable
                  - new environment `cnltxquote', formatting via options
                    `quote-format' and `quote-author-format'
                  - changed scaling of `beramono' from `.83' to `.81' -- seems
                    a better fit in relation to Linux Libertine
2013/09/24 v0.6   - workaround for footnotes in minipages => libertine does not
                    have superior letters
                  - new options `abstract-format' and `abstract-width'
2013/09/30 v0.7   - added better microtype settings to the predefined preamble
                  - replaced \def's with \newcommand or \newrobustcmd
2013/10/04 v0.7a  - renamed \cnltx@package@name@format into
                    \cnltxpackagenameformat
                  - added \cnltxpackagenameformat to the disabled pdfstring
                    commands
                  - added possibility to define a opitonal argument with
                    \newnote
2013/10/21 v0.8   - disable ligatures for teletype font
                  - extended preamble loading
                    * choice if fonts are loaded
                    * choice if microtype is loaded
                  - \visualizespaces and \visiblespace
2014/01/23 v0.10  - adapt to KOMA-Script v3.12
2014/03/11 v0.11  - change biblatex locale from en_EN to en_US
                  - fix bug: wrong boolean used for option `add-bib'
                  - some translations are now provided by the `tools' module
                    and by the `cnltx' bibliography style
                  - use \cnltx@load@modules
                  - new commands \email, \website, \securewebsite
                  - \expandablesymbol, \unexpandablesymbol
2015/08/17 v0.13  - resolve long overdue issues with cnltx-doc
2015/03/11 v0.13a - wrap title in minipage in order to enable linebreaks
2016/03/17 v0.13b - ragged right toc
2017/02/04 v0.14  - load `hyperref' only with `load-preample = true'

% --------------------------------------------------------------------------
TODO:


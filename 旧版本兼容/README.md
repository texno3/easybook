# 旧版本兼容文件

`easybook` 在优化更新中一些改动未保留兼容，加载此旧版本兼容文件后旧版本的特性仍可用，但推荐使用最新版的特性。

使用方法举例：

```latex
\documentclass{ctexart}

\usepackage{easybase,zhlipsum}
\input{eb-oldcompat.tex}%在easybase宏包后加载文件
%\ctexset{模块名/选项=值}

\begin{document}
\zhlipsum
\end{document}
```
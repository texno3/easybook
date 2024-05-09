# 旧版本兼容文件

用于 `easybook` 文档类 `v2024bb` 之前版本的兼容，`v2024bb` 版本更改了模块名，但未保留兼容，加载此文件后旧版本的模块名仍可用。

使用方法举例：

```latex
\documentclass{ctexart}

\usepackage{easybase,zhlipsum}
\input{module-old.tex}%在easybase宏包后加载文件
%\ctexset{模块名/选项=值}

\begin{document}
\zhlipsum
\end{document}
```
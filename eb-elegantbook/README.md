

# easybook 文档类适配 elegantbook 介绍 

ElegantBook 是为 LaTeX 书籍写作而设计美观、优雅、简便的模板，遗憾的是自 2023 年已停止更新和维护。我将文档类 elegantbook.cls 改写成 eb-elegantbook.sty 宏包，原来 elegantbook 文档类的选项现全部变为宏包选项。在 easybook 文档类中加载 eb-elegantbook 宏包后同时具有 elegantbook 的风格和 easybook 的功能，为确保兼容性改动了一些代码并尽可能保证样式与原来一致。

## 具体改动说明  

- 取消重复宏包的载入，取消和调整部分重复功能的代码。

- 中文字体兼容： elegantbook 原本只在中文语言 lang=cn 下载入 ctex 宏包， easybook 则始终依赖 CTEX 支持。字体选项 chinesefont 设置为 ctexfont 和 nofont 时什么也不做，设置中文字体使用 easybook 文档类选项 cjkfont 或 fontset。若使用 chinesefont=founder 方正字体需要文档类选项 cjkfont=none。

- 数学字体兼容： 使用 easybook 时加上文档类选项 mathfont=none 避免数学字体冲突，这里不做调整。

- 标题和目录格式： elegantbook 使用 titlesec 宏包设置章节标题格式，使用 tocloft 宏包设置目录格式，这里将其取消，改用 CTEX 的 heading 支持章节标题，用基于 titletoc 宏包的 toc 模块支持目录。

- 多语言兼容： 由于 XeLaTeX 下文档类字符始终由 xeCJK 支持，中文/英文外的其它语言字体、翻译支持宏包（babel）等可能与 xeCJK 有冲突，取消了其它语言字体、翻译支持宏包的载入，但保留各种标题标签名的翻译。如需使用其它语言且可能需要设置对应语言字体。

- 定理环境兼容： 给 elegantbook 新增了个定理选项 thmenv=<true|false>。若使用elegantbook定理功能时需要给 easybook 文档类选项加上 theorem=false，若使用 easybook 的定理功能需要给 ebelegantbook 宏包加上 thmenv=false 选项，即二者定理选项不能同时开启。

  ```
  %使用elegantbook定理支持
  \documentclass[mathfont=none,theorem=false]{easybook}
  \usepackage{eb-elegantbook}
  %使用easybook定理支持
  \documentclass[mathfont=none]{easybook}
  \usepackage[thmenv=false]{eb-elegantbook}
  ```

- elegantbook 失效的选项提供了替代方案  

  | 失效选项   | 替换选项                       |
  | ---------- | ------------------------------ |
  | nofont     | cjkfont=none                   |
  | toc        | 目录命令可选参数的 multoc 选项 |
  | scheme     | CTeX 的 scheme                 |
  | titlestyle | \ctexset{chapter/hang}         |

## 文档使用与迁移  

使用 eb-elegantbook 宏包需把 eb-elegantbook.sty 文件放在当前项目文件夹或私有路径
texlive/texmf-local/tex/latex/eb-elegantbook
中，再在命令行执行 texhash 刷新数据库。
如果有需要可以将 elegantbook 写的文档迁移为 easybook 文档类，如果没有额外载入或载入了较少宏
包，一般不会有问题，以下一个最基本示例：

```
\documentclass[mathfont=none,theorem=false]{easybook}
\usepackage{eb-elegantbook}
\begin{document}
文档主体
\end{document}
```

若出现宏包冲突就需要一些宏包载入顺序、选项传递之间的调整。  

### 宏包载入顺序调整  

如果是功能与已载入宏包没关联的宏包，在 eb-elegantbook 宏包之后载入所需宏包就可以了。如果有关联或冲突，可以用钩子命令调整宏包载入顺序。需要在 hyperref 后载入的宏包及需要在导言区末尾执行的命令在 \AtEndPreamble 命令执行。 2020 年 10 月 1 日后的 LATEX 版本提供了钩子 lthooks 新机制，使用通用宏包钩子可以在不修改宏包、文类源文件的情况下方便调整用户载入宏包的顺序。当宏包 abc 需要在def 前载入时，可以在文档开头使用：  

```
%\documentclass 之前
\AddToHook{package/def/before}{\usepackage{abc}}
```

当宏包 abc 需要在 def 后载入时，可以在文档开头使用：  

```
%\documentclass 之前
\AddToHook{package/def/after}{\usepackage{abc}}
```

### 宏包选项传递调整  

如果所需宏包与 easybook、 eb-elegantbook 重复，那么 1. 不需要使用宏包选项，取消宏包加载。 2. 需要使用宏包选项，使用 \PassOptionsToPackage 命令在文档开头传递选项（推荐），或复制一份 easybase.sty/ebelegantbook.sty 文件在项目文件夹，进入宏包文件修改。3. 使用passopt宏包的 \SetOptionsToPackage* 命令重置已载入宏包的选项为所需，在文档开头使用。如果上面处理之后仍存在报错，可能是所需宏包与已有宏包有冲突，要选择合适的宏包，进行取舍。

```
\RequirePackage{passopt}

% 在\PassOptionsToPackage和\usepackage传递的选项右侧执行
\SetOptionsToPackage{选项列表}{宏包}
% 不保留\PassOptionsToPackage和\usepackage传递的选项
% \SetOptionsToPackage*{选项列表}{宏包}

%向easybook、 eb-elegantbook已经载入的宏包传递宏包选项
\PassOptionsToPackage{选项列表}{宏包}
\documentclass[theorem=false,mathfont=none]{easybook}
\usepackage{eb-elegantbook}
\usepackage{宏包列表}
%设置代码
Some codes
%etoolbox的导言区末尾钩子
\AtEndPreamble{% 或\AtBeginDocument， 更靠后执行
%需要在hyperref后载入的宏包
\usepackage{宏包列表}
%需要在导言区结尾执行的代码
Some codes
}
\begin{document}
文档主体
\end{document}
```


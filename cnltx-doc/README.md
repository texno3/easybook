# cnltx-doc

[`cnltx-doc`](https://ctan.org/pkg/cnltx) 文档类是 Clemens Niederberger 编写的用于宏包文档的文档类（主要供自己使用），已几年未更新，存在一些问题，我在它基础上进行了修改调整，用于编写我的 `easybook` 文档类说明文档。

主要的改动说明：

- 用 `ctex` 宏包支持中文字体，用 `fontspec` 宏包设置英文字体。
- 取消 `listings` 和 `mdframed`  宏包，用 `fancyvrb` 宏包写代码示例。
- 取消 `commands` 、`options` 、`environments` 环境，统一用 `cnltxlist` 环境描述命令、选项、环境。


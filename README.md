# C++20 中文翻译

C++20标准的中文翻译。此翻译使用ElegantBook LaTeX模板。 感谢ElegantBook模板的出色工作。

**完成状态：** 翻译尚未完成（目前只到第7章）。

## 构建说明

*   依赖项：LaTeX, `xelatex`, 以及以下LaTeX包：`elegantbook`, `lmodern`, `flexisym`, `tablefootnote`, `multirow`, `chngcntr`, `tocloft`, `nextpage`, `listings`。
*   构建命令：`xelatex cpp20.tex` (运行两次以解决引用)
*   使用 `elegantbook.cls` 类进行样式设置。
*   使用 `gbt7714.sty` 样式进行中文书目。

## Artifacts

构建过程生成一个PDF文件。

## 目录结构

*   `chapters/`: 包含C++20翻译的各个章节。
*   `chapters/paragraphs/`: 包含各个章节的段落。
*   `figure/`: 包含文档中使用的图像。
*   `scripts/`: 包含用于构建文档的脚本。

## 脚本

*   `scripts/build.sh`: 构建文档。
*   `scripts/clear.sh`: 清理构建工件。
*   `scripts/gen.figure.sh`: 生成图形。
*   `scripts/gen.toc.sh`: 生成目录。
*   `scripts/make-ref.sh`: 生成引用。
*   `scripts/prepare.sh`: 准备文档。

## 下载

[V0.1](https://github.com/danix800/std-cpp20/releases/download/V0.1/cpp20.pdf)
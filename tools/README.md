* makepdf 目录是生成中文 pdf 的工具，首先需要安装 `kramdown`,

```
gem install kramdown-parser-gfm
gem install kramdown
```
Linux下需要安装 texlive-xetex 及相关软件包。 在Ubuntu14.10下：

```
sudo apt-get install -y texlive-xetex texlive-latex-recommended texlive-pictures texlive-latex-extra texlive-fonts-recommended
```
然后，就可以运行以下命令生成 pdf 了

```
cd makepdf
ruby makepdf.rb en-cn|cn
```

* getcn.rb 程序的功能是用来把中文从中英文件中分离出来

```
ruby getcn.rb all|file_name
```

这里的 all 参数，是处理全部的中英文件（01-37），file_name 是单个文件名，
注意没有文件扩展名 .md，比如说处理文件 chap01.md，运行这样的命令：

```
ruby getcn.rb chap01
```

* old 目录是之前写过的 bash 脚本，不再使用。

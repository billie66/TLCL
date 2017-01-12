---
layout: book-zh
title: 键盘高级操作技巧
---

开玩笑地说，我经常把 Unix 描述为“这个操作系统是为喜欢敲键盘的人们服务的。”
当然，Unix 甚至还有一个命令行这件事证明了我所说的话。但是命令行用户不喜欢敲入
那么多字。那又为什么如此多的命令会有这样简短的命令名，像cp，ls，mv，和 rm？事实上
，命令行最为珍视的目标之一就是懒惰；用最少的击键次数来完成最多的工作。另一个
目标是你的手指永远不必离开键盘，永不触摸鼠标。在这一章节，我们将看一下 bash 特性
，这些特性使键盘使用起来更加迅速，更加高效。

以下命令将会露面：

* clear － 清空屏幕

* history － 显示历史列表内容

### 命令行编辑

Bash 使用了一个名为 Readline 的库（共享的线程集合，可以被不同的程序使用），
来实现命令行编辑。我们已经看到一些例子。我们知道，例如，箭头按键可以移动光标，
此外还有许多特性。想想这些额外的工具，我们可以在工作中使用。学会所有的特性
并不重要，但许多特性非常有帮助。选择自己需要的特性。

注意：下面一些按键组合（尤其使用 Alt 键的组合），可能会被 GUI 拦截来触发其它的功能。
当使用虚拟控制台时，所有的按键组合都应该正确地工作。

### 移动光标

下表列出了移动光标所使用的按键：

<table class="multi">
<caption class="cap">表9-1: 光标移动命令</caption>
<tr>
<th class="title">按键</th>
<th class="title">行动</th>
</tr>
<tr>
<td valign="top" width="25%">Ctrl-a</td>
<td valign="top">移动光标到行首。</td>
</tr>
<tr>
<td valign="top">Ctrl-e</td>
<td valign="top">移动光标到行尾。</td>
</tr>
<tr>
<td valign="top">Ctrl-f</td>
<td valign="top">光标前移一个字符；和右箭头作用一样。</td>
</tr>
<tr>
<td valign="top">Ctrl-b</td>
<td valign="top">光标后移一个字符；和左箭头作用一样。</td>
</tr>
<tr>
<td valign="top">Alt-f</td>
<td valign="top">光标前移一个字。</td>
</tr>
<tr>
<td valign="top">Alt-b</td>
<td valign="top">光标后移一个字。</td>
</tr>
<tr>
<td valign="top">Ctrl-l</td>
<td valign="top">清空屏幕，移动光标到左上角。clear 命令完成同样的工作。</td>
</tr>
</table>

### 修改文本

表9－2列出了键盘命令，这些命令用来在命令行中编辑字符。

<table class="multi">
<caption class="cap">表9-2: 文本编辑命令</caption>
<tr>
<th class="title"> 按键</th>
<th class="title"> 行动</th>
</tr>
<tr>
<td valign="top" width="25%">Ctrl-d</td>
<td valign="top"> 删除光标位置的字符。</td>
</tr>
<tr>
<td valign="top">Ctrl-t</td>
<td valign="top"> 光标位置的字符和光标前面的字符互换位置。</td>
</tr>
<tr>
<td valign="top">Alt-t</td>
<td valign="top"> 光标位置的字和其前面的字互换位置。</td>
</tr>
<tr>
<td valign="top">Alt-l</td>
<td valign="top"> 把从光标位置到字尾的字符转换成小写字母。</td>
</tr>
<tr>
<td valign="top">Alt-u</td>
<td valign="top"> 把从光标位置到字尾的字符转换成大写字母。</td>
</tr>
</table>

### 剪切和粘贴文本

Readline 的文档使用术语 killing 和 yanking 来指我们平常所说的剪切和粘贴。
剪切下来的本文被存储在一个叫做剪切环(kill-ring)的缓冲区中。

<table class="multi">
<caption class="cap">表9-3: 剪切和粘贴命令</caption>
<tr>
<th class="title"> 按键</th>
<th class="title"> 行动</th>
</tr>
<tr>
<td valign="top" width="25%">Ctrl-k</td>
<td valign="top"> 剪切从光标位置到行尾的文本。</td>
</tr>
<tr>
<td valign="top">Ctrl-u</td>
<td valign="top"> 剪切从光标位置到行首的文本。</td>
</tr>
<tr>
<td valign="top">Alt-d</td>
<td valign="top"> 剪切从光标位置到词尾的文本。</td>
</tr>
<tr>
<td valign="top">Alt-Backspace</td>
<td valign="top"> 剪切从光标位置到词头的文本。如果光标在一个单词的开头，剪切前一个单词。</td>
</tr>
<tr>
<td valign="top">Ctrl-y</td>
<td valign="top"> 把剪切环中的文本粘贴到光标位置。</td>
</tr>
</table>

>
> 元键
>
>  如果你冒险进入到 Readline 的文档中，你会在 bash 手册页的 READLINE 段落，
遇到一个术语"元键"（meta key）。在当今的键盘上，这个元键是指 Alt 键，但
并不总是这样。
>
> 回到昏暗的年代（在 PC 之前 Unix 之后），并不是每个人都有他们自己的计算机。
他们可能有一个叫做终端的设备。一个终端是一种通信设备，它以一个文本显示
屏幕和一个键盘作为其特色，它里面有足够的电子器件来显示文本字符和移动光标。
它连接到（通常通过串行电缆）一个更大的计算机或者是一个大型计算机的通信
网络。有许多不同的终端产品商标，它们有着不同的键盘和特征显示集。因为它们
都倾向于至少能理解 ASCII，所以软件开发者想要符合最低标准的可移植的应用程序。
Unix 系统有一个非常精巧的方法来处理各种终端产品和它们不同的显示特征。因为
Readline 程序的开发者们，不能确定一个专用多余的控制键的存在，他们发明了一个
控制键，并把它叫做"元"（"meta"）。然而在现代的键盘上，Alt 键作为元键来服务。
如果你仍然在使用终端（在 Linux 中，你仍然可以得到一个终端），你也可以按下和
释放 Esc 键来得到如控制 Alt 键一样的效果。

### 自动补全

shell 能帮助你的另一种方式是通过一种叫做自动补全的机制。当你敲入一个命令时，
按下 tab 键，自动补全就会发生。让我们看一下这是怎样工作的。给出一个看起来
像这样的家目录：

    [me@linuxbox ~]$ ls
    Desktop   ls-output.txt   Pictures   Templates   Videos
    ....

试着输入下面的命令，但不要按下 Enter 键：

    [me@linuxbox ~]$ ls l

现在按下 tab 键：

    [me@linuxbox ~]$ ls ls-output.txt

看一下 shell 是怎样补全这一行的？让我们再试试另一个例子。这回，也
不要按下 Enter:

    [me@linuxbox ~]$ ls D

按下 tab:

    [me@linuxbox ~]$ ls D

没有补全，只是嘟嘟响。因为"D"不止匹配目录中的一个条目。为了自动补全执行成功，
你给它的"线索"必须不模棱两可。如果我们继续输入：

    [me@linuxbox ~]$ ls Do

然后按下 tab：

    [me@linuxbox ~]$ ls Documents

自动补全成功了。

这个实例展示了路径名自动补全，这是最常用的形式。自动补全也能对变量起作用（如果
字的开头是一个"$"），用户名字（单词以"~"开始），命令（如果单词是一行的第一个单词），
和主机名（如果单词的开头是"@"）。主机名自动补全只对包含在文件/etc/hosts 中的主机名有效。

有一系列的控制和元键序列与自动补全相关联：

<table class="multi">
<caption class="cap">表9-4: 自动补全命令</caption>
<tr>
<th class="title">按键</th>
<th class="title">行动</th>
</tr>
<tr>
<td valign="top" width="25%">Alt-?</td>
<td valign="top"> 显示可能的自动补全列表。在大多数系统中，你也可以完成这个通过按
两次 tab 键，这会更容易些。</td>
</tr>
<tr>
<td valign="top">Alt-*</td>
<td valign="top">插入所有可能的自动补全。当你想要使用多个可能的匹配项时，这个很有帮助。</td>
</tr>
</table>

>
> 可编程自动补全
>
> 目前的 bash 版本有一个叫做可编程自动补全工具。可编程自动补全允许你（更可能是，你的
发行版提供商）来加入额外的自动补全规则。通常需要加入对特定应用程序的支持，来完成这个
任务。例如，有可能为一个命令的选项列表，或者一个应用程序支持的特殊文件类型加入自动补全。
默认情况下，Ubuntu 已经定义了一个相当大的规则集合。可编程自动补全是由 shell
函数实现的，shell 函数是一种小巧的 shell 脚本，我们会在后面的章节中讨论到。如果你感到好奇，试一下：
>
>  _set \| less_
>
> 查看一下如果你能找到它们的话。默认情况下，并不是所有的发行版都包括它们。

### 利用历史命令

正如我们在第二章中讨论到的，bash 维护着一个已经执行过的命令的历史列表。这个命令列表
被保存在你家目录下，一个叫做 .bash_history 的文件里。这个 history 工具是个有用资源，
因为它可以减少你敲键盘的次数，尤其当和命令行编辑联系起来时。

### 搜索历史命令

在任何时候，我们都可以浏览历史列表的内容，通过：

    [me@linuxbox ~]$ history | less

在默认情况下，bash 会存储你所输入的最后 500 个命令。在随后的章节里，我们会知道
怎样调整这个数值。比方说我们想要找到列出目录 /usr/bin 内容的命令。一种方法，我们可以这样做：

    [me@linuxbox ~]$ history | grep /usr/bin

比方说在我们的搜索结果之中，我们得到一行，包含了有趣的命令，像这样；

    88  ls -l /usr/bin > ls-output.txt

数字 "88" 是这个命令在历史列表中的行号。随后在使用另一种展开类型时，叫做
历史命令展开，我们会用到这个数字。我们可以这样做，来使用我们所发现的行：

    [me@linuxbox ~]$ !88

bash 会把 "!88" 展开成为历史列表中88行的内容。还有其它的历史命令展开形式，我们一会儿
讨论它们。bash 也具有按递增顺序来搜索历史列表的能力。这意味着随着字符的输入，我们
可以告诉 bash 去搜索历史列表，每一个附加字符都进一步提炼我们的搜索。启动递增搜索，
输入 Ctrl-r，其后输入你要寻找的文本。当你找到它以后，你可以敲入 Enter 来执行命令，
或者输入 Ctrl-j，从历史列表中复制这一行到当前命令行。再次输入 Ctrl-r，来找到下一个
匹配项（向上移动历史列表）。输入 Ctrl-g 或者 Ctrl-c，退出搜索。实际来体验一下：

    [me@linuxbox ~]$

首先输入 Ctrl-r:

    (reverse-i-search)`':

提示符改变，显示我们正在执行反向递增搜索。搜索过程是"反向的"，因为我们按照从"现在"到过去
某个时间段的顺序来搜寻。下一步，我们开始输入要查找的文本。在这个例子里是 "/usr/bin"：

    (reverse-i-search)`/usr/bin': ls -l /usr/bin > ls-output.txt

即刻，搜索返回我们需要的结果。我们可以执行这个命令，按下 Enter 键，或者我们可以复制
这个命令到我们当前的命令行，来进一步编辑它，输入 Ctrl-j。复制它，输入 Ctrl-j：

    [me@linuxbox ~]$ ls -l /usr/bin > ls-output.txt

我们的 shell 提示符重新出现，命令行加载完毕，正准备行动！下表列出了一些按键组合，
这些按键用来操作历史列表：

<table class="multi">
<caption class="cap">表9-5: 历史命令</caption>
<tr>
<th class="title">按键</th>
<th class="title">行为</th>
</tr>
<tr>
<td valign="top" width="25%">Ctrl-p</td>
<td valign="top">移动到上一个历史条目。类似于上箭头按键。</td>
</tr>
<tr>
<td valign="top">Ctrl-n</td>
<td valign="top">移动到下一个历史条目。类似于下箭头按键。</td>
</tr>
<tr>
<td valign="top">Alt-<</td>
<td valign="top"> 移动到历史列表开头。</td>
</tr>
<tr>
<td valign="top">Alt-></td>
<td valign="top">移动到历史列表结尾，即当前命令行。</td>
</tr>
<tr>
<td valign="top">Ctrl-r</td>
<td valign="top">反向递增搜索。从当前命令行开始，向上递增搜索。</td>
</tr>
<tr>
<td valign="top">Alt-p</td>
<td valign="top">反向搜索，不是递增顺序。输入要查找的字符串，然后按下 Enter，执行搜索。</td>
</tr>
<tr>
<td valign="top">Alt-n</td>
<td valign="top"> 向前搜索，非递增顺序。</td>
</tr>
<tr>
<td valign="top">Ctrl-o</td>
<td valign="top">执行历史列表中的当前项，并移到下一个。如果你想要执行历史列表中一系列的命令，这很方便。</td>
</tr>
</table>

### 历史命令展开

通过使用 "!" 字符，shell 为历史列表中的命令，提供了一个特殊的展开类型。我们已经知道一个感叹号
，其后再加上一个数字，可以把来自历史列表中的命令插入到命令行中。还有一些其它的展开特性：

<table class="multi">
<caption class="cap">表9-6: 历史展开命令 </caption>
<tr>
<th class="title">序列</th>
<th class="title">行为</th>
</tr>
<tr>
<td valign="top" width="25%">!!</td>
<td valign="top">重复最后一次执行的命令。可能按下上箭头按键和 enter 键更容易些。</td>
</tr>
<tr>
<td valign="top">!number</td>
<td valign="top">重复历史列表中第 number 行的命令。</td>
</tr>
<tr>
<td valign="top">!string</td>
<td valign="top">重复最近历史列表中，以这个字符串开头的命令。</td>
</tr>
<tr>
<td valign="top">!?string</td>
<td valign="top">重复最近历史列表中，包含这个字符串的命令。</td>
</tr>
</table>

应该小心谨慎地使用 "!string" 和 "!?string" 格式，除非你完全确信历史列表条目的内容。

在历史展开机制中，还有许多可利用的特点，但是这个题目已经太晦涩难懂了，
如果我们再继续讨论的话，我们的头可能要爆炸了。bash 手册页的 HISTORY EXPANSION
部分详尽地讲述了所有要素。

>
> 脚本
>
> 除了 bash 中的命令历史特性，许多 Linux 发行版包括一个叫做 script 的程序，
这个程序可以记录整个 shell 会话，并把 shell
会话存在一个文件里面。这个命令的基本语法是：
>
>  _script [file]_
>
> 命令中的 file 是指用来存储 shell 会话记录的文件名。如果没有指定文件名，则使用文件
typescript。查看脚本的手册页，可以得到一个关于 script 程序选项和特点的完整列表。

### 总结归纳

在这一章中，我们已经讨论了一些由 shell 提供的键盘操作技巧，这些技巧是来帮助打字员减少工作量的。
随着时光流逝，你和命令行打交道越来越多，我猜想你会重新翻阅这一章的内容，学会更多的技巧。
目前，你就认为它们是可选的，潜在地有帮助的。

### 拓展阅读

* Wikipedia 上有一篇关于计算机终端的好文章：

    <http://en.wikipedia.org/wiki/Computer_terminal>


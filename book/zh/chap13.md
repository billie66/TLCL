---
layout: book-zh
title: vi 简介
---

有一个古老的笑话，说是一个在纽约的游客向行人打听这座城市中著名古典音乐场馆的方向：

游客： 请问一下，我怎样去卡内基音乐大厅？

行人： 练习，练习，练习!

学习 Linux 命令行，就像要成为一名造诣很深的钢琴家一样，它不是我们一下午就能学会的技能。这需要
经历几年的勤苦练习。在这一章中，我们将介绍 vi（发音“vee eye”）文本编辑器，它是 Unix 传统中核心程序之一。
vi 因它难用的用户界面而有点声名狼藉，但是当我们看到一位大师坐在钢琴前开始演奏时，我们的确成了
伟大艺术的见证人。虽然我们在这里不能成为 vi 大师，但是当我们学完这一章后，
我们会知道怎样在 vi 中玩“筷子”。

### 为什么我们应该学习 vi

在现在这个图形化编辑器和易于使用的基于文本编辑器的时代，比如说 nano，为什么我们还应该学习 vi 呢？
下面有三个充分的理由：

* vi 很多系统都预装。如果我们的系统没有图形界面，比方说一台远端服务器或者是一个
  X 配置损坏了的本地系统，那么 vi 就成了我们的救星。虽然 nano 逐渐流行起来，但是它
  还没有普及。POSIX，这套 Unix 系统中程序兼容的标准，就要求系统要预装 vi。

* vi 是轻量级且执行快速的编辑器。对于许多任务来说，启动 vi 比起在菜单中找到一个图形化文本编辑器，
  再等待编辑器数倍兆字节的数据加载而言，要容易的多。另外，vi 是为了加快输入速度而设计的。
  我们将会看到，当一名熟练的 vi 用户在编辑文件时，他或她的手从不需要移开键盘。

* 我们不希望其他 Linux 和 Unix 用户把我们看作胆小鬼。

好吧，可能只有两个充分的理由。

### 一点儿背景介绍

第一版 vi 是在1976由 Bill Joy 写成的，当时他是加州大学伯克利分校的学生，
后来他共同创建了 Sun 微系统公司。vi 这个名字
来源于单词“visual”，因为它打算在带有可移动光标的视频终端上编辑文本。在发明可视化编辑器之前，
有一次只能操作一行文本的行编辑器。为了指定一个修改，我们告诉行编辑器到一个特殊行并且
说明做什么修改，比方说添加或删除文本。视频终端（而不是基于打印机的终端，像电传打印机）的出现
，可视化编辑成为可能。vi 实际上整合了一个强大的叫做 ex 行编辑器,
所以我们在使用 vi 时能运行行编辑命令。

大多数 Linux 发行版不包含真正的 vi；而是自带一款高级替代版本，叫做 vim（它是“vi
improved”的简写）由 Bram Moolenaar 开发的。vim 相对于传统的 Unix
vi 来说，取得了实质性进步。通常，vim 在 Linux 系统中是“vi”的符号链接（或别名）。
在随后的讨论中，我们将会假定我们有一个叫做“vi”的程序，但它其实是 vim。

### 启动和停止 vi

要想启动 vi，只要简单地输入以下命令：

    [me@linuxbox ~]$ vi

一个像这样的屏幕应该出现：

    VIM - Vi Improved
    ....

正如我们之前操作 nano 时，首先要学的是怎样退出 vi。要退出 vi，输入下面的命令（注意冒号是命令的一部分）：

    :q

shell 提示符应该返回。如果由于某种原因，vi 不能退出（通常因为我们对文件做了修改，却没有保存文件）。
通过给命令加上叹号，我们可以告诉 vi 我们真要退出 vi。

    :q!

小贴示：如果你在 vi 中“迷失”了，试着按下 Esc 键两次来找到路（回到普通模式）。

>
> 兼容模式
>
>上面实例中的启动屏幕（来自于 Ubuntu
8.04），我们看到一行文字“以 Vi 兼容的模式运行”。这意味着 vim 将以近似于 vi 常规的模式
运行，而不是 vim 的高级模式。为了这章的目的，我们想要使用 vim 的高级模式。要想这样做，
你有几个选择：
>
> 用 vim 来代替 vi。
>
> 如果命令生效，考虑在你的.bashrc 文件中添加别名 vi='vim'。
>
> 或者，使用这个命令在你的 vim 配置文件中添加一行：
>
>  _echo "set nocp" >\> ~/.vimrc_
>
> 不同的 Linux 发行版其 vim 软件包也迥然不同。一些发行版只是安装了 vim 的最小版本，
其默认只支持有限的 vim 特性。当练习随后的课程时，你可能会遇到缺失的功能。
如果是这种情况，就安装 vim 的完整版。

### 编辑模式

再次启动 vi，这次传递给 vi 一个不存在的文件名。这也是用 vi 创建新文件的方法。

    [me@linuxbox ~]$ rm -f foo.txt
    [me@linuxbox ~]$ vi foo.txt

如果一切运行正常，我们应该获得一个像这样的屏幕：

    ....
    "foo.txt" [New File]

每行开头的波浪号（"~"）指示那一行不存在文本。这表示我们有一个空文件。还没有输入任何字符？

学习 vi 时，要知道的第二件非常重要的事情是（知道了如何退出 vi 后）vi 是一个模式编辑器。当 vi 启动后，进入
的是命令模式。这种模式下，几乎每个按键都是一个命令，所以如果我们打算输入字符，vi 会发疯，弄得一团糟。

#### 插入模式

为了在文件中添加文本，首先我们必须进入插入模式。按下"i"按键进入插入模式。之后，我们应该
在屏幕底部看到下面一行，如果 vi 运行在高级模式下（这不会出现在 vi 兼容模式下）：

    -- INSERT --

现在我们能输入一些文本了。试着输入这些文本：

    The quick brown fox jumped over the lazy dog.

按下 Esc 按键，退出插入模式并返回命令模式。

#### 保存我们的工作

为了保存我们刚才对文件所做的修改，我们必须在命令模式下输入一个 ex 命令。
通过按下":"键，这很容易完成。按下冒号键之后，一个冒号字符应该出现在屏幕的底部：

    :

为了写入我们修改的文件，我们在冒号之后输入"w"字符，然后按下回车键：

    :w

文件将会写入到硬盘，并且我们应该在屏幕底部得到一个确认信息，就像这样：

    "foo.txt" [New] 1L, 46C written

小贴示：如果你阅读 vim 的文档，你注意到（令人困惑地）命令模式被叫做普通模式，ex 命令
叫做命令模式。当心。

### 移动光标

当在 vi 命令模式下时，vi 提供了大量的移动命令，其中一些是与 less 阅读器共享的。这里
列举了一些：

<table class="multi">
<caption class="cap">表13-1: 光标移动按键</caption>
<tr>
<th class="title">按键</th>
<th class="title">移动光标</th>
</tr>
<tr>
<td valign="top" width="25%">l or 右箭头</td>
<td valign="top">向右移动一个字符</td>
</tr>
<tr>
<td valign="top">h or 左箭头</td>
<td valign="top">向左移动一个字符</td>
</tr>
<tr>
<td valign="top">j or 下箭头</td>
<td valign="top">向下移动一行</td>
</tr>
<tr>
<td valign="top">k or 上箭头</td>
<td valign="top">向上移动一行</td>
</tr>
<tr>
<td valign="top">0 (零按键) </td>
<td valign="top">移动到当前行的行首。</td>
</tr>
<tr>
<td valign="top">^</td>
<td valign="top">移动到当前行的第一个非空字符。</td>
</tr>
<tr>
<td valign="top">$</td>
<td valign="top">移动到当前行的末尾。</td>
</tr>
<tr>
<td valign="top">w</td>
<td valign="top">移动到下一个单词或标点符号的开头。</td>
</tr>
<tr>
<td valign="top">W</td>
<td valign="top">移动到下一个单词的开头，忽略标点符号。</td>
</tr>
<tr>
<td valign="top">b</td>
<td valign="top">移动到上一个单词或标点符号的开头。</td>
</tr>
<tr>
<td valign="top">B</td>
<td valign="top">移动到上一个单词的开头，忽略标点符号。</td>
</tr>
<tr>
<td valign="top">Ctrl-f or Page Down </td>
<td valign="top">向下翻一页</td>
</tr>
<tr>
<td valign="top">Ctrl-b or Page Up </td>
<td valign="top">向上翻一页</td>
</tr>
<tr>
<td valign="top">numberG</td>
<td valign="top">移动到第 number 行。例如，1G 移动到文件的第一行。</td>
</tr>
<tr>
<td valign="top">G</td>
<td valign="top">移动到文件末尾。</td>
</tr>
</table>

为什么 h，j，k，和 l 按键被用来移动光标呢？因为在开发 vi 之初，并不是所有的视频终端都有
箭头按键，熟练的打字员可以使用规则的键盘按键来移动光标，他们的手从不需要移开键盘。

vi 中的许多命令都可以在前面加上一个数字，比方说上面提到的"G"命令。在命令之前加上一个
数字，我们就可以指定命令执行的次数。例如，命令"5j"导致 vi 向下移动5行。

### 基本编辑

大多数编辑工作由一些基本的操作组成，比如说插入文本，删除文本和通过剪切和粘贴来移动文本。
vi，当然，以它自己的独特方式来支持所有的操作。vi 也提供了有限的撤销形式。如果我们按下“u”
按键，当在命令模式下，vi 将会撤销你所做的最后一次修改。当我们试着执行一些基本的
编辑命令时，这会很方便。

#### 追加文本

vi 有几种不同进入插入模式的方法。我们已经使用了 i 命令来插入文本。

让我们返回到我们的 foo.txt 文件中，呆一会儿：

    The quick brown fox jumped over the lazy dog.

如果我们想要在这个句子的末尾添加一些文本，我们会发现 i 命令不能完成任务，因为我们不能把
光标移到行尾。vi 提供了追加文本的命令，明智地命名为"a"命令。如果我们把光标移动到行尾，输入"a",
光标就会越过行尾，vi 进入插入模式。这样就允许我们添加更多的文本：

    The quick brown fox jumped over the lazy dog. It was cool.

记住按下 Esc 按键来退出插入模式。

因为我们几乎总是想要在行尾附加文本，所以 vi 提供了一种快捷方式来移动到当前行的末尾，并且能添加
文本。它是"A"命令。试着用一下它，给文件添加更多行。

首先，使用"0"(零)命令，将光标移动到行首。现在我们输入"A"，来添加以下文本行：

    The quick brown fox jumped over the lazy dog. It was cool.
    Line 2
    Line 3
    Line 4
    Line 5

再一次，按下 Esc 按键退出插入模式。

正如我们所看到的，大 A 命令非常有用，因为在启动插入模式之前，它把光标移到了行尾。

#### 打开一行

我们插入文本的另一种方式是“打开”一行。这会在存在的两行之间插入一个空白行，并且进入插入模式。
这种方式有两个变体：

<table class="multi">
<caption class="cap">表13-2: 文本行打开按键</caption>
<tr>
<th class="title">命令</th>
<th class="title">打开行</th>
</tr>
<tr>
<td valign="top" width="25%">o</td>
<td valign="top">当前行的下方打开一行。</td>
</tr>
<tr>
<td valign="top">O</td>
<td valign="top">当前行的上方打开一行。</td>
</tr>
</table>

我们可以演示一下：把光标放到"Line 3"上，按下小 o 按键。

    The quick brown fox jumped over the lazy dog. It was cool.
    Line 2
    Line 3

    line 4
    line 5

在第三行之下打开了新的一行，并且进入插入模式。按下 Esc，退出插入模式。按下 u 按键，撤销我们的修改。

按下大 O 按键在光标之上打开新的一行：

    The quick brown fox jumped over the lazy dog. It was cool.
    Line 2

    Line 3
    Line 4
    Line 5

按下 Esc 按键，退出插入模式，并且按下 u 按键，撤销我们的更改。

#### 删除文本

正如我们期望的，vi 提供了各种各样的方式来删除文本，所有的方式包含一个或两个按键。首先，
x 按键会删除光标位置的一个字符。可以在 x 命令之前带上一个数字，来指明要删除的字符个数。
d 按键更通用一些。类似 x 命令，d 命令之前可以带上一个数字，来指定要执行的删除次数。另外，
d 命令之后总是带上一个移动命令，用来控制删除的范围。这里有些实例：

<table class="multi">
<caption class="cap">表13-3: 文本删除命令</caption>
<tr>
<th class="title">命令</th>
<th class="title">删除的文本</th>
</tr>
<tr>
<td valign="top" width="25%">x</td>
<td valign="top">当前字符</td>
</tr>
<tr>
<td valign="top">3x</td>
<td valign="top">当前字符及其后的两个字符。</td>
</tr>
<tr>
<td valign="top" width="25%">dd</td>
<td valign="top">当前行。</td>
</tr>
<tr>
<td valign="top" width="25%">5dd</td>
<td valign="top">当前行及随后的四行文本。</td>
</tr>
<tr>
<td valign="top" width="25%">dW</td>
<td valign="top">从光标位置开始到下一个单词的开头。</td>
</tr>
<tr>
<td valign="top" width="25%">d$</td>
<td valign="top">从光标位置开始到当前行的行尾。</td>
</tr>
<tr>
<td valign="top" width="25%">d0</td>
<td valign="top">从光标位置开始到当前行的行首。</td>
</tr>
<tr>
<td valign="top" width="25%">d^</td>
<td valign="top">从光标位置开始到文本行的第一个非空字符。</td>
</tr>
<tr>
<td valign="top" width="25%">dG</td>
<td valign="top">从当前行到文件的末尾。</td>
</tr>
<tr>
<td valign="top" width="25%">d20G</td>
<td valign="top">从当前行到文件的第20行。</td>
</tr>
</table>

把光标放到第一行单词“It”之上。重复按下 x 按键直到删除剩下的部分。下一步，重复按下 u 按键
直到恢复原貌。

注意：真正的 vi 只是支持单层面的 undo 命令。vim 则支持多个层面的。

我们再次执行删除命令，这次使用 d 命令。还是移动光标到单词"It"之上，按下的 dW 来删除单词：

    The quick brown fox jumped over the lazy dog. was cool.
    Line 2
    Line 3
    Line 4
    Line 5

按下 d$删除从光标位置到行尾的文本：

    The quick brown fox jumped over the lazy dog.
    Line 2
    Line 3
    Line 4
    Line 5

按下 dG 按键删除从当前行到文件末尾的所有行：

    ~
    ....

连续按下 u 按键三次，来恢复删除部分。

#### 剪切，复制和粘贴文本

这个 d 命令不仅删除文本，它还“剪切”文本。每次我们使用 d 命令，删除的部分被复制到一个
粘贴缓冲区中（看作剪切板）。过后我们执行小 p 命令把剪切板中的文本粘贴到光标位置之后，
或者是大 P 命令把文本粘贴到光标之前。

y 命令用来“拉”（复制）文本，和 d 命令剪切文本的方式差不多。这里有些把 y 命令和各种移动命令
结合起来使用的实例：

<table class="multi">
<caption class="cap">表13-4: 复制命令 </caption>
<tr>
<th class="title">命令</th>
<th class="title">复制的内容</th>
</tr>
<tr>
<td valign="top" width="25%">yy</td>
<td valign="top">当前行。</td>
</tr>
<tr>
<td valign="top">5yy</td>
<td valign="top">当前行及随后的四行文本。</td>
</tr>
<tr>
<td valign="top">yW</td>
<td valign="top">从当前光标位置到下一个单词的开头。</td>
</tr>
<tr>
<td valign="top">y$</td>
<td valign="top">从当前光标位置到当前行的末尾。</td>
</tr>
<tr>
<td valign="top">y0</td>
<td valign="top">从当前光标位置到行首。</td>
</tr>
<tr>
<td valign="top">y^</td>
<td valign="top">从当前光标位置到文本行的第一个非空字符。</td>
</tr>
<tr>
<td valign="top">yG</td>
<td valign="top">从当前行到文件末尾。</td>
</tr>
<tr>
<td valign="top">y20G</td>
<td valign="top">从当前行到文件的第20行。</td>
</tr>
</table>

我们试着做些复制和粘贴工作。把光标放到文本第一行，输入 yy 来复制当前行。下一步，把光标移到
最后一行（G），输入小写的 p 把复制的一行粘贴到当前行的下面：

    The quick brown fox jumped over the lazy dog. It was cool.
    Line 2
    Line 3
    Line 4
    Line 5
    The quick brown fox jumped over the lazy dog. It was cool.

和以前一样，u 命令会撤销我们的修改。光标仍然位于文件的最后一行，输入大写的 P 命令把
所复制的文本粘贴到当前行之上：

    The quick brown fox jumped over the lazy dog. It was cool.
    Line 2
    Line 3
    Line 4
    The quick brown fox jumped over the lazy dog. It was cool.
    Line 5

试着执行上表中一些其他的 y 命令，了解小写 p 和大写 P 命令的行为。当你完成练习之后，把文件
恢复原样。

#### 连接行

vi 对于行的概念相当严格。通常，不可能把光标移到行尾，再删除行尾结束符（回车符）来连接
当前行和它下面的一行。由于这个原因，vi 提供了一个特定的命令，大写的 J（不要与小写的 j 混淆了，
j 是用来移动光标的）把行与行之间连接起来。

如果我们把光标放到 line 3上，输入大写的 J 命令，看看发生什么情况：

    The quick brown fox jumped over the lazy dog. It was cool.
    Line 2
    Line 3 Line 4
    Line 5

### 查找和替换

vi 有能力把光标移到搜索到的匹配项上。vi 可以在单一行或整个文件中运用这个功能。
它也可以在有或没有用户确认的情况下实现文本替换。

#### 查找一行

f 命令查找一行，移动光标到下一个所指定的字符上。例如，命令 fa 会把光标定位到同一行中
下一个出现的"a"字符上。在一行中执行了字符的查找命令之后，通过输入分号来重复这个查找。

#### 查找整个文件

移动光标到下一个出现的单词或短语上，使用 / 命令。这个命令和我们之前在 less 程序中学到
的一样。当你输入/命令后，一个"/"字符会出现在屏幕底部。下一步，输入要查找的单词或短语后，
按下回车。光标就会移动到下一个包含所查找字符串的位置。通过 n 命令来重复先前的查找。
这里有个例子：

    The quick brown fox jumped over the lazy dog. It was cool.
    Line 2
    Line 3
    Line 4
    Line 5

把光标移动到文件的第一行。输入：

    /Line

然后键入回车。光标会移动到第二行。下一步，输入 n，光标移到第三行。重复这个 n 命令，光标会
继续向下移动直到遍历了所有的匹配项。虽然目前，我们只是使用了单词和短语来作为我们的查找
模式，但是 vi 允许使用正则表达式，一种强大的用来表示复杂文本模式的方法。我们将会在随后
的章节里面详尽地介绍正则表达式。

#### 全局查找和替代

vi 使用 ex 命令来执行查找和替代操作（vi 中叫做“替换”）。把整个文件中的单词“Line”更改为“line”，
我们输入以下命令：

    :%s/Line/line/g

我们把这个命令分解为几个单独的部分，看一下每部分的含义：

<table class="multi">
<tr>
<th class="title">条目</th>
<th class="title">含义</th>
</tr>
<tr>
<td valign="top" width="25%">:</td>
<td valign="top">冒号字符运行一个 ex 命令。</td>
</tr>
<tr>
<td valign="top">%</td>
<td valign="top">指定要操作的行数。% 是一个快捷方式，表示从第一行到最后一行。另外，操作范围也
可以用 1,5 来代替（因为我们的文件只有5行文本），或者用 1,$ 来代替，意思是 “ 从第一行到文件的最后一行。”
如果省略了文本行的范围，那么操作只对当前行生效。</td>
</tr>
<tr>
<td valign="top">s</td>
<td valign="top">指定操作。在这种情况下是，替换（查找与替代）。</td>
</tr>
<tr>
<td valign="top">/Line/line</td>
<td valign="top">查找类型与替代文本。</td>
</tr>
<tr>
<td valign="top">g</td>
<td valign="top">这是“全局”的意思，意味着对文本行中所有匹配的字符串执行查找和替换操作。如果省略 g，则
只替换每个文本行中第一个匹配的字符串。</td>
</tr>
</table>

执行完查找和替代命令之后，我们的文件看起来像这样：

    The quick brown fox jumped over the lazy dog. It was cool.
    line 2
    line 3
    line 4
    line 5

我们也可以指定一个需要用户确认的替换命令。通过添加一个"c"字符到这个命令的末尾，来完成
这个替换命令。例如：

    :%s/line/Line/gc

这个命令会把我们的文件恢复先前的模样；然而，在执行每个替换命令之前，vi 会停下来，
通过下面的信息，来要求我们确认这个替换：

    replace with Line (y/n/a/q/l/^E/^Y)?

括号中的每个字符都是一个可能的选择，如下所示：

<table class="multi">
<caption class="cap">表13-5: 替换确认按键</caption>
<tr>
<th class="title">按键</th>
<th class="title">行为</th>
</tr>
<tr>
<td valign="top" width="25%">y</td>
<td valign="top">执行替换操作</td>
</tr>
<tr>
<td valign="top">n</td>
<td valign="top">跳过这个匹配的实例</td>
</tr>
<tr>
<td valign="top">a</td>
<td valign="top">对这个及随后所有匹配的字符串执行替换操作。</td>
</tr>
<tr>
<td valign="top">q or esc</td>
<td valign="top">退出替换操作。</td>
</tr>
<tr>
<td valign="top">l</td>
<td valign="top">执行这次替换并退出。l 是 “last” 的简写。</td>
</tr>
<tr>
<td valign="top">Ctrl-e, Ctrl-y</td>
<td valign="top">分别是向下滚动和向上滚动。用于查看建议替换的上下文。</td>
</tr>
</table>

如果你输入 y，则执行这个替换，输入 n 则会导致 vi 跳过这个实例，而移到下一个匹配项上。

### 编辑多个文件

同时能够编辑多个文件是很有用的。你可能需要更改多个文件或者从一个文件复制内容到
另一个文件。通过 vi，我们可以打开多个文件来编辑，只要在命令行中指定要编辑的文件名。

    vi file1 file2 file3...

我们先退出已经存在的 vi 会话，然后创建一个新文件来编辑。输入:wq 来退出 vi 并且保存了所做的修改。
下一步，我们将在家目录下创建一个额外的用来玩耍的文件。通过获取从 ls 命令的输出，来创建这个文件。

    [me@linuxbox ~]$ ls -l /usr/bin > ls-output.txt

用 vi 来编辑我们的原文件和新创建的文件：

    [me@linuxbox ~]$ vi foo.txt ls-output.txt

vi 启动，我们会看到第一个文件显示出来：

    The quick brown fox jumped over the lazy dog. It was cool.
    Line 2
    Line 3
    Line 4
    Line 5

#### 文件之间转换

从这个文件转到下一个文件，使用这个 ex 命令：

    :n

回到先前的文件使用：

    :N

当我们从一个文件移到另一个文件时，如果当前文件没有保存修改，vi 会阻止我们转换文件，
这是 vi 强制执行的政策。在命令之后添加感叹号，可以强迫 vi 放弃修改而转换文件。

另外，上面所描述的转换方法，vim（和一些版本的 vi）也提供了一些 ex 命令，这些命令使
多个文件更容易管理。我们可以查看正在编辑的文件列表，使用:buffers 命令。运行这个
命令后，屏幕顶部就会显示出一个文件列表：

    :buffers
    1 #     "foo.txt"                 line 1
    2 %a    "ls-output.txt"           line 0
    Press ENTER or type command to continue

要切换到另一个缓冲区（文件），输入 :buffer, 紧跟着你想要编辑的缓冲器编号。比如，要从包含文件 foo.txt
的1号缓冲区切换到包含文件 ls-output.txt 的2号缓冲区，我们会这样输入：

    :buffer 2

我们的屏幕现在会显示第二个文件。

#### 打开另一个文件并编辑

在我们的当前的编辑会话里也能添加别的文件。ex 命令 :e (编辑(edit) 的简写) 紧跟要打开的文件名将会打开
另外一个文件。 让我们结束当前的会话回到命令行。

重新启动vi并只打开一个文件

    [me@linuxbox ~]$ vi foo.txt

要加入我们的第二个文件，输入：

    :e ls-output.txt

它应该显示在屏幕上。 我们可以这样来确认第一个文件仍然存在：

    :buffers
     1 # "foo.txt" line 1
     2 %a "ls-output.txt" line 0
    Press ENTER or type command to continue 

注意：你不同通过:n 或:N 命令在由:e 命令加载的文件之间进行切换。这时要使用:buffer 命令，
其后加上缓冲区号码，来转换文件。

#### 从一个文件复制内容到另一个文件

当我们编辑多个文件时，经常地要复制文件的一部分到另一个正在编辑的文件。使用之前我们学到的
拉（yank）和粘贴命令，这很容易完成。说明如下。以打开的两个文件为例，首先转换到缓冲区1（foo.txt）
，输入：

    :buffer 1

我们应该得到以下输出：

    The quick brown fox jumped over the lazy dog. It was cool.
    Line 2
    Line 3
    Line 4
    Line 5

下一步，把光标移到第一行，并且输入 yy 来复制这一行。

转换到第二个缓冲区，输入：

    :buffer 2

现在屏幕会包含一些文件列表（这里只列出了一部分）：

    total 343700
    -rwxr-xr-x 1 root root    31316  2007-12-05  08:58 [
    ....

移动光标到第一行，输入 p 命令把我们从前面文件中复制的一行粘贴到这个文件中：

    total 343700
    The quick brown fox jumped over the lazy dog. It was cool.
    -rwxr-xr-x 1 root root    31316  2007-12-05  08:58 [
    ....

#### 插入整个文件到另一个文件

也有可能把整个文件插入到我们所编辑的文件中。看一下实际操作，结束 vi 会话，重新
启动一个只打开一个文件的 vi 会话：

    [me@linuxbox ~]$ vi ls-output.txt

再一次看到我们的文件列表：

    total 343700
    -rwxr-xr-x 1 root root    31316  2007-12-05  08:58 [

移动光标到第三行，然后输入以下 ex 命令：

    :r foo.txt

这个:r 命令（是"read"的简称）把指定的文件插入到光标位置之前。现在屏幕应该看起来像这样：

    total 343700
    -rwxr-xr-x 1 root root     31316 2007-12-05  08:58 [
    ....
    The quick brown fox jumped over the lazy dog. It was cool.
    Line 2
    Line 3
    Line 4
    Line 5
    -rwxr-xr-x 1 root root     111276 2008-01-31  13:36 a2p
    ....

### 保存工作

像 vi 中的其它操作一样，有几种不同的方法来保存我们所修改的文件。我们已经研究了:w 这个
ex 命令， 但还有几种方法，可能我们也觉得有帮助。

在命令模式下，输入 ZZ 就会保存并退出当前文件。同样地，ex 命令:wq 把:w 和:q 命令结合到
一起，来完成保存和退出任务。

这个:w 命令也可以指定可选的文件名。这个的作用就如"Save As..."。例如，如果我们
正在编辑 foo.txt 文件，想要保存一个副本，叫做 foo1.txt，那么我们可以执行以下命令：

    :w foo1.txt

---

注意：当上面的命令以一个新名字保存文件时，但它并没有更改你正在编辑的文件的名字。
如果你继续编辑的话，你还是在编辑文件 foo.txt，而不是 foo1.txt。

---

### 拓展阅读

即使把这章所学的内容都加起来，我们也只是学了 vi 和 vim 的一点儿皮毛而已。这里
有一些在线的资料，你可以用来继续 vi 学习之旅。

* 学习 vi 编辑器－一本来自于 Wikipedia 的 Wikibook，是一本关于 vi 的简要指南，并
  介绍了几个类似 vi 的程序，其中包括 vim。它可以在以下链接中得到：

  <http://en.wikibooks.org/wiki/Vi>

* The Vim Book－vim 项目，一本570页的书籍，包含了（几乎）所有的 vim 特性。你能在下面链接中找到它：

* Wikipedia 上关于 Bill Joy 的文章，vi 的创始人。

  <http://en.wikipedia.org/wiki/Bill_Joy>

* Wikipedia 上关于 Bram Moolenaar 的文章，vim 的作者：

  <http://en.wikipedia.org/wiki/Bram_Moolenaar>


---
layout: book-zh
title: 自定制 shell 提示符
---

在这一章中，我们将会看一下表面上看来很琐碎的细节－shell 提示符。但这会揭示一些内部 shell 和
终端仿真器的工作方式。

和 Linux 内的许多程序一样，shell 提示符是可高度配置的，虽然我们把它相当多地看作是理所当然的，
但是我们一旦学会了怎样控制它，shell 提示符是一个真正有用的设备。

### 解剖一个提示符

我们默认的提示符看起来像这样：

    [me@linuxbox ~]$

注意它包含我们的用户名，主机名和当前工作目录，但是它又是怎样得到这些东西的呢？
结果证明非常简单。提示符是由一个环境变量定义的，叫做 PS1（是“prompt string one”
的简写）。我们可以通过 echo 命令来查看 PS1的内容。

    [me@linuxbox ~]$ echo $PS1
    [\u@\h \W]\$

---

注意：如果你 shell 提示符的内容和上例不是一模一样，也不必担心。每个 Linux 发行版
定义的提示符稍微有点不同，其中一些相当异乎寻常。

---

从输出结果中，我们看到那个 PS1 环境变量包含一些这样的字符，比方说中括号，@符号，和美元符号，
但是剩余部分就是个谜。我们中一些机敏的人会把这些看作是由反斜杠转义的特殊字符，就像我们
在第八章中看到的一样。这里是一部分字符列表，在提示符中 shell 会特殊对待这些字符：

<table class="multi">
<caption class="cap">表14-1: Shell 提示符中用到的转义字符</caption>
<tr>
<th class="title">序列</th>
<th class="title">显示值</th>
</tr>
<tr>
<td valign="top" width="20%">\a</td>
<td valign="top">以 ASCII 格式编码的铃声 . 当遇到这个转义序列时，计算机会发出嗡嗡的响声。</td>
</tr>
<tr>
<td valign="top">\d</td>
<td valign="top">以日，月，天格式来表示当前日期。例如，“Mon May 26.”</td>
</tr>
<tr>
<td valign="top">\h</td>
<td valign="top">本地机的主机名，但不带末尾的域名。</td>
</tr>
<tr>
<td valign="top">\H</td>
<td valign="top">完整的主机名。</td>
</tr>
<tr>
<td valign="top">\j</td>
<td valign="top">运行在当前 shell 会话中的工作数。</td>
</tr>
<tr>
<td valign="top">\l</td>
<td valign="top">当前终端设备名。</td>
</tr>
<tr>
<td valign="top">\n</td>
<td valign="top">一个换行符。</td>
</tr>
<tr>
<td valign="top">\r</td>
<td valign="top">一个回车符。</td>
</tr>
<tr>
<td valign="top">\s</td>
<td valign="top">shell 程序名。</td>
</tr>
<tr>
<td valign="top">\t</td>
<td valign="top">以24小时制，hours:minutes:seconds 的格式表示当前时间.</td>
</tr>
<tr>
<td valign="top">\T</td>
<td valign="top">以12小时制表示当前时间。 </td>
</tr>
<tr>
<td valign="top">\@</td>
<td valign="top">以12小时制，AM/PM 格式来表示当前时间。</td>
</tr>
<tr>
<td valign="top">\A</td>
<td valign="top">以24小时制，hours:minutes 格式表示当前时间。</td>
</tr>
<tr>
<td valign="top">\u</td>
<td valign="top">当前用户名。</td>
</tr>
<tr>
<td valign="top">\v</td>
<td valign="top">shell 程序的版本号。</td>
</tr>
<tr>
<td valign="top">\V</td>
<td valign="top">Version and release numbers of the shell.</td>
</tr>
<tr>
<td valign="top">\w</td>
<td valign="top">当前工作目录名。</td>
</tr>
<tr>
<td valign="top">\W</td>
<td valign="top">当前工作目录名的最后部分。</td>
</tr>
<tr>
<td valign="top">\!</td>
<td valign="top">当前命令的历史号。
</td>
</tr>
<tr>
<td valign="top">\#</td>
<td valign="top">当前 shell 会话中的命令数。
</td>
</tr>
<tr>
<td valign="top">\$</td>
<td valign="top">这会显示一个"$"字符，除非你拥有超级用户权限。在那种情况下，
它会显示一个"#"字符。</td>
</tr>
<tr>
<td valign="top">\[</td>
<td valign="top">标志着一系列一个或多个非打印字符的开始。这被用来嵌入非打印
的控制字符，这些字符以某种方式来操作终端仿真器，比方说移动光标或者是更改文本颜色。
</td>
</tr>
<tr>
<td valign="top">\]</td>
<td valign="top">标志着非打印字符序列结束。 </td>
</tr>
</table>

### 试试一些可替代的提示符设计

参照这个特殊字符列表，我们可以更改提示符来看一下效果。首先，
我们把原来提示符字符串的内容备份一下，以备之后恢复原貌。为了完成备份，
我们把已有的字符串复制到另一个 shell 变量中，这个变量是我们自己创造的。

    [me@linuxbox ~]$ ps1_old="$PS1"

我们新创建了一个叫做 ps1_old 的变量，并把变量 PS1的值赋 ps1_old。通过 echo 命令可以证明
我们的确复制了 PS1的值。

    [me@linuxbox ~]$ echo $ps1_old
    [\u@\h \W]\$

在终端会话中，我们能在任一时间复原提示符，只要简单地反向操作就可以了。

    [me@linuxbox ~]$ PS1="$ps1_old"

现在，我们准备开始，让我们看看如果有一个空的字符串会发生什么：

    [me@linuxbox ~]$ PS1=

如果我们没有给提示字符串赋值，那么我们什么也得不到。根本没有提示字符串！提示符仍然在那里，
但是什么也不显示，正如我们所要求的那样。我们将用一个最小的提示符来代替它：

    PS1="\$ "

这样要好一些。至少能看到我们在做什么。注意双引号中末尾的空格。当提示符显示的时候，
这个空格把美元符号和光标分离开。

在提示符中添加一个响铃：

    $ PS1="\a\$ "

现在每次提示符显示的时候，我们应该能听到嗡嗡声。这会变得很烦人，但是它可能会
很有用，特别是当一个需要运行很长时间的命令执行完后，我们要得到通知。

下一步，让我们试着创建一个信息丰富的提示符，包含主机名和当天时间的信息。

    $ PS1="\A \h \$ "
    17:33 linuxbox $

试试其他上表中列出的转义序列，看看你能否想出精彩的新提示符。

### 添加颜色

大多数终端仿真器程序支持一定的非打印字符序列来控制，比方说字符属性（像颜色，黑体和可怕的闪烁）
和光标位置。我们会更深入地讨论光标位置，但首先我们要看一下字体颜色。

>
> 混乱的终端时代
>
> 回溯到终端连接到远端计算机的时代，有许多竞争的终端品牌，它们各自工作不同。
它们有着不同的键盘，以不同的方式来解释控制信息。Unix 和类 Unix 的系统有两个
相当复杂的子系统来处理终端控制领域的混乱局面（称为 termcap 和 terminfo）。如果你
查看一下终端仿真器最底层的属性设置，可能会找到一个关于终端仿真器类型的设置。
>
> 为了努力使所有的终端都讲某种通用语言，美国国家标准委员会（ANSI）制定了
一套标准的字符序列集合来控制视频终端。原先 DOS 用户会记得 ANSI.SYS 文件，
这是一个用来使这些编码解释生效的文件。

字符颜色是由发送到终端仿真器的一个嵌入到了要显示的字符流中的 ANSI 转义编码来控制的。
这个控制编码不会“打印”到屏幕上，而是被终端解释为一个指令。正如我们在上表看到的字符序列，
这个 [ 和 ] 序列被用来封装这些非打印字符。一个 ANSI 转义编码以一个八进制033（这个编码是由
退出按键产生的）开头，其后跟着一个可选的字符属性，在之后是一个指令。例如，把文本颜色
设为正常（attribute = 0），黑色文本的编码如下：

    \033[0;30m

这里是一个可用的文本颜色列表。注意这些颜色被分为两组，由应用程序粗体字符属性（1）
分化开来，这个属性可以描绘出“浅”色文本。

<table class="multi">
<caption class="cap">表14-2: 用转义序列来设置文本颜色</caption>
<tr>
<th class="title">序列</th>
<th class="title">文本颜色</th>
<th class="title">序列</th>
<th class="title">文本颜色</th>
</tr>
<tr>
<td valign="top">\033[0;30m</td>
<td valign="top">黑色</td>
<td valign="top">\033[1;30m </td>
<td valign="top">深灰色</td>
</tr>
<tr>
<td valign="top">\033[0;31m</td>
<td valign="top">红色</td>
<td valign="top">\033[1;31m </td>
<td valign="top">浅红色</td>
</tr>
<tr>
<td valign="top">\033[0;32m </td>
<td valign="top">绿色</td>
<td valign="top">\033[1;32m </td>
<td valign="top">浅绿色</td>
</tr>
<tr>
<td valign="top">\033[0;33m </td>
<td valign="top">棕色</td>
<td valign="top">\033[1;33m </td>
<td valign="top">黄色</td>
</tr>
<tr>
<td valign="top">\033[0;34m </td>
<td valign="top">蓝色</td>
<td valign="top">\033[1;34m </td>
<td valign="top">浅蓝色</td>
</tr>
<tr>
<td valign="top">\033[0;35m </td>
<td valign="top">粉红</td>
<td valign="top">\033[1;35m </td>
<td valign="top">浅粉色</td>
</tr>
<tr>
<td valign="top">\033[0;36m </td>
<td valign="top">青色</td>
<td valign="top">\033[1;36m </td>
<td valign="top">浅青色</td>
</tr>
<tr>
<td valign="top">\033[0;37m </td>
<td valign="top">浅灰色</td>
<td valign="top">\033[1;37m </td>
<td valign="top">白色</td>
</tr>
</table>

让我们试着制作一个红色提示符。我们将在开头加入转义编码：

    <me@linuxbox ~>$ PS1='\[\033[0;31m\]<\u@\h \W>\$'
    <me@linuxbox ~>$

我们的提示符生效了，但是注意我们在提示符之后输入的文本也是红色的。为了修改这个问题，
我们将添加另一个转义编码到这个提示符的末尾来告诉终端仿真器恢复到原来的颜色。

    <me@linuxbox ~>$ PS1='\[\033[0;31m\]<\u@\h \W>\$\[\033[0m\]'
    <me@linuxbox ~>$

这看起来要好些！

也有可能要设置文本的背景颜色，使用下面列出的转义编码。这个背景颜色不支持黑体属性。

<table class="multi">
<caption class="cap">表14-3: 用转义序列来设置背景颜色</caption>
<tr>
<td valign="top">\033[0;40m </td>
<td valign="top">蓝色</td>
<td valign="top">\033[1;44m </td>
<td valign="top">黑色</td>
</tr>
<tr>
<td valign="top">\033[0;41m </td>
<td valign="top">红色</td>
<td valign="top">\033[1;45m </td>
<td valign="top">紫色</td>
</tr>
<tr>
<td valign="top">\033[0;42m </td>
<td valign="top">绿色</td>
<td valign="top">\033[1;46m </td>
<td valign="top">青色</td>
</tr>
<tr>
<td valign="top">\033[0;43m </td>
<td valign="top">棕色</td>
<td valign="top">\033[1;47m </td>
<td valign="top">浅灰色</td>
</tr>
</table>

我们可以创建一个带有红色背景的提示符，只是对第一个转义编码做个简单的修改。

    <me@linuxbox ~>$ PS1='\[\033[0;41m\]<\u@\h \W>\$\[\033[0m\] '
    <me@linuxbox ~>$

试试这些颜色编码，看看你能定制出怎样的提示符！

---

注意：除了正常的 (0) 和黑体 (1) 字符属性之外，文本也可以具有下划线 (4)，闪烁 (5)，
和反向 (7) 属性。为了拥有好品味，然而，许多终端仿真器拒绝使用这个闪烁属性。

---

### 移动光标

转义编码也可以用来定位光标。这些编码被普遍地用来，每次当提示符出现的时候，会在屏幕的不同位置
比如说上面一个角落，显示一个时钟或者其它一些信息。这里是一系列用来定位光标的转义编码：

<table class="multi">
<caption class="cap">表14-4: 光标移动转义序列</caption>
<tr>
<th class="title">转义编码</th>
<th class="title">行动</th>
</tr>
<tr>
<td valign="top" width="25%">\033[l;cH </td>
<td valign="top">把光标移到第 l 行，第 c 列。</td>
</tr>
<tr>
<td valign="top">\033[nA </td>
<td valign="top">把光标向上移动 n 行。</td>
</tr>
<tr>
<td valign="top">\033[nB </td>
<td valign="top">把光标向下移动 n 行。</td>
</tr>
<tr>
<td valign="top">\033[nC </td>
<td valign="top">把光标向前移动 n 个字符。</td>
</tr>
<tr>
<td valign="top">\033[nD </td>
<td valign="top">把光标向后移动 n 个字符。</td>
</tr>
<tr>
<td valign="top">\033[2J </td>
<td valign="top">清空屏幕，把光标移到左上角（第零行，第零列）。</td>
</tr>
<tr>
<td valign="top">\033[K </td>
<td valign="top">清空从光标位置到当前行末的内容。</td>
</tr>
<tr>
<td valign="top">\033[s </td>
<td valign="top">存储当前光标位置。</td>
</tr>
<tr>
<td valign="top">\033[u </td>
<td valign="top">唤醒之前存储的光标位置。</td>
</tr>
</table>

使用上面的编码，我们将构建一个提示符，每次当这个提示符出现的时候，会在屏幕的上方画出一个
包含时钟（由黄色文本渲染）的红色长条。提示符的编码就是这个看起来令人敬畏的字符串：

    PS1='\[\033[s\033[0;0H\033[0;41m\033[K\033[1;33m\t\033[0m\033[u\]
    <\u@\h \W>\$ '

让我们分别看一下这个字符串的每一部分所表示的意思：

<table class="multi">
<tr>
<th class="title">序列</th>
<th class="title">行动</th>
</tr>
<tr>
<td valign="top" width="25%">\[</td>
<td valign="top">开始一个非打印字符序列。其真正的目的是为了让 bash
能够正确地计算提示符的大小。如果没有这个转义字符的话，命令行编辑
功能会弄错光标的位置。</td>
</tr>
<tr>
<td valign="top">\033[s </td>
<td valign="top">存储光标位置。这个用来使光标能回到原来提示符的位置，
当长条和时钟显示到屏幕上方之后。当心一些
终端仿真器不推崇这个编码。</td>
</tr>
<tr>
<td valign="top">\033[0;0H </td>
<td valign="top"> 把光标移到屏幕左上角，也就是第零行，第零列的位置。 </td>
</tr>
<tr>
<td valign="top">\033[0;41m </td>
<td valign="top">把背景设置为红色。</td>
</tr>
<tr>
<td valign="top">\033[K </td>
<td valign="top">清空从当前光标位置到行末的内容。因为现在
背景颜色是红色，则被清空行背景成为红色，以此来创建长条。注意虽然一直清空到行末，
但是不改变光标位置，它仍然在屏幕左上角。</td>
</tr>
<tr>
<td valign="top">\033[1;33m </td>
<td valign="top">把文本颜色设为黄色。</td>
</tr>
<tr>
<td valign="top">\t </td>
<td valign="top">显示当前时间。虽然这是一个可“打印”的元素，但我们仍把它包含在提示符的非打印部分，
因为我们不想 bash 在计算可见提示符的真正大小时包括这个时钟在内。</td>
</tr>
<tr>
<td valign="top">\033[0m </td>
<td valign="top">关闭颜色设置。这对文本和背景都起作用。</td>
</tr>
<tr>
<td valign="top">\033[u </td>
<td valign="top">恢复到之前保存过的光标位置处。</td>
</tr>
<tr>
<td valign="top">\] </td>
<td valign="top">结束非打印字符序列。</td>
</tr>
<tr>
<td valign="top"><\u@\h \W>\$ </td>
<td valign="top">提示符字符串。</td>
</tr>
</table>

### 保存提示符

显然地，我们不想总是敲入那个怪物，所以我们将要把这个提示符存储在某个地方。通过把它
添加到我们的.bashrc 文件，可以使这个提示符永久存在。为了达到目的，把下面这两行添加到.bashrc 文件中。

    PS1='\[\033[s\033[0;0H\033[0;41m\033[K\033[1;33m\t\033[0m\033[u\]<\u@\h \W>\$ '
    export PS1

### 总结归纳

不管你信不信，还有许多事情可以由提示符来完成，涉及到我们在这里没有论及的 shell 函数和脚本，
但这是一个好的开始。并不是每个人都会花心思来更改提示符，因为通常默认的提示符就很让人满意。
但是对于我们这些喜欢思考的人们来说，shell 却提供了许多制造琐碎乐趣的机会。

### 拓展阅读

* The Bash Prompt HOWTO 来自于 Linux 文档工程，对 shell 提示符的用途进行了相当
  完备的论述。可在以下链接中得到：

    <http://tldp.org/HOWTO/Bash-Prompt-HOWTO/>

* Wikipedia 上有一篇关于 ANSI Escape Codes 的好文章：

    <http://en.wikipedia.org/wiki/ANSI_escape_code>


---
layout: book-zh
title: 操作文件和目录
---

此时此刻，我们已经准备好了做些真正的工作！这一章节将会介绍以下命令：

* cp — 复制文件和目录

* mv — 移动/重命名文件和目录

* mkdir — 创建目录

* rm — 删除文件和目录

* ln — 创建硬链接和符号链接

这五个命令属于最常使用的 Linux 命令之列。它们用来操作文件和目录。

现在，坦诚地说，用图形文件管理器来完成一些由这些命令执行的任务会更容易些。使用文件管理器，
我们可以把文件从一个目录拖放到另一个目录，剪贴和粘贴文件，删除文件等等。那么，
为什么还使用早期的命令行程序呢？

答案是命令行程序，功能强大灵活。虽然图形文件管理器能轻松地实现简单的文件操作，但是对于
复杂的文件操作任务，则使用命令行程序比较容易完成。例如，怎样复制一个目录下的 HTML 文件
到另一个目录，但这些 HTML 文件不存在于目标目录，或者是文件版本新于目标目录里的文件？
要完成这个任务，使用文件管理器相当难，使用命令行相当容易：

    cp -u *.html destination

### 通配符

在开始使用命令之前，我们需要介绍一个使命令行如此强大的 shell 特性。因为 shell 频繁地使用
文件名，shell 提供了特殊字符来帮助你快速指定一组文件名。这些特殊字符叫做通配符。
使用通配符（也以文件名代换著称）允许你依据字符类型来选择文件名。下表列出这些通配符
以及它们所选择的对象：

<table class="multi">
<caption class="cap">表5-1: 通配符</caption>
<tr>
<th class="title">通配符</th>
<th class="title">意义</th>
</tr>
<tr>
<td valign="top">*</td>
<td valign="top">匹配任意多个字符（包括零个或一个）</td>
</tr>
<tr>
<td valign="top">?</td>
<td valign="top">匹配任意一个字符（不包括零个）</td>
</tr>
<tr>
<td valign="top">[characters]</td>
<td valign="top">匹配任意一个属于字符集中的字符</td>
</tr>
<tr>
<td valign="top">[!characters]</td>
<td valign="top">匹配任意一个不是字符集中的字符</td>
</tr>
<tr>
<td valign="top" width="25%">[[:class:]]</td>
<td valign="top">匹配任意一个属于指定字符类中的字符</td>
</tr>
</table>

表5-2列出了最常使用的字符类：

<table class="multi">
<caption class="cap">表5-2: 普遍使用的字符类</caption>
<tr>
<th class="title">字符类</th>
<th class="title">意义</th>
</tr>
<tr>
<td>[:alnum:]</td>
<td>匹配任意一个字母或数字</td>
</tr>
<tr>
<td>[:alpha:]</td>
<td>匹配任意一个字母</td>
</tr>
<tr>
<td>[:digit:]</td>
<td>匹配任意一个数字</td>
</tr>
<tr>
<td>[:lower:]</td>
<td>匹配任意一个小写字母</td>
</tr>
<tr>
<td width="25%">[:upper]</td>
<td>匹配任意一个大写字母</td>
</tr>
</table>

借助通配符，为文件名构建非常复杂的选择标准成为可能。下面是一些类型匹配的范例:

<table class="multi">
<caption class="cap">表5-3: 通配符范例</caption>
<tr>
<th class="title">模式</th>
<th class="title">匹配对象</th>
</tr>
<tr>
<td valign="top">*</td>
<td valign="top">所有文件</td>
</tr>
<tr>
<td valign="top">g*</td>
<td valign="top">文件名以“g”开头的文件</td>
</tr>
<tr>
<td valign="top">b*.txt</td>
<td valign="top">以"b"开头，中间有零个或任意多个字符，并以".txt"结尾的文件</td>
</tr>
<tr>
<td valign="top">Data???</td>
<td valign="top">以“Data”开头，其后紧接着3个字符的文件</td>
</tr>
<tr>
<td valign="top">[abc]*</td>
<td valign="top">文件名以"a","b",或"c"开头的文件</td>
</tr>
<tr>
<td valign="top">BACKUP.[0-9][0-9][0-9]</td>
<td valign="top">以"BACKUP."开头，并紧接着3个数字的文件</td>
</tr>
<tr>
<td valign="top">[[:upper:]]*</td>
<td valign="top">以大写字母开头的文件</td>
</tr>
<tr>
<td valign="top">[![:digit:]]*</td>
<td valign="top">不以数字开头的文件</td>
</tr>
<tr>
<td valign="top" width="25%">*[[:lower:]123]</td>
<td valign="top">文件名以小写字母结尾，或以 “1”，“2”，或 “3” 结尾的文件</td>
</tr>
</table>

接受文件名作为参数的任何命令，都可以使用通配符，我们会在第八章更深入的谈到这个知识点。

>
> 字符范围
>
> 如果你用过别的类 Unix 系统的操作环境，或者是读过这方面的书籍，你可能遇到过[A-Z]或
[a-z]形式的字符范围表示法。这些都是传统的 Unix 表示法，并且在早期的 Linux 版本中仍有效。
虽然它们仍然起作用，但是你必须小心地使用它们，因为它们不会产生你期望的输出结果，除非
你合理地配置它们。从现在开始，你应该避免使用它们，并且用字符类来代替它们。
>
> 通配符在 GUI 中也有效
>
> 通配符非常重要，不仅因为它们经常用在命令行中，而且一些图形文件管理器也支持它们。
>
> * 在 Nautilus (GNOME 文件管理器）中，可以通过 Edit/Select 模式菜单项来选择文件。
输入一个用通配符表示的文件选择模式后，那么当前所浏览的目录中，所匹配的文件名就会高亮显示。
>
> * 在 Dolphin 和 Konqueror（KDE 文件管理器）中，可以在地址栏中直接输入通配符。例如，
如果你想查看目录 /usr/bin 中，所有以小写字母 'u' 开头的文件，
在地址栏中敲入 '/usr/bin/u*'，则 文件管理器会显示匹配的结果。
>
> 最初源于命令行界面中的想法，在图形界面中也适用。这就是使 Linux 桌面系统
如此强大的众多原因中的一个

### mkdir - 创建目录

mkdir 命令是用来创建目录的。它这样工作：

    mkdir directory...

__注意表示法:__ 在描述一个命令时（如上所示），当有三个圆点跟在一个命令的参数后面，
这意味着那个参数可以重复，就像这样：

    mkdir dir1

会创建一个名为"dir1"的目录，而

    mkdir dir1 dir2 dir3

会创建三个目录，名为 dir1, dir2, dir3。

### cp - 复制文件和目录

cp 命令，复制文件或者目录。它有两种使用方法：

    cp item1 item2

复制单个文件或目录"item1"到文件或目录"item2"，和：

    cp item... directory

复制多个项目（文件或目录）到一个目录下。

### 有用的选项和实例

这里列举了 cp 命令一些有用的选项（短选项和等效的长选项）：

<table class="multi">
<caption class="cap">表5-4: cp 选项</caption>
<tr>
<th class="title">选项</th>
<th class="title">意义</th>
</tr>
<tr>
<td valign="top" width="25%">-a, --archive</td>
<td valign="top">复制文件和目录，以及它们的属性，包括所有权和权限。
通常，复本具有用户所操作文件的默认属性。</td>
</tr>
<tr>
<td valign="top">-i, --interactive</td>
<td valign="top">在重写已存在文件之前，提示用户确认。如果这个选项不指定，
cp 命令会默认重写文件。</td>
</tr>
<tr>
<td valign="top">-r, --recursive</td>
<td valign="top">递归地复制目录及目录中的内容。当复制目录时，
需要这个选项（或者-a 选项）。</td>
</tr>
<tr>
<td valign="top">-u, --update </td>
<td valign="top">当把文件从一个目录复制到另一个目录时，仅复制
目标目录中不存在的文件，或者是文件内容新于目标目录中已经存在的文件。</td>
</tr>
<tr>
<td valign="top">-v, --verbose</td>
<td valign="top">显示翔实的命令操作信息</td>
</tr>
</table>

<table class="multi">
<caption class="cap">表5-5: cp 实例</caption>
<tr>
<th class="title">命令</th>
<th class="title">运行结果</th>
</tr>
<tr>
<td valign="top" width="25%">cp file1 file2</td>
<td valign="top">复制文件 file1 内容到文件 file2。如果 file2 已经存在，
file2 的内容会被 file1 的内容重写。如果 file2 不存在，则会创建 file2。</td>
</tr>
<tr>
<td valign="top">cp -i file1 file2 </td>
<td valign="top">这条命令和上面的命令一样，除了如果文件 file2 存在的话，在文件 file2 被重写之前，
会提示用户确认信息。</td>
</tr>
<tr>
<td valign="top">cp file1 file2 dir1 </td>
<td valign="top">复制文件 file1 和文件 file2 到目录 dir1。目录 dir1 必须存在。
</td>
</tr>
<tr>
<td valign="top">cp dir1/* dir2 </td>
<td valign="top">使用一个通配符，在目录 dir1 中的所有文件都被复制到目录 dir2 中。
dir2 必须已经存在。</td>
</tr>
<tr>
<td valign="top">cp -r dir1 dir2 </td>
<td valign="top">复制目录 dir1 中的内容到目录 dir2。如果目录 dir2 不存在，
创建目录 dir2，操作完成后，目录 dir2 中的内容和 dir1 中的一样。
如果目录 dir2 存在，则目录 dir1 (和目录中的内容)将会被复制到 dir2 中。</td>
</tr>
</table>

### mv - 移动和重命名文件

mv 命令可以执行文件移动和文件命名任务，这依赖于你怎样使用它。任何一种
情况下，完成操作之后，原来的文件名不再存在。mv 使用方法与 cp 很相像：

    mv item1 item2

把文件或目录 “item1” 移动或重命名为 “item2”, 或者：

    mv item... directory

把一个或多个条目从一个目录移动到另一个目录中。

### 有用的选项和实例

mv 与 cp 共享了很多一样的选项：

<table class="multi">
<caption class="cap">表5-6: mv 选项</caption>
<tr>
<th class="title">选项</th>
<th class="title">意义</th>
</tr>
<tr>
<td valign="top" width="25%">-i --interactive</td>
<td valign="top">在重写一个已经存在的文件之前，提示用户确认信息。
<b>如果不指定这个选项，mv 命令会默认重写文件内容。</b></td>
</tr>
<tr>
<td valign="top">-u --update</td>
<td valign="top">当把文件从一个目录移动另一个目录时，只是移动不存在的文件，
或者文件内容新于目标目录相对应文件的内容。</td>
</tr>
<tr>
<td valign="top">-v --verbose</td>
<td valign="top">当操作 mv 命令时，显示翔实的操作信息。</td>
</tr>
</table>

<table class="multi">
<caption class="cap">表5-7: mv 实例</caption>
<tr>
<td class="title">mv file1 file2</td>
<td class="title">移动 file1 到 file2。<b>如果 file2 存在，它的内容会被 file1 的内容重写。
</b>如果 file2 不存在，则创建 file2。<b> 每种情况下，file1 不再存在。</b></td>
</tr>
<tr>
<td valign="top" width="25%">mv -i file1 file2</td>
<td valign="top">除了如果 file2 存在的话，在 file2 被重写之前，用户会得到
提示信息外，这个和上面的选项一样。</td>
</tr>
<tr>
<td valign="top">mv file1 file2 dir1</td>
<td valign="top">移动 file1 和 file2 到目录 dir1 中。dir1 必须已经存在。</td>
</tr>
<tr>
<td valign="top">mv dir1 dir2</td>
<td valign="top">如果目录 dir2 不存在，创建目录 dir2，并且移动目录 dir1 的内容到
目录 dir2 中，同时删除目录 dir1。如果目录 dir2 存在，移动目录 dir1（及它的内容）到目录 dir2。</td>
</tr>
</table>

### rm - 删除文件和目录

rm 命令用来移除（删除）文件和目录：

    rm item...

"item"代表一个或多个文件或目录。

### 有用的选项和实例

下表是一些普遍使用的 rm 选项：

<table class="multi">
<caption class="cap">表5-8: rm 选项</caption>
<tr>
<th class="title">选项</th>
<th class="title">意义</th>
</tr>
<tr>
<td valign="top" width="25%">-i, --interactive </td>
<td
valign="top">在删除已存在的文件前，提示用户确认信息。
<b>如果不指定这个选项，rm 会默默地删除文件</b>
</td>
</tr>
<tr>
<td valign="top">-r, --recursive</td>
<td valign="top">递归地删除文件，这意味着，如果要删除一个目录，而此目录
又包含子目录，那么子目录也会被删除。要删除一个目录，必须指定这个选项。</td>
</tr>
<tr>
<td valign="top">-f, --force</td>
<td valign="top">忽视不存在的文件，不显示提示信息。这选项颠覆了“--interactive”选项。</td>
</tr>
<tr>
<td valign="top">-v, --verbose</td>
<td valign="top">在执行 rm 命令时，显示翔实的操作信息。</td>
</tr>
</table>

<table class="multi">
<caption class="cap">表5-9: rm 实例</caption>
<tr>
<th class="title">命令</th>
<th class="title">运行结果</th>
</tr>
<tr>
<td valign="top" width="25%">rm file1</td>
<td valign="top">默默地删除文件</td>
</tr>
<tr>
<td valign="top">rm -i file1</td>
<td valign="top">除了在删除文件之前，提示用户确认信息之外，和上面的命令作用一样。</td>
</tr>
<tr>
<td valign="top">rm -r file1 dir1</td>
<td valign="top">删除文件 file1, 目录 dir1，及 dir1 中的内容。</td>
</tr>
<tr>
<td valign="top">rm -rf file1 dir1</td>
<td valign="top">同上，除了如果文件 file1，或目录 dir1 不存在的话，rm 仍会继续执行。</td>
</tr>
</table>

>
> 小心 rm!
>
> 类 Unix 的操作系统，比如说 Linux，没有复原命令。一旦你用 rm 删除了一些东西，
它就消失了。Linux 假定你很聪明，你知道你在做什么。
>
> 尤其要小心通配符。思考一下这个经典的例子。假如说，你只想删除一个目录中的 HTML
文件。输入：
>
>  _rm *.html_
>
> 这是正确的，如果你不小心在 “*” 和 “.html” 之间多输入了一个空格，就像这样：
>
>  _rm * .html_
>
> 这个 rm 命令会删除目录中的所有文件，还会抱怨没有文件叫做 “.html”。
>
> _小贴士。_ 无论什么时候，rm 命令用到通配符（除了仔细检查输入的内容外！），
用 ls 命令来测试通配符。这会让你看到要删除的文件列表。然后按下上箭头按键，重新调用
刚刚执行的命令，用 rm 替换 ls。

### ln — 创建链接

ln 命令即可创建硬链接，也可以创建符号链接。可以用其中一种方法来使用它：

    ln file link

创建硬链接，和：

    ln -s item link

创建符号链接，"item" 可以是一个文件或是一个目录。

### 硬链接

硬链接和符号链接比起来，硬链接是最初 Unix 创建链接的方式，而符号链接更加现代。
在默认情况下，每个文件有一个硬链接，这个硬链接给文件起名字。当我们创建一个
硬链接以后，就为文件创建了一个额外的目录条目。硬链接有两个重要局限性：

1. 一个硬链接不能关联它所在文件系统之外的文件。这是说一个链接不能关联
与链接本身不在同一个磁盘分区上的文件。

2. 一个硬链接不能关联一个目录。

一个硬链接和文件本身没有什么区别。不像符号链接，当你列出一个包含硬链接的目录
内容时，你会看到没有特殊的链接指示说明。当一个硬链接被删除时，这个链接
被删除，但是文件本身的内容仍然存在（这是说，它所占的磁盘空间不会被重新分配），
直到所有关联这个文件的链接都删除掉。知道硬链接很重要，因为你可能有时
会遇到它们，但现在实际中更喜欢使用符号链接，下一步我们会讨论符号链接。

### 符号链接

创建符号链接是为了克服硬链接的局限性。符号链接生效，是通过创建一个
特殊类型的文件，这个文件包含一个关联文件或目录的文本指针。在这一方面，
它们和 Windows 的快捷方式差不多，当然，符号链接早于 Windows 的快捷方式
很多年;-)

一个符号链接指向一个文件，而且这个符号链接本身与其它的符号链接几乎没有区别。
例如，如果你往一个符号链接里面写入东西，那么相关联的文件也被写入。然而，
当你删除一个符号链接时，只有这个链接被删除，而不是文件自身。如果先于符号链接
删除文件，这个链接仍然存在，但是不指向任何东西。在这种情况下，这个链接被称为
坏链接。在许多实现中，ls 命令会以不同的颜色展示坏链接，比如说红色，来显示它们
的存在。

关于链接的概念，看起来很迷惑，但不要胆怯。我们将要试着练习
这些命令，希望，它变得清晰起来。

### 创建游戏场（实战演习）

下面我们将要做些真正的文件操作，让我们先建立一个安全地带，
来玩一下文件操作命令。首先，我们需要一个工作目录。在我们的
家目录下创建一个叫做“playground”的目录。

### 创建目录

mkdir 命令被用来创建目录。首先确定我们在我们的家目录下，来创建 playground 目录，
然后创建这个新目录：

    [me@linuxbox ~]$ cd
    [me@linuxbox ~]$ mkdir playground

为了让我们的游戏场更加有趣，在 playground 目录下创建一对目录
，分别叫做 “dir1” 和 “dir2”。更改我们的当前工作目录到 playground，然后
执行 mkdir 命令：

    [me@linuxbox ~]$ cd playground
    [me@linuxbox playground]$ mkdir dir1 dir2

注意到 mkdir 命令可以接受多个参数，它允许我们用一个命令来创建这两个目录。

###　复制文件

下一步，让我们得到一些数据到我们的游戏场中。通过复制一个文件来实现目的。
使用 cp 命令，我们从 /etc 目录复制 passwd 文件到当前工作目录下：

    [me@linuxbox playground]$ cp /etc/passwd .

注意：我们怎样使用当前工作目录的快捷方式，命令末尾的单个圆点。如果我们执行 ls 命令，
可以看到我们的文件：

    [me@linuxbox playground]$ ls -l
    total 12
    drwxrwxr-x 2  me  me   4096 2008-01-10 16:40 dir1
    drwxrwxr-x 2  me  me   4096 2008-01-10 16:40 dir2
    -rw-r--r-- 1  me  me   1650 2008-01-10 16:07 passwd

现在，仅仅是为了高兴，重复操作复制命令，使用"-v"选项（唠叨），看一个它的作用：

    [me@linuxbox playground]$ cp -v /etc/passwd .
    `/etc/passwd' -> `./passwd'

cp 命令再一次执行了复制操作，但是这次显示了一条简洁的信息，指明它
进行了什么操作。注意，cp 没有警告，就重写了第一次复制的文件。这是一个案例，
cp 假定你知道你的所作所为。为了得到警示信息，在命令中包含"-i"选项：

    [me@linuxbox playground]$ cp -i /etc/passwd .
    cp: overwrite `./passwd'?

响应命令提示信息，输入"y"，文件就会被重写，其它的字符（例如，"n"）会导致 cp 命令不理会文件。

### 移动和重命名文件

现在，"passwd" 这个名字，看起来不怎么有趣，这是个游戏场，所以我们给它改个名字：

    [me@linuxbox playground]$ mv passwd fun

让我们来传送 fun 文件，通过移动重命名的文件到各个子目录，
然后再把它移回到当前目录：

    [me@linuxbox playground]$ mv fun dir1

首先，把 fun 文件移动目录 dir1 中，然后：

    [me@linuxbox playground]$ mv dir1/fun dir2

再把 fun 文件从 dir1 移到目录 dir2, 然后：

    [me@linuxbox playground]$ mv dir2/fun .

最后，再把 fun 文件带回到当前工作目录。下一步，来看看移动目录的效果。
首先，我们先移动我们的数据文件到 dir1 目录：

    [me@linuxbox playground]$ mv fun dir1

然后移动 dir1到 dir2目录，用 ls 来确认执行结果:

    [me@linuxbox playground]$ mv dir1 dir2
    [me@linuxbox playground]$ ls -l dir2
    total 4
    drwxrwxr-x 2 me me 4096 2008-01-11 06:06 dir1
    [me@linuxbox playground]$ ls -l dir2/dir1
    total 4
    -rw-r--r-- 1 me me 1650 2008-01-10 16:33 fun

注意：因为目录 dir2 已经存在，mv 命令移动 dir1 到 dir2 目录。如果 dir2 不存在，
mv 会重新命名 dir1 为 dir2。最后，把所有的东西放回原处。

    [me@linuxbox playground]$ mv dir2/dir1 .
    [me@linuxbox playground]$ mv dir1/fun .

### 创建硬链接

现在，我们试着创建链接。首先是硬链接。我们创建一些关联我们
数据文件的链接：

    [me@linuxbox playground]$ ln fun fun-hard
    [me@linuxbox playground]$ ln fun dir1/fun-hard
    [me@linuxbox playground]$ ln fun dir2/fun-hard

所以现在，我们有四个文件"fun"的实例。看一下目录 playground 中的内容：

    [me@linuxbox playground]$ ls -l
    total 16
    drwxrwxr-x 2 me  me 4096 2008-01-14 16:17 dir1
    drwxrwxr-x 2 me  me 4096 2008-01-14 16:17 dir2
    -rw-r--r-- 4 me  me 1650 2008-01-10 16:33 fun
    -rw-r--r-- 4 me  me 1650 2008-01-10 16:33 fun-hard

注意到一件事，列表中，文件 fun 和 fun-hard 的第二个字段是"4"，这个数字
是文件"fun"的硬链接数目。你要记得一个文件至少有一个硬链接，因为文件
名就是由链接创建的。所以，我们怎样知道实际上 fun 和 fun-hard 是一样的文件呢？
在这个例子里，ls 不是很有用。虽然我们能够看到 fun 和 fun-hard 文件大小一样
（第五字段），但我们的列表没有提供可靠的信息来确定（这两个文件一样）。
为了解决这个问题，我们更深入的研究一下。

当考虑到硬链接的时候，我们可以假设文件由两部分组成：包含文件内容的数据部分和持有文件名的名字部分
，这将有助于我们理解这个概念。当我们创建文件硬链接的时候，实际上是为文件创建了额外的名字部分，
并且这些名字都关系到相同的数据部分。这时系统会分配一连串的磁盘给所谓的索引节点，然后索引节点与文
件名字部分相关联。因此每一个硬链接都关系到一个具体的包含文件内容的索引节点。

ls 命令有一种方法，来展示（文件索引节点）的信息。在命令中加上"-i"选项：

    [me@linuxbox playground]$ ls -li
    total 16
    12353539 drwxrwxr-x 2 me  me 4096  2008-01-14  16:17  dir1
    12353540 drwxrwxr-x 2 me  me 4096  2008-01-14  16:17  dir2
    12353538 -rw-r--r-- 4 me  me 1650  2008-01-10  16:33  fun
    12353538 -rw-r--r-- 4 me  me 1650  2008-01-10  16:33  fun-hard

在这个版本的列表中，第一字段表示文件索引节点号，正如我们所见到的，
fun 和 fun-hard 共享一样的索引节点号，这就证实这两个文件是一样的文件。

### 创建符号链接

建立符号链接的目的是为了克服硬链接的两个缺点：硬链接不能跨越物理设备，
硬链接不能关联目录，只能是文件。符号链接是文件的特殊类型，它包含一个指向
目标文件或目录的文本指针。

符号链接的建立过程相似于创建硬链接：

    [me@linuxbox playground]$ ln -s fun fun-sym
    [me@linuxbox playground]$ ln -s ../fun dir1/fun-sym
    [me@linuxbox playground]$ ln -s ../fun dir2/fun-sym

第一个实例相当直接，在 ln 命令中，简单地加上"-s"选项就可以创建一个符号链接，
而不是一个硬链接。下面两个例子又是怎样呢？ 记住，当我们创建一个符号链接
的时候，会建立一个目标文件在哪里和符号链接有关联的文本描述。如果我们看看
ls 命令的输出结果，比较容易理解。

    [me@linuxbox playground]$ ls -l dir1
    total 4
    -rw-r--r-- 4 me  me 1650 2008-01-10 16:33 fun-hard
    lrwxrwxrwx 1 me  me    6 2008-01-15 15:17 fun-sym -> ../fun

目录 dir1 中，fun-sym 的列表说明了它是一个符号链接，通过在第一字段中的首字符"l"
可知，并且它还指向"../fun"，也是正确的。相对于 fun-sym 的存储位置，fun 在它的
上一个目录。同时注意，符号链接文件的长度是6，这是字符串"../fun"所包含的字符数，
而不是符号链接所指向的文件长度。

当建立符号链接时，你即可以使用绝对路径名：

    ln -s /home/me/playground/fun dir1/fun-sym

也可用相对路径名，正如前面例题所展示的。使用相对路径名更令人满意，
因为它允许一个包含符号链接的目录重命名或移动，而不会破坏链接。

除了普通文件，符号链接也能关联目录：

    [me@linuxbox playground]$ ln -s dir1 dir1-sym
    [me@linuxbox playground]$ ls -l
    total 16
    ...省略

### 移动文件和目录

正如我们之前讨论的，rm 命令被用来删除文件和目录。我们将要使用它
来清理一下我们的游戏场。首先，删除一个硬链接：

    [me@linuxbox playground]$ rm fun-hard
    [me@linuxbox playground]$ ls -l
    total 12
    ...省略

结果不出所料。文件 fun-hard 消失了，文件 fun 的链接数从4减到3，正如
目录列表第二字段所示。下一步，我们会删除文件 fun，仅为了娱乐，我们会包含"-i"
选项，看一个它的作用：

    [me@linuxbox playground]$ rm -i fun
    rm: remove regular file `fun'?

在提示符下输入"y"，删除文件。让我们看一下 ls 的输出结果。注意，fun-sym 发生了
什么事? 因为它是一个符号链接，指向已经不存在的文件，链接已经坏了：

    [me@linuxbox playground]$ ls -l
    total 8
    drwxrwxr-x 2 me  me     4096 2008-01-15 15:17 dir1
    lrwxrwxrwx 1 me  me        4 2008-01-16 14:45 dir1-sym -> dir1
    drwxrwxr-x 2 me  me     4096 2008-01-15 15:17 dir2
    lrwxrwxrwx 1 me  me        3 2008-01-15 15:15 fun-sym -> fun

大多数 Linux 的发行版本配置 ls 显示损坏的链接。在 Fedora 系统中，坏的链接以闪烁的
红色文本显示！损坏链接的出现，并不危险，但是相当混乱。如果我们试着使用
损坏的链接，会看到以下情况：

    [me@linuxbox playground]$ less fun-sym
    fun-sym: No such file or directory

稍微清理一下现场。删除符号链接：

    [me@linuxbox playground]$ rm fun-sym dir1-sym
    [me@linuxbox playground]$ ls -l
    total 8
    drwxrwxr-x 2 me  me    4096 2008-01-15 15:17 dir1
    drwxrwxr-x 2 me  me    4096 2008-01-15 15:17 dir2

对于符号链接，有一点值得记住，执行的大多数文件操作是针对链接的对象，而不是链接本身。
而 rm 命令是个特例。当你删除链接的时候，删除链接本身，而不是链接的对象。

最后，我们将删除我们的游戏场。为了完成这个工作，我们将返回到
我们的家目录，然后用 rm 命令加上选项(-r)，来删除目录 playground，
和目录下的所有内容，包括子目录：

    [me@linuxbox playground]$ cd
    [me@linuxbox ~]$ rm -r playground

>
> 用 GUI 来创建符号链接
>
> 文件管理器 GNOME 和 KDE 都提供了一个简单而且自动化的方法来创建符号链接。
在 GNOME 里面，当拖动文件时，同时按下 Ctrl+Shift 按键会创建一个链接，而不是
复制（或移动）文件。在 KDE 中，无论什么时候放下一个文件，会弹出一个小菜单，
这个菜单会提供复制，移动，或创建链接文件选项。

### 总结

在这一章中，我们已经研究了许多基础知识。我们得花费一些时间来全面的理解。
反复练习 playground 例题，直到你觉得它有意义。能够良好的理解基本文件操作
命令和通配符，非常重要。空闲时，通过添加文件和目录来拓展 playground 练习，
使用通配符来为各种各样的操作命令指定文件。关于链接的概念，在刚开始接触
时会觉得有点迷惑，花些时间来学习它们是怎样工作的。它们能成为真正的救星。


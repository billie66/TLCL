---
layout: book-zh
title: 查找文件
---

因为我们已经浏览了 Linux 系统，所以一件事已经变得非常清楚：一个典型的 Linux 系统包含很多文件！
这就引发了一个问题，“我们怎样查找东西？”。虽然我们已经知道 Linux 文件系统良好的组织结构，是源自
类 Unix 的操作系统代代传承的习俗。但是仅文件数量就会引起可怕的问题。在这一章中，我们将察看
两个用来在系统中查找文件的工具。这些工具是：

* locate – 通过名字来查找文件

* find – 在目录层次结构中搜索文件

我们也将看一个经常与文件搜索命令一起使用的命令，它用来处理搜索到的文件列表：

* xargs – 从标准输入生成和执行命令行

另外，我们将介绍两个命令来协助我们探索：

* touch – 更改文件时间

* stat – 显示文件或文件系统状态

### locate - 查找文件的简单方法

这个 locate 程序快速搜索路径名数据库，并且输出每个与给定字符串相匹配的文件名。比如说，
例如，我们想要找到所有名字以“zip”开头的程序。因为我们正在查找程序，可以假定包含
匹配程序的目录以"bin/"结尾。因此，我们试着以这种方式使用 locate 命令，来找到我们的文件：

    [me@linuxbox ~]$ locate bin/zip

locate 命令将会搜索它的路径名数据库，输出任一个包含字符串“bin/zip”的路径名：

    /usr/bin/zip
    /usr/bin/zipcloak
    /usr/bin/zipgrep
    /usr/bin/zipinfo
    /usr/bin/zipnote
    /usr/bin/zipsplit

如果搜索要求没有这么简单，locate 可以结合其它工具，比如说 grep 命令，来设计更加
有趣的搜索：

    [me@linuxbox ~]$ locate zip | grep bin
    /bin/bunzip2
    /bin/bzip2
    /bin/bzip2recover
    /bin/gunzip
    /bin/gzip
    /usr/bin/funzip
    /usr/bin/gpg-zip
    /usr/bin/preunzip
    /usr/bin/prezip
    /usr/bin/prezip-bin
    /usr/bin/unzip
    /usr/bin/unzipsfx
    /usr/bin/zip
    /usr/bin/zipcloak
    /usr/bin/zipgrep
    /usr/bin/zipinfo
    /usr/bin/zipnote
    /usr/bin/zipsplit

这个 locate 程序已经存在了很多年了，它有几个不同的变体被普遍使用着。在现在 Linux
发行版中发现的两个最常见的变体是 slocate 和 mlocate，但是通常它们被名为 locate 的
符号链接访问。不同版本的 locate 命令拥有重复的选项集合。一些版本包括正则表达式
匹配（我们会在下一章中讨论）和通配符支持。查看 locate 命令的手册，从而确定安装了
哪个版本的 locate 程序。

>
> locate 数据库来自何方？
>
> 你可能注意到了，在一些发行版中，仅仅在系统安装之后，locate 不能工作，
但是如果你第二天再试一下，它就工作正常了。怎么回事呢？locate 数据库由另一个叫做 updatedb
的程序创建。通常，这个程序作为一个 cron 工作例程周期性运转；也就是说，一个任务
在特定的时间间隔内被 cron 守护进程执行。大多数装有 locate 的系统会每隔一天运行一回
updatedb 程序。因为数据库不能被持续地更新，所以当使用 locate 时，你会发现
目前最新的文件不会出现。为了克服这个问题，可以手动运行 updatedb 程序，
更改为超级用户身份，在提示符下运行 updatedb 命令。

### find - 查找文件的复杂方式

locate 程序只能依据文件名来查找文件，而 find 程序能基于各种各样的属性，
搜索一个给定目录（以及它的子目录），来查找文件。我们将要花费大量的时间学习 find 命令，因为
它有许多有趣的特性，当我们开始在随后的章节里面讨论编程概念的时候，我们将会重复看到这些特性。

find 命令的最简单使用是，搜索一个或多个目录。例如，输出我们的家目录列表。

    [me@linuxbox ~]$ find ~

对于最活跃的用户帐号，这将产生一张很大的列表。因为这张列表被发送到标准输出，
我们可以把这个列表管道到其它的程序中。让我们使用 wc 程序来计算出文件的数量：

    [me@linuxbox ~]$ find ~ | wc -l
    47068

哇，我们一直很忙！find 命令的魅力所在就是它能够被用来识别符合特定标准的文件。它通过
（有点奇怪）应用选项，测试条件，和操作来完成搜索。我们先看一下测试条件。

#### Tests

比如说我们想要目录列表。我们可以添加以下测试条件：

    [me@linuxbox ~]$ find ~ -type d | wc -l
    1695

添加测试条件-type d 限制了只搜索目录。相反地，我们使用这个测试条件来限定搜索普通文件：

    [me@linuxbox ~]$ find ~ -type f | wc -l
    38737

这里是 find 命令支持的普通文件类型测试条件：

<table class="multi">
<caption class="cap">表18-1: find 文件类型</caption>
<tr>
<th class="title">文件类型</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top" width="25%">b</td>
<td valign="top">块设备文件 </td>
</tr>
<tr>
<td valign="top">c</td>
<td valign="top">字符设备文件</td>
</tr>
<tr>
<td valign="top">d</td>
<td valign="top">目录</td>
</tr>
<tr>
<td valign="top">f</td>
<td valign="top">普通文件</td>
</tr>
<tr>
<td valign="top">l</td>
<td valign="top">符号链接</td>
</tr>
</table>

我们也可以通过加入一些额外的测试条件，根据文件大小和文件名来搜索：让我们查找所有文件名匹配
通配符模式“*.JPG”和文件大小大于1M 的文件：

    [me@linuxbox ~]$ find ~ -type f -name "*.JPG" -size +1M | wc -l
    840

在这个例子里面，我们加入了 -name 测试条件，后面跟通配符模式。注意，我们把它用双引号引起来，
从而阻止 shell 展开路径名。紧接着，我们加入 -size 测试条件，后跟字符串“+1M”。开头的加号表明
我们正在寻找文件大小大于指定数的文件。若字符串以减号开头，则意味着查找小于指定数的文件。
若没有符号意味着“精确匹配这个数”。结尾字母“M”表明测量单位是兆字节。下面的字符可以
被用来指定测量单位：

<table class="multi">
<caption class="cap">表18-2: find 大小单位</caption>
<tr>
<th class="title">字符</th>
<th class="title">单位</th>
</tr>
<tr>
<td valign="top" width="25%">b</td>
<td valign="top">512 个字节块。如果没有指定单位，则这是默认值。</td>
</tr>
<tr>
<td valign="top">c</td>
<td valign="top">字节</td>
</tr>
<tr>
<td valign="top">w</td>
<td valign="top">两个字节的字</td>
</tr>
<tr>
<td valign="top">k</td>
<td valign="top">千字节(1024个字节单位)</td>
</tr>
<tr>
<td valign="top">M</td>
<td valign="top">兆字节(1048576个字节单位)</td>
</tr>
<tr>
<td valign="top">G</td>
<td valign="top">千兆字节(1073741824个字节单位)</td>
</tr>
</table>

find 命令支持大量不同的测试条件。下表是列出了一些常见的测试条件。请注意，在需要数值参数的
情况下，可以应用以上讨论的“+”和"-"符号表示法：

<table class="multi">
<caption class="cap">表18-3: find 测试条件</caption>
<tr>
<th class="title">测试条件</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top" width="25%">-cmin n </td>
<td valign="top">匹配的文件和目录的内容或属性最后修改时间正好在 n 分钟之前。
指定少于 n 分钟之前，使用 -n，指定多于 n 分钟之前，使用 +n。 </td>
</tr>
<tr>
<td valign="top">-cnewer file </td>
<td valign="top">匹配的文件和目录的内容或属性最后修改时间早于那些文件。 </td>
</tr>
<tr>
<td valign="top">-ctime n </td>
<td valign="top">匹配的文件和目录的内容和属性最后修改时间在 n*24小时之前。</td>
</tr>
<tr>
<td valign="top">-empty </td>
<td valign="top">匹配空文件和目录。</td>
</tr>
<tr>
<td valign="top">-group name </td>
<td valign="top">匹配的文件和目录属于一个组。组可以用组名或组 ID 来表示。</td>
</tr>
<tr>
<td valign="top">-iname pattern </td>
<td valign="top">就像-name 测试条件，但是不区分大小写。</td>
</tr>
<tr>
<td valign="top">-inum n </td>
<td valign="top">匹配的文件的 inode 号是 n。这对于找到某个特殊 inode 的所有硬链接很有帮助。 </td>
</tr>
<tr>
<td valign="top">-mmin n </td>
<td valign="top">匹配的文件或目录的内容被修改于 n 分钟之前。</td>
</tr>
<tr>
<td valign="top">-mtime n </td>
<td valign="top">匹配的文件或目录的内容被修改于 n*24小时之前。 </td>
</tr>
<tr>
<td valign="top">-name pattern </td>
<td valign="top">用指定的通配符模式匹配的文件和目录。</td>
</tr>
<tr>
<td valign="top">-newer file </td>
<td
valign="top">匹配的文件和目录的内容早于指定的文件。当编写 shell 脚本，做文件备份时，非常有帮助。
每次你制作一个备份，更新文件（比如说日志），然后使用 find 命令来决定自从上次更新，哪一个文件已经更改了。 </td>
</tr>
<tr>
<td valign="top">-nouser </td>
<td valign="top">匹配的文件和目录不属于一个有效用户。这可以用来查找
属于删除帐户的文件或监测攻击行为。 </td>
</tr>
<tr>
<td valign="top">-nogroup </td>
<td valign="top">匹配的文件和目录不属于一个有效的组。 </td>
</tr>
<tr>
<td valign="top">-perm mode </td>
<td valign="top">匹配的文件和目录的权限已经设置为指定的 mode。mode 可以用
八进制或符号表示法。</td>
</tr>
<tr>
<td valign="top">-samefile name </td>
<td valign="top">相似于-inum 测试条件。匹配和文件 name 享有同样 inode 号的文件。 </td>
</tr>
<tr>
<td valign="top">-size n </td>
<td valign="top">匹配的文件大小为 n。</td>
</tr>
<tr>
<td valign="top">-type c </td>
<td valign="top">匹配的文件类型是 c。</td>
</tr>
<tr>
<td valign="top">-user name </td>
<td
valign="top">匹配的文件或目录属于某个用户。这个用户可以通过用户名或用户 ID 来表示。 </td>
</tr>
</table>

这不是一个完整的列表。find 命令手册有更详细的说明。

#### 操作符

即使拥有了 find 命令提供的所有测试条件，我们还需要一个更好的方式来描述测试条件之间的逻辑关系。例如，
如果我们需要确定是否一个目录中的所有的文件和子目录拥有安全权限，怎么办呢？
我们可以查找权限不是0600的文件和权限不是0700的目录。幸运地是，find 命令提供了
一种方法来结合测试条件，通过使用逻辑操作符来创建更复杂的逻辑关系。
为了表达上述的测试条件，我们可以这样做：

    [me@linuxbox ~]$ find ~ \( -type f -not -perm 0600 \) -or \( -type d -not -perm 0700 \)

呀！这的确看起来很奇怪。这些是什么东西？实际上，这些操作符没有那么复杂，一旦你知道了它们的原理。
这里是操作符列表：

<table class="multi">
<caption class="cap">表18-4: find 命令的逻辑操作符</caption>
<tr>
<th class="title">操作符</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top" width="25%">-and</td>
<td valign="top">如果操作符两边的测试条件都是真，则匹配。可以简写为 -a。
注意若没有使用操作符，则默认使用 -and。</td>
</tr>
<tr>
<td valign="top">-or</td>
<td valign="top">若操作符两边的任一个测试条件为真，则匹配。可以简写为 -o。</td>
</tr>
<tr>
<td valign="top">-not</td>
<td valign="top">若操作符后面的测试条件是真，则匹配。可以简写为一个感叹号（!）。</td>
</tr>
<tr>
<td valign="top">()</td>
<td valign="top"> 把测试条件和操作符组合起来形成更大的表达式。这用来控制逻辑计算的优先级。
默认情况下，find 命令按照从左到右的顺序计算。经常有必要重写默认的求值顺序，以得到期望的结果。
即使没有必要，有时候包括组合起来的字符，对提高命令的可读性是很有帮助的。注意
因为圆括号字符对于 shell 来说有特殊含义，所以在命令行中使用它们的时候，它们必须
用引号引起来，才能作为实参传递给 find 命令。通常反斜杠字符被用来转义圆括号字符。</td>
</tr>
</table>

通过这张操作符列表，我们重建 find 命令。从最外层看，我们看到测试条件被分为两组，由一个
-or 操作符分开：

    ( expression 1 ) -or ( expression 2 )

这看起来合理，因为我们正在搜索具有不同权限集合的文件和目录。如果我们文件和目录两者都查找，
那为什么要用 -or 来代替 -and 呢？因为 find 命令扫描文件和目录时，会计算每一个对象，看看它是否
匹配指定的测试条件。我们想要知道它是具有错误权限的文件还是有错误权限的目录。它不可能同时符合这
两个条件。所以如果展开组合起来的表达式，我们能这样解释它：

    ( file with bad perms ) -or ( directory with bad perms )

下一个挑战是怎样来检查“错误权限”，这个怎样做呢？我们不从这个角度做。我们将测试
“不是正确权限”，因为我们知道什么是“正确权限”。对于文件，我们定义正确权限为0600，
目录则为0711。测试具有“不正确”权限的文件表达式为：

    -type f -and -not -perms 0600

对于目录，表达式为：

    -type d -and -not -perms 0700

正如上述操作符列表中提到的，这个-and 操作符能够被安全地删除，因为它是默认使用的操作符。
所以如果我们把这两个表达式连起来，就得到最终的命令：

    find ~ ( -type f -not -perms 0600 ) -or ( -type d -not -perms 0700 )

然而，因为圆括号对于 shell 有特殊含义，我们必须转义它们，来阻止 shell 解释它们。在圆括号字符
之前加上一个反斜杠字符来转义它们。

逻辑操作符的另一个特性要重点理解。比方说我们有两个由逻辑操作符分开的表达式：

    expr1 -operator expr2

在所有情况下，总会执行表达式 expr1；然而由操作符来决定是否执行表达式 expr2。这里
列出了它是怎样工作的：

<table class="multi">
<caption class="cap">表18-5: find AND/OR 逻辑</caption>
<tr>
<th class="title" width="%30">expr1 的结果</th>
<th class="title" width="%30">操作符</th>
<th class="title">expr2 is...</th>
</tr>
<tr>
<td valign="top">真</td>
<td valign="top">-and</td>
<td valign="top">总要执行</td>
</tr>
<tr>
<td valign="top">假</td>
<td valign="top">-and</td>
<td valign="top">从不执行</td>
</tr>
<tr>
<td valign="top">真</td>
<td valign="top">-or</td>
<td valign="top">从不执行</td>
</tr>
<tr>
<td valign="top">假</td>
<td valign="top">-or</td>
<td valign="top">总要执行</td>
</tr>
</table>

为什么这会发生呢？这样做是为了提高性能。以 -and 为例，我们知道表达式 expr1 -and expr2
不能为真，如果表达式 expr1的结果为假，所以没有必要执行 expr2。同样地，如果我们有表达式
expr1 -or expr2，并且表达式 expr1的结果为真，那么就没有必要执行 expr2，因为我们已经知道
表达式 expr1 -or expr2 为真。好，这样会执行快一些。为什么这个很重要？
它很重要是因为我们能依靠这种行为来控制怎样来执行操作。我们会很快看到...

### 预定义的操作

让我们做一些工作吧！从 find 命令得到的结果列表很有用处，但是我们真正想要做的事情是操作列表
中的某些条目。幸运地是，find 命令允许基于搜索结果来执行操作。有许多预定义的操作和几种方式来
应用用户定义的操作。首先，让我们看一下几个预定义的操作：

<table class="multi">
<caption class="cap">表18-6: 几个预定义的 find 命令操作</caption>
<tr>
<th class="title">操作</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top" width="25%">-delete</td>
<td valign="top">删除当前匹配的文件。</td>
</tr>
<tr>
<td valign="top">-ls</td>
<td valign="top">对匹配的文件执行等同的 ls -dils 命令。并将结果发送到标准输出。
</td>
</tr>
<tr>
<td valign="top">-print</td>
<td valign="top">把匹配文件的全路径名输送到标准输出。如果没有指定其它操作，这是
默认操作。</td>
</tr>
<tr>
<td valign="top">-quit</td>
<td valign="top">一旦找到一个匹配，退出。</td>
</tr>
</table>

和测试条件一样，还有更多的操作。查看 find 命令手册得到更多细节。在第一个例子里，
我们这样做：

    find ~

这个命令输出了我们家目录中包含的每个文件和子目录。它会输出一个列表，因为会默认使用-print 操作
，如果没有指定其它操作的话。因此我们的命令也可以这样表述：

    find ~ -print

我们可以使用 find 命令来删除符合一定条件的文件。例如，来删除扩展名为“.BAK”（这通常用来指定备份文件）
的文件，我们可以使用这个命令：

    find ~ -type f -name '*.BAK' -delete

在这个例子里面，用户家目录（和它的子目录）下搜索每个以.BAK 结尾的文件名。当找到后，就删除它们。

---

警告：当使用 -delete 操作时，不用说，你应该格外小心。首先测试一下命令，
用 -print 操作代替 -delete，来确认搜索结果。

---

在我们继续之前，让我们看一下逻辑运算符是怎样影响操作的。考虑以下命令：

    find ~ -type f -name '*.BAK' -print

正如我们所见到的，这个命令会查找每个文件名以.BAK (-name '*.BAK') 结尾的普通文件 (-type f)，
并把每个匹配文件的相对路径名输出到标准输出 (-print)。然而，此命令按这个方式执行的原因，是
由每个测试和操作之间的逻辑关系决定的。记住，在每个测试和操作之间会默认应用 -and 逻辑运算符。
我们也可以这样表达这个命令，使逻辑关系更容易看出：

    find ~ -type f -and -name '*.BAK' -and -print

当命令被充分表达之后，让我们看看逻辑运算符是如何影响其执行的：

<table class="multi">
<tr>
<th class="title">测试／行为 </th>
<th class="title">只有...的时候，才被执行</th>
</tr>
<tr>
<td valign="top" width="25%">-print</td>
<td valign="top">只有 -type f and -name '*.BAK'为真的时候</td>
</tr>
<tr>
<td valign="top">-name ‘*.BAK’ </td>
<td valign="top">只有 -type f 为真的时候</td>
</tr>
<tr>
<td valign="top">-type f </td>
<td valign="top">总是被执行，因为它是与 -and 关系中的第一个测试／行为。</td>
</tr>
</table>

因为测试和行为之间的逻辑关系决定了哪一个会被执行，我们知道测试和行为的顺序很重要。例如，
如果我们重新安排测试和行为之间的顺序，让 -print 行为是第一个，那么这个命令执行起来会截然不同：

    find ~ -print -and -type f -and -name '*.BAK'

这个版本的命令会打印出每个文件（-print 行为总是为真），然后测试文件类型和指定的文件扩展名。

### 用户定义的行为

除了预定义的行为之外，我们也可以唤醒随意的命令。传统方式是通过 -exec 行为。这个
行为像这样工作：

    -exec command {} ;

这里的 command 就是指一个命令的名字，{}是当前路径名的符号表示，分号是要求的界定符
表明命令结束。这里是一个使用 -exec 行为的例子，其作用如之前讨论的 -delete 行为：

    -exec rm '{}' ';'

重述一遍，因为花括号和分号对于 shell 有特殊含义，所以它们必须被引起来或被转义。

也有可能交互式地执行一个用户定义的行为。通过使用 -ok 行为来代替 -exec，在执行每个指定的命令之前，
会提示用户：

    find ~ -type f -name 'foo*' -ok ls -l '{}' ';'
    < ls ... /home/me/bin/foo > ? y
    -rwxr-xr-x 1 me    me 224 2007-10-29 18:44 /home/me/bin/foo
    < ls ... /home/me/foo.txt > ? y
    -rw-r--r-- 1 me    me 0 2008-09-19 12:53 /home/me/foo.txt

在这个例子里面，我们搜索以字符串“foo”开头的文件名，并且对每个匹配的文件执行 ls -l 命令。
使用 -ok 行为，会在 ls 命令执行之前提示用户。

### 提高效率

当 -exec 行为被使用的时候，若每次找到一个匹配的文件，它会启动一个新的指定命令的实例。
我们可能更愿意把所有的搜索结果结合起来，再运行一个命令的实例。例如，而不是像这样执行命令：

    ls -l file1
    ls -l file2

我们更喜欢这样执行命令：

    ls -l file1 file2

这样就导致命令只被执行一次而不是多次。有两种方法可以这样做。传统方式是使用外部命令
xargs，另一种方法是，使用 find 命令自己的一个新功能。我们先讨论第二种方法。

通过把末尾的分号改为加号，就激活了 find 命令的一个功能，把搜索结果结合为一个参数列表，
然后执行一次所期望的命令。再看一下之前的例子，这个：

    find ~ -type f -name 'foo*' -exec ls -l '{}' ';'
    -rwxr-xr-x 1 me     me 224 2007-10-29 18:44 /home/me/bin/foo
    -rw-r--r-- 1 me     me 0 2008-09-19 12:53 /home/me/foo.txt

会执行 ls 命令，每次找到一个匹配的文件。把命令改为：

    find ~ -type f -name 'foo*' -exec ls -l '{}' +
    -rwxr-xr-x 1 me     me 224 2007-10-29 18:44 /home/me/bin/foo
    -rw-r--r-- 1 me     me 0 2008-09-19 12:53 /home/me/foo.txt

虽然我们得到一样的结果，但是系统只需要执行一次 ls 命令。

#### xargs

这个 xargs 命令会执行一个有趣的函数。它从标准输入接受输入，并把输入转换为一个特定命令的
参数列表。对于我们的例子，我们可以这样使用它：

    find ~ -type f -name 'foo*' -print | xargs ls -l
    -rwxr-xr-x 1 me     me 224 2007-10-29 18:44 /home/me/bin/foo
    -rw-r--r-- 1 me     me 0 2008-09-19 12:53 /home/me/foo.txt

这里我们看到 find 命令的输出被管道到 xargs 命令，反过来，xargs 会为 ls 命令构建
参数列表，然后执行 ls 命令。

---

注意：当被放置到命令行中的参数个数相当大时，参数个数是有限制的。有可能创建的命令
太长以至于 shell 不能接受。当命令行超过系统支持的最大长度时，xargs 会执行带有最大
参数个数的指定命令，然后重复这个过程直到耗尽标准输入。执行带有 --show--limits 选项
的 xargs 命令，来查看命令行的最大值。

---

>
> 处理古怪的文件名
>
> 类 Unix 的系统允许在文件名中嵌入空格（甚至换行符）。这就给一些程序，如为其它
程序构建参数列表的 xargs 程序，造成了问题。一个嵌入的空格会被看作是一个界定符，生成的
命令会把每个空格分离的单词解释为单独的参数。为了解决这个问题，find 命令和 xarg 程序
允许可选择的使用一个 null 字符作为参数分隔符。一个 null 字符被定义在 ASCII 码中，由数字
零来表示（相反的，例如，空格字符在 ASCII 码中由数字32表示）。find 命令提供的 -print0 行为，
则会产生由 null 字符分离的输出，并且 xargs 命令有一个 --null 选项，这个选项会接受由 null 字符
分离的输入。这里有一个例子：
>
>  find ~ -iname '*.jpg' -print0 | xargs --null ls -l
>
> 使用这项技术，我们可以保证所有文件，甚至那些文件名中包含空格的文件，都能被正确地处理。

### 返回操练场

到实际使用 find 命令的时候了。我们将会创建一个操练场，来实践一些我们所学到的知识。

首先，让我们创建一个包含许多子目录和文件的操练场：

    [me@linuxbox ~]$ mkdir -p playground/dir-{00{1..9},0{10..99},100}
    [me@linuxbox ~]$ touch playground/dir-{00{1..9},0{10..99},100}/file-{A..Z}

惊叹于命令行的强大功能！只用这两行，我们就创建了一个包含一百个子目录，每个子目录中
包含了26个空文件的操练场。试试用 GUI 来创建它！

我们用来创造这个奇迹的方法中包含一个熟悉的命令（mkdir），一个奇异的 shell 扩展（大括号）
和一个新命令，touch。通过结合 mkdir 命令和-p 选项（导致 mkdir 命令创建指定路径的父目录），以及
大括号展开，我们能够创建一百个目录。

这个 touch 命令通常被用来设置或更新文件的访问，更改，和修改时间。然而，如果一个文件名参数是一个
不存在的文件，则会创建一个空文件。

在我们的操练场中，我们创建了一百个名为 file-A 的文件实例。让我们找到它们：

    [me@linuxbox ~]$ find playground -type f -name 'file-A'

注意不同于 ls 命令，find 命令的输出结果是无序的。其顺序由存储设备的布局决定。为了确定实际上
我们拥有一百个此文件的实例，我们可以用这种方式来确认：

    [me@linuxbox ~]$ find playground -type f -name 'file-A' | wc -l

下一步，让我们看一下基于文件的修改时间来查找文件。当创建备份文件或者以年代顺序来
组织文件的时候，这会很有帮助。为此，首先我们将创建一个参考文件，我们将与其比较修改时间：

    [me@linuxbox ~]$ touch playground/timestamp

这个创建了一个空文件，名为 timestamp，并且把它的修改时间设置为当前时间。我们能够验证
它通过使用另一个方便的命令，stat，是一款加大马力的 ls 命令版本。这个 stat 命令会展示系统对
某个文件及其属性所知道的所有信息：

    [me@linuxbox ~]$ stat playground/timestamp
    File: 'playground/timestamp'
    Size: 0 Blocks: 0 IO Block: 4096 regular empty file
    Device: 803h/2051d Inode: 14265061 Links: 1
    Access: (0644/-rw-r--r--) Uid: ( 1001/ me) Gid: ( 1001/ me)
    Access: 2008-10-08 15:15:39.000000000 -0400
    Modify: 2008-10-08 15:15:39.000000000 -0400
    Change: 2008-10-08 15:15:39.000000000 -0400

如果我们再次 touch 这个文件，然后用 stat 命令检测它，我们会发现所有文件的时间已经更新了。

    [me@linuxbox ~]$ touch playground/timestamp
    [me@linuxbox ~]$ stat playground/timestamp
    File: 'playground/timestamp'
    Size: 0 Blocks: 0 IO Block: 4096 regular empty file
    Device: 803h/2051d Inode: 14265061 Links: 1
    Access: (0644/-rw-r--r--) Uid: ( 1001/ me) Gid: ( 1001/ me)
    Access: 2008-10-08 15:23:33.000000000 -0400
    Modify: 2008-10-08 15:23:33.000000000 -0400
    Change: 2008-10-08 15:23:33.000000000 -0400

下一步，让我们使用 find 命令来更新一些操练场中的文件：

    [me@linuxbox ~]$ find playground -type f -name 'file-B' -exec touch '{}' ';'

这会更新操练场中所有名为 file-B 的文件。接下来我们会使用 find 命令来识别已更新的文件，
通过把所有文件与参考文件 timestamp 做比较：

    [me@linuxbox ~]$ find playground -type f -newer playground/timestamp

搜索结果包含所有一百个文件 file-B 的实例。因为我们在更新了文件 timestamp 之后，
touch 了操练场中名为 file-B 的所有文件，所以现在它们“新于”timestamp 文件，因此能被用
-newer 测试条件识别出来。

最后，让我们回到之前那个错误权限的例子中，把它应用于操练场里：

    [me@linuxbox ~]$ find playground \( -type f -not -perm 0600 \) -or \( -type d -not -perm 0700 \)

这个命令列出了操练场中所有一百个目录和二百六十个文件（还有 timestamp 和操练场本身，共 2702 个）
，因为没有一个符合我们“正确权限”的定义。通过对运算符和行为知识的了解，我们可以给这个命令
添加行为，对实战场中的文件和目录应用新的权限。

    [me@linuxbox ~]$ find playground \( -type f -not -perm 0600 -exec chmod 0600 '{}' ';' \)
       -or \( -type d -not -perm 0711 -exec chmod 0700 '{}' ';' \)

在日常的基础上，我们可能发现运行两个命令会比较容易一些，一个操作目录，另一个操作文件，
而不是这一个长长的复合命令，但是很高兴知道，我们能这样执行命令。这里最重要的一点是要
理解怎样把操作符和行为结合起来使用，来执行有用的任务。

#### 选项

最后，我们有这些选项。这些选项被用来控制 find 命令的搜索范围。当构建 find 表达式的时候，
它们可能被其它的测试条件和行为包含：

<table class="multi">
<caption class="cap">表 18-7: find 命令选项</caption>
<tr>
<th class="title">选项</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top" width="25%">-depth</td>
<td valign="top"> 指导 find 程序先处理目录中的文件，再处理目录自身。当指定-delete 行为时，会自动
应用这个选项。</td>
</tr>
<tr>
<td valign="top">-maxdepth levels </td>
<td valign="top">当执行测试条件和行为的时候，设置 find 程序陷入目录树的最大级别数 </td>
</tr>
<tr>
<td valign="top">-mindepth levels </td>
<td valign="top">在应用测试条件和行为之前，设置 find 程序陷入目录数的最小级别数。 </td>
</tr>
<tr>
<td valign="top">-mount </td>
<td valign="top">指导 find 程序不要搜索挂载到其它文件系统上的目录。</td>
</tr>
<tr>
<td valign="top">-noleaf </td>
<td valign="top">指导 find 程序不要基于搜索类 Unix 的文件系统做出的假设，来优化它的搜索。</td>
</tr>
</table>

### 拓展阅读

* 程序 locate，updatedb，find 和 xargs 都是 GNU 项目 findutils 软件包的一部分。
  这个 GUN 项目提供了大量的在线文档，这些文档相当出色，如果你在高安全性的
  环境中使用这些程序，你应该读读这些文档。

  <http://www.gnu.org/software/findutils/>


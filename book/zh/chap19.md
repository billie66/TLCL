---
layout: book-zh
title: 归档和备份
---

计算机系统管理员的一个主要任务就是保护系统的数据安全，其中一种方法是通过时时备份系统文件，来保护
数据。即使你不是一名系统管理员，像做做拷贝或者在各个位置和设备之间移动大量的文件，通常也是很有帮助的。
在这一章中，我们将会看看几个经常用来管理文件集合的程序。它们就是文件压缩程序：

* gzip – 压缩或者展开文件

* bzip2 – 块排序文件压缩器

归档程序：

* tar – 磁带打包工具

* zip – 打包和压缩文件

还有文件同步程序：

* rsync – 同步远端文件和目录

### 压缩文件

纵观计算领域的发展历史，人们努力想把最多的数据存放到到最小的可用空间中，不管是内存，存储设备
还是网络带宽。今天我们把许多数据服务都看作是理所当然的事情，但是诸如便携式音乐播放器，
高清电视，或宽带网络之类的存在都应归功于高效的数据压缩技术。

数据压缩就是一个删除冗余数据的过程。让我们考虑一个假想的例子，比方说我们有一张100\*100像素的
纯黑的图片文件。根据数据存储方案（假定每个像素占24位，或者3个字节），那么这张图像将会占用
30,000个字节的存储空间：

    100 * 100 * 3 = 30,000

一张单色图像包含的数据全是多余的。我们要是聪明的话，可以用这种方法来编码这些数据，
我们只要简单地描述这个事实，我们有3万个黑色的像素数据块。所以，我们不存储包含3万个0
（通常在图像文件中，黑色由0来表示）的数据块，取而代之，我们把这些数据压缩为数字30,000，
后跟一个0，来表示我们的数据。这种数据压缩方案被称为游程编码，是一种最基本的压缩技术。今天的技术更加先进和复杂，但是基本目标依然不变——避免多余数据。

压缩算法（数学技巧被用来执行压缩任务）分为两大类，无损压缩和有损压缩。无损压缩保留了
原始文件的所有数据。这意味着，当还原一个压缩文件的时候，还原的文件与原文件一模一样。
而另一方面，有损压缩，执行压缩操作时会删除数据，允许更大的压缩。当一个有损文件被还原的时候，
它与原文件不相匹配; 相反，它是一个近似值。有损压缩的例子有 JPEG（图像）文件和 MP3（音频）文件。
在我们的讨论中，我们将看看完全无损压缩，因为计算机中的大多数数据是不能容忍丢失任何数据的。

#### gzip

这个 gzip 程序被用来压缩一个或多个文件。当执行 gzip 命令时，则原始文件的压缩版会替代原始文件。
相对应的 gunzip 程序被用来把压缩文件复原为没有被压缩的版本。这里有个例子：

    [me@linuxbox ~]$ ls -l /etc > foo.txt
    [me@linuxbox ~]$ ls -l foo.*
    -rw-r--r-- 1 me     me 15738 2008-10-14 07:15 foo.txt
    [me@linuxbox ~]$ gzip foo.txt
    [me@linuxbox ~]$ ls -l foo.*
    -rw-r--r-- 1 me     me 3230 2008-10-14 07:15 foo.txt.gz
    [me@linuxbox ~]$ gunzip foo.txt.gz
    [me@linuxbox ~]$ ls -l foo.*
    -rw-r--r-- 1 me     me 15738 2008-10-14 07:15 foo.txt

在这个例子里，我们创建了一个名为 foo.txt 的文本文件，其内容包含一个目录的列表清单。
接下来，我们运行 gzip 命令，它会把原始文件替换为一个叫做 foo.txt.gz 的压缩文件。在
foo.\* 文件列表中，我们看到原始文件已经被压缩文件替代了，并将这个压缩文件大约是原始
文件的五分之一。我们也能看到压缩文件与原始文件有着相同的权限和时间戳。

接下来，我们运行 gunzip 程序来解压缩文件。随后，我们能见到压缩文件已经被原始文件替代了，
同样地保留了相同的权限和时间戳。

gzip 命令有许多选项。这里列出了一些：

<table class="multi">
<caption class="cap">表19-1: gzip 选项 </caption>
<tr>
<th class="title">选项</th>
<th class="title">说明</th>
</tr>
<tr>
<td valign="top" width="25%">-c </td>
<td valign="top">把输出写入到标准输出，并且保留原始文件。也有可能用--stdout 和--to-stdout 选项来指定。 </td>
</tr>
<tr>
<td valign="top">-d</td>
<td
valign="top">解压缩。正如 gunzip 命令一样。也可以用--decompress 或者--uncompress 选项来指定. </td>
</tr>
<tr>
<td valign="top">-f</td>
<td valign="top">强制压缩，即使原始文件的压缩文件已经存在了，也要执行。也可以用--force 选项来指定。 </td>
</tr>
<tr>
<td valign="top">-h</td>
<td valign="top">显示用法信息。也可用--help 选项来指定。</td>
</tr>
<tr>
<td valign="top">-l</td>
<td valign="top">列出每个被压缩文件的压缩数据。也可用--list 选项。 </td>
</tr>
<tr>
<td valign="top">-r</td>
<td valign="top">若命令的一个或多个参数是目录，则递归地压缩目录中的文件。也可用--recursive 选项来指定。 </td>
</tr>
<tr>
<td valign="top">-t</td>
<td valign="top">测试压缩文件的完整性。也可用--test 选项来指定。</td>
</tr>
<tr>
<td valign="top">-v</td>
<td valign="top">显示压缩过程中的信息。也可用--verbose 选项来指定。 </td>
</tr>
<tr>
<td valign="top">-number</td>
<td valign="top">设置压缩指数。number 是一个在1（最快，最小压缩）到9（最慢，最大压缩）之间的整数。
数值1和9也可以各自用--fast 和--best 选项来表示。默认值是整数6。 </td>
</tr>
</table>

返回到我们之前的例子中：

    [me@linuxbox ~]$ gzip foo.txt
    [me@linuxbox ~]$ gzip -tv foo.txt.gz
    foo.txt.gz: OK
    [me@linuxbox ~]$ gzip -d foo.txt.gz

这里，我们用压缩文件来替代文件 foo.txt，压缩文件名为 foo.txt.gz。下一步，我们测试了压缩文件
的完整性，使用了-t 和-v 选项。

    [me@linuxbox ~]$ ls -l /etc | gzip > foo.txt.gz

这个命令创建了一个目录列表的压缩文件。

这个 gunzip 程序，会解压缩 gzip 文件，假定那些文件名的扩展名是.gz，所以没有必要指定它，
只要指定的名字与现有的未压缩文件不冲突就可以：

    [me@linuxbox ~]$ gunzip foo.txt

如果我们的目标只是为了浏览一下压缩文本文件的内容，我们可以这样做：

    [me@linuxbox ~]$ gunzip -c foo.txt | less

另外，对应于 gzip 还有一个程序，叫做 zcat，它等同于带有-c 选项的 gunzip 命令。
它可以被用来如 cat 命令作用于 gzip 压缩文件：

    [me@linuxbox ~]$ zcat foo.txt.gz | less

---

_小贴士:_ 还有一个 zless 程序。它与上面的管道线有相同的功能。

---

#### bzip2

这个 bzip2 程序，由 Julian Seward 开发，与 gzip 程序相似，但是使用了不同的压缩算法，
舍弃了压缩速度，而实现了更高的压缩级别。在大多数情况下，它的工作模式等同于 gzip。
由 bzip2 压缩的文件，用扩展名 .bz2 来表示：

    [me@linuxbox ~]$ ls -l /etc > foo.txt
    [me@linuxbox ~]$ ls -l foo.txt
    -rw-r--r-- 1 me     me      15738 2008-10-17 13:51 foo.txt
    [me@linuxbox ~]$ bzip2 foo.txt
    [me@linuxbox ~]$ ls -l foo.txt.bz2
    -rw-r--r-- 1 me     me      2792 2008-10-17 13:51 foo.txt.bz2
    [me@linuxbox ~]$ bunzip2 foo.txt.bz2

正如我们所看到的，bzip2 程序使用起来和 gzip 程序一样。我们之前讨论的 gzip 程序的所有选项（除了-r）
，bzip2 程序同样也支持。注意，然而，压缩级别选项（-number）对于 bzip2 程序来说，有少许不同的含义。
伴随着 bzip2 程序，有 bunzip2 和 bzcat 程序来解压缩文件。bzip2 文件也带有 bzip2recover 程序，其会
试图恢复受损的 .bz2 文件。

>
> 不要强迫性压缩
>
> 我偶然见到人们试图用高效的压缩算法，来压缩一个已经被压缩过的文件，通过这样做：
>
>  _$ gzip picture.jpg_
>
> 不要这样。你可能只是在浪费时间和空间！如果你再次压缩已经压缩过的文件，实际上你
会得到一个更大的文件。这是因为所有的压缩技术都会涉及一些开销，文件中会被添加描述
此次压缩过程的信息。如果你试图压缩一个已经不包含多余信息的文件，那么再次压缩不会节省
空间，以抵消额外的花费。

### 归档文件

一个常见的，与文件压缩结合一块使用的文件管理任务是归档。归档就是收集许多文件，并把它们
捆绑成一个大文件的过程。归档经常作为系统备份的一部分来使用。当把旧数据从一个系统移到某
种类型的长期存储设备中时，也会用到归档程序。

#### tar

在类 Unix 的软件世界中，这个 tar 程序是用来归档文件的经典工具。它的名字，是 tape
archive 的简称，揭示了它的根源，它是一款制作磁带备份的工具。而它仍然被用来完成传统任务，
它也同样适用于其它的存储设备。我们经常看到扩展名为 .tar 或者 .tgz 的文件，它们各自表示“普通”
的 tar 包和被 gzip 程序压缩过的 tar 包。一个 tar 包可以由一组独立的文件，一个或者多个目录，或者
两者混合体组成。命令语法如下：

    tar mode[options] pathname...

这里的 mode 是指以下操作模式（这里只展示了一部分，查看 tar 的手册来得到完整列表）之一：

<table class="multi">
<caption class="cap">表19-2: tar 模式</caption>
<tr>
<th class="title">模式</th>
<th class="title">说明</th>
</tr>
<tr>
<td valign="top" width="25%">c</td>
<td valign="top">为文件和／或目录列表创建归档文件。 </td>
</tr>
<tr>
<td valign="top">x</td>
<td valign="top">抽取归档文件。</td>
</tr>
<tr>
<td valign="top">r</td>
<td valign="top">追加具体的路径到归档文件的末尾。</td>
</tr>
<tr>
<td valign="top">t</td>
<td valign="top">列出归档文件的内容。</td>
</tr>
</table>

tar 命令使用了稍微有点奇怪的方式来表达它的选项，所以我们需要一些例子来展示它是
怎样工作的。首先，让我们重新创建之前我们用过的操练场:

    [me@linuxbox ~]$ mkdir -p playground/dir-{00{1..9},0{10..99},100}
    [me@linuxbox ~]$ touch playground/dir-{00{1..9},0{10..99},100}/file-{A..Z}

下一步，让我们创建整个操练场的 tar 包：

    [me@linuxbox ~]$ tar cf playground.tar playground

这个命令创建了一个名为 playground.tar 的 tar 包，其包含整个 playground 目录层次结果。我们
可以看到模式 c 和选项 f，其被用来指定这个 tar 包的名字，模式和选项可以写在一起，而且不
需要开头的短横线。注意，然而，必须首先指定模式，然后才是其它的选项。

要想列出归档文件的内容，我们可以这样做：

    [me@linuxbox ~]$ tar tf playground.tar

为了得到更详细的列表信息，我们可以添加选项 v：

    [me@linuxbox ~]$ tar tvf playground.tar

现在，抽取 tar 包 playground 到一个新位置。我们先创建一个名为 foo 的新目录，更改目录，
然后抽取 tar 包中的文件：

    [me@linuxbox ~]$ mkdir foo
    [me@linuxbox ~]$ cd foo
    [me@linuxbox ~]$ tar xf ../playground.tar
    [me@linuxbox ~]$ ls
    playground

如果我们检查 ~/foo/playground 目录中的内容，会看到这个归档文件已经被成功地安装了，就是创建了
一个精确的原始文件的副本。然而，这里有一个警告：除非你是超级用户，要不然从归档文件中抽取的文件
和目录的所有权由执行此复原操作的用户所拥有，而不属于原始所有者。

tar 命令另一个有趣的行为是它处理归档文件路径名的方式。默认情况下，路径名是相对的，而不是绝对
路径。当创建归档文件的时候，tar 命令会简单地删除路径名开头的斜杠。为了说明问题，我们将会
重新创建我们的归档文件，这次指定一个绝对路径：

    [me@linuxbox foo]$ cd
    [me@linuxbox ~]$ tar cf playground2.tar ~/playground

记住，当按下回车键后，~/playground 会展开成 /home/me/playground，所以我们将会得到一个
绝对路径名。接下来，和之前一样我们会抽取归档文件，观察发生什么事情：

    [me@linuxbox ~]$ cd foo
    [me@linuxbox foo]$ tar xf ../playground2.tar
    [me@linuxbox foo]$ ls
    home     playground
    [me@linuxbox foo]$ ls home
    me
    [me@linuxbox foo]$ ls home/me
    playground

这里我们看到当我们抽取第二个归档文件时，它重新创建了 home/me/playground 目录，
相对于我们当前的工作目录，~/foo，而不是相对于 root 目录，作为带有绝对路径名的案例。
这看起来似乎是一种奇怪的工作方式，但事实上这种方式很有用，因为这样就允许我们抽取文件
到任意位置，而不是强制地把抽取的文件放置到原始目录下。加上 verbose（v）选项，重做
这个练习，将会展现更加详细的信息。

让我们考虑一个假设，tar 命令的实际应用。假定我们想要复制家目录及其内容到另一个系统中，
并且有一个大容量的 USB 硬盘，可以把它作为传输工具。在现代 Linux 系统中，
这个硬盘会被“自动地”挂载到 /media 目录下。我们也假定硬盘中有一个名为 BigDisk 的逻辑卷。
为了制作 tar 包，我们可以这样做：

    [me@linuxbox ~]$ sudo tar cf /media/BigDisk/home.tar /home

tar 包制作完成之后，我们卸载硬盘，然后把它连接到第二个计算机上。再一次，此硬盘被
挂载到 /media/BigDisk 目录下。为了抽取归档文件，我们这样做：

    [me@linuxbox2 ~]$ cd /
    [me@linuxbox2 /]$ sudo tar xf /media/BigDisk/home.tar

值得注意的一点是，因为归档文件中的所有路径名都是相对的，所以首先我们必须更改目录到根目录下，
这样抽取的文件路径就相对于根目录了。

当抽取一个归档文件时，有可能限制从归档文件中抽取什么内容。例如，如果我们想要抽取单个文件，
可以这样实现：

    tar xf archive.tar pathname

通过给命令添加末尾的路径名，tar 命令就只会恢复指定的文件。可以指定多个路径名。注意
路径名必须是完全的，精准的相对路径名，就如存储在归档文件中的一样。当指定路径名的时候，
通常不支持通配符；然而，GNU 版本的 tar 命令（在 Linux 发行版中最常出现）通过 -\-wildcards 选项来
支持通配符。这个例子使用了之前 playground.tar 文件：

    [me@linuxbox ~]$ cd foo
    [me@linuxbox foo]$ tar xf ../playground2.tar --wildcards 'home/me/playground/dir-\*/file-A'

这个命令将只会抽取匹配特定路径名的文件，路径名中包含了通配符 dir-\*。

tar 命令经常结合 find 命令一起来制作归档文件。在这个例子里，我们将会使用 find 命令来
产生一个文件集合，然后这些文件被包含到归档文件中。

    [me@linuxbox ~]$ find playground -name 'file-A' -exec tar rf playground.tar '{}' '+'

这里我们使用 find 命令来匹配 playground 目录中所有名为 file-A 的文件，然后使用-exec 行为，来
唤醒带有追加模式（r）的 tar 命令，把匹配的文件添加到归档文件 playground.tar 里面。

使用 tar 和 find 命令，来创建逐渐增加的目录树或者整个系统的备份，是个不错的方法。通过 find
命令匹配新于某个时间戳的文件，我们就能够创建一个归档文件，其只包含新于上一个 tar 包的文件，
假定这个时间戳文件恰好在每个归档文件创建之后被更新了。

tar 命令也可以利用标准输出和输入。这里是一个完整的例子:

    [me@linuxbox foo]$ cd
    [me@linuxbox ~]$ find playground -name 'file-A' | tar cf - --files-from=-
       | gzip > playground.tgz

在这个例子里面，我们使用 find 程序产生了一个匹配文件列表，然后把它们管道到 tar 命令中。
如果指定了文件名“-”，则其被看作是标准输入或输出，正是所需（顺便说一下，使用“-”来表示
标准输入／输出的惯例，也被大量的其它程序使用）。这个 -\-file-from 选项（也可以用 -T 来指定）
导致 tar 命令从一个文件而不是命令行来读入它的路径名列表。最后，这个由 tar 命令产生的归档
文件被管道到 gzip 命令中，然后创建了压缩归档文件 playground.tgz。此 .tgz 扩展名是命名
由 gzip 压缩的 tar 文件的常规扩展名。有时候也会使用 .tar.gz 这个扩展名。

虽然我们使用 gzip 程序来制作我们的压缩归档文件，但是现在的 GUN 版本的 tar 命令
，gzip 和 bzip2 压缩两者都直接支持，各自使用 z 和 j 选项。以我们之前的例子为基础，
我们可以这样简化它：

    [me@linuxbox ~]$ find playground -name 'file-A' | tar czf playground.tgz -T -

如果我们本要创建一个由 bzip2 压缩的归档文件，我们可以这样做：

    [me@linuxbox ~]$ find playground -name 'file-A' | tar cjf playground.tbz -T -

通过简单地修改压缩选项，把 z 改为 j（并且把输出文件的扩展名改为 .tbz，来指示一个 bzip2 压缩文件），
就使 bzip2 命令压缩生效了。另一个 tar 命令与标准输入和输出的有趣使用，涉及到在系统之间经过
网络传输文件。假定我们有两台机器，每台都运行着类 Unix，且装备着 tar 和 ssh 工具的操作系统。
在这种情景下，我们可以把一个目录从远端系统（名为 remote-sys）传输到我们的本地系统中：

    [me@linuxbox ~]$ mkdir remote-stuff
    [me@linuxbox ~]$ cd remote-stuff
    [me@linuxbox remote-stuff]$ ssh remote-sys 'tar cf - Documents' | tar xf -
    me@remote-sys’s password:
    [me@linuxbox remote-stuff]$ ls
    Documents

这里我们能够从远端系统 remote-sys 中复制目录 Documents 到本地系统名为 remote-stuff 目录中。
我们怎样做的呢？首先，通过使用 ssh 命令在远端系统中启动 tar 程序。你可记得 ssh 允许我们
在远程联网的计算机上执行程序，并且在本地系统中看到执行结果——远端系统中产生的输出结果
被发送到本地系统中查看。我们可以利用。在本地系统中，我们执行 tar 命令，

#### zip

这个 zip 程序既是压缩工具，也是一个打包工具。这程序使用的文件格式，Windows 用户比较熟悉，
因为它读取和写入.zip 文件。然而，在 Linux 中 gzip 是主要的压缩程序，而 bzip2则位居第二。

在 zip 命令最基本的使用中，可以这样唤醒 zip 命令：

    zip options zipfile file...

例如，制作一个 playground 的 zip 版本的文件包，这样做：

    [me@linuxbox ~]$ zip -r playground.zip playground

除非我们包含-r 选项，要不然只有 playground 目录（没有任何它的内容）被存储。虽然会自动添加
.zip 扩展名，但为了清晰起见，我们还是包含文件扩展名。

在创建 zip 版本的文件包时，zip 命令通常会显示一系列的信息：

    adding: playground/dir-020/file-Z (stored 0%)
    adding: playground/dir-020/file-Y (stored 0%)
    adding: playground/dir-020/file-X (stored 0%)
    adding: playground/dir-087/ (stored 0%)
    adding: playground/dir-087/file-S (stored 0%)

这些信息显示了添加到文件包中每个文件的状态。zip 命令会使用两种存储方法之一，来添加
文件到文件包中：要不它会“store”没有压缩的文件，正如这里所示，或者它会“deflate”文件，
执行压缩操作。在存储方法之后显示的数值表明了压缩量。因为我们的 playground 目录
只是包含空文件，没有对它的内容执行压缩操作。

使用 unzip 程序，来直接抽取一个 zip 文件的内容。

    [me@linuxbox ~]$ cd foo
    [me@linuxbox foo]$ unzip ../playground.zip

对于 zip 命令（与 tar 命令相反）要注意一点，就是如果指定了一个已经存在的文件包，其被更新
而不是被替代。这意味着会保留此文件包，但是会添加新文件，同时替换匹配的文件。可以列出
文件或者有选择地从一个 zip 文件包中抽取文件，只要给 unzip 命令指定文件名：

    [me@linuxbox ~]$ unzip -l playground.zip playground/dir-87/file-Z
    Archive: ../playground.zip
        Length      Date    Time    Name

             0    10-05-08  09:25   playground/dir-87/file-Z

             0                      1 file
    [me@linuxbox ~]$ cd foo
    [me@linuxbox foo]$ unzip ./playground.zip playground/dir-87/file-Z
    Archive: ../playground.zip
    replace playground/dir-87/file-Z? [y]es, [n]o, [A]ll, [N]one,
    [r]ename: y
    extracting: playground/dir-87/file-Z

使用-l 选项，导致 unzip 命令只是列出文件包中的内容而没有抽取文件。如果没有指定文件，
unzip 程序将会列出文件包中的所有文件。添加这个-v 选项会增加列表的冗余信息。注意当抽取的
文件与已经存在的文件冲突时，会在替代此文件之前提醒用户。

像 tar 命令一样，zip 命令能够利用标准输入和输出，虽然它的实施不大有用。通过-@选项，有可能把一系列的
文件名管道到 zip 命令。

    [me@linuxbox foo]$ cd
    [me@linuxbox ~]$ find playground -name "file-A" | zip -@ file-A.zip

这里我们使用 find 命令产生一系列与“file-A”相匹配的文件列表，并且把此列表管道到 zip 命令，
然后创建包含所选文件的文件包 file-A.zip。

zip 命令也支持把它的输出写入到标准输出，但是它的使用是有限的，因为很少的程序能利用输出。
不幸地是，这个 unzip 程序，不接受标准输入。这就阻止了 zip 和 unzip 一块使用，像 tar 命令那样，
来复制网络上的文件。

然而，zip 命令可以接受标准输入，所以它可以被用来压缩其它程序的输出：

    [me@linuxbox ~]$ ls -l /etc/ | zip ls-etc.zip -
    adding: - (deflated 80%)

在这个例子里，我们把 ls 命令的输出管道到 zip 命令。像 tar 命令，zip 命令把末尾的横杠解释为
“使用标准输入作为输入文件。”

这个 unzip 程序允许它的输出发送到标准输出，当指定了-p 选项之后：

    [me@linuxbox ~]$ unzip -p ls-etc.zip | less

我们讨论了一些 zip/unzip 可以完成的基本操作。它们两个都有许多选项，其增加了
命令的灵活性，虽然一些选项只针对于特定的平台。zip 和 unzip 命令的说明手册都相当不错，
并且包含了有用的实例。然而，这些程序的主要用途是为了和 Windows 系统交换文件，
而不是在 Linux 系统中执行压缩和打包操作，tar 和 gzip 程序在 Linux 系统中更受欢迎。

### 同步文件和目录

维护系统备份的常见策略是保持一个或多个目录与另一个本地系统（通常是某种可移动的存储设备）
或者远端系统中的目录（或多个目录）同步。我们可能，例如有一个正在开发的网站的本地备份，
需要时不时的与远端网络服务器中的文件备份保持同步。在类 Unix 系统的世界里，能完成此任务且
备受人们喜爱的工具是 rsync。这个程序能同步本地与远端的目录，通过使用 rsync 远端更新协议，此协议
允许 rsync 快速地检测两个目录的差异，执行最小量的复制来达到目录间的同步。比起其它种类的复制程序，
这就使 rsync 命令非常快速和高效。

rsync 被这样唤醒：

    rsync options source destination

这里 source 和 destination 是下列选项之一：

* 一个本地文件或目录

* 一个远端文件或目录，以[user@]host:path 的形式存在

* 一个远端 rsync 服务器，由 rsync://[user@]host[:port]/path 指定

注意 source 和 destination 两者之一必须是本地文件。rsync 不支持远端到远端的复制

让我们试着对一些本地文件使用 rsync 命令。首先，清空我们的 foo 目录：

    [me@linuxbox ~]$ rm -rf foo/*

下一步，我们将同步 playground 目录和它在 foo 目录中相对应的副本

    [me@linuxbox ~]$ rsync -av playground foo

我们包括了-a 选项（递归和保护文件属性）和-v 选项（冗余输出），
来在 foo 目录中制作一个 playground 目录的镜像。当这个命令执行的时候，
我们将会看到一系列的文件和目录被复制。在最后，我们将看到一条像这样的总结信息：

    sent 135759 bytes received 57870 bytes 387258.00 bytes/sec
    total size is 3230 speedup is 0.02

说明复制的数量。如果我们再次运行这个命令，我们将会看到不同的结果：

    [me@linuxbox ~]$ rsync -av playgound foo
    building file list ... done
    sent 22635 bytes received 20 bytes
    total size is 3230 speedup is 0.14
    45310.00 bytes/sec

注意到没有文件列表。这是因为 rsync 程序检测到在目录~/playground 和 ~/foo/playground 之间
不存在差异，因此它不需要复制任何数据。如果我们在 playground 目录中修改一个文件，然后
再次运行 rsync 命令：

    [me@linuxbox ~]$ touch playground/dir-099/file-Z
    [me@linuxbox ~]$ rsync -av playground foo
    building file list ... done
    playground/dir-099/file-Z
    sent 22685 bytes received 42 bytes 45454.00 bytes/sec
    total size is 3230 speedup is 0.14

我们看到 rsync 命令检测到更改，并且只是复制了更新的文件。作为一个实际的例子，
让我们考虑一个假想的外部硬盘，之前我们在 tar 命令中用到过的。如果我们再次把此
硬盘连接到我们的系统中，它被挂载到/media/BigDisk 目录下，我们可以执行一个有
用的系统备份了，首先在外部硬盘上创建一个目录，名为/backup，然后使用 rsync 程序
从我们的系统中复制最重要的数据到此外部硬盘上：

    [me@linuxbox ~]$ mkdir /media/BigDisk/backup
    [me@linuxbox ~]$ sudo rsync -av --delete /etc /home /usr/local /media/BigDisk/backup

在这个例子里，我们把/etc，/home，和/usr/local 目录从我们的系统中复制到假想的存储设备中。
我们包含了--delete 这个选项，来删除可能在备份设备中已经存在但却不再存在于源设备中的文件，
（这与我们第一次创建备份无关，但是会在随后的复制操作中有用途）。挂载外部驱动器，运行
rsync 命令，不断重复这个过程，是一个不错的（虽然不理想）方式来保存少量的系统备份文件。
当然，别名会对这个操作更有帮助些。我们将会创建一个别名，并把它添加到.bashrc 文件中，
来提供这个特性：

    alias backup='sudo rsync -av --delete /etc /home /usr/local /media/BigDisk/backup'

现在我们所做的事情就是连接外部驱动器，然后运行 backup 命令来完成工作。

#### 在网络间使用 rsync 命令

rsync 程序的真正好处之一，是它可以被用来在网络间复制文件。毕竟，rsync 中的“r”象征着“remote”。
远程复制可以通过两种方法完成。第一个方法要求另一个系统已经安装了 rsync 程序，还安装了
远程 shell 程序，比如 ssh。比方说我们本地网络中的一个系统有大量可用的硬盘空间，我们想要
用远程系统来代替一个外部驱动器，来执行文件备份操作。假定远程系统中有一个名为/backup 的目录，
其用来存放我们传送的文件，我们这样做：

    [me@linuxbox ~]$ sudo rsync -av --delete --rsh=ssh /etc /home /usr/local remote-sys:/backup

我们对命令做了两处修改，来方便网络间文件复制。首先，我们添加了-\-rsh=ssh 选项，其指示
rsync 使用 ssh 程序作为它的远程 shell。以这种方式，我们就能够使用一个 ssh 加密通道，把数据
安全地传送到远程主机中。其次，通过在目标路径名前加上远端主机的名字（在这种情况下，
远端主机名为 remote-sys），来指定远端主机。

rsync 可以被用来在网络间同步文件的第二种方式是通过使用 rsync 服务器。rsync 可以被配置为一个
守护进程，监听即将到来的同步请求。这样做经常是为了允许一个远程系统的镜像。例如，Red
Hat 软件中心为它的 Fedora 发行版，维护着一个巨大的正在开发中的软件包的仓库。对于软件测试人员，
在发行周期的测试阶段，镜像这些软件集合是非常有帮助的。因为仓库中的这些文件会频繁地
（通常每天不止一次）改动，定期同步本地镜像，这是可取的，而不是大量地拷贝软件仓库。
这些软件库之一被维护在 Georgia Tech；我们可以使用本地 rsync 程序和它们的 rsync 服务器来镜像它。

    [me@linuxbox ~]$ mkdir fedora-devel
    [me@linuxbox ~]$ rsync -av -delete rsync://rsync.gtlib.gatech.edu/fedora-linux-
     core/development/i386/os fedora-devel

在这个例子里，我们使用了远端 rsync 服务器的 URI，其由协议（rsync://），远端主机名
（rsync.gtlib.gatech.edu），和软件仓库的路径名组成。

### 拓展阅读

* 在这里讨论的所有命令的手册文档都相当清楚明白，并且包含了有用的例子。另外，
GNU 版本的 tar 命令有一个不错的在线文档。可以在下面链接处找到：

    <http://www.gnu.org/software/tar/manual/index.html>


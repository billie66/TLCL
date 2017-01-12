---
layout: book-zh
title: 探究操作系统
---

既然我们已经知道了如何在文件系统中跳转，是时候开始 Linux 操作系统之旅了。然而在开始之前，我们先学习一些对研究
Linux 系统有帮助的命令。

* ls — 列出目录内容

* file — 确定文件类型

* less — 浏览文件内容

### ls 乐趣

ls 可能是用户最常使用的命令了，这自有它的道理。通过它，我们可以知道目录的内容，以及各种各样重要文件和目录的
属性。正如我们已经见到的，只要简单的输入 ls 就能看到在当前目录下所有文件和子目录的列表。

    [me@linuxbox ~]$ ls
    Desktop Documents Music Pictures Publica Templates Videos

除了当前工作目录以外，也可以指定别的目录，就像这样：

    me@linuxbox ~]$ ls /usr
    bin games   kerberos    libexec  sbin   src
    etc include lib         local    share  tmp

甚至可以列出多个指定目录的内容。在这个例子中，将会列出用户家目录（用字符“~”代表）和/usr 目录的内容：

    [me@linuxbox ~]$ ls ~ /usr
    /home/me:
    Desktop  Documents  Music  Pictures  Public  Templates  Videos

    /usr:
    bin  games      kerberos  libexec  sbin   src
    etc  include    lib       local    share  tmp

我们也可以改变输出格式，来得到更多的细节：

    [me@linuxbox ~]$ ls -l
    total 56
    drwxrwxr-x 2  me  me  4096  2007-10-26  17:20  Desktop
    drwxrwxr-x 2  me  me  4096  2007-10-26  17:20  Documents
    drwxrwxr-x 2  me  me  4096  2007-10-26  17:20  Music
    drwxrwxr-x 2  me  me  4096  2007-10-26  17:20  Pictures
    drwxrwxr-x 2  me  me  4096  2007-10-26  17:20  Public
    drwxrwxr-x 2  me  me  4096  2007-10-26  17:20  Templates
    drwxrwxr-x 2  me  me  4096  2007-10-26  17:20  Videos

使用 ls 命令的“-l”选项，则结果以长模式输出。

### 选项和参数

我们将学习一个非常重要的知识点，大多数命令是如何工作的。命令名经常会带有一个或多个用来更正命令行为的选项，
更进一步，选项后面会带有一个或多个参数，这些参数是命令作用的对象。所以大多数命令看起来像这样：

    command -options arguments

大多数命令使用的选项，是由一个中划线加上一个字符组成，例如，“-l”，但是许多命令，包括来自于
GNU 项目的命令，也支持长选项，长选项由两个中划线加上一个字组成。当然，
许多命令也允许把多个短选项串在一起使用。下面这个例子，ls 命令有两个选项，
“l” 选项产生长格式输出，“t”选项按文件修改时间的先后来排序。

    [me@linuxbox ~]$ ls -lt

加上长选项 “--reverse”，则结果会以相反的顺序输出：

    [me@linuxbox ~]$ ls -lt --reverse

ls 命令有大量的选项。表4-1列出了最常使用的选项。

<table class="multi">
<caption class="cap">表 4-1: ls 命令选项 </caption>
<tr>
<th class="title" width="10%">选项</th>
<th width="20%">长选项</th>
<th>描述</th>
</tr>
<tr>
<td valign="top">-a</td>
<td>--all</td>
<td>列出所有文件，甚至包括文件名以圆点开头的默认会被隐藏的隐藏文件。</td>
</tr>
<tr>
<td valign="top">-d</td>
<td>--directory</td>
<td>通常，如果指定了目录名，ls 命令会列出这个目录中的内容，而不是目录本身。
把这个选项与 -l 选项结合使用，可以看到所指定目录的详细信息，而不是目录中的内容。</td>
</tr>
<tr>
<td >-F</td>
<td >--classify</td>
<td >这个选项会在每个所列出的名字后面加上一个指示符。例如，如果名字是
目录名，则会加上一个'/'字符。 </td>
</tr>
<tr>
<td >-h</td>
<td >--human-readable</td>
<td >当以长格式列出时，以人们可读的格式，而不是以字节数来显示文件的大小。</td>
</tr>
<tr>
<td >-l</td>
<td > </td>
<td >以长格式显示结果。 </td>
</tr>
<tr>
<td>-r</td>
<td>--reverse</td>
<td>以相反的顺序来显示结果。通常，ls 命令的输出结果按照字母升序排列。</td>
</tr>
<tr>
<td>-S</td>
<td> </td>
<td>命令输出结果按照文件大小来排序。 </td>
</tr>
<tr>
<td>-t</td>
<td> </td>
<td>按照修改时间来排序。</td>
</tr>
</table>

### 深入研究长格式输出

正如我们先前知道的，“-l”选项导致 ls 的输出结果以长格式输出。这种格式包含大量的有用信息。下面的例子目录来自
于 Ubuntu 系统：

    -rw-r--r-- 1 root root 3576296 2007-04-03 11:05 Experience ubuntu.ogg
    -rw-r--r-- 1 root root 1186219 2007-04-03 11:05 kubuntu-leaflet.png
    -rw-r--r-- 1 root root   47584 2007-04-03 11:05 logo-Edubuntu.png
    -rw-r--r-- 1 root root   44355 2007-04-03 11:05 logo-Kubuntu.png
    -rw-r--r-- 1 root root   34391 2007-04-03 11:05 logo-Ubuntu.png
    -rw-r--r-- 1 root root   32059 2007-04-03 11:05 oo-cd-cover.odf
    -rw-r--r-- 1 root root  159744 2007-04-03 11:05 oo-derivatives.doc
    -rw-r--r-- 1 root root   27837 2007-04-03 11:05 oo-maxwell.odt
    -rw-r--r-- 1 root root   98816 2007-04-03 11:05 oo-trig.xls
    -rw-r--r-- 1 root root  453764 2007-04-03 11:05 oo-welcome.odt
    -rw-r--r-- 1 root root  358374 2007-04-03 11:05 ubuntu Sax.ogg

选一个文件，来看一下各个输出字段的含义：

<table class="multi">
<caption class="cap">表 4-2: ls 长格式列表的字段</caption>
<tr>
<th class="title">字段</th>
<th class="title">含义</th>
</tr>
<tr>
<td valign="top" width="20%">-rw-r--r--</td>
<td valign="top">对于文件的访问权限。第一个字符指明文件类型。在不同类型之间，
开头的“－”说明是一个普通文件，“d”表明是一个目录。其后三个字符是文件所有者的
访问权限，再其后的三个字符是文件所属组中成员的访问权限，最后三个字符是其他所
有人的访问权限。这个字段的完整含义将在第十章讨论。 </td>
</tr>
<tr>
<td>1</td>
<td>文件的硬链接数目。参考随后讨论的关于链接的内容。 </td>
</tr>
<tr>
<td>root</td>
<td>文件属主的用户名。</td>
</tr>
<tr>
<td>root</td>
<td>文件所属用户组的名字。</td>
</tr>
<tr>
<td>32059</td>
<td>以字节数表示的文件大小。</td>
</tr>
<tr>
<td>2007-04-03 11:05 </td>
<td>上次修改文件的时间和日期。</td>
</tr>
<tr>
<td>oo-cd-cover.odf </td>
<td>文件名。</td>
</tr>
</table>

### 确定文件类型

随着探究操作系统的进行，知道文件包含的内容是很有用的。我们将用 file 命令来确定文件的类型。我们之前讨论过，
在 Linux 系统中，并不要求文件名来反映文件的内容。然而，一个类似 “picture.jpg” 的文件名，我们会期望它包含
JPEG 压缩图像，但 Linux 却不这样要求它。可以这样调用 file 命令：

    file filename

当调用 file 命令后，file 命令会打印出文件内容的简单描述。例如：

    [me@linuxbox ~]$ file picture.jpg
    picture.jpg: JPEG image data, JFIF standard 1.01

有许多种类型的文件。事实上，在类 Unix 操作系统中比如说 Linux 中，有个普遍的观念就是“一切皆文件”。
随着课程的进行，我们将会明白这句话是多么的正确。

虽然系统中许多文件格式是熟悉的，例如 MP3和 JPEG 文件，但也有一些文件格式比较含蓄，极少数文件相当陌生。

### 用 less 浏览文件内容

less 命令是一个用来浏览文本文件的程序。纵观 Linux 系统，有许多人类可读的文本文件。less 程序为我们检查文本文件 提供了方便。

>
> 什么是“文本”
>
> 在计算机中，有许多方法可以表达信息。所有的方法都涉及到，在信息与一些数字之间确立一种关系，而这些数字可以
用来代表信息。毕竟，计算机只能理解数字，这样所有的数据都被转换成数值来表示。
>
> 有些数值表达法非常复杂（例如压缩的视频文件），而其它的就相当简单。最早也是最简单的一种表达法，叫做
ASCII 文本。ASCII（发音是"As-Key"）是美国信息交换标准码的简称。这是一个简单的编码方法，它首先
被用在电传打字机上，用来实现键盘字符到数字的映射。
>
> 文本是简单的字符与数字之间的一对一映射。它非常紧凑。五十个字符的文本翻译成五十个字节的数据。文本只是包含
简单的字符到数字的映射，理解这点很重要。它和一些文字处理器文档不一样，比如说由微软和
OpenOffice.org 文档 编辑器创建的文件。这些文件，和简单的 ASCII
文件形成鲜明对比，它们包含许多非文本元素，来描述它的结构和格式。 普通的 ASCII
文件，只包含字符本身，和一些基本的控制符，像制表符，回车符及换行符。纵观 Linux
系统，许多文件 以文本格式存储，也有许多 Linux 工具来处理文本文件。甚至 Windows
也承认这种文件格式的重要性。著名的 NOTEPAD.EXE 程序就是一个 ASCII
文本文件编辑器。

为什么我们要查看文本文件呢？ 因为许多包含系统设置的文件（叫做配置文件），是以文本格式存储的，阅读它们
可以更深入的了解系统是如何工作的。另外，许多系统所用到的实际程序（叫做脚本）也是以这种格式存储的。
在随后的章节里，我们将要学习怎样编辑文本文件，为的是修改系统设置，还要学习编写自己的脚本文件，但现在我们只是看看它们的内容而已。

less 命令是这样使用的：

    less filename

一旦运行起来，less 程序允许你前后滚动文件。例如，要查看一个定义了系统中全部用户身份的文件，输入以下命令：

    [me@linuxbox ~]$ less /etc/passwd

一旦 less 程序运行起来，我们就能浏览文件内容了。如果文件内容多于一页，那么我们可以上下滚动文件。按下“q”键，
退出 less 程序。

下表列出了 less 程序最常使用的键盘命令。

<table class="multi">
<caption class="cap">表 4-3: less 命令</caption>
<tr>
<th class="title" width="30%">命令</th>
<th class="title">行为</th>
</tr>
<tr>
<td valign="top">Page UP or b</td>
<td valign="top">向上翻滚一页</td>
</tr>
<tr>
<td valign="top">Page Down or space</td>
<td valign="top">向下翻滚一页</td>
</tr>
<tr>
<td valign="top">UP Arrow</td>
<td valign="top">向上翻滚一行</td>
</tr>
<tr>
<td valign="top">Down Arrow</td>
<td valign="top">向下翻滚一行</td>
</tr>
<tr>
<td valign="top">G</td>
<td valign="top">移动到最后一行</td>
</tr>
<tr>
<td valign="top">1G or g</td>
<td valign="top">移动到开头一行</td>
</tr>
<tr>
<td valign="top">/charaters</td>
<td valign="top">向前查找指定的字符串</td>
</tr>
<tr>
<td valign="top">n</td>
<td valign="top">向前查找下一个出现的字符串，这个字符串是之前所指定查找的</td>
</tr>
<tr>
<td valign="top">h</td>
<td valign="top">显示帮助屏幕</td>
</tr>
<tr>
<td valign="top">q</td>
<td valign="top">退出 less 程序</td>
</tr>
</table>

### less 就是 more（禅语：色即是空）

less 程序是早期 Unix 程序 more 的改进版。“less” 这个名字，对习语 “less is more” 开了个玩笑，
这个习语是现代主义建筑师和设计者的座右铭。

less 属于"页面调度器"程序类，这些程序允许通过页方式，在一页中轻松地浏览长长的文本文档。然而 more
程序只能向前分页浏览，而 less 程序允许前后分页浏览，它还有很多其它的特性。

### 旅行指南

Linux 系统中，文件系统布局与类 Unix 系统的文件布局很相似。实际上，一个已经发布的标准，
叫做 Linux 文件系统层次标准，详细说明了这种设计模式。不是所有Linux发行版都根据这个标准，但
大多数都是。

下一步，我们将在文件系统中游玩，来了解 Linux 系统的工作原理。这会给你一个温习跳转命令的机会。
我们会发现很多有趣的文件都是普通的可读文本。将开始旅行，做做以下练习：

1. cd 到给定目录
2. 列出目录内容 ls -l
3. 如果看到一个有趣的文件，用 file 命令确定文件内容
4. 如果文件看起来像文本，试着用 less 命令浏览它

---

记得复制和粘贴技巧！如果你正在使用鼠标，双击文件名，来复制它，然后按下鼠标中键，粘贴文件名到命令行中。

---

在系统中游玩时，不要害怕粘花惹草。普通用户是很难把东西弄乱的。那是系统管理员的工作！
如果一个命令抱怨一些事情，不要管它，尽管去玩别的东西。花一些时间四处走走。
系统是我们自己的，尽情地探究吧。记住在 Linux 中，没有秘密存在！
表4-4仅仅列出了一些我们可以浏览的目录。闲暇时试试看！

<table class="multi">
<caption class="cap">表 4-4: Linux 系统中的目录</caption>
<tr>
<th class="title">目录</th>
<th class="title">评论</th>
</tr>
<tr>
<td valign="top">/</td>
<td valign="top">根目录，万物起源。</td>
</tr>
<tr>
<td valign="top">/bin</td>
<td valign="top">包含系统启动和运行所必须的二进制程序。</td>
</tr>
<tr>
<td valign="top">/boot</td>
<td valign="top"><p>包含 Linux 内核，最初的 RAM 磁盘映像（系统启动时，由驱动程序所需），和
启动加载程序。</p>
<p>有趣的文件：</p>
<ul>
<li>/boot/grub/grub.conf or menu.lst， 被用来配置启动加载程序。</li>
<li>/boot/vmlinuz，Linux 内核。</li>
</ul>
</td>
</tr>
<tr>
<td valign="top">/dev</td>
<td valign="top">这是一个包含设备结点的特殊目录。“一切都是文件”，也使用于设备。
在这个目录里，内核维护着它支持的设备。</td>
</tr>
<tr>
<td valign="top">/etc</td>
<td valign="top"><p>这个目录包含所有系统层面的配置文件。它也包含一系列的 shell 脚本，
在系统启动时，这些脚本会运行每个系统服务。这个目录中的任何文件应该是可读的文本文件。</p>
<p>有意思的文件：虽然/etc 目录中的任何文件都有趣，但这里只列出了一些我一直喜欢的文件：</p>
<ul>
<li>/etc/crontab， 定义自动运行的任务。</li>
<li>/etc/fstab，包含存储设备的列表，以及与他们相关的挂载点。</li>
<li>/etc/passwd，包含用户帐号列表。 </li>
</ul>
</td>
</tr>
<tr>
<td valign="top">/home</td>
<td valign="top">在通常的配置环境下，系统会在/home 下，给每个用户分配一个目录。普通只能
在他们自己的目录下创建文件。这个限制保护系统免受错误的用户活动破坏。</td>
</tr>
<tr>
<td valign="top">/lib </td>
<td valign="top">包含核心系统程序所需的库文件。这些文件与 Windows 中的动态链接库相似。</td>
</tr>
<tr>
<td valign="top">/lost+found </td>
<td valign="top">每个使用 Linux 文件系统的格式化分区或设备，例如 ext3文件系统，
都会有这个目录。当部分恢复一个损坏的文件系统时，会用到这个目录。除非文件系统
真正的损坏了，那么这个目录会是个空目录。</td>
</tr>
<tr>
<td>/media </td>
<td>在现在的 Linux 系统中，/media 目录会包含可移除媒体设备的挂载点，
例如 USB 驱动器，CD-ROMs 等等。这些设备连接到计算机之后，会自动地挂载到这个目录结点下。
</td>
</tr>
<tr>
<td>/mnt</td>
<td>在早些的 Linux 系统中，/mnt 目录包含可移除设备的挂载点。</td>
</tr>
<tr>
<td>/opt</td>
<td>这个/opt 目录被用来安装“可选的”软件。这个主要用来存储可能
安装在系统中的商业软件产品。</td>
</tr>
<tr>
<td>/proc</td>
<td>这个/proc 目录很特殊。从存储在硬盘上的文件的意义上说，它不是真正的文件系统。
反而，它是一个由 Linux 内核维护的虚拟文件系统。它所包含的文件是内核的窥视孔。这些文件是可读的，
它们会告诉你内核是怎样监管计算机的。</td>
</tr>
<tr>
<td>/root</td>
<td>root 帐户的家目录。</td>
</tr>
<tr>
<td>/sbin</td>
<td>这个目录包含“系统”二进制文件。它们是完成重大系统任务的程序，通常为超级用户保留。</td>
</tr>
<tr>
<td>/tmp</td>
<td>这个/tmp 目录，是用来存储由各种程序创建的临时文件的地方。一些配置，导致系统每次
重新启动时，都会清空这个目录。</td>
</tr>
<tr>
<td>/usr</td>
<td>在 Linux 系统中，/usr 目录可能是最大的一个。它包含普通用户所需要的所有程序和文件。</td>
</tr>
<tr>
<td>/usr/bin</td>
<td>/usr/bin 目录包含系统安装的可执行程序。通常，这个目录会包含许多程序。</td>
</tr>
<tr>
<td>/usr/lib</td>
<td>包含由/usr/bin 目录中的程序所用的共享库。 </td>
</tr>
<tr>
<td>/usr/local</td>
<td>这个/usr/local 目录，是非系统发行版自带，却打算让系统使用的程序的安装目录。
通常，由源码编译的程序会安装在/usr/local/bin 目录下。新安装的 Linux 系统中，会存在这个目录，
但却是空目录，直到系统管理员放些东西到它里面。</td>
</tr>
<tr>
<td>/usr/sbin</td>
<td>包含许多系统管理程序。 </td>
</tr>
<tr>
<td>/usr/share</td>
<td>/usr/share 目录包含许多由/usr/bin 目录中的程序使用的共享数据。
其中包括像默认的配置文件，图标，桌面背景，音频文件等等。</td>
</tr>
<tr>
<td>/usr/share/doc</td>
<td>大多数安装在系统中的软件包会包含一些文档。在/usr/share/doc 目录下，
我们可以找到按照软件包分类的文档。</td>
</tr>
<tr>
<td>/var</td>
<td>除了/tmp 和/home 目录之外，相对来说，目前我们看到的目录是静态的，这是说，
它们的内容不会改变。/var 目录是可能需要改动的文件存储的地方。各种数据库，假脱机文件，
用户邮件等等，都驻扎在这里。</td>
</tr>
<tr>
<td>/var/log</td>
<td>这个/var/log 目录包含日志文件，各种系统活动的记录。这些文件非常重要，并且
应该时时监测它们。其中最重要的一个文件是/var/log/messages。注意，为了系统安全，在一些系统中，
你必须是超级用户才能查看这些日志文件。</td></tr>
</table>

### 符号链接

在我们到处查看时，我们可能会看到一个目录，列出像这样的一条信息：

    lrwxrwxrwx 1 root root 11 2007-08-11 07:34 libc.so.6 -> libc-2.6.so

注意看，为何这条信息第一个字符是“l”，并且有两个文件名呢？
这是一个特殊文件，叫做符号链接（也称为软链接或者 symlink ）。 在大多数“类 Unix” 系统中，
有可能一个文件被多个文件名所指向。虽然这种特性的意义并不明显，但它真地很有用。

描绘一下这样的情景：一个程序要求使用某个包含在名为“foo”文件中的共享资源，但是“foo”经常改变版本号。
这样，在文件名中包含版本号，会是一个好主意，因此管理员或者其它相关方，会知道安装了哪个“foo”版本。
这又会导致一个问题。如果我们更改了共享资源的名字，那么我们必须跟踪每个可能使用了
这个共享资源的程序，当每次这个资源的新版本被安装后，都要让使用了它的程序去寻找新的资源名。
这听起来很没趣。

这就是符号链接存在至今的原因。比方说，我们安装了文件 “foo” 的 2.6 版本，它的
文件名是 “foo-2.6”，然后创建了叫做 “foo” 的符号链接，这个符号链接指向 “foo-2.6”。
这意味着，当一个程序打开文件 “foo” 时，它实际上是打开文件 “foo-2.6”。
现在，每个人都很高兴。依赖于 “foo” 文件的程序能找到这个文件，并且我们能知道安装了哪个文件版本。
当升级到 “foo-2.7” 版本的时候，仅添加这个文件到文件系统中，删除符号链接 “foo”，
创建一个指向新版本的符号链接。这不仅解决了版本升级问题，而且还允许在系统中保存两个不同的文件版本。
假想 “foo-2.7” 有个错误（该死的开发者！），那我们得回到原来的版本。
一样的操作，我们只需要删除指向新版本的符号链接，然后创建指向旧版本的符号链接就可以了。

在上面列出的目录（来自于 Fedora 的 /lib 目录）展示了一个叫做 “libc.so.6” 的符号链接，这个符号链接指向一个
叫做 “libc-2.6.so” 的共享库文件。这意味着，寻找文件 “libc.so.6” 的程序，实际上得到是文件 “libc-2.6.so”。
在下一章节，我们将学习如何建立符号链接。

### 硬链接

讨论到链接问题，我们需要提一下，还有一种链接类型，叫做硬链接。硬链接同样允许文件有多个名字，
但是硬链接以不同的方法来创建多个文件名。在下一章中，我们会谈到更多符号链接与硬链接之间的差异问题。

### 拓展阅读

* 完整的 Linux 文件系统层次体系标准可通过以下链接找到：

    <http://www.pathname.com/fhs/>


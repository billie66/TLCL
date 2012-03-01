---
layout: book
title: 查找文件 
---

As we have wandered around our Linux system, one thing has become abundantly clear:
a typical Linux system has a lot of files! This begs the question, “how do we find
things?” We already know that the Linux file system is well organized according to
conventions that have been passed down from one generation of Unix-like system to the
next, but the sheer number of files can present a daunting problem.
In this chapter, we will look at two tools that are used to find files on a system. These
tools are:

因为我们已经浏览了Linux系统，所以一件事已经变得非常清楚：一个典型的Linux系统包含很多文件！
这就引发了一个问题，“我们怎样查找东西？”。虽然我们已经知道Linux文件系统良好的组织结构，是源自
类似于Unix的操作系统代代传承的习俗。但是仅文件数量就会引起可怕的问题。在这一章中，我们将察看
两个用来在系统中查找文件的工具。这些工具是：

* locate – Find files by name

* locate – 通过名字来查找文件 

* find – Search for files in a directory hierarchy

* find – 在目录层次结构中搜索文件

We will also look at a command that is often used with file search commands to process
the resulting list of files:

我们也将看一个经常与文件搜索命令一起使用的命令，它用来处理搜索到的文件列表：

* xargs – Build and execute command lines from standard input

* xargs – 从标准输入生成和执行命令行

In addition, we will introduce a couple of commands to assist us in or exploration:

另外，我们将介绍两个命令来协助我们探索：

* touch – Change file times

* touch – 更改文件时间

* stat – Display file or file system status

* stat – 显示文件或文件系统状态 

### locate – Find Files The Easy Way

### locate – 查找文件的简单方法 

The locate program performs a rapid database search of pathnames and outputs every
name that matches a given substring. Say, for example, we want to find all the programs
with names that begin with “zip.” Since we are looking for programs, we can assume
that the directory containing the programs would end with “bin/”. Therefore, we could
try to use locate this way to find our files:

这个locate程序快速搜索路径名数据库，并且输出每个与给定字符串相匹配的文件名。比如说，
例如，我们想要找到所有名字以“zip”开头的程序。因为我们正在查找程序，可以假定包含
匹配程序的目录以"bin/"结尾。因此，我们试着以这种方式使用locate命令，来找到我们的文件：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ locate bin/zip</tt>
</pre></div>

locate will search its database of pathnames and output any that contain the string “bin/zip”:

locate命令将会搜索它的路径名数据库，输出任一个包含字符串“bin/zip”的路径名：

<div class="code"><pre>
<tt>/usr/bin/zip
/usr/bin/zipcloak
/usr/bin/zipgrep
/usr/bin/zipinfo
/usr/bin/zipnote
/usr/bin/zipsplit</tt>
</pre></div>

If the search requirement is not so simple, locate can be combined with other tools
such as grep to design more interesting searches:

如果搜索要求没有这么简单，locate可以结合其它工具，比如说grep命令，来设计更加
有趣的搜索：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ locate zip | grep bin
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
/usr/bin/zipsplit</tt>
</pre></div>

The locate program has been around for a number of years, and there are several
different variants in common use. The two most common ones found in modern Linux
distributions are slocate and mlocate, though they are usually accessed by a
symbolic link named locate. The different versions of locate have overlapping
options sets. Some versions include regular expression matching (which we’ll cover in
an upcoming chapter) and wild card support. Check the man page for locate to
determine which version of locate is installed.

这个locate程序已经存在了很多年了，它有几个不同的变体被普遍使用着。在现在Linux
发行版中发现的两个最常见的变体是slocate和mlocate，但是通常它们被名为locate的
符号链接访问。不同版本的locate命令拥有重复的选项集合。一些版本包括正则表达式
匹配（我们会在下一章中讨论）和通配符支持。查看locate命令的手册，从而确定安装了
哪个版本的locate程序。

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>Where Does The locate Database Come From?</h3>

<h3>locate数据库来自何方？</h3>

<p> You may notice that, on some distributions, locate fails to work just
after the system is installed, but if you try again the next day, it works
fine. What gives?  The locate database is created by another program named
updatedb.  Usually, it is run periodically as a cron job; that is, a task
performed at regular intervals by the cron daemon. Most systems equipped
with locate run updatedb once a day. Since the database is not updated
continuously, you will notice that very recent files do not show up when using
locate. To overcome this, it’s possible to run the updatedb program manually
by becoming the superuser and running updatedb at the prompt.  </p> 

<p>你可能注意到了，在一些发行版中，仅仅在系统安装之后，locate不能工作，
但是如果你第二天再试一下，它就工作正常了。怎么回事呢？locate数据库由另一个叫做updatedb
的程序创建。通常，这个程序作为一个cron工作例程周期性运转；也就是说，一个任务
在特定的时间间隔内被cron守护进程执行。大多数装有locate的系统会每隔一天运行一回
updatedb程序。因为数据库不能被持续地更新，所以当使用locate时，你会发现
目前最新的文件不会出现。为了克服这个问题，有可能手动运行updatedb程序，
更改为超级用户身份，在提示符下运行updatedb命令。</p>

</td>
</tr> </table>

### find – Find Files The Hard Way

### find – 查找文件的复杂方式 

While the locate program can find a file based solely on its name, the find program
searches a given directory (and its subdirectories) for files based on a variety of
attributes. We’re going to spend a lot of time with find because it has a lot of
interesting features that we will see again and again when we start to cover programming
concepts in later chapters.

locate程序只能依据文件名来查找文件，而find程序能基于各种各样的属性，
搜索一个给定目录（以及它的子目录），来查找文件。我们将要花费大量的时间学习find命令，因为
它有许多有趣的特性，当我们开始在随后的章节里面讨论编程概念的时候，我们将会重复看到这些特性。

In its simplest use, find is given one or more names of directories to search. For
example, to produce a list of our home directory:

find命令的最简单使用是，搜索一个或多个目录。例如，输出我们的主目录列表。

<div class="code"><pre>
<tt>[me@linuxbox ~]$ find ~</tt>
</pre></div>

On most active user accounts, this will produce a large list. Since the list is sent to
standard output, we can pipe the list into other programs. Let’s use wc to count the
number of files:

对于最活跃的用户帐号，这将产生一张很大的列表。因为这张列表被发送到标准输出，
我们可以把这个列表管道到其它的程序中。让我们使用wc程序来计算出文件的数量：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ find ~ | wc -l
47068</tt>
</pre></div>

Wow, we’ve been busy! The beauty of find is that it can be used to identify files that
meet specific criteria. It does this through the (slightly strange) application of options,
tests, and actions. We’ll look at the tests first.

哇，我们一直很忙！find命令的美丽所在就是它能够被用来识别符合特定标准的文件。它通过
（有点奇怪）应用选项，测试，和操作来完成搜索。我们先看一下测试。

#### Tests

Let’s say that we want a list of directories from our search. To do this, we could add the
following test:

比如说我们想要目录列表。我们可以添加以下测试：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ find ~ -type d | wc -l
1695</tt>
</pre></div>

Adding the test -type d limited the search to directories. Conversely, we could have
limited the search to regular files with this test:

添加测试-type d限制了只搜索目录。相反地，我们使用这个测试来限定搜索普通文件：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ find ~ -type f | wc -l
38737</tt>
</pre></div>

Here are the common file type tests supported by find:

这里是find命令支持的普通文件类型测试：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 18-1: find File Types</caption>
<tr>
<th class="title">File Type </th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="25%">b</td>
<td valign="top">Block special device file
</td>
</tr>
<tr>
<td valign="top">c</td>
<td valign="top">Character special device file</td>
</tr>
<tr>
<td valign="top">d</td>
<td valign="top">Directory</td>
</tr>
<tr>
<td valign="top">f</td>
<td valign="top">Regular file</td>
</tr>
<tr>
<td valign="top">l</td>
<td valign="top">Symbolic link</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">表18-1: find文件类型</caption>
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
</p>

We can also search by file size and filename by adding some additional tests: Let’s look
for all the regular files that match the wild card pattern “\*.JPG” and are larger than one
megabyte:

我们也可以通过加入一些额外的测试，根据文件大小和文件名来搜索：让我们查找所有文件名匹配
通配符模式“\*.JPG”和文件大小大于1M的文件：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ find ~ -type f -name "\*.JPG" -size +1M | wc -l
840</tt>
</pre></div>

In this example, we add the -name test followed by the wild card pattern. Notice how
we enclose it in quotes to prevent pathname expansion by the shell. Next, we add the
-size test followed by the string “+1M”. The leading plus sign indicates that we are
looking for files larger than the specified number. A leading minus sign would change
the meaning of the string to be smaller than the specified number. No sign means,
“match the value exactly.” The trailing letter “M” indicates that the unit of measurement
is megabytes. The following characters may be used to specify units:

在这个例子里面，我们加入了-name测试，后跟通配符模式。注意，我们把它用双引号引起来，
从而阻止shell展开路径名。紧接着，我们加入-size测试，后跟字符串“+1M”。开头的加号表明
我们正在寻找文件大小大于指定数的文件。若字符串以减号开头，则意味着查找小于指定数的文件。
若没有符号意味着“精确匹配这个数”。结尾字母“M”表明测量单位是兆字节。下面的字符可以
被用来指定测量单位：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 18-2: find Size Units</caption>
<tr>
<th class="title">Character</th>
<th class="title">Unit</th>
</tr>
<tr>
<td valign="top" width="25%">b</td>
<td valign="top">512 byte blocks. This is the default if no unit is specified.</td>
</tr>
<tr>
<td valign="top">c</td>
<td valign="top">Bytes</td>
</tr>
<tr>
<td valign="top">w</td>
<td valign="top">Two byte words</td>
</tr>
<tr>
<td valign="top">k</td>
<td valign="top">Kilobytes (Units of 1024 bytes)</td>
</tr>
<tr>
<td valign="top">M</td>
<td valign="top">Megabytes (Units of 1048576 bytes)</td>
</tr>
<tr>
<td valign="top">G</td>
<td valign="top">Gigabytes (Units of 1073741824 bytes)</td>
</tr>
</table>
</p>

find supports a large number of different tests. Below is a rundown of the common
ones. Note that in cases where a numeric argument is required, the same “+” and “-”
notation discussed above can be applied:

find命令支持大量不同的测试。下表是列出了一些常见的测试。请注意，在需要数值参数的
情况下，可以应用以上讨论的“+”和"-"符号表示法：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 18-3: find Tests</caption>
<tr>
<th class="title">Test</th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="25%">-cmin n </td>
<td valign="top">Match files or directories whose content or attributes were
last modified exactly n minutes ago. To specify less than n
minutes ago, use -n and to specify more than n minutes
ago, use +n.</td>
</tr>
<tr>
<td valign="top">-cnewer file </td>
<td valign="top">Match files or directories whose contents or attributes were
last modified more recently than those of file.</td>
</tr>
<tr>
<td valign="top">-ctime n </td>
<td valign="top">Match files or directories whose contents or attributes were
last modified n\*24 hours ago.</td>
</tr>
<tr>
<td valign="top">-empty </td>
<td valign="top">Match empty files and directories.</td>
</tr>
<tr>
<td valign="top">-group name </td>
<td valign="top">Match file or directories belonging to group. group may
be expressed as either a group name or as a numeric group
ID.</td>
</tr>
<tr>
<td valign="top">-iname pattern </td>
<td valign="top">Like the -name test but case insensitive.</td>
</tr>
<tr>
<td valign="top">-inum n </td>
<td valign="top">Match files with inode number n. This is helpful for
finding all the hard links to a particular inode.</td>
</tr>
<tr>
<td valign="top">-mmin n </td>
<td valign="top">Match files or directories whose contents were modified n
minutes ago.</td>
</tr>
<tr>
<td valign="top">-mtime n </td>
<td valign="top">Match files or directories whose contents were modified
n\*24 hours ago.</td>
</tr>
<tr>
<td valign="top">-name pattern </td>
<td valign="top">Match files and directories with the specified wild card pattern.</td>
</tr>
<tr>
<td valign="top">-newer file </td>
<td valign="top">Match files and directories whose contents were modified
more recently than the specified file. This is very useful
when writing shell scripts that perform file backups. Each
time you make a backup, update a file (such as a log), then
use find to determine which files that have changed since
the last update.</td>
</tr>
<tr>
<td valign="top">-nouser </td>
<td valign="top">Match file and directories that do not belong to a valid user.
This can be used to find files belonging to deleted accounts
or to detect activity by attackers.</td>
</tr>
<tr>
<td valign="top">-nogroup </td>
<td valign="top">Match files and directories that do not belong to a valid
group.</td>
</tr>
<tr>
<td valign="top">-perm mode </td>
<td valign="top">Match files or directories that have permissions set to the
specified mode. mode may be expressed by either octal or
symbolic notation.</td>
</tr>
<tr>
<td valign="top">-samefile name </td>
<td valign="top">Similar to the -inum test. Matches files that share the
same inode number as file name.</td>
</tr>
<tr>
<td valign="top">-size n </td>
<td valign="top">Match files of size n.</td>
</tr>
<tr>
<td valign="top">-type c </td>
<td valign="top">Match files of type c.</td>
</tr>
<tr>
<td valign="top">-user name </td>
<td valign="top">Match files or directories belonging to user name. The
user may be expressed by a user name or by a numeric user
ID.</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">表18-3: find 测试</caption>
<tr>
<th class="title">测试</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top" width="25%">-cmin n </td>
<td valign="top">匹配的文件和目录的内容或属性最后修改时间正好在n分钟之前。
指定少于n分钟之前，使用-n，指定多于n分钟之前，使用+n。 </td>
</tr>
<tr>
<td valign="top">-cnewer file </td>
<td valign="top">匹配的文件和目录的内容或属性最后修改时间早于那些文件。 </td>
</tr>
<tr>
<td valign="top">-ctime n </td>
<td valign="top">匹配的文件和目录的内容和属性最后修改时间在n\*24小时之前。</td>
</tr>
<tr>
<td valign="top">-empty </td>
<td valign="top">匹配空文件和目录。</td>
</tr>
<tr>
<td valign="top">-group name </td>
<td valign="top">匹配的文件和目录属于一个组。组可以用组名或组ID来表示。</td>
</tr>
<tr>
<td valign="top">-iname pattern </td>
<td valign="top">就像-name测试，但是大小写敏感。</td>
</tr>
<tr>
<td valign="top">-inum n </td>
<td valign="top">匹配的文件的inode号是n。这对于找到某个特殊inode的所有硬链接很有帮助。 </td>
</tr>
<tr>
<td valign="top">-mmin n </td>
<td valign="top">匹配的文件或目录的内容被修改于n分钟之前。</td>
</tr>
<tr>
<td valign="top">-mtime n </td>
<td valign="top">匹配的文件或目录的内容被修改于n\*24小时之前。 </td>
</tr>
<tr>
<td valign="top">-name pattern </td>
<td valign="top">用指定的通配符模式匹配的文件和目录。</td>
</tr>
<tr>
<td valign="top">-newer file </td>
<td
valign="top">匹配的文件和目录的内容早于指定的文件。当编写shell脚本，做文件备份时，非常有帮助。
每次你制作一个备份，更新文件（比如说日志），然后使用find命令来决定自从上次更新，哪一个文件已经更改了。 </td>
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
<td valign="top">匹配的文件和目录的权限已经设置为指定的mode。mode可以用
八进制或符号表示法。</td>
</tr>
<tr>
<td valign="top">-samefile name </td>
<td valign="top">相似于-inum测试。匹配和文件name享有同样inode号的文件。 </td>
</tr>
<tr>
<td valign="top">-size n </td>
<td valign="top">匹配的文件大小为n。</td>
</tr>
<tr>
<td valign="top">-type c </td>
<td valign="top">匹配的文件类型是c。</td>
</tr>
<tr>
<td valign="top">-user name </td>
<td
valign="top">匹配的文件或目录属于某个用户。这个用户可以通过用户名或用户ID来表示。 </td>
</tr>
</table>
</p>

This is not a complete list. The find man page has all the details.

这不是一个完整的列表。find命令手册有更详细的说明。

#### Operators

#### 操作符

Even with all the tests that find provides, we may still need a better way to describe the
logical relationships between the tests. For example, what if we needed to determine if
all the files and subdirectories in a directory had secure permissions? We would look for
all the files with permissions that are not 0600 and the directories with permissions that
are not 0700. Fortunately, find provides a way to combine tests using logical operators
to create more complex logical relationships. To express the aforementioned test, we
could do this:

即使拥有了find命令提供的所有测试，我们还需要一个更好的方式来描述测试之间的逻辑关系。例如，
如果我们需要确定是否一个目录中的所有的文件和子目录拥有安全权限，怎么办呢？
我们可以查找权限不是0600的文件和权限不是0700的目录。幸运地是，find命令提供了
一种方法来结合测试，通过使用逻辑操作符来创建更复杂的逻辑关系。为了表达上述的测试，我们可以这样做：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ find ~ \( -type f -not -perm 0600 \) -or \( -type d -not -perm 0700 \)</tt>
</pre></div>

Yikes! That sure looks weird. What is all this stuff? Actually, the operators are not that
complicated once you get to know them. Here is the list:

呀！这的确看起来很奇怪。这些是什么东西？实际上，这些操作符没有那么复杂，一旦你知道了它们。
这里是操作符列表：

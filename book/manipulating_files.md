---
layout: book
title: 操作文件和目录 
---
At this point, we are ready for some real work! This chapter will introduce
the following commands:

此时此刻，我们已经准备好了做些真正的工作！在这一章节里，将会介绍一下命令：

* cp – Copy files and directories

* mv – Move/rename files and directories

* mkdir – Create directories

* rm – Remove files and directories

* ln – Create hard and symbolic links

* cp — 复制文件和目录

* mv — 移动/重命名文件和目录

* mkdir — 创建目录

* rm — 删除文件和目录

* ln — 创建硬链接和符号链接

These five commands are among the most frequently used Linux commands. They
are used for manipulating both files and directories.

这五个命令属于最常使用的Linux命令之列。它们用来操作文件和目录。

Now, to be frank, some of the tasks performed by these commands are more
easily done with a graphical file manager. With a file manager, we can drag and drop a
file from one directory to another, cut and paste files, delete files, etc. So why use these
old command line programs?

现在，坦诚地说，图形文件管理器来完成一些由这些命令执行的任务会更容易些。使用文件管理器，
我们可以把文件从一个目录拖放到另一个目录，剪贴和粘贴文件，删除文件，等等。那么，
为什么还使用早期的命令行程序呢？

The answer is power and flexibility. While it is easy to perform simple file
manipulations with a graphical file manager, complicated tasks can be easier with the
command line programs. For example, how could we copy all the HTML files from one directory
to another, but only copy files that do not exist in the destination directory or
are newer than the versions in the destination directory? Pretty hard with a file
manager. Pretty easy with the command line:

答案是命令行程序功能强大灵活。虽然图形文件管理器能轻松地实现简单的文件操作，但是对于
复杂的文件操作任务，则使用命令行程序比较容易完成。例如，怎样复制一个目录下的HTML文件
到另一个目录，这些HTML文件不存在于目标目录，或者是文件版本新于目标目录里的文件？
要完成这个任务，使用文件管理器相当难，使用命令行相当容易：

<div class="code"><pre>
<tt>cp -u *.html destination </tt>
</pre></div>

Wildcards

### 通配符

Before we begin using our commands, we need to talk about a shell feature that
makes these commands so powerful. Since the shell uses filenames so much, it
provides special characters to help you rapidly specify groups of filenames. These special
characters are called wildcards. Using wildcards (which is also known as globbing) allow you
to select filenames based on patterns of characters. The table below lists the wildcards
and what they select:

在开始使用命令之前，我们需要介绍一个使命令行如此强大的shell特性。因为shell频繁地使用
文件名，shell提供了特殊字符来帮助你快速指定一组文件名。这些特殊字符叫做通配符。
使用通配符（也以文件名代换著称）允许你依据字符类型来选择文件名。下表列出这些通配符
以及它们所选择的对象：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 5-1: Wildcards</caption>
<tr>
<th class="title">Wildcard</th>
<th class="title">Meaning</th>
</tr>
<tr>
<td valign="top">*</td>
<td valign="top">Matches any characters</td>
</tr>
<tr>
<td valign="top">?</td>
<td valign="top">Matches any single character</td>
</tr>
<tr>
<td valign="top">[characters]</td>
<td valign="top">Matches any character that is a member of the set characters</td>
</tr>
<tr>
<td valign="top">[!characters]</td>
<td valign="top">Matches any character that is not a member of the set
characters</td>
</tr>
<tr>
<td valign="top">[[:class:]]</td>
<td valign="top">Matches any character that is a member of the specified class</td>
</tr>
</table>
</p>
<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">表5－1：通配符</caption>
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
<td valign="top">[[:class:]]</td>
<td valign="top">匹配任意一个属于指定字符类中的字符</td>
</tr>
</table>
</p>

Table 5-2 lists the most commonly used character classes:

表5-2列出了最常使用的字符类：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 5-2: Commonly Used Character Classes</caption>
<tr>
<th class="title">Character Class</th>
<th class="title">Meaning</th>
</tr>
<tr>
<td valign="top">[:alnum:]</td>
<td valign="top">Matches any alphanumeric character</td>
</tr>
<tr>
<td valign="top">[:alpha:]</td>
<td valign="top">Matches any alphabetic character</td>
</tr>
<tr>
<td valign="top">[:digit:]</td>
<td valign="top">Matches any numeral</td>
</tr>
<tr>
<td valign="top">[:lower:]</td>
<td valign="top">Matches any lowercase letter</td>
</tr>
<tr>
<td valign="top">[:upper]</td>
<td valign="top">Matches any uppercase letter</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">表5－2：普遍使用的字符类</caption>
<tr>
<th class="title">字符类</th>
<th class="title">意义</th>
</tr>
<tr>
<td valign="top">[:alnum:]</td>
<td valign="top">匹配任意一个字母或数字</td>
</tr>
<tr>
<td valign="top">[:alpha:]</td>
<td valign="top">匹配任意一个字母</td>
</tr>
<tr>
<td valign="top">[:digit:]</td>
<td valign="top">匹配任意一个数字</td>
</tr>
<tr>
<td valign="top">[:lower:]</td>
<td valign="top">匹配任意一个小写字母</td>
</tr>
<tr>
<td valign="top">[:upper]</td>
<td valign="top">匹配任意一个大写字母</td>
</tr>
</table>
</p>

Using wildcards makes it possible to construct very sophisticated selection criteria for
filenames. Here are some examples of patterns and what they match:

借助通配符，为文件名构建非常复杂的选择标准成为可能。下面是一些类型匹配的范例:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 5-3: Wildcard Examples</caption>
<tr>
<th class="title">Pattern</th>
<th class="title">Matches</th>
</tr>
<tr>
<td valign="top">*</td>
<td valign="top">All files</td>
</tr>
<tr>
<td valign="top">g*</td>
<td valign="top">All file beginning with "g"</td>
</tr>
<tr>
<td valign="top">b*.txt</td>
<td valign="top">Any file beginning with "b" followed by any characters and
ending with ".txt"</td>
</tr>
<tr>
<td valign="top">Data???</td>
<td valign="top">Any file beginning with "Data" followed by exactly three
characters</td>
</tr>
<tr>
<td valign="top">[abc]*</td>
<td valign="top">Any file beginning with either an "a", a "b", or a "c"</td>
</tr>
<tr>
<td valign="top">BACKUP.[0-9][0-9][0-9]</td>
<td valign="top">Any file beginning with "BACKUP." followed by exactly three
numerals</td>
</tr>
<tr>
<td valign="top">[[:upper:]]*</td>
<td valign="top">Any file beginning with an uppercase letter</td>
</tr>
<tr>
<td valign="top">[![:digit:]]*</td>
<td valign="top">Any file not beginning with a numeral</td>
</tr>
<tr>
<td valign="top">*[[:lower:]123]</td>
<td valign="top">Any file ending with a lowercase letter or the numerals "1",
"2", or "3"</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">表5－3：通配符范例</caption>
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
<td valign="top">以数字开头的文件</td>
</tr>
<tr>
<td valign="top">*[[:lower:]123]</td>
<td valign="top">文件名以小写字母结尾，或以“1”，“2”，或“3”结尾的文件</td>
</tr>
</table>
</p>

Wildcards can be used with any command that accepts filenames as arguments, but we’ll
talk more about that in Chapter 8.

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>Character Ranges</h3>

<p>If you are coming from another Unix-like environment or have been reading
some other books on this subject, you may have encountered the [A-Z] or the
[a-z] character range notations. These are traditional Unix notations and
worked in older versions of Linux as well. They can still work, but you have to
be very careful with them because they will not produce the expected results
unless properly configured. For now, you should avoid using them and use
character classes instead.</p>

<h3>Wildcards Work In The GUI Too</h3>

<p>Wildcards are especially valuable not only because they are used so frequently on
the command line, but are also supported by some graphical file managers.</p>

<ul>
<li>In Nautilus (the file manager for GNOME), you can select files using the
Edit/Select Pattern menu item. Just enter a file selection pattern with
wildcards and the files in the currently viewed directory will be highlighted
for selection.</li>
<li>In Dolphin and Konqueror (the file managers for KDE), you can enter
wildcards directly on the location bar. For example, if you want to see all the
files starting with a lowercase “u” in the /usr/bin directory, type “/usr/bin/u*”
into the location bar and it will display the result.
</li>
</ul>

<p>Many ideas originally found in the command line interface make their way into
the graphical interface, too. It is one of the many things that make the Linux
desktop so powerful.
</p>
</td>
</tr>
</table>

### mkdir — Create Directories

The mkdir command is used to create directories. It works like this:

<div class="code"><pre>
<tt>mkdir directory...</tt>
</pre></div>

__A note on notation:__ When three periods follow an argument in the
description of a command (as above), it means that the argument can be
repeated, thus:

<div class="code"><pre>
<tt>mkdir dir1</tt>
</pre></div>

would create a single directory named "dir1", while

<div class="code"><pre>
<tt>mkdir dir1 dir2 dir3</tt>
</pre></div>

would create three directories named "dir1", "dir2", "dir3".

### cp — Copy Files And Directories

The cp command copies files or directories. It can be used two dfferent ways:

<div class="code"><pre>
<tt>cp item1 item2</tt>
</pre></div>

to copy the single file or directory “item1” to file or directory “item2” and:

<div class="code"><pre>
<tt>cp item... directory</tt>
</pre></div>

to copy multiple items (either files or directories) into a directory.

### Useful Options And Examples

Here are some of the commonly used options (the short option and the equivalent long
option) for cp:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 5-4: cp Options</caption>
<tr>
<th class="title">Option</th>
<th class="title">Meaning</th>
</tr>
<tr>
<td valign="top" width="25%">-a, --archive</td>
<td valign="top">Copy the files and directories and all of their attributes,
including ownerships and permissions. Normally, copies take on the default
attributes of the user performing the copy</td>
</tr>
<tr>
<td valign="top">-i, --interactive</td>
<td valign="top">Before overwriting an existing file, prompt the user for
confirmation. If this option is not specified, cp will
silently overwrite files.
</td>
</tr>
<tr>
<td valign="top">-r, --recursive</td>
<td valign="top">Recursively copy directories and their contents. This
option (or the -a option) is required when copying directories.
</td>
</tr>
<tr>
<td valign="top">-u, --update </td>
<td valign="top">When copying files from one directory to another, only
copy files that either don't exist, or are newer than the
existing corresponding files, in the destination
directory.</td>
</tr>
<tr>
<td valign="top">-v, --verbose</td>
<td valign="top">Display informative messages as the copy is
performed.</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 5-5: cp Examples</caption>
<tr>
<th class="title">Command</th>
<th class="title">Results</th>
</tr>
<tr>
<td valign="top" width="25%">cp file1 file2</td>
<td valign="top">Copy file1 to file2. If file2 exists, it is overwritten
with the contents of file1. If file2 does not exist, it is created.</td>
</tr>
<tr>
<td valign="top">cp -i file1 file2 </td>
<td valign="top">Same as above, except that if file2 exists, the user is
prompted before it is overwritten.</td>
</tr>
<tr>
<td valign="top">cp file1 file2 dir1 </td>
<td valign="top">Copy file1 and file2 into directory dir1. dir1 must
already exist.</td>
</tr>
<tr>
<td valign="top">cp dir1/* dir2 </td>
<td valign="top">Using a wildcard, all the files in dir1 are copied
into dir2. dir2 must already exist.</td>
</tr>
<tr>
<td valign="top">cp -r dir1 dir2 </td>
<td valign="top">Copy the contents of directory dir1 to directory
dir2. If directory dir2 does not exist, it is created
and, after the copy, will contain the same contents
as directory dir1.
If directory dir2 does exist, then directory dir1 (and
its contents) will be copied into dir2.
</td>
</tr>
</table>
</p>

### rm — Move And Rename Files

The mv command performs both file moving and file renaming, depending on how it is
used. In either case, the original filename no longer exists after the operation. mv is used
in much the same way as cp:

<div class="code"><pre>
<tt>rm item...</tt>
</pre></div>

where "item" is one or more files or directories.

### Useful Options And Examples

Here are some of the common options for rm:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 5-8: rm Options</caption>
<tr>
<th class="title">Option</th>
<th class="title">Meaning</th>
</tr>
<tr>
<td valign="top" width="25%">-i, --interactive </td>
<td valign="top">Before deleting an existing file, prompt the user for
confirmation. <em>If this option is not specified, rm will
silently delete files.</em></td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top"></td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top"></td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top"></td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 5-9: rm Examples</caption>
<tr>
<th class="title">Command</th>
<th class="title">Results</th>
</tr>
<tr>
<td valign="top" width="25%">text</td>
<td valign="top">text</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top"></td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top"></td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top"></td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top"></td>
</tr>
</table>
</p>

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>Be Careful With rm!</h3>
<p>Unix-like operating systems such as Linux do not have an undelete command.
Once you delete something with rm, it's gone. Linux assumes you're smart and
you know what you're doing.  </p>
<p>Be particularly careful with wildcards. Consider this classic example. Let's say
you want to delete just the HTML files in a directory. To do this, you type:  </p>
<p>rm *.html </p>
<p>which is correct, but if you accidentally place a space between the “*” and the
“.html” like so:</p>
<p>rm * .html</p>
<p>the rm command will delete all the files in the directory and then complain that
there is no file called “.html”.</p>
<p><em>Here is a useful tip.</em> Whenever you use wildcards with rm (besides carefully
checking your typing!), test the wildcard first with ls. This will let you see the
files that will be deleted. Then press the up arrow key to recall the command and
replace the ls with rm.</p>
</td>
</tr>
</table>

### In — Create Links

The ln command is used to create either hard or symbolic links. It is used in one of two
ways:

<div class="code"><pre>
<tt>ln file link</tt>
</pre></div>

to create a hard link, and:

<div class="code"><pre>
<tt>ln -s item link</tt>
</pre></div>

to create a symbolic link where "item" is either a file or a directory.

### Hard Links

Hard links are the original Unix way of creating links, compared to symbolic links, which
are more modern. By default, every file has a single hard link that gives the file its name.
When we create a hard link, we create an additional directory entry for a file. Hard links
have two important limitations:

1. A hard link cannot reference a file outside its own file system. This means a link
may not reference a file that is not on the same disk partition as the link itself.
2. A hard link may not reference a directory.

A hard link is indistinguishable from the file itself. Unlike a symbolic link, when you list
a directory containing a hard link you will see no special indication of the link. When a
hard link is deleted, the link is removed but the contents of the file itself continue to exist
(that is, its space is not deallocated) until all links to the file are deleted.
It is important to be aware of hard links because you might encounter them from time to
time, but modern practice prefers symbolic links, which we will cover next.

Symbolic Links

Symbolic links were created to overcome the limitations of hard links. Symbolic links
work by creating a special type of file that contains a text pointer to the referenced file or
directory. In this regard, they operate in much the same way as a Windows shortcut
though of course, they predate the Windows feature by many years ;-)

A file pointed to by a symbolic link, and the symbolic link itself are largely
indistinguishable from one another. For example, if you write some something to the
symbolic link, the referenced file is also written to. However when you delete a symbolic
link, only the link is deleted, not the file itself. If the file is deleted before the symbolic
link, the link will continue to exist, but will point to nothing. In this case, the link is said
to be broken. In many implementations, the ls command will display broken links in a
distinguishing color, such as red, to reveal their presence.

The concept of links can seem very confusing, but hang in there. We're going to try all
this stuff and it will, hopefully, become clear.

Let's Build A Playground

Since we are going to do some real file manipulation, let's build a safe place to “play”
with our file manipulation commands. First we need a directory to work in. We'll create
one in our home directory and call it “playground.”

Creating Directories

The mkdir command is used to create a directory. To create our playground directory
we will first make sure we are in our home directory and will then create the new
directory:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cd
[me@linuxbox ~]$ mkdir playground</tt>
</pre></div>

To make our playground a little more interesting, let's create a couple of directories inside
it called “dir1” and “dir2”. To do this, we will change our current working directory to
playground and execute another mkdir:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cd playground
[me@linuxbox playground]$ mkdir dir1 dir2</tt>
</pre></div>

Notice that the mkdir command will accept multiple arguments allowing us to create
both directories with a single command.

Copying Files

Next, let's get some data into our playground. We'll do this by copying a file. Using the
cp command, we'll copy the passwd file from the /etc directory to the current
working directory:

<div class="code"><pre>
<tt>[me@linuxbox playground]$ cp /etc/passwd .</tt>
</pre></div>



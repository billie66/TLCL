---
layout: book
title: 文本处理 
---

All Unix-like operating systems rely heavily on text files for several types of data
storage. So it makes sense that there are many tools for manipulating text. In this
chapter, we will look at programs that are used to “slice and dice” text. In the next
chapter, we will look at more text processing, focusing on programs that are used to
format text for printing and other kinds of human consumption.

所有类似于Unix的操作系统都非常依赖于被用于几种数据类型存储的文本文件。所以这很有道理，
有许多用于处理文本的工具。在这一章中，我们将看一些被用来“切割”文本的程序。在下一章中，
我们将查看更多的文本处理程序，但主要集中于文本格式化输出程序和其它一些人们需要的工具。

This chapter will revisit some old friends and introduce us to some new ones:

这一章会重新拜访一些老朋友，并且会给我们介绍一些新朋友：

* cat – Concatenate files and print on the standard output

* cat – 连接文件并且打印到标准输出

* sort – Sort lines of text files

* sort – 给文本行排序

* uniq – Report or omit repeated lines

* uniq – 报告或者省略重复行

* cut – Remove sections from each line of files

* cut – 从每行中删除

* paste – Merge lines of files

* paste – 合并文件行 

* join – Join lines of two files on a common field

* join –  

* comm – Compare two sorted files line by line

* comm – 按行比较两个有序的文件 

* diff – Compare files line by line

* diff – 按行比较文件

* patch – Apply a diff file to an original

* patch – 给原始文件打补丁

* tr – Translate or delete characters

* tr – 翻译或删除字符

* sed – Stream editor for filtering and transforming text

* sed – 用于筛选和转换文本的流编辑器

* aspell – Interactive spell checker

* aspell – 交互式拼写检查器

### Applications Of Text

### 文本应用程序 

So far, we have learned a couple of text editors (nano and vim), looked a bunch of
configuration files, and have witnessed the output of dozens of commands, all in text.
But what else is text used for? For many things, it turns out.

到目前为止，我们已经知道了一对文本编辑器（nano和vim），看过一堆配置文件，并且目睹了
许多命令的输出都是文本格式。但是文本还被用来做什么？ 它可以做很多事情。

#### Documents

Many people write documents using plain text formats. While it is easy to see how a
small text file could be useful for keeping simple notes, it is also possible to write large
documents in text format, as well. One popular approach is to write a large document in
a text format and then use a `markup language` to describe the formatting of the finished
document. Many scientific papers are written using this method, as Unix-based text
processing systems were among the first systems that supported the advanced
typographical layout needed by writers in technical disciplines.

许多人使用纯文本格式来编写文档。虽然很容易看到一个小的文本文件对于保存简单的笔记会
很有帮助，但是也有可能用文本格式来编写大的文档。一个流行的方法是先用文本格式来编写一个
大的文档，然后使用一种标记语言来描述已完成文档的格式。许多科学论文就是用这种方法编写的，
因为基于Unix的文本处理系统位于支持技术学科作家所需要的高级排版布局的一流系统之列。

#### Web Pages

The world’s most popular type of electronic document is probably the web page. Web
pages are text documents that use either HTML (Hypertext Markup Language) or XML
(Extensible Markup Language) as markup languages to describe the document’s visual
format.

世界上最流行的电子文档类型可能就是网页了。网页是文本文档，它们使用HTML（超文本标记语言）或者是XML
（可扩展的标记语言）作为标记语言来描述文档的可视格式。

#### Email

Email is an intrinsically text-based medium. Even non-text attachments are converted
into a text representation for transmission. We can see this for ourselves by downloading
an email message and then viewing it in less. We will see that the message begins with
a header that describes the source of the message and the processing it received during its
journey, followed by the body of the message with its content.

从本质上来说，email是一个基于文本的媒介。为了传输，甚至非文本的附件也被转换成文本表示形式。
我们能看到这些，通过下载一个email信息，然后用less来浏览它。我们将会看到这条信息开始于一个标题，
其描述了信息的来源以及在传输过程中它接受到的处理，然后是信息的正文内容。

#### Printer Output

On Unix-like systems, output destined for a printer is sent as plain text or, if the page
contains graphics, is converted into a text format page description language known as
PostScript, which is then sent to a program that generates the graphic dots to be printed.

在类似于Unix的系统中，输出会以纯文本格式发送到打印机，或者如果页面包含图形，其会被转换成
一种文本格式的页面描述语言，以PostScript著称，然后再被发送给一款能产生图形点阵的程序，
最后被打印出来。

#### Program Source Code

Many of the command line programs found on Unix-like systems were created to support
system administration and software development, and text processing programs are no
exception. Many of them are designed to solve software development problems. The
reason text processing is important to software developers is that all software starts out as
text. Source code, the part of the program the programmer actually writes, is always in
text format.

在类似于Unix系统中会发现许多命令行程序被用来支持系统管理和软件开发，并且文本处理程序也不例外。
许多文本处理程序被设计用来解决软件开发问题。文本处理对于软件开发者来言至关重要是因为所有的软件
都起始于文本格式。源代码，程序员实际编写的一部分程序，总是文本格式。

### Revisiting Some Old Friends

Back in Chapter 7 (Redirection), we learned about some commands that are able to
accept standard input in addition to command line arguments. We only touched on them
briefly then, but now we will take a closer look at how they can be used to perform text
processing.

回到第7章（重定向），我们已经知道一些命令除了接受命令行参数之外，还能够接受标准输入。
那时候我们只是简单地介绍了它们，但是现在我们将仔细地看一下它们是怎样被用来执行文本处理的。

#### cat

The cat program has a number of interesting options. Many of them are used to help
better visualize text content. One example is the -A option, which is used to display non-
printing characters in the text. There are times when we want to know if control
characters are embedded in our otherwise visible text. The most common of these are tab
characters (as opposed to spaces) and carriage returns, often present as end-of-line
characters in MS-DOS style text files. Another common situation is a file containing
lines of text with trailing spaces.

这个cat程序具有许多有趣的选项。其中许多选项用来帮助更好的可视化文本内容。一个例子是-A选项，
其用来在文本中显示非打印字符。有些时候我们想知道是否控制字符嵌入到了我们的可见文本中。
最常用的控制字符是tab字符（而不是空格）和回车字符，在MS-DOS风格的文本文件中回车符经常作为
结束符出现。另一种常见情况是文件中包含末尾带有空格的文本行。

Let’s create a test file using cat as a primitive word processor. To do this, we’ll just
enter the command cat (along with specifying a file for redirected output) and type our
text, followed by Enter to properly end the line, then Ctrl-d, to indicate to cat that
we have reached end-of-file. In this example, we enter a leading tab character and follow
the line with some trailing spaces:

让我们创建一个测试文件，用cat程序作为一个简单的文字处理器。为此，我们将键入cat命令（随后指定了
用于重定向输出的文件），然后输入我们的文本，最后按下Enter键来结束这一行，然后按下组合键Ctrl-d，
来指示cat程序，我们已经到达文件末尾了。在这个例子中，我们文本行的开头和末尾分别键入了一个tab字符以及一些空格。

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cat > foo.txt
    The quick brown fox jumped over the lazy dog.     
[me@linuxbox ~]$ </tt>
</pre></div>

Next, we will use cat with the -A option to display the text:

下一步，我们将使用带有-A选项的cat命令来显示这个文本：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cat -A foo.txt
^IThe quick brown fox jumped over the lazy dog.       $
[me@linuxbox ~]$        </tt>
</pre></div>

As we can see in the results, the tab character in our text is represented by ^I. This is a
common notation that means “Control-I” which, as it turns out, is the same as a tab
character. We also see that a $ appears at the true end of the line, indicating that our text
contains trailing spaces.

在输出结果中我们看到，这个tab字符在我们的文本中由^I字符来表示。这是一种常见的表示方法，意思是
“Control-I”，结果证明，它和tab字符是一样的。我们也看到一个$字符出现在文本行真正的结尾处，
表明我们的文本包含末尾的空格。

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>MS-DOS Text Vs. Unix Text </h3>

<h3>MS-DOS文本 Vs. Unix文本</h3>
<p> One of the reasons you may want to use cat to look for non-printing characters
in text is to spot hidden carriage returns. Where do hidden carriage returns come
from? DOS and Windows! Unix and DOS don’t define the end of a line the
same way in text files. Unix ends a line with a linefeed character (ASCII 10)
while MS-DOS and its derivatives use the sequence carriage return (ASCII 13)
and linefeed to terminate each line of text. </p>

<p>可能你想用cat程序在文本中查看非打印字符的一个原因是发现隐藏的回车符。那么
隐藏的回车符来自于哪里呢？它们来自于DOS和Windows！Unix和DOS在文本文件中定义每行
结束的方式不相同。Unix通过一个换行符（ASCII 10）来结束一行，然而MS-DOS和它的
衍生品使用回车（ASCII 13）和换行字符序列来终止每个文本行。</p>

<p> There are a several ways to convert files from DOS to Unix format. On many
Linux systems, there are programs called dos2unix and unix2dos, which can
convert text files to and from DOS format. However, if you don’t have
dos2unix on your system, don’t worry. The process of converting text from
DOS to Unix format is very simple; it simply involves the removal of the
offending carriage returns. That is easily accomplished by a couple of the
programs discussed later in this chapter.</p>

<p>有几种方法能够把文件从DOS格式转变为Unix格式。在许多Linux系统中，有两个
程序叫做dos2unix和unix2dos，它们能在两种格式之间转变文本文件。然而，如果你
的系统中没有安装dos2unix程序，也不要担心。文件从DOS格式转变为Unix格式的过程非常
简单；它只简单地涉及到删除违规的回车符。通过随后本章中讨论的一些程序，这个工作很容易
完成。</p>

</td>
</tr>
</table>

cat also has options that are used to modify text. The two most prominent are -n,
which numbers lines, and -s, which suppresses the output of multiple blank lines. We
can demonstrate thusly:

cat程序也包含用来修改文本的选项。最著名的两个选项是-n，其给文本行添加行号和-s，
禁止输出多个空白行。我们这样来说明：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cat > foo.txt
The quick brown fox


jumped over the lazy dog.
[me@linuxbox ~]$ cat -ns foo.txt
1   The quick brown fox
2
3   jumped over the lazy dog.
[me@linuxbox ~]$ </tt>
</pre></div>

In this example, we create a new version of our foo.txt test file, which contains two
lines of text separated by two blank lines. After processing by cat with the -ns options,
the extra blank line is removed and the remaining lines are numbered. While this is not
much of a process to perform on text, it is a process.

在这个例子里，我们创建了一个测试文件foo.txt的新版本，其包含两行文本，由两个空白行分开。
经由带有-ns选项的cat程序处理之后，多余的空白行被删除，并且对保留的文本行进行编号。
然而这并不是多个进程在操作这个文本，只有一个进程。

#### sort
 
The sort program sorts the contents of standard input, or one or more files specified on
the command line, and sends the results to standard output. Using the same technique
that we used with cat, we can demonstrate processing of standard input directly from
the keyboard:

这个sort程序对标准输入的内容，或命令行中指定的一个或多个文件进行排序，然后把排序
结果发送到标准输出。使用与cat命令相同的技巧，我们能够演示如何用sort程序来处理标准输入：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sort > foo.txt
c
b
a
[me@linuxbox ~]$ cat foo.txt
a
b
c </tt>
</pre></div>

After entering the command, we type the letters “c”, “b”, and “a”, followed once again by
Ctrl-d to indicate end-of-file. We then view the resulting file and see that the lines
now appear in sorted order.

输入命令之后，我们键入字母“c”，“b”，和“a”，然后再按下Ctrl-d组合键来表示文件的结尾。
随后我们查看生成的文件，看到文本行有序地显示。

Since sort can accept multiple files on the command line as arguments, it is possible to
merge multiple files into a single sorted whole. For example, if we had three text files
and wanted to combine them into a single sorted file, we could do something like this:

因为sort程序能接受命令行中的多个文件作为参数，所以有可能把多个文件合并成一个有序的文件。例如，
如果我们有三个文本文件，想要把它们合并为一个有序的文件，我们可以这样做：

<div class="code"><pre>
<tt><b>sort file1.txt file2.txt file3.txt > final_sorted_list.txt</b> </tt>
</pre></div>

sort has several interesting options. Here is a partial list:

sort程序有几个有趣的选项。这里只是一部分列表：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 21-1: Common sort Options</caption>
<tr>
<th class="title">Option</th>
<th class="title">Long Option</th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="20%">-b</td>
<td valign="top">--ignore-leading-blanks </td>
<td valign="top">By default, sorting is performed on the entire line,
starting with the first character in the line. This option causes sort to
ignore leading spaces in lines and calculates sorting based on the first
non-whitespace character on the line.</td>
</tr>
<tr>
<td valign="top">-f</td>
<td valign="top">--ignore-case </td>
<td valign="top">Makes sorting case insensitive.</td>
</tr>
<tr>
<td valign="top">-n</td>
<td valign="top">--numeric-sort</td>
<td valign="top">Performs sorting based on the numeric evaluation of a string.
Using this option allows sorting to be performed on numeric values rather than
alphabetic values.  </td>
</tr>
<tr>
<td valign="top">-r</td>
<td valign="top">--reverse </td>
<td valign="top">Sort in reverse order. Results are
in descending rather than ascending order.</td>
</tr>
<tr>
<td valign="top">-k</td>
<td valign="top">--key=field1[,field2] </td>
<td valign="top">Sort based on a key field located from field1 to field2
rather than the entire line. See discussion below.</td>
</tr>
<tr>
<td valign="top">-m</td>
<td valign="top">--merge</td>
<td valign="top">Treat each argument as the name of a presorted file.
Merge multiple files into a single sorted result without performing any
additional sorting. </td>
</tr>
<tr>
<td valign="top">-o</td>
<td valign="top">--output=file </td>
<td valign="top">Send sorted output to file rather than standard output.</td>
</tr>
<tr>
<td valign="top">-t</td>
<td valign="top">--field-separator=char </td>
<td valign="top">Define the field separator character. By default fields are
separated by spaces or tabs.</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">表21-1: 常见的sort程序选项</caption>
<tr>
<th class="title">选项</th>
<th class="title">长选项</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top" width="20%">-b</td>
<td valign="top">--ignore-leading-blanks </td>
<td valign="top"> 默认情况下，对整行进行排序，从每行的第一个字符开始。这个选项导致sort程序忽略
每行开头的空格，从第一个非空白字符开始排序。</td>
</tr>
<tr>
<td valign="top">-f</td>
<td valign="top">--ignore-case </td>
<td valign="top">让排序不区分大小写。</td>
</tr>
<tr>
<td valign="top">-n</td>
<td valign="top">--numeric-sort</td>
<td valign="top">基于字符串的长度来排序。使用此选项允许根据数字值执行排序，而不是字母值。</td>
</tr>
<tr>
<td valign="top">-r</td>
<td valign="top">--reverse </td>
<td valign="top">按相反顺序排序。结果按照降序排列，而不是升序。</td>
</tr>
<tr>
<td valign="top">-k</td>
<td valign="top">--key=field1[,field2] </td>
<td valign="top">对从field1到field2之间的字符排序，而不是整个文本行。看下面的讨论。 </td>
</tr>
<tr>
<td valign="top">-m</td>
<td valign="top">--merge</td>
<td
valign="top">把每个参数看作是一个预先排好序的文件。把多个文件合并成一个排好序的文件，而没有执行额外的排序。</td>
</tr>
<tr>
<td valign="top">-o</td>
<td valign="top">--output=file </td>
<td valign="top">把排好序的输出结果发送到文件，而不是标准输出。</td>
</tr>
<tr>
<td valign="top">-t</td>
<td valign="top">--field-separator=char </td>
<td valign="top">定义域分隔字符。默认情况下，域由空格或制表符分隔。</td>
</tr>
</table>
</p>

Although most of the options above are pretty self-explanatory, some are not. First, let’s
look at the -n option, used for numeric sorting. With this option, it is possible to sort
values based on numeric values. We can demonstrate this by sorting the results of the du
command to determine the largest users of disk space. Normally, the du command lists
the results of a summary in pathname order:

虽然以上大多数选项的含义是不言自喻的，但是有些也不是。首先，让我们看一下-n选项，被用做数值排序。
通过这个选项，有可能基于数值进行排序。我们通过对du命令的输出结果排序来说明这个选项，du命令可以
确定最大的磁盘空间用户。通常，这个du命令列出的输出结果按照路径名来排序：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ du -s /usr/share/\* | head
252     /usr/share/aclocal
96      /usr/share/acpi-support
8       /usr/share/adduser
196     /usr/share/alacarte
344     /usr/share/alsa
8       /usr/share/alsa-base
12488   /usr/share/anthy
8       /usr/share/apmd
21440   /usr/share/app-install
48      /usr/share/application-registry </tt>
</pre></div>

In this example, we pipe the results into head to limit the results to the first ten lines.
We can produce a numerically sorted list to show the ten largest consumers of space this
way:

在这个例子里面，我们把结果管道到head命令，把输出结果限制为前10行。我们能够产生一个按数值排序的
列表，来显示10个最大的空间消费者：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ du -s /usr/share/\* | sort -nr | head
509940         /usr/share/locale-langpack
242660         /usr/share/doc
197560         /usr/share/fonts
179144         /usr/share/gnome
146764         /usr/share/myspell
144304         /usr/share/gimp
135880         /usr/share/dict
76508          /usr/share/icons
68072          /usr/share/apps
62844          /usr/share/foomatic </tt>
</pre></div>

By using the -nr options, we produce a reverse numerical sort, with the largest values
appearing first in the results. This sort works because the numerical values occur at the
beginning of each line. But what if we want to sort a list based on some value found
within the line? For example, the results of an ls -l:

通过使用此-nr选项，我们产生了一个反向的数值排序，最大数值排列在第一位。这种排序起作用是
因为数值出现在每行的开头。但是如果我们想要基于文件行中的某个数值排序，又会怎样呢？
例如，命令ls -l的输出结果：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls -l /usr/bin | head
total 152948
-rwxr-xr-x 1 root   root     34824  2008-04-04  02:42 [
-rwxr-xr-x 1 root   root    101556  2007-11-27  06:08 a2p
...</tt>
</pre></div>

Ignoring, for the moment, that ls can sort its results by size, we could use sort to sort
this list by file size, as well:

此刻，忽略ls程序能按照文件大小对输出结果进行排序，我们也能够使用sort程序来完成此任务：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls -l /usr/bin | sort -nr -k 5 | head
-rwxr-xr-x 1 root   root   8234216  2008-04-0717:42 inkscape
-rwxr-xr-x 1 root   root   8222692  2008-04-07 17:42 inkview
...</tt>
</pre></div>

Many uses of sort involve the processing of tabular data, such as the results of the ls
command above. If we apply database terminology to the table above, we would say that
each row is a record and that each record consists of multiple fields, such as the file
attributes, link count, filename, file size and so on. sort is able to process individual
fields. In database terms, we are able to specify one or more key fields to use as sort keys.
In the example above, we specify the n and r options to perform a reverse numerical sort
and specify -k 5 to make sort use the fifth field as the key for sorting.

sort程序的许多用法都涉及到处理表格数据，例如上面ls命令的输出结果。如果我们
把数据库这个术语应用到上面的表格中，我们会说每行是一条记录，并且每条记录由多个字段组成，
例如文件属性，链接数，文件名，文件大小等等。sort程序能够处理独立的字段。在数据库术语中，
我们能够指定一个或者多个关键字段，来作为排序的关键值。在上面的例子中，我们指定
n和r选项来执行相反的数值排序，并且指定-k 5，让sort程序使用第五字段作为排序的关键值。

The k option is very interesting and has many features, but first we need to talk about
how sort defines fields. Let’s consider a very simple text file consisting of a single line
containing the author’s name:

这个k选项非常有趣，而且还有很多特点，但是首先我们需要讲讲sort程序怎样来定义字段。
让我们考虑一个非常简单的文本文件，只有一行包含作者名字的文本。

<div class="code"><pre>
<tt>William      Shotts </tt>
</pre></div>

By default, sort sees this line as having two fields. The first field contains the characters:

默认情况下，sort程序把此行看作有两个字段。第一个字段包含字符：

“William”

and the second field contains the characters:

和第二个字段包含字符：

“     Shotts”

meaning that whitespace characters (spaces and tabs) are used as delimiters between
fields and that the delimiters are included in the field when sorting is performed.
Looking again at a line from our ls output, we can see that a line contains eight fields
and that the fifth field is the file size:

意味着空白字符（空格和制表符）被当作是字段间的界定符，当执行排序时，界定符会被
包含在字段当中。再看一下ls命令的输出，我们看到每行包含八个字段，并且第五个字段是文件大小：

<div class="code"><pre>
<tt>-rwxr-xr-x 1 root root 8234216 2008-04-07 17:42 inkscape </tt>
</pre></div>

For our next series of experiments, let’s consider the following file containing the history
of three popular Linux distributions released from 2006 to 2008. Each line in the file has
three fields: the distribution name, version number, and date of release in
MM/DD/YYYY format:

让我们考虑用下面的文件，其包含从2006年到2008年三款流行的Linux发行版的发行历史，来做一系列实验。
文件中的每一行都有三个字段：发行版的名称，版本号，和MM/DD/YYYY格式的发行日期：

<div class="code"><pre>
<tt>SUSE        10.2   12/07/2006
Fedora          10     11/25/2008
SUSE            11.04  06/19/2008
Ubuntu          8.04   04/24/2008
Fedora          8      11/08/2007
SUSE            10.3   10/04/2007 
...</tt>
</pre></div>

Using a text editor (perhaps vim), we’ll enter this data and name the resulting file
distros.txt.

使用一个文本编辑器（可能是vim），我们将输入这些数据，并把产生的文件命名为distros.txt。

Next, we’ll try sorting the file and observe the results:

下一步，我们将试着对这个文件进行排序，并观察输出结果：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sort distros.txt
Fedora          10     11/25/2008
Fedora          5     03/20/2006
Fedora          6     10/24/2006
Fedora          7     05/31/2007
Fedora          8     11/08/2007
...</tt>
</pre></div>

Well, it mostly worked. The problem occurs in the sorting of the Fedora version
numbers. Since a “1” comes before a “5” in the character set, version “10” ends up at the
top while version “9” falls to the bottom.

恩，大部分正确。问题出现在Fedora的版本号上。因为在字符集中“1”出现在“5”之前，版本号“10”在
最顶端，然而版本号“9”却掉到底端。

To fix this problem we are going to have to sort on multiple keys. We want to perform an
alphabetic sort on the first field and then a numeric sort on the third field. sort allows
multiple instances of the -k option so that multiple sort keys can be specified. In fact, a
key may include a range of fields. If no range is specified (as has been the case with our
previous examples), sort uses a key that begins with the specified field and extends to
the end of the line. Here is the syntax for our multi-key sort:

为了解决这个问题，我们必须依赖多个键值来排序。我们想要对第一个字段执行字母排序，然后对
第三个字段执行数值排序。sort程序允许多个-k选项的实例，所以可以指定多个排序关键值。事实上，
一个关键值可能包括一个字段区域。如果没有指定区域（如同之前的例子），sort程序会使用一个键值，
其始于指定的字段，一直扩展到行尾。下面是多键值排序的语法：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sort --key=1,1 --key=2n distros.txt
Fedora         5     03/20/2006
Fedora         6     10/24/2006
Fedora         7     05/31/2007
...  </tt>
</pre></div>

Though we used the long form of the option for clarity, -k 1,1 -k 2n would be
exactly equivalent. In the first instance of the key option, we specified a range of fields
to include in the first key. Since we wanted to limit the sort to just the first field, we
specified 1,1 which means “start at field one and end at field one.” In the second
instance, we specified 2n, which means that field two is the sort key and that the sort
should be numeric. An option letter may be included at the end of a key specifier to
indicate the type of sort to be performed. These option letters are the same as the global
options for the sort program: b (ignore leading blanks), n (numeric sort), r (reverse
sort), and so on.

虽然为了清晰，我们使用了选项的长格式，但是-k 1,1 -k 2n格式是等价的。在第一个key选项的实例中，
我们指定了一个字段区域。因为我们只想对第一个字段排序，我们指定了1,1，
意味着“始于并且结束于第一个字段。”在第二个实例中，我们指定了2n，意味着第二个字段是排序的键值，
并且按照数值排序。一个选项字母可能被包含在一个键值说明符的末尾，其用来指定排序的种类。这些
选项字母和sort程序的全局选项一样：b（忽略开头的空格），n（数值排序），r（逆向排序），等等。

The third field in our list contains a date in an inconvenient format for sorting. On
computers, dates are usually formatted in YYYY-MM-DD order to make chronological
sorting easy, but ours are in the American format of MM/DD/YYYY. How can we sort
this list in chronological order?

我们列表中第三个字段包含的日期格式不利于排序。在计算机中，日期通常设置为YYYY-MM-DD格式，
这样使按时间顺序排序变得容易，但是我们的日期为美国格式MM/DD/YYYY。那么我们怎样能按照
时间顺序来排列这个列表呢？

Fortunately, sort provides a way. The key option allows specification of offsets within
fields, so we can define keys within fields:

幸运地是，sort程序提供了一种方式。这个key选项允许在字段中指定偏移量，所以我们能在字段中
定义键值。

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sort -k 3.7nbr -k 3.1nbr -k 3.4nbr distros.txt
Fedora         10    11/25/2008
Ubuntu         8.10  10/30/2008
SUSE           11.0  06/19/2008
...</tt>
</pre></div>

By specifying -k 3.7 we instruct sort to use a sort key that begins at the seventh
character within the third field, which corresponds to the start of the year. Likewise, we
specify -k 3.1 and -k 3.4 to isolate the month and day portions of the date. We also
add the n and r options to achieve a reverse numeric sort. The b option is included to
suppress the leading spaces (whose numbers vary from line to line, thereby affecting the
outcome of the sort) in the date field.

通过指定-k 3.7，我们指示sort程序使用一个排序键值，其始于第三个字段中的第七个字符，对应于
年的开头。同样地，我们指定-k 3.1和-k 3.4来分离日期中的月和日。
我们也添加了n和r选项来实现一个逆向的数值排序。这个b选项用来删除日期字段中开头的空格（
行与行之间的空格数迥异，因此会影响sort程序的输出结果）。

Some files don’t use tabs and spaces as field delimiters; for example, the /etc/passwd
file:

一些文件不会使用tabs和空格做为字段界定符；例如，这个/etc/passwd文件：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ head /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/bin/sh
bin:x:2:2:bin:/bin:/bin/sh
sys:x:3:3:sys:/dev:/bin/sh
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/bin/sh
man:x:6:12:man:/var/cache/man:/bin/sh
lp:x:7:7:lp:/var/spool/lpd:/bin/sh
mail:x:8:8:mail:/var/mail:/bin/sh
news:x:9:9:news:/var/spool/news:/bin/sh</tt>
</pre></div>

The fields in this file are delimited with colons (:), so how would we sort this file using a
key field? sort provides the -t option to define the field separator character. To sort
the passwd file on the seventh field (the account’s default shell), we could do this:

这个文件的字段之间通过冒号分隔开，所以我们怎样使用一个key字段来排序这个文件？sort程序提供
了一个-t选项来定义分隔符。按照第七个字段（帐户的默认shell）来排序此passwd文件，我们可以这样做：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sort -t ':' -k 7 /etc/passwd | head
me:x:1001:1001:Myself,,,:/home/me:/bin/bash
root:x:0:0:root:/root:/bin/bash
dhcp:x:101:102::/nonexistent:/bin/false
gdm:x:106:114:Gnome Display Manager:/var/lib/gdm:/bin/false
hplip:x:104:7:HPLIP system user,,,:/var/run/hplip:/bin/false
klog:x:103:104::/home/klog:/bin/false
messagebus:x:108:119::/var/run/dbus:/bin/false
polkituser:x:110:122:PolicyKit,,,:/var/run/PolicyKit:/bin/false
pulse:x:107:116:PulseAudio daemon,,,:/var/run/pulse:/bin/false</tt>
</pre></div>

By specifying the colon character as the field separator, we can sort on the seventh field.

通过指定冒号字符做为字段分隔符，我们能按照第七个字段来排序。

####uniq

Compared to sort, the uniq program is a lightweight. uniq performs a seemingly
trivial task. When given a sorted file (including standard input), it removes any duplicate
lines and sends the results to standard output. It is often used in conjunction with sort
to clean the output of duplicates.

与sort程序相比，这个uniq程序是个轻量级程序。uniq执行一个看似琐碎的认为。当给定一个
排好序的文件（包括标准输出），uniq会删除任意重复行，并且把结果发送到标准输出。
它常常和sort程序一块使用，来清理重复的输出。

<hr style="height:5px;width:100%;background:gray" />
<b>Tip:</b> While uniq is a traditional Unix tool often used with sort, the GNU version
of sort supports a -u option, which removes duplicates from the sorted output.

uniq程序是一个传统的Unix工具，经常与sort程序一块使用，但是这个GNU版本的sort程序支持一个-u选项，
其可以从排好序的输出结果中删除重复行。
<hr style="height:5px;width:100%;background:gray" />

Let’s make a text file to try this out:

让我们创建一个文本文件，来实验一下：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cat > foo.txt
a
b
c
a
b
c</tt>
</pre></div>

Remember to type Ctrl-d to terminate standard input. Now, if we run uniq on our
text file:

记住输入Ctrl-d来终止标准输入。现在，如果我们对文本文件执行uniq命令：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ uniq foo.txt
a
b
c
a
b
c</tt>
</pre></div>

the results are no different from our original file; the duplicates were not removed. For
uniq to actually do its job, the input must be sorted first:

输出结果与原始文件没有差异；重复行没有被删除。实际上，uniq程序能完成任务，其输入必须是排好序的数据，

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sort foo.txt | uniq
a
b
c</tt>
</pre></div>

This is because uniq only removes duplicate lines which are adjacent to each other.
uniq has several options. Here are the common ones:

这是因为uniq只会删除相邻的重复行。uniq程序有几个选项。这里是一些常用选项：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 21-2: Common uniq Options</caption>
<tr>
<th class="title">Option</th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="25%">-c</td>
<td valign="top">Output a list of duplicate lines preceded by the number of times the
line occurs.</td>
</tr>
<tr>
<td valign="top">-d</td>
<td valign="top">Only output repeated lines, rather than unique lines.</td>
</tr>
<tr>
<td valign="top">-f n</td>
<td valign="top">Ignore n leading fields in each line. Fields are separated by
whitespace as they are in sort; however, unlike sort, uniq has
no option for setting an alternate field separator.</td>
</tr>
<tr>
<td valign="top">-i</td>
<td valign="top">Ignore case during the line comparisons.</td>
</tr>
<tr>
<td valign="top">-s n</td>
<td valign="top">Skip (ignore) the leading n characters of each line.</td>
</tr>
<tr>
<td valign="top">-u</td>
<td valign="top">Only output unique lines. This is the default.</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">表21-2: 常用的uniq选项</caption>
<tr>
<th class="title">选项</th>
<th class="title">说明</th>
</tr>
<tr>
<td valign="top" width="25%">-c</td>
<td valign="top">输出所有的重复行，并且每行开头显示重复的次数。 </td>
</tr>
<tr>
<td valign="top">-d</td>
<td valign="top">只输出重复行，而不是特有的文本行。</td>
</tr>
<tr>
<td valign="top">-f n</td>
<td valign="top">忽略每行开头的n个字段，字段之间由空格分隔，正如sort程序中的空格分隔符；然而，
不同于sort程序，uniq没有选项来设置备用的字段分隔符。 </td>
</tr>
<tr>
<td valign="top">-i</td>
<td valign="top">在比较文本行的时候忽略大小写。</td>
</tr>
<tr>
<td valign="top">-s n</td>
<td valign="top">跳过（忽略）每行开头的n个字符。</td>
</tr>
<tr>
<td valign="top">-u</td>
<td valign="top">只是输出独有的文本行。这是默认的。</td>
</tr>
</table>
</p>

Here we see uniq used to report the number of duplicates found in our text file, using
the -c option:

这里我们看到uniq被用来报告文本文件中重复行的次数，使用这个-c选项：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sort foo.txt | uniq -c
        2 a
        2 b
        2 c</tt>
</pre></div>

###Slicing And Dicing

The next three programs we will discuss are used to peel columns of text out of files and
recombine them in useful ways.

下面我们将要讨论的三个程序被用来

####cut

The cut program is used to extract a section of text from a line and output the extracted
section to standard output. It can accept multiple file arguments or input from standard
input.

Specifying the section of the line to be extracted is somewhat awkward and is specified
using the following options:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 21-3: cut Selection Options
</caption>
<tr>
<th class="title">Option</th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="25%">-c char\_list </td>
<td valign="top">Extract the portion of the line defined by char\_list. The list
may consist of one or more comma-separated numerical ranges.</td>
</tr>
<tr>
<td valign="top">-f field\_list</td>
<td valign="top">Extract one or more fields from the line as defined by
field\_list. The list may contain one or more fields or field
ranges separated by commas.</td>
</tr>
<tr>
<td valign="top">-d delim\_char </td>
<td valign="top">When -f is specified, use delim\_char as the field delimiting
character. By default, fields must be separated by a single tab
character.</td>
</tr>
<tr>
<td valign="top">--complement </td>
<td valign="top">Extract the entire line of text, except for those portions
specified by -c and/or -f.</td>
</tr>
</table>
</p>

As we can see, the way cut extracts text is rather inflexible. cut is best used to extract
text from files that are produced by other programs, rather than text directly typed by
humans. We’ll take a look at our distros.txt file to see if it is “clean” enough to be
a good specimen for our cut examples. If we use cat with the -A option, we can see if
the file meets our requirements of tab separated fields:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cat -A distros.txt
SUSE^I10.2^I12/07/2006$
Fedora^I10^I11/25/2008$
SUSE^I11.0^I06/19/2008$
Ubuntu^I8.04^I04/24/2008$
Fedora^I8^I11/08/2007$
SUSE^I10.3^I10/04/2007$
Ubuntu^I6.10^I10/26/2006$
Fedora^I7^I05/31/2007$
Ubuntu^I7.10^I10/18/2007$
Ubuntu^I7.04^I04/19/2007$
SUSE^I10.1^I05/11/2006$
Fedora^I6^I10/24/2006$
Fedora^I9^I05/13/2008$
Ubuntu^I6.06^I06/01/2006$
Ubuntu^I8.10^I10/30/2008$
Fedora^I5^I03/20/2006$</tt>
</pre></div>

It looks good. No embedded spaces, just single tab characters between the fields. Since
the file uses tabs rather than spaces, we’ll use the -f option to extract a field:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cut -f 3 distros.txt
12/07/2006
11/25/2008
06/19/2008
04/24/2008
11/08/2007
10/04/2007
10/26/2006
05/31/2007
10/18/2007
04/19/2007
05/11/2006
10/24/2006
05/13/2008
06/01/2006
10/30/2008
03/20/2006</tt>
</pre></div>

Because our distros file is tab-delimited, it is best to use cut to extract fields rather
than characters. This is because when a file is tab-delimited, it is unlikely that each line
will contain the same number of characters, which makes calculating character positions
within the line difficult or impossible. In our example above, however, we now have
extracted a field that luckily contains data of identical length, so we can show how
character extraction works by extracting the year from each line:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cut -f 3 distros.txt | cut -c 7-10
2006
2008
2008
2008
2007
2007
2006
2007
2007
2007
2006
2006
2008
2006
2008
2006</tt>
</pre></div>

By running cut a second time on our list, we are able to extract character positions 7
through 10, which corresponds to the year in our date field. The 7-10 notation is an
example of a range. The cut man page contains a complete description of how ranges
can be specified.

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>Expanding Tabs</h3>
<p>Our distros.txt file is ideally formatted for extracting fields using cut. But
what if we wanted a file that could be fully manipulated with cut by characters,
rather than fields? This would require us to replace the tab characters within the
file with the corresponding number of spaces. Fortunately, the GNU Coreutils
package includes a tool for that. Named expand, this program accepts either
one or more file arguments or standard input, and outputs the modified text to
standard output.</p>
<p>If we process our distros.txt file with expand, we can use the cut -c to
extract any range of characters from the file. For example, we could use the
following command to extract the year of release from our list, by expanding the
file and using cut to extract every character from the twenty-third position to the
end of the line: </p>
<p> [me@linuxbox ~]$ expand distros.txt | cut -c 23- </p>
<p>Coreutils also provides the unexpand program to substitute tabs for
spaces.</p>
</td>
</tr>
</table>

When working with fields, it is possible to specify a different field delimiter rather than
the tab character. Here we will extract the first field from the /etc/passwd file:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cut -d ':' -f 1 /etc/passwd | head
root
daemon
bin
sys
sync
games
man
lp
mail
news</tt>
</pre></div>

Using the -d option, we are able to specify the colon character as the field delimiter.

paste

The paste command does the opposite of cut. Rather than extracting a column of text
from a file, it adds one or more columns of text to a file. It does this by reading multiple
files and combining the fields found in each file into a single stream on standard output.
Like cut, paste accepts multiple file arguments and/or standard input. To demonstrate
how paste operates, we will perform some surgery on our distros.txt file to
produce a chronological list of releases.

From our earlier work with sort, we will first produce a list of distros sorted by date
and store the result in a file called distros-by-date.txt:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sort -k 3.7nbr -k 3.1nbr -k 3.4nbr distros.txt > distros-by-date.txt </tt>
</pre></div>

Next, we will use cut to extract the first two fields from the file (the distro name and
version), and store that result in a file named distro-versions.txt:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cut -f 1,2 distros-by-date.txt > distros-versions.txt
[me@linuxbox ~]$ head distros-versions.txt
Fedora     10
Ubuntu     8.10
SUSE       11.0
Fedora     9
Ubuntu     8.04
Fedora     8
Ubuntu     7.10
SUSE       10.3
Fedora     7
Ubuntu     7.04

</tt>
</pre></div>

The final piece of preparation is to extract the release dates and store them a file named
distro-dates.txt:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cut -f 3 distros-by-date.txt > distros-dates.txt
[me@linuxbox ~]$ head distros-dates.txt
11/25/2008
10/30/2008
06/19/2008
05/13/2008
04/24/2008
11/08/2007
10/18/2007
10/04/2007
05/31/2007
04/19/2007</tt>
</pre></div>

We now have the parts we need. To complete the process, use paste to put the column
of dates ahead of the distro names and versions, thus creating a chronological list. This is
done simply by using paste and ordering its arguments in the desired arrangement:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ paste distros-dates.txt distros-versions.txt
11/25/2008	Fedora     10
10/30/2008	Ubuntu     8.10
06/19/2008	SUSE       11.0
05/13/2008	Fedora     9
04/24/2008	Ubuntu     8.04
11/08/2007	Fedora     8
10/18/2007	Ubuntu     7.10
10/04/2007	SUSE       10.3
05/31/2007	Fedora     7
04/19/2007	Ubuntu     7.04 </tt>
</pre></div>

join

In some ways, join is like paste in that it adds columns to a file, but it uses a unique
way to do it. A join is an operation usually associated with relational databases where
data from multiple tables with a shared key field is combined to form a desired result.
The join program performs the same operation. It joins data from multiple files based
on a shared key field.

To see how a join operation is used in a relational database, let’s imagine a very small
database consisting of two tables each containing a single record. The first table, called
CUSTOMERS, has three fields: a customer number (CUSTNUM), the customer’s first
name (FNAME) and the customer’s last name (LNAME):

The second table is called ORDERS and contains four fields: an order number
(ORDERNUM), the customer number (CUSTNUM), the quantity (QUAN), and the item
ordered (ITEM).

Note that both tables share the field CUSTNUM. This is important, as it allows a
relationship between the tables.

Performing a join operation would allow us to combine the fields in the two tables to
achieve a useful result, such as preparing an invoice. Using the matching values in the
CUSTNUM fields of both tables, a join operation could produce the following:

To demonstrate the join program, we’ll need to make a couple of files with a shared
key. To do this, we will use our distros-by-date.txt file. From this file, we will
construct two additional files, one containing the release date (which will be our shared
key for this demonstration) and the release name:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cut -f 1,1 distros-by-date.txt > distros-names.txt
[me@linuxbox ~]$ paste distros-dates.txt distros-names.txt > distros-key-names.txt
[me@linuxbox ~]$ head distros-key-names.txt
11/25/2008 Fedora
10/30/2008 Ubuntu
06/19/2008 SUSE
05/13/2008 Fedora
04/24/2008 Ubuntu
11/08/2007 Fedora
10/18/2007 Ubuntu
10/04/2007 SUSE
05/31/2007 Fedora
04/19/2007 Ubuntu</tt>
</pre></div>

and the second file, which contains the release dates and the version numbers:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cut -f 2,2 distros-by-date.txt > distros-vernums.txt
[me@linuxbox ~]$ paste distros-dates.txt distros-vernums.txt > distros-key-vernums.txt
[me@linuxbox ~]$ head distros-key-vernums.txt
11/25/2008 10
10/30/2008 8.10
06/19/2008 11.0
05/13/2008 9
04/24/2008 8.04
11/08/2007 8
10/18/2007 7.10
10/04/2007 10.3
05/31/2007 7
04/19/2007 7.04</tt>
</pre></div>

We now have two files with a shared key (the “release date” field). It is important to
point out that the files must be sorted on the key field for join to work properly.

<div class="code"><pre>
<tt>[me@linuxbox ~]$ join distros-key-names.txt distros-key-vernums.txt | head
11/25/2008 Fedora 10
10/30/2008 Ubuntu 8.10
06/19/2008 SUSE 11.0
05/13/2008 Fedora 9
04/24/2008 Ubuntu 8.04
11/08/2007 Fedora 8
10/18/2007 Ubuntu 7.10
10/04/2007 SUSE 10.3
05/31/2007 Fedora 7
04/19/2007 Ubuntu 7.04</tt>
</pre></div>

Note also that, by default, join uses whitespace as the input field delimiter and a single
space as the output field delimiter. This behavior can be modified by specifying options.
See the join man page for details.

Comparing Text

It is often useful to compare versions of text files. For system administrators and
software developers, this is particularly important. A system administrator may, for
example, need to compare an existing configuration file to a previous version to diagnose
a system problem. Likewise, a programmer frequently needs to see what changes have
been made to programs over time.

comm

The comm program compares two text files and displays the lines that are unique to each
one and the lines they have in common. To demonstrate, we will create two nearly
identical text files using cat:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cat > file1.txt
a
b
c
d
[me@linuxbox ~]$ cat > file2.txt
b
c
d
e</tt>
</pre></div>

Next, we will compare the two files using comm:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ comm file1.txt file2.txt
a
        b
        c
        d
    e</tt>
</pre></div>

As we can see, comm produces three columns of output. The first column contains lines
unique to the first file argument; the second column, the lines unique to the second file
argument; the third column contains the lines shared by both files. comm supports
options in the form -n where n is either 1, 2 or 3. When used, these options specify
which column(s) to suppress. For example, if we only wanted to output the lines shared
by both files, we would suppress the output of columns one and two:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ comm -12 file1.txt file2.txt
b
c
d</tt>
</pre></div>

diff

Like the comm program, diff is used to detect the differences between files. However,
diff is a much more complex tool, supporting many output formats and the ability to
process large collections of text files at once. diff is often used by software developers
to examine changes between different versions of program source code, and thus has the
ability to recursively examine directories of source code often referred to as source trees.
One common use for diff is the creation of diff files or patches that are used by
programs such as patch (which we’ll discuss shortly) to convert one version of a file (or
files) to another version.

If we use diff to look at our previous example files:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ diff file1.txt file2.txt
1d0
&lt; a
4a4
&gt; e</tt>
</pre></div>

we see its default style of output: a terse description of the differences between the two
files. In the default format, each group of changes is preceded by a change command in
the form of range operation range to describe the positions and type of changes required
to convert the first file to the second file:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 21-4: diff Change Commands</caption>
<tr>
<th class="title">Change</th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="25%">r1ar2</td>
<td valign="top">Append the lines at the position r2 in the second file to the position
r1 in the first file.</td>
</tr>
<tr>
<td valign="top">r1cr2</td>
<td valign="top">Change (replace) the lines at position r1 with the lines at the
position r2 in the second file.</td>
</tr>
<tr>
<td valign="top">r1dr2</td>
<td valign="top">Delete the lines in the first file at position r1, which would have
appeared at range r2 in the second file.</td>
</tr>
</table>
</p>

In this format, a range is a comma separated list of the starting line and the ending line.
While this format is the default (mostly for POSIX compliance and backward
compatibility with traditional Unix versions of diff), it is not as widely used as other,
optional formats. Two of the more popular formats are the context format and the unified
format.

When viewed using the context format (the -c option), we will see this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ diff -c file1.txt file2.txt
\*\*\* file1.txt    2008-12-23 06:40:13.000000000 -0500
--- file2.txt   2008-12-23 06:40:34.000000000 -0500
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
\*\*\* 1,4 \*\*\*\*
- a
  b
  c
  d
--- 1,4 ----
  b
  c
  d
  + e </tt>
</pre></div>

The output begins with the names of the two files and their timestamps. The first file is
marked with asterisks and the second file is marked with dashes. Throughout the
remainder of the listing, these markers will signify their respective files. Next, we see
groups of changes, including the default number of surrounding context lines. In the first
group, we see:

\*\*\* 1,4 \*\*\*

which indicates lines one through four in the first file. Later we see:

--- 1,4 ---

which indicates lines one through four in the second file. Within a change group, lines
begin with one of four indicators:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 21-5: diff Context Format Change Indicators</caption>
<tr>
<th class="title">Indicator</th>
<th class="title">Meaning</th>
</tr>
<tr>
<td valign="top" width="25%">blank</td>
<td valign="top">A line shown for context. It does not indicate a difference between the two files.</td>
</tr>
<tr>
<td valign="top">-</td>
<td valign="top">A line deleted. This line will appear in the first file but not in the second file.</td>
</tr>
<tr>
<td valign="top">+</td>
<td valign="top">A line added. This line will appear in the second file but not in the first file.</td>
</tr>
<tr>
<td valign="top">!</td>
<td valign="top">A line changed. The two versions of the line will be displayed, each
in its respective section of the change group.</td>
</tr>
</table>
</p>

The unified format is similar to the context format, but is more concise. It is specified
with the -u option:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ diff -u file1.txt file2.txt
--- file1.txt 2008-12-23 06:40:13.000000000 -0500
+++ file2.txt 2008-12-23 06:40:34.000000000 -0500
@@ -1,4 +1,4 @@
-a
b
c
d
+e</tt>
</pre></div>

The most notable difference between the context and unified formats is the elimination of
the duplicated lines of context, making the results of the unified format shorter than the
context format. In our example above, we see file timestamps like those of the context
format, followed by the string @@ -1,4 +1,4 @@. This indicates the lines in the first
file and the lines in the second file described in the change group. Following this are the
lines themselves, with the default three lines of context. Each line starts with one of three
possible characters:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 21-6: diff Unified Format Change Indicators</caption>
<tr>
<th class="title">Character</th>
<th class="title">Meaning</th>
</tr>
<tr>
<td valign="top" width="25%">blank</td>
<td valign="top">This line is shared by both files.</td>
</tr>
<tr>
<td valign="top">-</td>
<td valign="top">This line was removed from the first file.</td>
</tr>
<tr>
<td valign="top">+</td>
<td valign="top">This line was added to the first file.</td>
</tr>
</table>
</p>

patch

The patch program is used to apply changes to text files. It accepts output from diff
and is generally used to convert older version of files into newer versions. Let’s consider
a famous example. The Linux kernel is developed by a large, loosely organized team of
contributors who submit a constant stream of small changes to the source code. The
Linux kernel consists of several million lines of code, while the changes that are made by
one contributor at one time are quite small. Iit makes no sense for a contributor to send
each developer an entire kernel source tree each time a small change is made. Instead, a
diff file is submitted. The diff file contains the change from the previous version of the
kernel to the new version with the contributor's changes. The receiver then uses the
patch program to apply the change to his own source tree. Using diff/patch offers
two significant advantages:

1. The diff file is very small, compared to the full size of the source tree.

2. The diff file concisely shows the change being made, allowing reviewers of the patch to quickly evaluate it.

Of course, diff/patch will work on any text file, not just source code. It would be
equally applicable to configuration files or any other text.

To prepare a diff file for use with patch, the GNU documentation (see Further Reading
below) suggests using diff as follows:

diff -Naur old\_file new\_file > diff\_file

Where old\_file and new\_file are either single files or directories containing files. The r
option supports recursion of a directory tree.

Once the diff file has been created, we can apply it to patch the old file into the new file:

patch < diff\_file

We’ll demonstrate with our test file:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ diff -Naur file1.txt file2.txt &gt; patchfile.txt
[me@linuxbox ~]$ patch &lt; patchfile.txt
patching file file1.txt
[me@linuxbox ~]$ cat file1.txt
b
c
d
e</tt>
</pre></div>

In this example, we created a diff file named patchfile.txt and then used the
patch program to apply the patch. Note that we did not have to specify a target file to
patch, as the diff file (in unified format) already contains the filenames in the header.
Once the patch is applied, we can see that file1.txt now matches file2.txt.

patch has a large number of options, and there are additional utility programs that can
be used to analyze and edit patches.

Editing On The Fly

Our experience with text editors has been largely interactive, meaning that we manually
move a cursor around, then type our changes. However, there are non-interactive ways to
edit text as well. It’s possible, for example, to apply a set of changes to multiple files
with a single command.

tr

The tr program is used to transliterate characters. We can think of this as a sort of
character-based search-and-replace operation. Transliteration is the process of changing
characters from one alphabet to another. For example, converting characters from
lowercase to uppercase is transliteration. We can perform such a conversion with tr as
follows:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo "lowercase letters" | tr a-z A-Z
LOWERCASE LETTERS</tt>
</pre></div>

As we can see, tr operates on standard input, and outputs its results on standard output.
tr accepts two arguments: a set of characters to convert from and a corresponding set of
characters to convert to. Character sets may be expressed in one of three ways:

1. An enumerated list. For example, ABCDEFGHIJKLMNOPQRSTUVWXYZ

2. A character range. For example, A-Z. Note that this method is sometimes
subject to the same issues as other commands, due to the locale collation order,
and thus should be used with caution.

3. POSIX character classes. For example, [:upper:].

In most cases, both character sets should be of equal length; however, it is possible for
the first set to be larger than the second, particularly if we wish to convert multiple
characters to a single character:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo "lowercase letters" | tr [:lower:] A
AAAAAAAAA AAAAAAA</tt>
</pre></div>

In addition to transliteration, tr allows characters to simply be deleted from the input
stream. Earlier in this chapter, we discussed the problem of converting MS-DOS text
files to Unix style text. To perform this conversion, carriage return characters need to be
removed from the end of each line. This can be performed with tr as follows:

tr -d '\r' < dos\_file > unix\_file

where dos_file is the file to be converted and unix_file is the result. This form of the
command uses the escape sequence \r to represent the carriage return character. To see
a complete list of the sequences and character classes tr supports, try:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ tr --help</tt>
</pre></div>

<br />
<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>ROT13: The Not-So-Secret Decoder Ring</h3>
<p>One amusing use of tr is to perform ROT13 encoding of text. ROT13 is a trivial
type of encryption based on a simple substitution cipher. Calling ROT13
“encryption” is being generous; “text obfuscation” is more accurate. It is used
sometimes on text to obscure potentially offensive content. The method simply
moves each character thirteen places up the alphabet. Since this is half way up
the possible twenty-six characters, performing the algorithm a second time on the
text restores it to its original form. To perform this encoding with tr: </p>
<p>echo "secret text" | tr a-zA-Z n-za-mN-ZA-M </p>
<p> frperg grkg </p>
<p>Performing the same procedure a second time results in the translation:</p>
<p>echo "frperg grkg" | tr a-zA-Z n-za-mN-ZA-M</p>
<p>secret text</p>
<p>A number of email programs and USENET news readers support ROT13
encoding. Wikipedia contains a good article on the subject:</p>
<p>http://en.wikipedia.org/wiki/ROT13</p>
</td>
</tr>
</table>

tr can perform another trick, too. Using the -s option, tr can “squeeze” (delete)
repeated instances of a character:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo "aaabbbccc" | tr -s ab
abccc</tt>
</pre></div>

Here we have a string containing repeated characters. By specifying the set “ab” to tr,
we eliminate the repeated instances of the letters in the set, while leaving the character
that is missing from the set (“c”) unchanged. Note that the repeating characters must be
adjoining. If they are not:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo "abcabcabc" | tr -s ab
abcabcabc</tt>
</pre></div>

the squeezing will have no effect.

sed

The name sed is short for stream editor. It performs text editing on a stream of text,
either a set of specified files or standard input. sed is a powerful and somewhat complex
program (there are entire books about it), so we will not cover it completely here.

In general, the way that sed works is that it is given either a single editing command (on
the command line) or the name of a script file containing multiple commands, and it then
performs these commands upon each line in the stream of text. Here is a very simple
example of sed in action:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo "front" | sed 's/front/back/'
back</tt>
</pre></div>

In this example, we produce a one word stream of text using echo and pipe it into sed.
sed, in turn, carries out the instruction s/front/back/ upon the text in the stream
and produces the output “back” as a result. We can also recognize this command as
resembling the “substitution” (search and replace) command in vi.

Commands in sed begin with a single letter. In the example above, the substitution
command is represented by the letter s and is followed by the search and replace strings,
separated by the slash character as a delimiter. The choice of the delimiter character is
arbitrary. By convention, the slash character is often used, but sed will accept any
character that immediately follows the command as the delimiter. We could perform the
same command this way:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo "front" | sed 's\_front\_back\_'
back</tt>
</pre></div>

By using the underscore character immediately after the command, it becomes the
delimiter. The ability to set the delimiter can be used to make commands more readable,
as we shall see.

Most commands in sed may be preceded by an address, which specifies which line(s) of
the input stream will be edited. If the address is omitted, then the editing command is
carried out on every line in the input stream. The simplest form of address is a line
number. We can add one to our example:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo "front" | sed '1s/front/back/'
back</tt>
</pre></div>

Adding the address 1 to our command causes our substitution to be performed on the first
line of our one-line input stream. If we specify another number:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo "front" | sed '2s/front/back/'
front</tt>
</pre></div>

we see that the editing is not carried out, since our input stream does not have a line two.
Addresses may be expressed in many ways. Here are the most common:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 21-7: sed Address Notation</caption>
<tr>
<th class="title">Address</th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="25%">n</td>
<td valign="top">A line number where n is a positive integer.</td>
</tr>
<tr>
<td valign="top">$</td>
<td valign="top">The last line.</td>
</tr>
<tr>
<td valign="top">/regexp/ </td>
<td valign="top">Lines matching a POSIX basic regular expression. Note that
the regular expression is delimited by slash characters.
Optionally, the regular expression may be delimited by an
alternate character, by specifying the expression with
\cregexpc, where c is the alternate character.</td>
</tr>
<tr>
<td valign="top">addr1,addr2 </td>
<td valign="top">A range of lines from addr1 to addr2, inclusive. Addresses
may be any of the single address forms above.</td>
</tr>
<tr>
<td valign="top">first~step </td>
<td valign="top">Match the line represented by the number first, then each
subsequent line at step intervals. For example 1~2 refers to
each odd numbered line, 5~5 refers to the fifth line and every
fifth line thereafter.</td>
</tr>
<tr>
<td valign="top">addr1,+n </td>
<td valign="top">Match addr1 and the following n lines.</td>
</tr>
<tr>
<td valign="top">addr! </td>
<td valign="top">Match all lines except addr, which may be any of the forms above.</td>
</tr>
</table>
</p>

We’ll demonstrate different kinds of addresses using the distros.txt file from earlier
in this chapter. First, a range of line numbers:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sed -n '1,5p' distros.txt
SUSE           10.2     12/07/2006
Fedora         10       11/25/2008
SUSE           11.0     06/19/2008
Ubuntu         8.04     04/24/2008
Fedora         8        11/08/2007 </tt>
</pre></div>

In this example, we print a range of lines, starting with line one and continuing to line
five. To do this, we use the p command, which simply causes a matched line to be
printed. For this to be effective however, we must include the option -n (the no auto-
print option) to cause sed not to print every line by default.

Next, we’ll try a regular expression:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sed -n '/SUSE/p' distros.txt
SUSE         10.2     12/07/2006
SUSE         11.0     06/19/2008
SUSE         10.3     10/04/2007
SUSE         10.1     05/11/2006</tt>
</pre></div>

By including the slash-delimited regular expression /SUSE/, we are able to isolate the
lines containing it in much the same manner as grep.

Finally, we’ll try negation by adding an ! to the address:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sed -n '/SUSE/!p' distros.txt
Fedora         10       11/25/2008
Ubuntu         8.04     04/24/2008
Fedora         8        11/08/2007
Ubuntu         6.10     10/26/2006
Fedora         7        05/31/2007
Ubuntu         7.10     10/18/2007
Ubuntu         7.04     04/19/2007
Fedora         6        10/24/2006
Fedora         9        05/13/2008
Ubuntu         6.06     06/01/2006
Ubuntu         8.10     10/30/2008
Fedora         5        03/20/2006 </tt>
</pre></div>

Here we see the expected result: all of the lines in the file except the ones matched by the
regular expression.

So far, we’ve looked at two of the sed editing commands, s and p. Here is a more
complete list of the basic editing commands:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 21-8: sed Basic Editing Commands</caption>
<tr>
<th class="title">Command</th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="25%">=</td>
<td valign="top">Output current line number.</td>
</tr>
<tr>
<td valign="top">a</td>
<td valign="top">Append text after the current line.</td>
</tr>
<tr>
<td valign="top">d</td>
<td valign="top">Delete the current line.</td>
</tr>
<tr>
<td valign="top">i</td>
<td valign="top">Insert text in front of the current line.</td>
</tr>
<tr>
<td valign="top">p</td>
<td valign="top">Print the current line. By default, sed prints
every line and only edits lines that match a
specified address within the file. The default
behavior can be overridden by specifying the -n option.</td>
</tr>
<tr>
<td valign="top">q</td>
<td valign="top">Exit sed without processing any more lines. If
the -n option is not specified, output the current line.</td>
</tr>
<tr>
<td valign="top">Q</td>
<td valign="top">Exit sed without processing any more lines.</td>
</tr>
<tr>
<td valign="top">s/regexp/replacement/ </td>
<td valign="top">Substitute the contents of replacement wherever
regexp is found. replacement may include the
special character &amp;, which is equivalent to the text
matched by regexp. In addition, replacement may
include the sequences \1 through \9, which are
the contents of the corresponding subexpressions
in regexp. For more about this, see the discussion
of back references below. After the trailing slash
following replacement, an optional flag may be
specified to modify the s command’s behavior.</td>
</tr>
<tr>
<td valign="top">y/set1/set2 </td>
<td valign="top">Perform transliteration by converting characters
from set1 to the corresponding characters in set2.
Note that unlike tr, sed requires that both sets be of the same length.</td>
</tr>
</table>
</p>

The s command is by far the most commonly used editing command. We will
demonstrate just some of its power by performing an edit on our distros.txt file.
We discussed before how the date field in distros.txt was not in a “computer-
friendly” format. While the date is formatted MM/DD/YYYY, it would be better (for
ease of sorting) if the format were YYYY-MM-DD. To perform this change on the file
by hand would be both time-consuming and error prone, but with sed, this change can
be performed in one step:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sed 's/\([0-9]\{2\}\)\/\([0-9]\{2\}\)\/\([0-9]\{4\}\
)$/\3-\1-\2/' distros.txt
SUSE           10.2     2006-12-07
Fedora         10       2008-11-25
SUSE           11.0     2008-06-19
Ubuntu         8.04     2008-04-24
Fedora         8        2007-11-08
SUSE           10.3     2007-10-04
Ubuntu         6.10     2006-10-26
Fedora         7        2007-05-31
Ubuntu         7.10     2007-10-18
Ubuntu         7.04     2007-04-19
SUSE           10.1     2006-05-11
Fedora         6        2006-10-24
Fedora         9        2008-05-13
Ubuntu         6.06     2006-06-01
Ubuntu         8.10     2008-10-30
Fedora         5        2006-03-20 </tt>
</pre></div>

Wow! Now that is an ugly looking command. But it works. In just one step, we have
changed the date format in our file. It is also a perfect example of why regular
expressions are sometimes jokingly referred to as a “write-only” medium. We can write
them, but we sometimes cannot read them. Before we are tempted to run away in terror
from this command, let’s look at how it was constructed. First, we know that the
command will have this basic structure:

<div class="code"><pre>
<tt>sed 's/regexp/replacement/' distros.txt</tt>
</pre></div>

Our next step is to figure out a regular expression that will isolate the date. Since it is in
MM/DD/YYYY format and appears at the end of the line, we can use an expression like
this:

<div class="code"><pre>
<tt>[0-9]{2}/[0-9]{2}/[0-9]{4}$</tt>
</pre></div>

which matches two digits, a slash, two digits, a slash, four digits, and the end of line. So
that takes care of regexp, but what about replacement? To handle that, we must introduce
a new regular expression feature that appears in some applications which use BRE. This
feature is called back references and works like this: if the sequence \n appears in
replacement where n is a number from one to nine, the sequence will refer to the
corresponding subexpression in the preceding regular expression. To create the subexpressions, 
we simply enclose them in parentheses like so:

<div class="code"><pre>
<tt>([0-9]{2})/([0-9]{2})/([0-9]{4})$</tt>
</pre></div>

We now have three subexpressions. The first contains the month, the second contains the
day of the month, and the third contains the year. Now we can construct replacement as
follows:

<div class="code"><pre>
<tt>\3-\1-\2</tt>
</pre></div>

which gives us the year, a dash, the month, a dash, and the day.

Now, our command looks like this:

<div class="code"><pre>
<tt>sed 's/([0-9]{2})/([0-9]{2})/([0-9]{4})$/\3-\1-\2/' distros.txt</tt>
</pre></div>

We have two remaining problems. The first is that the extra slashes in our regular
expression will confuse sed when it tries to interpret the s command. The second is that
since sed, by default, accepts only basic regular expressions, several of the characters in
our regular expression will be taken as literals, rather than as metacharacters. We can
solve both these problems with a liberal application of backslashes to escape the
offending characters:

<div class="code"><pre>
<tt>sed 's/\([0-9]\{2\}\)\/\([0-9]\{2\}\)\/\([0-9]\{4\}\)$/\3-\1-\2/' distros.txt</tt>
</pre></div>

And there you have it!

Another feature of the s command is the use of optional flags that may follow the
replacement string. The most important of these is the g flag, which instructs sed to
apply the search and replace globally to a line, not just to the first instance, which is the
default. Here is an example:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo "aaabbbccc" | sed 's/b/B/'
aaaBbbccc</tt>
</pre></div>

We see that the replacement was performed, but only to the first instance of the letter “b,”
while the remaining instances were left unchanged. By adding the g flag, we are able to
change all the instances:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo "aaabbbccc" | sed 's/b/B/g'
aaaBBBccc </tt>
</pre></div>

So far, we have only given sed single commands via the command line. It is also
possible to construct more complex commands in a script file using the -f option. To
demonstrate, we will use sed with our distros.txt file to build a report. Our report
will feature a title at the top, our modified dates, and all the distribution names converted
to upper case. To do this, we will need to write a script, so we’ll fire up our text editor
and enter the following:

<div class="code"><pre>
<tt># sed script to produce Linux distributions report
1 i\
\
Linux Distributions Report\
s/\([0-9]\{2\}\)\/\([0-9]\{2\}\)\/\([0-9]\{4\}\)$/\3-\1-\2/
y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/</tt>
</pre></div>

We will save our sed script as distros.sed and run it like this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sed -f distros.sed distros.txt
Linux Distributions Report
SUSE	10.2	2006-12-07
FEDORA	10	    2008-11-25
SUSE	11.0	2008-06-19
UBUNTU	8.04	2008-04-24
FEDORA	8	    2007-11-08
SUSE	10.3	2007-10-04
UBUNTU	6.10	2006-10-26
FEDORA	7	    2007-05-31
UBUNTU	7.10	2007-10-18
UBUNTU	7.04	2007-04-19
SUSE	10.1	2006-05-11
FEDORA	6	    2006-10-24
FEDORA	9	    2008-05-13 
...</tt>
</pre></div>

As we can see, our script produces the desired results, but how does is do it? Let’s take
another look at our script. We’ll use cat to number the lines:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cat -n distros.sed
    1 # sed script to produce Linux distributions report
    2
    3 1 i\
    4 \
    5 Linux Distributions Report\
    6
    7 s/\([0-9]\{2\}\)\/\([0-9]\{2\}\)\/\([0-9]\{4\}\)$/\3-\1-\2/
    8 y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ </tt>
</pre></div>

Line one of our script is a comment. Like many configuration files and programming
languages on Linux systems, comments begin with the # character and are followed by
human-readable text. Comments can be placed anywhere in the script (though not within
commands themselves) and are helpful to any humans who might need to identify and/or
maintain the script.

Line two is a blank line. Like comments, blank lines may be added to improve readability.

Many sed commands support line addresses. These are used to specify which lines of
the input are to be acted upon. Line addresses may be expressed as single line numbers,
line number ranges, and the special line number “$” which indicates the last line of input.

Lines three through six contain text to be inserted at the address 1, the first line of the
input. The i command is followed by the sequence backslash-carriage return to produce
an escaped carriage return, or what is called a line continuation character. This
sequence, which can be used in many circumstances including shell scripts, allows a
carriage return to be embedded in a stream of text without signaling the interpreter (in
this case sed) that the end of the line has been reached. The i, and likewise, the a
(which appends text, rather than inserting it) and c (which replaces text) commands,
allow multiple lines of text as long as each line, except the last, ends with a line
continuation character. The sixth line of our script is actually the end of our inserted text
and ends with a plain carriage return rather than a line continuation character, signaling
the end of the i command.

<hr style="height:5px;width:100%;background:gray" />
Note: A line continuation character is formed by a backslash followed immediately
by a carriage return. No intermediary spaces are permitted.
<hr style="height:5px;width:100%;background:gray" />

Line seven is our search and replace command. Since it is not preceded by an address,
each line in the input stream is subject to its action.

Line eight performs transliteration of the lowercase letters into uppercase letters. Note
that unlike tr, the y command in sed does not support character ranges (for example,
[a-z]), nor does it support POSIX character classes. Again, since the y command is
not preceded by an address, it applies to every line in the input stream.

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>People Who Like sed Also Like...</h3>
<p>  sed is a very capable program, able to perform fairly complex editing tasks to
streams of text. It is most often used for simple one line tasks rather than long
scripts. Many users prefer other tools for larger tasks. The most popular of these
are awk and perl. These go beyond mere tools, like the programs covered here,
and extend into the realm of complete programming languages. perl, in
particular, is often used in place of shell scripts for many system management and
administration tasks, as well as being a very popular medium for web
development. awk is a little more specialized. Its specific strength is its ability to
manipulate tabular data. It resembles sed in that awk programs normally
process text files line-by-line, using a scheme similar to the sed concept of an
address followed by an action. While both awk and perl are outside the scope
of this book, they are very good skills for the Linux command line user.
</p>
</td>
</tr>
</table>

aspell

The last tool we will look at is aspell, an interactive spelling checker. The aspell
program is the successor to an earlier program named ispell, and can be used, for the
most part, as a drop-in replacement. While the aspell program is mostly used by other
programs that require spell checking capability, it can also be used very effectively as a
stand-alone tool from the command line. It has the ability to intelligently check various
type of text files, including HTML documents, C/C++ programs, email messages and
other kinds of specialized texts.

To spell check a text file containing simple prose, it could be used like this:

<div class="code"><pre>
<tt>aspell check textfile</tt>
</pre></div>

where textfile is the name of the file to check. As a practical example, let’s create a
simple text file named foo.txt containing some deliberate spelling errors:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cat > foo.txt
The quick brown fox jimped over the laxy dog.</tt>
</pre></div>

Next we’ll check the file using aspell:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ aspell check foo.txt</tt>
</pre></div>

As aspell is interactive in the check mode, we will see a screen like this:

<div class="code"><pre>
<tt>The quick brown fox jimped over the laxy dog.
<hr style="height:5px;width:70%;background:black" />
1)jumped                        6)wimped
2)gimped                        7)camped
3)comped                        8)humped
4)limped                        9)impede
5)pimped                        0)umped
i)Ignore                        I)Ignore all
r)Replace                       R)Replace all
a)Add                           l)Add Lower
b)Abort                         x)Exit
<hr style="height:5px;width:70%;background:black" />
?  </tt>
</pre></div>

At the top of the display, we see our text with a suspiciously spelled word highlighted. In
the middle, we see ten spelling suggestions numbered zero through nine, followed by a
list of other possible actions. Finally, at the very bottom, we see a prompt ready to accept
our choice.

If we press the 1 key, aspell replaces the offending word with the word “jumped” and
moves on to the next misspelled word which is “laxy.” If we select the replacement
“lazy,” aspell replaces it and terminates. Once aspell has finished, we can examine
our file and see that the misspellings have been corrected:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cat foo.txt
The quick brown fox jumped over the lazy dog.</tt>
</pre></div>

Unless told otherwise via the command line option --dont-backup, aspell creates
a backup file containing the original text by appending the extension .bak to the
filename.

Showing off our sed editing prowess, we’ll put our spelling mistakes back in so we can
reuse our file:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sed -i 's/lazy/laxy/; s/jumped/jimped/' foo.txt</tt>
</pre></div>

The sed option -i tells sed to edit the file “in-place,” meaning that rather than sending
the edited output to standard output, it will re-write the file with the changes applied. We
also see the ability to place more than one editing command on the line by separating
them with a semicolon.

Next, we’ll look at how aspell can handle different kinds of text files. Using a text
editor such as vim (the adventurous may want to try sed), we will add some HTML
markup to our file:

<div class="code"><pre>
<tt><html>
       <head>
              <title>Mispelled HTML file</title>
       </head>
       <body>
              <p>The quick brown fox jimped over the laxy dog.</p>
       </body>
</html></tt>
</pre></div>

Now, if we try to spell check our modified file, we run into a problem. If we do it this
way:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ aspell check foo.txt</tt>
</pre></div>

we’ll get this:

<div class="code"><pre>
<tt>&lt;html&gt;
       <head>
              <title>Mispelled HTML file</title>
       </head>
       <body>
              <p>The quick brown fox jimped over the laxy dog.</p>
       </body>
&lt;/html&gt;</tt>

<hr style="height:5px;width:70%;background:black" />
1) HTML                     4) Hamel
2) ht ml                    5) Hamil
3) ht-ml                    6) hotel

i) Ignore                   I) Ignore all
r) Replace                  R) Replace all
a) Add                      l) Add Lower
b) Abort                    x) Exit
<hr style="height:5px;width:70%;background:black" />
?
</pre></div>

aspell will see the contents of the HTML tags as misspelled. This problem can be
overcome by including the -H (HTML) checking mode option, like this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ aspell -H check foo.txt</tt>
</pre></div>

which will result in this:


<div class="code"><pre>
<tt><html>
       <head>
              <title><b>Mispelled</b> HTML file</title>
       </head>
       <body>
              <p>The quick brown fox jimped over the laxy dog.</p>
       </body>
</html></tt>

<hr style="height:5px;width:70%;background:black" />
1) HTML                     4) Hamel
2) ht ml                    5) Hamil
3) ht-ml                    6) hotel

i) Ignore                   I) Ignore all
r) Replace                  R) Replace all
a) Add                      l) Add Lower
b) Abort                    x) Exit
<hr style="height:5px;width:70%;background:black" />
?
</pre></div>

The HTML is ignored and only the non-markup portions of the file are checked. In this
mode, the contents of HTML tags are ignored and not checked for spelling. However, the
contents of ALT tags, which benefit from checking, are checked in this mode.

<hr style="height:5px;width:100%;background:gray" />
Note: By default, aspell will ignore URLs and email addresses in text. This
behavior can be overridden with command line options. It is also possible to
specify which markup tags are checked and skipped. See the aspell man page
for details.
<hr style="height:5px;width:100%;background:gray" />

### Summing Up

In this chapter, we have looked at a few of the many command line tools that operate on
text. In the next chapter, we will look at several more. Admittedly, it may not seem
immediately obvious how or why you might use some of these tools on a day-to-day
basis, though we have tried to show some semi-practical examples of their use. We will
find in later chapters that these tools form the basis of a tool set that is used to solve a
host of practical problems. This will be particularly true when we get into shell scripting,
where these tools will really show their worth.

### Further Reading

The GNU Project website contains many online guides to the tools discussed in this
chapter.

* From the Coreutils package:

  http://www.gnu.org/software/coreutils/manual/coreutils.html#Output-of-entire-files

  http://www.gnu.org/software/coreutils/manual/coreutils.html#Operating-on-sorted-files

  http://www.gnu.org/software/coreutils/manual/coreutils.html#Operating-on-fields-within-a-line

  http://www.gnu.org/software/coreutils/manual/coreutils.html#Operating-on-characters

* From the Diffutils package:
  
  http://www.gnu.org/software/diffutils/manual/html\_mono/diff.html

* sed

  http://www.gnu.org/software/sed/manual/sed.html

* aspell

  http://aspell.net/man-html/index.html

* There are many other online resources for sed, in particular:

  http://www.grymoire.com/Unix/Sed.html
  
  http://sed.sourceforge.net/sed1line.txt

* Also try googling “sed one liners”, “sed cheat sheets”

### Extra Credit

There are a few more interesting text manipulation commands worth investigating.
Among these are: split (split files into pieces), csplit (split files into pieces based
on context), and sdiff (side-by-side merge of file differences.)



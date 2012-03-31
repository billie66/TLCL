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
1 The quick brown fox
2
3 jumped over the lazy dog.
[me@linuxbox ~]$ </tt>
</pre></div>

In this example, we create a new version of our foo.txt test file, which contains two
lines of text separated by two blank lines. After processing by cat with the -ns options,
the extra blank line is removed and the remaining lines are numbered. While this is not
much of a process to perform on text, it is a process.

#### sort

The sort program sorts the contents of standard input, or one or more files specified on
the command line, and sends the results to standard output. Using the same technique
that we used with cat, we can demonstrate processing of standard input directly from
the keyboard:

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

Since sort can accept multiple files on the command line as arguments, it is possible to
merge multiple files into a single sorted whole. For example, if we had three text files
and wanted to combine them into a single sorted file, we could do something like this:

<div class="code"><pre>
<tt><b>sort file1.txt file2.txt file3.txt > final_sorted_list.txt</b> </tt>
</pre></div>

sort has several interesting options. Here is a partial list:


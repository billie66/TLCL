---
layout: book
title: 格式化输出
---

In this chapter, we continue our look at text related tools, focusing on programs that are
used to format text output, rather than changing the text itself. These tools are often used
to prepare text for eventual printing, a subject that we will cover in the next chapter. The
programs that we will cover in this chapter include:

在这章中，我们继续着手于文本相关的工具，关注那些用来格式化输出的程序，而不是改变文本自身。
这些工具通常让文本准备就绪打印，这是我们在下一章会提到的。我们在这章中会提到的工具有：

* nl – Number lines

* nl – 添加行号

* fold – Wrap each line to a specified length

* fold – 限制文件列宽

* fmt – A simple text formatter

* fmt – 一个简单的文本格式转换器

* pr – Prepare text for printing

* pr – 让文本为打印做好准备

* printf – Format and print data

* printf – 格式化数据并打印出来

* groff – A document formatting system

* groff – 一个文件格式系统

### 简单的格式化工具

We’ll look at some of the simple formatting tools first. These are mostly single purpose
programs, and a bit unsophisticated in what they do, but they can be used for small tasks
and as parts of pipelines and scripts.

我们将先着眼于一些简单的格式工具。他们都是功能单一的程序，并且做法有一点单纯，
但是他们能被用于小任务并且作为脚本和管道的一部分 。

#### nl - 添加行号

The nl program is a rather arcane tool used to perform a simple task. It numbers lines.
In its simplest use, it resembles cat -n:

nl 程序是一个相当神秘的工具，用作一个简单的任务。它添加文件的行数。在它最简单的用途中，它相当于 cat -n:

    [me@linuxbox ~]$ nl distros.txt | head

Like cat, nl can accept either multiple files as command line arguments, or standard
input. However, nl has a number of options and supports a primitive form of markup to
allow more complex kinds of numbering.

像 cat，nl 既能接受多个文件作为命令行参数，也能标准输出。然而，nl 有一个相当数量的选项并支持一个简单的标记方式去允许更多复杂的方式的计算。

nl supports a concept called “logical pages” when numbering. This allows nl to reset
(start over) the numerical sequence when numbering. Using options, it is possible to set
the starting number to a specific value and, to a limited extent, its format. A logical page
is further broken down into a header, body, and footer. Within each of these sections, line
numbering may be reset and/or be assigned a different style. If nl is given multiple files,
it treats them as a single stream of text. Sections in the text stream are indicated by the
presence of some rather odd-looking markup added to the text:

nl 在计算文件行数的时候支持一个叫“逻辑页面”的概念 。这允许nl在计算的时候去重设（再一次开始）可数的序列。用到那些选项
的时候，可以设置一个特殊的开始值，并且在某个可限定的程度上还能设置它的格式。一个逻辑页面被进一步分为 header,body 和 footer
这样的元素。在每一个部分中，数行数可以被重设，并且/或被设置成另外一个格式。如果nl同时处理多个文件，它会把他们当成一个单一的
文本流。文本流中的部分被一些相当古怪的标记的存在加进了文本：

<table class="multi">
<caption class="cap">Table 22-1: nl Markup</caption>
<tr>
<th class="title">MarkUp</th>
<th class="title">Meaning</th>
</tr>
<tr>
<td valign="top">\:\:\: </td>
<td valign="top">Start of logical page header</td>
</tr>
<tr>
<td valign="top">\:\:</td>
<td valign="top">Start of logical page body</td>
</tr>
<tr>
<td valign="top">\:</td>
<td valign="top">Start of logical page footer</td>
</tr>
</table">

<table class="multi">
<caption class="cap">Table 22-1: nl 标记</caption>
<tr>
<th class="title">标记</th>
<th class="title">含义</th>
</tr>
<tr>
<td valign="top">\:\:\: </td>
<td valign="top">逻辑页页眉开始处</td>
</tr>
<tr>
<td valign="top">\:\:</td>
<td valign="top">逻辑页主体开始处</td>
</tr>
<tr>
<td valign="top">\:</td>
<td valign="top">逻辑页页脚开始处</td>
</tr>
</table">

Each of the above markup elements must appear alone on its own line. After processing
a markup element, nl deletes it from the text stream.

每一个上述的标记元素肯定在自己的行中独自出现。在处理完一个标记元素之后，nl 把它从文本流中删除。

Here are the common options for nl:

这里有一些常用的 nl 选项：

<table class="multi">
<caption class="cap">Table 22-2: Common nl Options</caption>
<tr>
<th class="title">Option</th>
<th class="title">Meaning</th>
</tr>
<tr>
<td valign="top" width="25%">-b style</td>
<td valign="top">Set body numbering to style, where style is one of the following:
<p>a = number all lines</p>
<p>t = number only non-blank lines. This is the default.</p>
<p>n = none</p>
<p>pregexp = number only lines matching basic regular expression regexp.</p>
</td>
</tr>
<tr>
<td valign="top">-f style </td>
<td valign="top">Set footer numbering to style. Default is n (none).</td>
</tr>
<tr>
<td valign="top">-h style </td>
<td valign="top">Set header numbering to style. Default is n (none).</td>
</tr>
<tr>
<td valign="top">-i number </td>
<td valign="top">Set page numbering increment to number. Default is one.</td>
</tr>
<tr>
<td valign="top">-n format </td>
<td valign="top">Sets numbering format to format, where format is:
<p>ln = left justified, without leading zeros.</p>
<p>rn = right justified, without leading zeros. This is the default.</p>
<p>rz = right justified, with leading zeros.</p></td>
</tr>
<tr>
<td valign="top">-p</td>
<td valign="top">Do not reset page numbering at the beginning of each logical page.</td>
</tr>
<tr>
<td valign="top">-s string </td>
<td valign="top">Add string to the end of each line number to create a separator.Default is a single tab character.</td>
</tr>
<tr>
<td valign="top">-v number </td>
<td valign="top">Set first line number of each logical page to number. Default is one.</td>
</tr>
<tr>
<td valign="top">-w width  </td>
<td valign="top">Set width of the line number field to width. Default is six.</td>
</tr>
</table>

<table class="multi">
<caption class="cap">表格 22-2: 常用 nl 选项 </caption>
<tr>
<th class="title">选项</th>
<th class="title">含义</th>
</tr>
<tr>
<td valign="top" width="25%">-b style</td>
<td valign="top">把 body 按被要求方式数行，可以是以下方式：
<p>a = 数所有行</p>
<p>t = 数非空行。这是默认设置。</p>
<p>n = 无</p>
<p>pregexp = 只数那些匹配了正则表达式的行</p>
</td>
</tr>
<tr>
<td valign="top">-f style </td>
<td valign="top">将 footer 按被要求设置数。默认是无</td>
</tr>
<tr>
<td valign="top">-h style </td>
<td valign="top">将 header 按被要求设置数。默认是</td>
</tr>
<tr>
<td valign="top">-i number </td>
<td valign="top">将页面增加量设置为数字。默认是一。</td>
</tr>
<tr>
<td valign="top">-n format </td>
<td valign="top">设置数数的格式，格式可以是：
<p>ln = 左偏，没有前导零。</p>
<p>rn = 右偏，没有前导零。</p>
<p>rz = 右偏，有前导零。</p></td>
</tr>
<tr>
<td valign="top">-p</td>
<td valign="top">不要在没一个逻辑页面的开始重设页面数。</td>
</tr>
<tr>
<td valign="top">-s string </td>
<td valign="top">在没一个行的末尾加字符作分割符号。默认是单个的 tab。</td>
</tr>
<tr>
<td valign="top">-v number </td>
<td valign="top">将每一个逻辑页面的第一行设置成数字。默认是一。</td>
</tr>
<tr>
<td valign="top">-w width  </td>
<td valign="top">将行数的宽度设置，默认是六。</td>
</tr>
</table>

Admittedly, we probably won’t be numbering lines that often, but we can use nl to look
at how we can combine multiple tools to perform more complex tasks. We will build on
our work in the previous chapter to produce a Linux distributions report. Since we will
be using nl, it will be useful to include its header/body/footer markup. To do this, we
will add it to the sed script from the last chapter. Using our text editor, we will change
the script as follows and save it as distros-nl.sed:

坦诚的说，我们大概不会那么频繁地去数行数，但是我们能用 nl 去查看我们怎么将多个工具结合在一个去完成更复杂的任务。
我们将在之前章节的基础上做一个 Linux 发行版的报告。因为我们将使用 nl，包含它的 header/body/footer 标记将会十分有用。
我们将把它加到上一章的 sed 脚本来做这个。使用我们的文本编辑器，我们将脚本改成一下并且把它保存成 distros-nl.sed:

    # sed script to produce Linux distributions report
    1 i\
    \\:\\:\\:\
    \
    Linux Distributions Report\
    \
    Name
    Ver. Released\
    ----
    ---- --------\
    \\:\\:
    s/\([0-9]\{2\}\)\/\([0-9]\{2\}\)\/\([0-9]\{4\}\)$/\3-\1-\2/
    $ i\
    \\:\
    \
    End Of Report

The script now inserts the nl logical page markup and adds a footer at the end of the
report. Note that we had to double up the backslashes in our markup, because they are
normally interpreted as an escape character by sed.

这个脚本现在加入了 nl 的逻辑页面标记并且在报告的最后加了一个 footer。记得我们在我们的标记中必须两次使用反斜杠，
因为他们通常被 sed 解释成一个转义字符。

Next, we’ll produce our enhanced report by combining sort, sed, and nl:

下一步，我们将结合 sort, sed, nl 来生成我们改进的报告：

    [me@linuxbox ~]$ sort -k 1,1 -k 2n distros.txt | sed -f distros-nl.sed | nl
            Linux Distributions Report
            Name    Ver.    Released
            ----    ----    --------
        1   Fedora  5       2006-03-20
        2   Fedora  6       2006-10-24
        3   Fedora  7       2007-05-31
        4   Fedora  8       2007-11-08
        5   Fedora  9       2008-05-13
        6   Fedora  10      2008-11-25
        7   SUSE    10.1    2006-05-11
        8   SUSE    10.2    2006-12-07
        9   SUSE    10.3    2007-10-04
        10  SUSE    11.0    2008-06-19
        11  Ubuntu  6.06    2006-06-01
        12  Ubuntu  6.10    2006-10-26
        13  Ubuntu  7.04    2007-04-19
        14  Ubuntu  7.10    2007-10-18
        15  Ubuntu  8.04    2008-04-24
            End Of Report

Our report is the result of our pipeline of commands. First, we sort the list by distribution
name and version (fields one and two), then we process the results with sed, adding the
report header (including the logical page markup for nl) and footer. Finally, we process
the result with nl, which, by default, only numbers the lines of the text stream that
belong to the body section of the logical page.

我们的报告是一串命令的结果，首先，我们给名单按发行版本和版本号（表格1和2处）进行排序，然后我们用 sed 生产结果，
增加了 header（包括了为 nl 增加的逻辑页面标记）和 footer。最后，我们按默认用 nl 生成了结果，只数了属于逻辑页面的 body 部分的
文本流的行数。

We can repeat the command and experiment with different options for nl. Some
interesting ones are:

我们能够重复命令并且实验不同的 nl 选项。一些有趣的方式：

    nl -n rz

and

和

    nl -w 3 -s ' '

#### fold - 限制文件行宽

Folding is the process of breaking lines of text at a specified width. Like our other
commands, fold accepts either one or more text files or standard input. If we send
fold a simple stream of text, we can see how it works:

折叠是将文本的行限制到特定的宽的过程。像我们的其他命令，fold 接受一个或多个文件及标准输入。如果我们将
一个简单的文本流 fold，我们可以看到它工作的方式：

    [me@linuxbox ~]$ echo "The quick brown fox jumped over the lazy dog."
    | fold -w 12
    The quick br
    own fox jump
    ed over the
    lazy dog.

Here we see fold in action. The text sent by the echo command is broken into
segments specified by the -w option. In this example, we specify a line width of twelve
characters. If no width is specified, the default is eighty characters. Notice how the lines
are broken regardless of word boundaries. The addition of the -s option will cause
fold to break the line at the last available space before the line width is reached:

这里我们看到了 fold 的行为。这个用 echo 命令发送的文本用 -w 选项分解成块。在这个例子中，我们设定了行宽为12个字符。
如果没有字符设置，默认是80。注意到文本行不会因为单词边界而不会被分解。增加的 -s 选项将让 fold 分解到最后可用的空白
字符，即会考虑单词边界。

    [me@linuxbox ~]$ echo "The quick brown fox jumped over the lazy dog."
    | fold -w 12 -s
    The quick
    brown fox
    jumped over
    the lazy
    dog.

#### fmt - 一个简单的文本格式器

The fmt program also folds text, plus a lot more. It accepts either files or standard input
and performs paragraph formatting on the text stream. Basically, it fills and joins lines in
text while preserving blank lines and indentation.

fmt 程序同样折叠文本，外加很多功能。它接受文本或标准输入并且在文本流上呈现照片转换。基础来说，他填补并且将文本粘帖在
一起并且保留了空白符和缩进。

To demonstrate, we’ll need some text. Let’s lift some from the fmt info page:

为了解释，我们将需要一些文本。让我们抄一些 fmt 主页上的东西吧：

    ‘fmt’ reads from the specified FILE arguments (or standard input if
    none are given), and writes to standard output.

       By default, blank lines, spaces between words, and indentation are
    preserved in the output; successive input lines with different
    indentation are not joined; tabs are expanded on input and introduced on
    output.

       ‘fmt’ prefers breaking lines at the end of a sentence, and tries to
    avoid line breaks after the first word of a sentence or before the last
    word of a sentence.  A "sentence break" is defined as either the end of
    a paragraph or a word ending in any of ‘.?!’, followed by two spaces or
    end of line, ignoring any intervening parentheses or quotes.  Like TeX,
    ‘fmt’ reads entire “paragraphs” before choosing line breaks; the
    algorithm is a variant of that given by Donald E. Knuth and Michael F.
    Plass in “Breaking Paragraphs Into Lines”, ‘Software—Practice &
    Experience’ 11, 11 (November 1981), 1119–1184.

We’ll copy this text into our text editor and save the file as fmt-info.txt. Now, let’s
say we wanted to reformat this text to fit a fifty character wide column. We could do this
by processing the file with fmt and the -w option:

我们将把这段文本复制进我们的文本编辑器并且保存文件名为 fmt-info.txt。现在，让我们重新格式这个文本并且让它成为一个50
个字符宽的项目。我们能用 -w 选项对文件进行处理：

    [me@linuxbox ~]$ fmt -w 50 fmt-info.txt | head
    'fmt' reads from the specified FILE arguments
    (or standard input if
    none are given), and writes to standard output.
    By default, blank lines, spaces between words,
    and indentation are
    preserved in the output; successive input lines
    with different indentation are not joined; tabs
    are expanded on input and introduced on output.

Well, that’s an awkward result. Perhaps we should actually read this text, since it explains what’s going on:

好，这真是一个奇怪的结果。大概我们应该认真的阅读这段文本，因为它恰好解释了发生了什么：

“By default, blank lines, spaces between words, and indentation are preserved in the
output; successive input lines with different indentation are not joined; tabs are
expanded on input and introduced on output.”

默认来说，空白行，单词间距，还有缩进都会在输出中保留；持续输入不同的缩进的流不会被结合；tabs被用来扩展
输入并且引入输出。

So, fmt is preserving the indentation of the first line. Fortunately, fmt provides an
option to correct this:

所以，fmt 保留了第一行的缩进。幸运的是，fmt 提供一个修正这个的选项：

Much better. By adding the -c option, we now have the desired result.

好多了。通过加了 -c 选项，我们现在有了我们想要的结果。

fmt has some interesting options:

fmt 有一些有趣的选项：

The -p option is particularly interesting. With it, we can format selected portions of a
file, provided that the lines to be formatted all begin with the same sequence of
characters. Many programming languages use the pound sign (#) to indicate the
beginning of a comment and thus can be formatted using this option. Let’s create a file
that simulates a program that uses comments:

-p 选项特别有趣。通过它，我们可以格式文件选中的部分，通过在开头使用一样的符号。
很多编程语言使用锚标记（#）去提醒注释的开始，而且它可以通过这个选项来被格式。让我们创建一个有用到注释的程序。

    [me@linuxbox ~]$ cat > fmt-code.txt
    # This file contains code with comments.
    # This line is a comment.
    # Followed by another comment line.
    # And another.
    This, on the other hand, is a line of code.
    And another line of code.
    And another.

Our sample file contains comments which begin the string “# “ (a # followed by a space)
and lines of “code” which do not. Now, using fmt, we can format the comments and
leave the code untouched:

我们的示例文件包含了用 “#” 开始的注释（一个 # 后跟着一个空白符）和代码。现在，使用 fmt，我们能格式注释并且
不让代码被触及。

---
layout: book
title: 自定制shell提示符 
---

14 – Customizing The Prompt

In this chapter we will look at a seemingly trivial detail — our shell prompt. This
examination will reveal some of the inner workings of the shell and the terminal emulator
program itself.

在这一章中，我们将会看一下表面上看来很琐碎的细节－shell提示符。但这会揭示一些内部shell和
终端仿真器的工作方式。

Like so many things in Linux, the shell prompt is highly configurable, and while we have
pretty much taken it for granted, the prompt is a really useful device once we learn how
to control it.

和Linux内的许多程序一样，shell提示符是可高度配置的，虽然我们把它相当多地看作是理所当然的，
但是我们一旦学会了怎样控制它，shell提示符是一个真正有用的设备。

Anatomy Of A Prompt

### 解剖一个提示符

Our default prompt looks something like this:

我们默认的提示符看起来像这样：

<div class="code"><pre>
<tt>[me@linuxbox ~]$</tt>
</pre></div>

Notice that it contains our user name, our host name and our current working directory,
but how did it get that way? Very simply, it turns out. The prompt is defined by an
environment variable named PS1 (short for “prompt string one”). We can view the
contents of PS1 with the echo command:

注意它包含我们的用户名，主机名和当前工作目录，但是它又是怎样得到这些东西的呢？
结果证明非常简单。提示符是由一个环境变量定义的，叫做PS1（是“prompt string one”
的简写）。我们可以通过echo命令来查看PS1的内容。

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo $PS1
[\u@\h \W]\$</tt>
</pre></div>

<br />
<hr />
Note: Don't worry if your results are not exactly the same as the example above.
Every Linux distribution defines the prompt string a little differently, some quite
exotically.

注意：如果你shell提示符的内容和上例不是一模一样，也不必担心。每个Linux发行版
定义的提示符稍微有点不同，其中一些相当异乎寻常。
<hr />

From the results, we can see that PS1 contains a few of the characters we see in our
prompt such as the brackets, the at-sign, and the dollar sign, but the rest are a mystery.
The astute among us will recognize these as backslash-escaped special characters like
those we saw in Chapter 8. Here is a partial list of the characters that the shell treats
specially in the prompt string:

从输出结果中，我们看到那个PS1环境变量包含一些这样的字符，比方说中括号，@符号，和美元符号，
但是剩余部分就是个谜。我们中一些机敏的人会把这些看作是由反斜杠转义的特殊字符，就像我们
在第八章中看到的一样。这里是一部分字符列表，在提示符中shell会特殊对待这些字符：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 14-1: Escape Codes Used In Shell Prompts</caption>
<tr>
<th class="title">Sequence</th>
<th class="title">Value Displayed</th>
</tr>
<tr>
<td valign="top" width="20%">\a</td>
<td valign="top">ASCII bell. This makes the computer beep when it is encountered.</td>
</tr>
<tr>
<td valign="top">\d</td>
<td valign="top">Current date in day, month, date format. For example, “Mon
May 26."</td>
</tr>
<tr>
<td valign="top">\h</td>
<td valign="top">Host name of the local machine minus the trailing domain name.</td>
</tr>
<tr>
<td valign="top">\H</td>
<td valign="top">Full host name.</td>
</tr>
<tr>
<td valign="top">\j</td>
<td valign="top">Number of jobs running in the current shell session.</td>
</tr>
<tr>
<td valign="top">\l</td>
<td valign="top">Name of the current terminal device.</td>
</tr>
<tr>
<td valign="top">\n</td>
<td valign="top">A newline character.</td>
</tr>
<tr>
<td valign="top">\r</td>
<td valign="top">A carriage return.</td>
</tr>
<tr>
<td valign="top">\s</td>
<td valign="top">Name of the shell program.</td>
</tr>
<tr>
<td valign="top">\t</td>
<td valign="top">Current time in 24 hour hours:minutes:seconds format.
</td>
</tr>
<tr>
<td valign="top">\T</td>
<td valign="top">Current time in 12 hour format.
</td>
</tr>
<tr>
<td valign="top">\@</td>
<td valign="top">Current time in 12 hour AM/PM format.</td>
</tr>
<tr>
<td valign="top">\A</td>
<td valign="top">Current time in 24 hour hours:minutes format.</td>
</tr>
<tr>
<td valign="top">\u</td>
<td valign="top">User name of the current user.</td>
</tr>
<tr>
<td valign="top">\v</td>
<td valign="top">Version number of the shell.
</td>
</tr>
<tr>
<td valign="top">\V</td>
<td valign="top">Version and release numbers of the shell.</td>
</tr>
<tr>
<td valign="top">\w</td>
<td valign="top">Name of the current working directory.
</td>
</tr>
<tr>
<td valign="top">\W</td>
<td valign="top">Last part of the current working directory name.</td>
</tr>
<tr>
<td valign="top">\!</td>
<td valign="top">History number of the current command.
</td>
</tr>
<tr>
<td valign="top">\#</td>
<td valign="top">Number of commands entered into this shell session.
</td>
</tr>
<tr>
<td valign="top">\$</td>
<td valign="top">This displays a “$” character unless you have superuser privileges.
In that case, it displays a “#” instead.
</td>
</tr>
<tr>
<td valign="top">\[</td>
<td valign="top">Signals the start of a series of one or more non-printing characters.
This is used to embed non-printing control characters which
manipulate the terminal emulator in some way, such as moving the
cursor or changing text colors.
</td>
</tr>
<tr>
<td valign="top">\]</td>
<td valign="top">Signals the end of a non-printing character sequence.
</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">表14－1：Shell提示符中用到的转义字符</caption>
<tr>
<th class="title">序列</th>
<th class="title">显示值</th>
</tr>
<tr>
<td valign="top" width="20%">\a</td>
<td valign="top">以ASCII格式编码的铃声 . 当遇到这个转义序列时，计算机会发出嗡嗡的响声。</td>
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
<td valign="top">运行在当前shell会话中的工作数。</td>
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
<td valign="top">shell程序名。</td>
</tr>
<tr>
<td valign="top">\t</td>
<td valign="top">以24小时制，hours:minutes:seconds的格式表示当前时间.</td>
</tr>
<tr>
<td valign="top">\T</td>
<td valign="top">以12小时制表示当前时间。 </td>
</tr>
<tr>
<td valign="top">\@</td>
<td valign="top">以12小时制，AM/PM格式来表示当前时间。</td>
</tr>
<tr>
<td valign="top">\A</td>
<td valign="top">以24小时制，hours:minutes格式表示当前时间。</td>
</tr>
<tr>
<td valign="top">\u</td>
<td valign="top">当前用户名。</td>
</tr>
<tr>
<td valign="top">\v</td>
<td valign="top">shell程序的版本号。</td>
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
<td valign="top">当前shell会话中的命令数。
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
</p>

Trying Some Alternate Prompt Designs

### 试试一些可替代的提示符设计 

With this list of special characters, we can change the prompt to see the effect. First,
we'll back up the existing string so we can restore it later. To do this, we will copy the
existing string into another shell variable that we create ourselves:

参照这个特殊字符列表，我们可以更改提示符来看一下效果。首先，
我们把原来提示符字符串的内容备份一下，以备之后恢复原貌。为了完成备份，
我们把已有的字符串复制到另一个shell变量中，这个变量是我们自己创造的。

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ps1\_old="$PS1"</tt>
</pre></div>

We create a new variable called ps1_old and assign the value of PS1 to it. We can
verify that the string has been copied with the echo command:

我们新创建了一个叫做ps1_old的变量，并把变量PS1的值赋ps1\_old。通过echo命令可以证明
我们的确复制了PS1的值。

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo $ps1\_old
[\u@\h \W]\$</tt>
</pre></div>

We can restore the original prompt at any time during our terminal session by simply
reversing the process:

在终端会话中，我们能在任一时间复原提示符，只要简单地反向操作就可以了。

<div class="code"><pre>
<tt>[me@linuxbox ~]$ PS1="$ps1\_old"</tt>
</pre></div>

Now that we are ready to proceed, let's see what happens if we have an empty prompt
string:

现在，我们准备开始，让我们看看如果有一个空的字符串会发生什么：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ PS1=</tt>
</pre></div>

If we assign nothing to the prompt string, we get nothing. No prompt string at all! The
prompt is still there, but displays nothing, just as we asked it to. Since this is kind of
disconcerting to look at, we'll replace it with a minimal prompt:

如果我们没有给提示字符串赋值，那么我们什么也得不到。根本没有提示字符串！提示符仍然在那里，
但是什么也不显示，正如我们所要求的那样。我们将用一个最小的提示符来代替它：

<div class="code"><pre>
<tt><b>PS1="\$ "</b></tt>
</pre></div>

That's better. At least now we can see what we are doing. Notice the trailing space
within the double quotes. This provides the space between the dollar sign and the cursor
when the prompt is displayed.

这样要好一些。至少能看到我们在做什么。注意双引号中末尾的空格。当提示符显示的时候，
这个空格把美元符号和光标分离开。

Let's add a bell to our prompt:

在提示符中添加一个响铃：

<div class="code"><pre>
<tt>$ <b>PS1="\a\$ "</b></tt>
</pre></div>

Now we should hear a beep each time the prompt is displayed. This could get annoying,
but it might be useful if we needed notification when an especially long-running
command has been executed.

现在每次提示符显示的时候，我们应该能听到嗡嗡声。这会变得很烦人，但是它可能会
很有用，特别是当一个需要运行很长时间的命令执行完后，我们要得到通知。

Next, let's try to make an informative prompt with some host name and time-of-day
information:

下一步，让我们试着创建一个信息丰富的提示符，包含主机名和当天时间的信息。

<div class="code"><pre>
<tt>$ PS1="\A \h \$ "
17:33 linuxbox $</tt>
</pre></div>

Try out the other sequences listed in the table above and see if you can come up with a
brilliant new prompt.

试试其他上表中列出的转义序列，看看你能否想出精彩的新提示符。

Adding Color

### 添加颜色

Most terminal emulator programs respond to certain non-printing character sequences to
control such things as character attributes (like color, bold text and the dreaded blinking
text) and cursor position. We'll cover cursor position in a little bit, but first we'll look at
color.

大多数终端仿真器程序支持一定的非打印字符序列来控制，比方说字符属性（像颜色，黑体和可怕的闪烁）
和光标位置。我们会更深入地讨论光标位置，但首先我们要看一下字体颜色。

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>Terminal Confusion</h3>
<h3>混乱的终端时代</h3>

<p>Back in ancient times, when terminals were hooked to remote computers, there
were many competing brands of terminals and they all worked differently. They
had different keyboards and they all had different ways of interpreting control
information. Unix and Unix-like systems have two rather complex subsystems to
deal with the babel of terminal control (called termcap and terminfo). If
you look in the deepest recesses of your terminal emulator settings you may find
a setting for the type of terminal emulation.</p>

<p>回溯到终端连接到远端计算机的时代，有许多竞争的终端品牌，它们各自工作不同。
它们有着不同的键盘，以不同的方式来解释控制信息。Unix和类似于Unix的系统有两个
相当复杂的子系统来处理终端控制领域的混乱局面（称为termcap和terminfo）。如果你
查看一下终端仿真器最底层的属性设置，可能会找到一个关于终端仿真器类型的设置。</p>

<p> In an effort to make terminals speak some sort of common language, the
American National Standards Institute (ANSI) developed a standard set of
character sequences to control video terminals. Old time DOS users will
remember the ANSI.SYS file that was used to enable interpretation of these
codes. </p>
<p>为了努力使所有的终端都讲某种通用语言，美国国家标准委员会（ANSI）制定了
一套标准的字符序列集合来控制视频终端。原先DOS用户会记得ANSI.SYS文件，
这是一个用来使这些编码解释生效的文件。</p>
</td>
</tr>
</table>

Character color is controlled by sending the terminal emulator an ANSI escape code
embedded in the stream of characters to be displayed. The control code does not “print
out” on the display, rather it is interpreted by the terminal as an instruction. As we saw in
the table above, the \[ and \] sequences are used to encapsulate non-printing characters.
An ANSI escape code begins with an octal 033 (the code generated by the escape key)
followed by an optional character attribute followed by an instruction. For example, the
code to set the text color to normal (attribute = 0), black text is:

字符颜色是由发送到终端仿真器的一个嵌入到了要显示的字符流中的ANSI转义编码来控制的。
这个控制编码不会“打印”到屏幕上，而是被终端解释为一个指令。正如我们在上表看到的字符序列，
这个\[和\]序列被用来封装这些非打印字符。一个ANSI转义编码以一个八进制033（这个编码是由
退出按键产生的）开头，其后跟着一个可选的字符属性，在之后是一个指令。例如，把文本颜色
设为正常（attribute = 0）,黑色文本的编码如下：

\033[0;30m

Here is a table of available text colors. Notice that the colors are divided into two groups,
differentiated by the application of the bold character attribute (1) which creates the
appearance of “light” colors:

这里是一个可用的文本颜色列表。注意这些颜色被分为两组，由应用程序粗体字符属性（1）
分化开来，这个属性可以描绘出“浅”色文本。


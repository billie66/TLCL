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
<td valign="top"></td>
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


---
layout: book
title: shell&nbsp;环&nbsp;境
---
The Environment

As we discussed earlier, the shell maintains a body of information during our shell
session called the environment. Data stored in the environment is used by programs to
determine facts about our configuration. While most programs use configuration files to
store program settings, some programs will also look for values stored in the environment
to adjust their behavior. Knowing this, we can use the environment to customize our
shell experience.

正如我们之前所讨论到的，shell在shell会话中维护着大量的信息，这些信息称为(shell)环境。
存储在shell环境中的数据被程序用来确定配置属性。然而大多数程序用配置文件来存储程序设置，
某些程序也会查找存储在shell环境中的数值来调整他们的行为。知道了这些，我们就可以用shell环境
来自定制shell经历。

In this chapter, we will work with the following commands:

在这一章，我们将用到以下命令：

* printenv – Print part or all of the environment 打印部分或所有的环境数据

* set – Set shell options 设置shell选项

* export – Export environment to subsequently executed programs
  
* export — 导出环境变量到随后执行的程序
  
* alias – Create an alias for a command 创建命令别名

What Is Stored In The Environment?

### 什么存储在环境变量中？

The shell stores two basic types of data in the environment, though, with bash, the
types are largely indistinguishable. They are environment variables and shell variables.
Shell variables are bits of data placed there by bash, and environment variables are
basically everything else. In addition to variables, the shell also stores some
programmatic data, namely aliases and shell functions. We covered aliases in Chapter 6,
and shell functions (which are related to shell scripting) will be covered in Part 5.

shell在环境中存储了两种基本类型的数据，虽然对于bash来说，很大程度上这些类型是不可
辨别的。它们是环境变量和shell变量。Shell变量是由bash存放的一很少数据，而环境变量基本上
就是其它的所有数据。除了变量，shell也存储了一些可编程的数据，命名为别名和shell函数。我们
已经在第六章讨论了别名，而shell函数（涉及到shell脚本）将会在第五部分叙述。

Examining The Environment

### 检查环境变量

We can use either the set builtin in bash or the printenv program to see what is
stored in the environment. The set command will show both the shell and environment
variables, while printenv will only display the latter. Since the list of environment
contents will be fairly long, it is best to pipe the output of either command into less:

我们既可以用bash的内部命令set，或者是printenv程序来查看什么存储在环境当中。set命令可以
显示shell和环境变量两者，而printenv只是显示环境变量。因为环境变量内容列表相当长，所以最好
把每个命令的输出结果管道到less命令：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ printenv | less</tt>
</pre></div>

Doing so, we should get something that looks like this:

执行以上命令之后，我们应该能得到类似以下内容：

What we see is a list of environment variables and their values. For example, we see a
variable called USER, which contains the value “me”. The printenv command can
also list the value of a specific variable:

我们所看到的是环境变量及其数值的列表。例如，我们看到一个叫做USER的变量，这个变量值是
“me”。printenv命令也能够列出特定变量的数值：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ printenv USER
me</tt>
</pre></div>

The set command, when used without options or arguments, will display both the shell
and environment variables, as well as any defined shell functions. Unlike printenv,
its output is courteously sorted in alphabetical order:

当使用没有带选项和参数的set命令时，shell和环境变量二者都会显示，同时也会显示定义的
shell函数。不同于printenv命令，set命令的输出结果很礼貌地按照字母顺序排列：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ set | less</tt>
</pre></div>

It is also possible to view the contents of a variable using the echo command, like this:

也可以通过echo命令来查看一个变量的内容，像这样：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo $HOME
/home/me</tt>
</pre></div>

One element of the environment that neither set nor printenv displays is aliases. To
see them, enter the alias command without arguments:

如果shell环境中的一个成员既不可用set命令也不可用printenv命令显示，则这个变量是别名。
输入不带参数的alias命令来查看它们:

Some Interesting Variables

### 一些有趣的变量

The environment contains quite a few variables, and though your environment may differ
from the one presented here, you will likely see the following variables in your
environment:

shell环境中包含相当多的变量，虽然你的shell环境可能不同于这里展示的，但是你可能会看到
以下变量在你的shell环境中：

<div class="code"><pre>
<tt>KDE\_MULTIHEAD=false
SSH\_AGENT\_PID=6666
HOSTNAME=linuxbox
GPG\_AGENT\_INFO=/tmp/gpg-PdOt7g/S.gpg-agent:6689:1
SHELL=/bin/bash
TERM=xterm
XDG\_MENU\_PREFIX=kde-
HISTSIZE=1000
XDG\_SESSION\_COOKIE=6d7b05c65846c3eaf3101b0046bd2b00-1208521990.996705
-1177056199
GTK2\_RC\_FILES=/etc/gtk-2.0/gtkrc:/home/me/.gtkrc-2.0:/home/me/.kde/sh
are/config/gtkrc-2.0
GTK\_RC\_FILES=/etc/gtk/gtkrc:/home/me/.gtkrc:/home/me/.kde/share/confi
g/gtkrc
GS\_LIB=/home/me/.fonts
WINDOWID=29360136
QTDIR=/usr/lib/qt-3.3
QTINC=/usr/lib/qt-3.3/include
KDE\_FULL\_SESSION=true
USER=me
LS\_COLORS=no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01
:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:\*.cmd=00;32:\*.exe:</tt>
</pre></div>


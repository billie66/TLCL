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
<tt>KDE_MULTIHEAD=false
SSH_AGENT_PID=6666
HOSTNAME=linuxbox
GPG_AGENT_INFO=/tmp/gpg-PdOt7g/S.gpg-agent:6689:1
SHELL=/bin/bash
TERM=xterm
XDG_MENU_PREFIX=kde-
HISTSIZE=1000
XDG_SESSION_COOKIE=6d7b05c65846c3eaf3101b0046bd2b00-1208521990.996705
-1177056199
GTK2_RC_FILES=/etc/gtk-2.0/gtkrc:/home/me/.gtkrc-2.0:/home/me/.kde/sh
are/config/gtkrc-2.0
GTK_RC_FILES=/etc/gtk/gtkrc:/home/me/.gtkrc:/home/me/.kde/share/confi
g/gtkrc
GS_LIB=/home/me/.fonts
WINDOWID=29360136
QTDIR=/usr/lib/qt-3.3
QTINC=/usr/lib/qt-3.3/include
KDE_FULL_SESSION=true
USER=me
LS_COLORS=no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01
:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:\*.cmd=00;32:\*.exe:</tt>
</pre></div>

What we see is a list of environment variables and their values. For example, we see a
variable called USER, which contains the value &quot;me&quot;. The printenv command can
also list the value of a specific variable:

我们所看到的是环境变量及其数值的列表。例如，我们看到一个叫做USER的变量，这个变量值是
&quot;me&quot;。printenv命令也能够列出特定变量的数值：

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

<div class="code"><pre>
<tt>[me@linuxbox ~]$ alias
alias l.=&apos;ls -d .\* --color=tty&apos;
alias ll=&apos;ls -l --color=tty&apos;
alias ls=&apos;ls --color=tty&apos;
alias vi=&apos;vim&apos;
alias which=&apos;alias | /usr/bin/which --tty-only --read-alias --show-
dot --show-tilde&apos;</tt>
</pre></div>

Some Interesting Variables

### 一些有趣的变量

The environment contains quite a few variables, and though your environment may differ
from the one presented here, you will likely see the following variables in your
environment:

shell环境中包含相当多的变量，虽然你的shell环境可能不同于这里展示的，但是你可能会看到
以下变量在你的shell环境中：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 12-1: Environment Variables</caption>
<tr>
<th class="title">Variable</th>
<th class="title">Contents</th>
</tr>
<tr>
<td valign="top" width="25%">DISPLAY </td>
<td valign="top">The name of your display if you are running a graphical
environment. Usually this is &quot;:0&quot;, meaning the first display
generated by the X server.</td>
</tr>
<tr>
<td valign="top">EDITOR</td>
<td valign="top">The name of the program to be used for text editing.</td>
</tr>
<tr>
<td valign="top">SHELL</td>
<td valign="top">The name of your shell program.</td>
</tr>
<tr>
<td valign="top">HOME</td>
<td valign="top">The pathname of your home directory.</td>
</tr>
<tr>
<td valign="top">LANG</td>
<td valign="top">Defines the character set and collation order of your language.</td>
</tr>
<tr>
<td valign="top">OLD\_PWD </td>
<td valign="top">The previous working directory.</td>
</tr>
<tr>
<td valign="top">PAGER</td>
<td valign="top">The name of the program to be used for paging output. This is
often set to /usr/bin/less.
</td>
</tr>
<tr>
<td valign="top">PATH</td>
<td valign="top">A colon-separated list of directories that are searched when you
enter the name of a executable program.
</td>
</tr>
<tr>
<td valign="top">PS1</td>
<td valign="top">Prompt String 1. This defines the contents of your shell prompt. As
we will later see, this can be extensively customized.
</td>
</tr>
<tr>
<td valign="top">PWD</td>
<td valign="top">The current working directory.</td>
</tr>
<tr>
<td valign="top">TERM </td>
<td valign="top">The name of your terminal type. Unix-like systems support many
terminal protocols; this variable sets the protocol to be used with
your terminal emulator.</td>
</tr>
<tr>
<td valign="top">TZ</td>
<td valign="top">Specifies your timezone. Most Unix-like systems maintain the
computer&apos;s internal clock in Coordinated Universal Time (UTC)
and then displays the local time by applying an offset specified by
this variable.</td>
</tr>
<tr>
<td valign="top">USER</td>
<td valign="top">Your user name.</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">表12-1: 环境变量</caption>
<tr>
<th class="title">变量</th>
<th class="title">内容</th>
</tr>
<tr>
<td valign="top" width="25%">DISPLAY </td>
<td valign="top">如果你正在运行图形界面环境，那么这个变量就是你显示器的名字。通常，它是&quot;:0&quot;，
意思是由X产生的第一个显示器。</td>
</tr>
<tr>
<td valign="top">EDITOR</td>
<td valign="top">文本编辑器的名字。</td>
</tr>
<tr>
<td valign="top">SHELL</td>
<td valign="top">shell程序的名字。</td>
</tr>
<tr>
<td valign="top">HOME</td>
<td valign="top">用户主目录。</td>
</tr>
<tr>
<td valign="top">LANG</td>
<td valign="top">定义了字符集以及语言编码方式。</td>
</tr>
<tr>
<td valign="top">OLD\_PWD </td>
<td valign="top">先前的工作目录。</td>
</tr>
<tr>
<td valign="top">PAGER</td>
<td valign="top">页输出程序的名字。这经常设置为/usr/bin/less。 
</td>
</tr>
<tr>
<td valign="top">PATH</td>
<td valign="top">由冒号分开的目录列表，当你输入可执行程序名后，会搜索这个目录列表。
</td>
</tr>
<tr>
<td valign="top">PS1</td>
<td valign="top">Prompt String 1. 这个定义了你的shell提示符的内容。随后我们可以看到，这个变量
内容可以全面地定制。
</td>
</tr>
<tr>
<td valign="top">PWD</td>
<td valign="top">当前工作目录。</td>
</tr>
<tr>
<td valign="top">TERM </td>
<td valign="top">终端类型名。类似于Unix的系统支持许多终端协议；这个变量设置你的终端仿真器所用的协议。
</td>
</tr>
<tr>
<td valign="top">TZ</td>
<td valign="top">指定你所在的时区。大多数类似于Unix的系统按照协调时间时(UTC)来维护计算机内部的时钟
，然后应用一个由这个变量指定的偏差来显示本地时间。
</td>
</tr>
<tr>
<td valign="top">USER</td>
<td valign="top">你的用户名</td>
</tr>
</table>
</p>

Don't worry if some of these values are missing. They vary by distribution.

如果缺失了一些变量，不要担心，这些变量会因发行版本的不同而不同。

How Is The Environment Established?

### 如何建立shell环境？

When we log on to the system, the bash program starts, and reads a series of
configuration scripts called startup files, which define the default environment shared by
all users. This is followed by more startup files in our home directory that define our
personal environment. The exact sequence depends on the type of shell session being
started. There are two kinds: a login shell session and a non-login shell session.

当我们登录系统后，启动bash程序，并且会读取一系列称为启动文件的配置脚本，
这些文件定义了默认的可供所有用户共享的shell环境。然后是读取更多位于我们自己主目录中
的启动文件，这些启动文件定义了用户个人的shell环境。精确的启动顺序依赖于要运行的shell会话
类型。有两种shell会话类型：一个是登录shell会话，另一个是非登录shell会话。

A login shell session is one in which we are prompted for our user name and password;
when we start a virtual console session, for example. A non-login shell session typically
occurs when we launch a terminal session in the GUI.

登录shell会话会提示用户输入用户名和密码；例如，我们启动一个虚拟控制台会话。当我们在GUI模式下
运行终端会话时，非登录shell会话会出现。

Login shells read one or more startup files as shown in Table 12-2:

登录shell会读取一个或多个启动文件，正如表12－2所示：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 12-2: Startup Files For Login Shell Sessions</caption>
<tr>
<th class="title">File</th>
<th class="title">Contents</th>
</tr>
<tr>
<td valign="top" width="25%">/etc/profile</td>
<td valign="top">A global configuration script that applies to all users.</td>
</tr>
<tr>
<td valign="top">~/.bash_profile </td>
<td valign="top">A user's personal startup file. Can be used to extend or
override settings in the global configuration script.</td>
</tr>
<tr>
<td valign="top">~/.bash_login </td>
<td valign="top">If ~/.bash_profile is not found, bash attempts to
read this script.</td>
</tr>
<tr>
<td valign="top">~/.profile </td>
<td valign="top">If neither ~/.bash_profile nor ~/.bash_login
is found, bash attempts to read this file. This is the
default in Debian-based distributions, such as Ubuntu.</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">表12-2: 登录shell会话的启动文件</caption>
<tr>
<th class="title">文件</th>
<th class="title">内容</th>
</tr>
<tr>
<td valign="top" width="25%">/etc/profile</td>
<td valign="top">应用于所有用户的全局配置脚本。</td>
</tr>
<tr>
<td valign="top">~/.bash_profile </td>
<td valign="top">用户私人的启动文件。可以用来扩展或重写全局配置脚本中的设置。</td>
</tr>
<tr>
<td valign="top">~/.bash_login </td>
<td valign="top">如果文件~/.bash_profile没有找到，bash会尝试读取这个脚本。
</td>
</tr>
<tr>
<td valign="top">~/.profile </td>
<td
valign="top">如果文件~/.bash_profile或文件~/.bash_login都没有找到，bash会试图读取这个文件。
这是基于Debian发行版的默认设置，比方说Ubuntu。
</td>
</tr>
</table>
</p>

Non-login shell sessions read the following startup files:

非登录shell会话会读取以下启动文件：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 12-3: Startup Files For Non-Login Shell Sessions</caption>
<tr>
<th class="title">File</th>
<th class="title">Contents</th>
</tr>
<tr>
<td valign="top" width="25%">/etc/bash.bashrc </td>
<td valign="top">A global configuration script that applies to all users.</td>
</tr>
<tr>
<td valign="top">~/.bashrc</td>
<td valign="top">A user's personal startup file. Can be used to extend or
override settings in the global configuration script.</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">表12-3: 非登录shell会话的启动文件</caption>
<tr>
<th class="title">文件</th>
<th class="title">内容</th>
</tr>
<tr>
<td valign="top" width="25%">/etc/bash.bashrc </td>
<td valign="top">应用于所有用户的全局配置文件。</td>
</tr>
<tr>
<td valign="top">~/.bashrc</td>
<td valign="top">用户私有的启动文件。可以用来扩展或重写全局配置脚本中的设置。
</td>
</tr>
</table>
</p>

In addition to reading the startup files above, non-login shells also inherit the
environment from their parent process, usually a login shell.

除了读取以上启动文件之外，非登录shell会话也会继承它们父进程的环境设置，通常是一个登录shell。
 
Take a look at your system and see which of these startup files you have. Remember— 
since most of the filenames listed above start with a period (meaning that they are
hidden), you will need to use the &quot;-a&quot; option when using ls.

浏览一下你的系统，看一看系统中有哪些启动文件。记住－因为上面列出的大多数文件名都以圆点开头
（意味着它们是隐藏文件），你需要使用带&quot;-a&quot;选项的ls命令。

The ~/.bashrc file is probably the most important startup file from the
ordinary user’s point of view, since it is almost always read. Non-login
shells read it by default and most startup files for login shells are written
in such a way as to read the ~/.bashrc file as well.

在普通用户看来，文件~/.bashrc可能是最重要的启动文件，因为它几乎总是被读取。非登录shell默认
会读取它，并且大多数登录shell的启动文件会以能读取~/.bashrc文件的方式来书写。

What's In A Startup File?

### 一个启动文件的内容

If we take a look inside a typical .bash\_profile (taken from a CentOS 4 system), it
looks something like this:

如果我们看一下典型的.bash\_profile文件（来自于CentOS 4系统），它看起来像这样：

<div class="code"><pre>
<tt># .bash\_profile
 # Get the aliases and functions
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
 # User specific environment and startup programs
PATH=$PATH:$HOME/bin
export PATH</tt>
</pre></div>

Lines that begin with a &quot;#&quot; are comments and are not read by the shell. These are there
for human readability. The first interesting thing occurs on the fourth line, with the
following code:

以&quot;#&quot;开头的行是注释，shell不会读取它们。它们在那里是为了方便人们阅读。第一件有趣的事情
发生在第四行，伴随着以下代码：

<div class="code"><pre>
<tt>if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi</tt>
</pre></div>

This is called an if compound command, which we will cover fully when we get to shell
scripting in Part 5, but for now we will translate:

这叫做一个if复合命令，我们将会在第五部分详细地介绍它，现在我们对它翻译一下：

<div class="code"><pre>
<tt>If the file &quot;~/.bashrc&quot; exists, then
        read the &quot;~/.bashrc&quot; file.</tt>
</pre></div>

We can see that this bit of code is how a login shell gets the contents of .bashrc. The
next thing in our startup file has to do with the PATH variable.

我们可以看到这一小段代码就是一个登录shell得到.bashrc文件内容的方式。在我们启动文件中，
下一件有趣的事与PATH变量有关系。

Ever wonder how the shell knows where to find commands when we enter them on the
command line? For example, when we enter ls, the shell does not search the entire
computer to find /bin/ls (the full pathname of the ls command), rather, it searches a
list of directories that are contained in the PATH variable.

曾经是否迷惑shell是怎样知道到哪里找到我们在命令行中输入的命令的？例如，当我们输入ls后，
shell不会查找整个计算机系统，来找到/bin/ls（ls命令的绝对路径名），而是，它查找一个目录列表，
这些目录包含在PATH变量中。

The PATH variable is often (but not always, depending on the distribution) set by the
/etc/profile startup file and with this code:

PATH变量经常（但不总是，依赖于发行版）在/etc/profile启动文件中设置，通过这些代码：

<div class="code"><pre>
<tt>PATH=$PATH:$HOME/bin</tt>
</pre></div>

PATH is modified to add the directory $HOME/bin to the end of the list. This is an
example of parameter expansion, which we touched on in Chapter 8. To demonstrate
how this works, try the following:

修改PATH变量，添加目录$HOME/bin到目录列表的末尾。这是一个参数展开的实例，
参数展开我们在第八章中提到过。为了说明这是怎样工作的，试试下面的例子：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ foo=&quot;This is some &quot;
[me@linuxbox ~]$ echo $foo
This is some
[me@linuxbox ~]$ foo=$foo&quot;text.&quot;
[me@linuxbox ~]$ echo $foo
This is some text.</tt>
</pre></div>

Using this technique, we can append text to the end of a variable's contents.
By adding the string $HOME/bin to the end of the PATH variable's contents, the
directory $HOME/bin is added to the list of directories searched when a command is
entered. This means that when we want to create a directory within our home directory
for storing our own private programs, the shell is ready to accommodate us. All we have
to do is call it bin, and we’re ready to go.

使用这种技巧，我们可以把文本附加到一个变量值的末尾。通过添加字符串$HOME/bin到PATH变量值
的末尾，则目录$HOME/bin就添加到了命令搜索目录列表中。这意味着当我们想要在自己的主目录下，
创建一个目录来存储我们自己的私人程序时，shell已经给我们准备好了。我们所要做的事就是
把创建的目录叫做bin，赶快行动吧。

Note: Many distributions provide this PATH setting by default. Some Debian
based distributions, such as Ubuntu, test for the existence of the ~/bin directory at
login, and dynamically add it to the PATH variable if the directory is found.

注意：很多发行版默认地提供了这个PATH设置。一些基于Debian的发行版，例如Ubuntu，在登录
的时候，会检测目录~/bin是否存在，若找到目录则把它动态地加到PATH变量中。

Lastly, we have:

最后，有下面一行代码：

<div class="code"><pre>
<tt>export PATH</tt>
</pre></div>

The export command tells the shell to make the contents of PATH available to child
processes of this shell.

export命令告诉shell让这个shell的子进程可以使用PATH变量的内容。

Modifying The Environment

### 修改shell环境

Since we know where the startup files are and what they contain, we can modify them to
customize our environment.

既然我们知道了启动文件所在的位置和它们所包含的内容，我们就可以修改它们来定制自己的shell环境。

Which Files Should We Modify?

### 我们应该修改哪个文件？

As a general rule, to add directories to your PATH, or define additional environment
variables, place those changes in .bash_profile (or equivalent, according to your
distribution. For example, Ubuntu uses .profile.) For everything else, place the
changes in .bashrc. Unless you are the system administrator and need to change the
defaults for all users of the system, restrict your modifications to the files in your home
directory. It is certainly possible to change the files in /etc such as profile, and in
many cases it would be sensible to do so, but for now, let's play it safe.

按照通常的规则，添加目录到你的PATH变量或者是定义额外的环境变量，要把这些更改放置到
.bash_profile文件中（或者其替代文件中，根据不同的发行版。例如，Ubuntu使用.profile文件。）
对于其它的更改，要放到.bashrc文件中。除非你是系统管理员，需要为系统中的所有用户修改
默认设置，那么则限定你只能对自己主目录下的文件进行修改。当然，有可能会更改/etc目录中的
文件，比如说profile文件，而且在许多情况下，修改这些文件也是明智的，但是现在，我们要
安全起见。

Activating Our Changes

### 激活我们的修改

The changes we have made to our .bashrc will not take affect until we close our
terminal session and start a new one, since the .bashrc file is only read at the
beginning of a session. However, we can force bash to re-read the modified .bashrc
file with the following command:

我们对于文件.bashrc的修改不会生效，直到我们关闭终端会话，再重新启动一个新的会话，
因为.bashrc文件只是在刚开始启动终端会话时读取。然而，我们可以强迫bash重新读取修改过的
.bashrc文件，使用下面的命令：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ source .bashrc</tt>
</pre></div>

After doing this, we should be able to see the effect of our changes. Try out one of the
new aliases:

运行上面命令之后，我们就应该能够看到所做修改的效果了。试试其中一个新的别名：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ll</tt>
</pre></div>

Summing Up

### 总结

In this chapter we learned an essential skill—editing configuration files with a text
editor. Moving forward, as we read man pages for commands, take note of the
environment variables that commands support. There may be a gem or two. In later
chapters, we will learn about shell functions, a powerful feature that you can also include
in the bash startup files to add to your arsenal of custom commands.

在这一章中，我们学到了用文本编辑器来编辑配置文件的必要技巧。随着继续学习，当我们
读到命令的手册页时，记录下命令所支持的环境变量。可能会有一个或两个宝贝。在随后的章节
里面，我们将会学习shell函数，一个很强大的特性，你可以把它包含在bash启动文件里面，以此
来添加你自定制的命令宝库。

Further Reading

### 拓展阅读

The INVOCATION section of the bash man page covers the bash startup files
in gory detail.

bash手册页的INVOCATION部分非常详细地讨论了bash启动文件。


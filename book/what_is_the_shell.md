---
layout: book
title: 什么是shell 
---
2 – What Is The Shell?

### 2 — 什么是Shell?

When we speak of the command line, we are really referring to the shell. The
shell is a program that takes keyboard commands and passes them to the
operating system to carry out. Almost all Linux distributions supply a shell
program from the GNU Project called bash. The name “bash” is an acronym for
“Bourne Again SHell”, a reference to the fact bash is an enhanced replacement
for sh, the original Unix shell program written by Steve Bourne.

当一说到命令行，我们真正指的是shell。shell就是一个程序，它接受从键盘输入的命令，
然后把命令传递给操作系统去执行。几乎所有的Linux发行版都提供一个shell程序，
它来自于名为bash的GNU项目。“bash”是“Bourne Again SHell”的首字母缩写，
所指的是这样一个事实，bash是sh的增强版，sh是最初Unix的shell程序，由Steve Bourne写成。

Terminal Emulators

### 终端仿真器

When using a graphical user interface, we need another program called a
terminal emulator to interact with the shell. If we look through our desktop
menus, we will probably find one. KDE uses konsole and GNOME uses
gnome-terminal, though it's likely called simply “terminal” on our menu. There
are a number of other terminal emulators available for Linux, but they all
basically do the same thing; give us access to the shell. You will probably
develop a preference for one or another based on the number of bells and
whistles it has.

当使用图形用户界面时，我们需要另一个叫做终端仿真器的程序，去和shell进行交互。
浏览一下我们的桌面菜单，我们可能会找到一个。虽然在菜单里它可能都
被简单地称为“terminal”，但是KDE用的是konsole程序, 而GNOME则使用gnome-terminal。
还有其他一些终端仿真器可供Linux使用，但基本上，它们都是为了完成同样的事情，
让我们能访问shell。也许，你会喜欢上这个或那个终端，因为它所附加的一系列花俏功能。

Your First Keystrokes

### 第一次按键

So let's get started. Launch the terminal emulator! Once it comes up, we
should see something like this:

好，开始吧。启动终端仿真器！一旦它运行起来，我们应该能够看到一行类似下面文字的输出：

<div class="code"><pre>
<tt>[me@linuxbox ~]$</tt>
</pre>
</div>

This is called a shell prompt and it will appear whenever the shell is ready
to accept input. While it may vary in appearance somewhat depending on the
distribution, it will usually include your username@machinename, followed by
the current working directory (more about that in a little bit) and a dollar
sign.

这叫做shell提示符，当shell准备好了去接受输入时，它就会出现。然而，
它可能会以各种各样的面孔显示，这则取决于不同的Linux发行版，
它通常包括你的，用户名@主机名，紧接着当前工作目录（关于它的知识有点多）和一个美元符号。

If the last character of the prompt is a pound sign (“#”) rather than a dollar
sign, the terminal session has superuser privileges. This means either we are
logged in as the root user or we selected a terminal emulator that provides
superuser (administrative) privileges.

如果提示符的最后一个字符是“#”, 而不是“$”, 那么这个终端会话就有超级用户权限。
这意味着，我们或是以根用户的身份登录的，或者是我们选择的终端仿真器，
提供超级用户（管理员）权限。

Assuming that things are good so far, let's try some typing. Type some
gibberish at the prompt like so:

假定到目前为止，所有事情都进行顺利，那我们试着打字吧。在提示符下敲入
一些乱七八糟的无用数据，如下所示：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ kaekfjaeifj</tt>
</pre></div>

Since this command makes no sense, the shell will tell us so and give us
another chance:

因为这个命令没有任何意义，所以shell会提示错误信息，并让我们再试一下：

<div class="code"><pre>
<tt>bash: kaekfjaeifj: command not found
[me@linuxbox ~]$
</tt>
</pre></div>

Command History

### 命令历史

If we press the up-arrow key, we will see that the previous command “kaekfjaeifj”
reappears after the prompt. This is called command history. Most Linux distributions
remember the last five hundred commands by default. Press the down-arrow key and the
previous command disappears.

如果按下上箭头按键，我们会看到刚才输入的命令“kaekfjaeifj”重新出现在提示符之后。
这就叫做命令历史。许多Linux发行版默认保存最后输入的500个命令。
按下下箭头按键，先前输入的命令就消失了。

Cursor Movement

### 移动鼠标

Recall the previous command with the up-arrow key again. Now try the left and right-arrow keys. 
See how we can position the cursor anywhere on the command line? This makes editing commands easy.

可借助上箭头按键，来回想起上次输入的命令。现在试着使用左右箭头按键。
看一下怎样把鼠标定位到命令行的任意位置？通过使用箭头按键，使编辑命令变得轻松些。

A Few Words About Mice And Focus

### 关于鼠标和光标

While the shell is all about the keyboard, you can also use a mouse with your
terminal emulator. There is a mechanism built into the X Window System (the
underlying engine that makes the GUI go) that supports a quick copy and paste
technique. If you highlight some text by holding down the left mouse button and
dragging the mouse over it (or double clicking on a word), it is copied into a
buffer maintained by X. Pressing the middle mouse button will cause the text to
be pasted at the cursor location. Try it.

虽然，shell是和键盘打交道的，但你也可以在终端仿真器里使用鼠标。X窗口系统
（使GUI工作的底层引擎）内建了一种机制，支持快速拷贝和粘贴技巧。
如果，你想高亮一些文本，可以按下鼠标左键，沿着文本拖动鼠标（或者双击一个单词），
那么这些高亮的文本就被拷贝到了一个由X管理的缓冲区里面。然后按下鼠标中键，
这些文本就被粘贴到光标所在的位置。试试看。

Note: Don't be tempted to use Ctrl-c and Ctrl-v to perform copy and paste
inside a terminal window. They don't work. These control codes have different
meanings to the shell and were assigned many years before Microsoft Windows.

注意： 不要受诱惑在一个终端窗口里，使用Ctrl-c和Ctrl-v快捷键，去执行拷贝和粘贴操作。
它们不起作用。对于shell,这些控制代码有着不同的含义，它们被赋值，
早于Microsoft Windows许多年。

Your graphical desktop environment (most likely KDE or GNOME), in an effort
to behave like Windows, probably has its focus policy set to “click to focus.”
This means for a window to get focus (become active) you need to click on it.
This is contrary to the traditional X behavior of “focus follows mouse” which
means that a window gets focus by just passing the mouse over it. The window
will not come to the foreground until you click on it but it will be able to receive
input. Setting the focus policy to “focus follows mouse” will make the copy and
paste technique even more useful. Give it a try. I think if you give it a chance
you will prefer it. You will find this setting in the configuration program for your
window manager.

你的图形桌面环境（像KDE或GNOME），努力想和Windows一样，可能把它的聚焦策略
设置成“单击聚焦”。这意味着，为了让窗口聚焦（变得活跃）你需要单击它。
这与“聚焦跟随着鼠标”的传统X行为相反，传统X行为是指只要把鼠标移动到一个窗口的上方，
这个窗口就成为活动窗口。这个窗口不会成为前端窗口，直到你单击它，但它能接受输入。
设置聚焦策略为“聚焦跟随着鼠标”，可以使拷贝和粘贴技巧更有益。尝试一下。
给它一个机会，我想你会喜欢上它的。在窗口管理器的配置程序中，你会找到这个设置。

Try Some Simple Commands

### 试试运行一些简单命令

Now that we have learned to type, let's try a few simple commands. The first one is
date. This command displays the current time and date.

现在，我们学习了怎样输入命令，那我们执行一些简单的命令吧。第一个命令是date。
这个命令显示系统当前时间和日期。

<div class="code"><pre>
<tt>[me@linuxbox ~]$ date
Thu Oct 25 13:51:54 EDT 2007
</tt>
</pre></div>

A related command is cal which, by default, displays a calendar of the current month.

一个相关联的命令，cal，它默认显示当前月份的日历。

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cal
October 2007
Su Mo Tu We Th Fr Sa
1 2 3 4 5 6
7 8 9 10 11 12 13
14 15 16 17 18 19 20
21 22 23 24 25 26 27
28 29 30 31
</tt>
</pre></div>

To see the current amount of free space on your disk drives, type df:

查看磁盘剩余空间的数量，输入df:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda2             15115452   5012392   9949716  34% /
/dev/sda5             59631908  26545424  30008432  47% /home
/dev/sda1               147764     17370   122765   13% /boot
tmpfs                   256856         0   256856    0% /dev/shm
</tt>
</pre></div>

Likewise, to display the amount of free memory, type the free command.

同样地，显示空闲内存的数量，输入命令free。

<div class="code"><pre>
<tt>[me@linuxbox ~]$ free
total       used       free     shared    buffers     cached
Mem:       2059676     846456    1213220          0
44028      360568
-/+ buffers/cache:     441860    1617816
Swap:      1042428          0    1042428
</tt>
</pre></div>

Ending A Terminal Session

### 结束终端会话

We can end a terminal session by either closing the terminal emulator window, or by
entering the exit command at the shell prompt:

我们可以终止一个终端会话，通过关闭终端仿真器窗口，或者是在shell提示符下输入exit命令：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ exit</tt>
</pre></div>

The Console Behind The Curtain

### 幕后控制台

Even if we have no terminal emulator running, several terminal sessions
continue to run behind the graphical desktop. Called virtual terminals or
virtual consoles, these sessions can be accessed on most Linux distributions
by pressing Ctrl- Alt-F1 through Ctrl-Alt-F6 on most systems. When a session
is accessed, it presents a login prompt into which we can enter our user name
and password.  To switch from one virtual console to another, press Alt and
F1-F6. To return to the graphical desktop, press Alt-F7.

即使，终端仿真器没有运行，几个终端会话仍然在后台运行着。它们叫做虚拟终端
或者是虚拟控制台。在大多数Linux 发行版中，这些终端会话都可以访问，
按下Ctrl-Alt-F1到Ctrl-Alt-F6访问不同的虚拟终端。当一个会话被访问的时候，
它会显示登录提示框，我们要输入用户名和密码。从一个虚拟控制台转换到另一个，
按下 Alt 和 F1-F6。返回图形桌面，按下Alt-F7。

Further Reading

### 扩展阅读

To learn more about Steve Bourne, father of the Bourne Shell, see this
Wikipedia article:

*  想了解更多关于Steve Bourne的故事，Bourne Shell之父，读一下这篇文章：

   <http://en.wikipedia.org/wiki/Steve_Bourne>

Here is an article about the concept of shells in computing:

*  这是一篇关于在计算机领域里，shells概念的文章：

   <http://en.wikipedia.org/wiki/Shell_(computing)>


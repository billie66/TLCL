---
layout: book
title: 什么是 shell
---

When we speak of the command line, we are really referring to the shell. The
shell is a program that takes keyboard commands and passes them to the
operating system to carry out. Almost all Linux distributions supply a shell
program from the GNU Project called bash. The name “bash” is an acronym for
“Bourne Again SHell”, a reference to the fact bash is an enhanced replacement
for sh, the original Unix shell program written by Steve Bourne.

一说到命令行，我们真正指的是 shell。shell 就是一个程序，它接受从键盘输入的命令，
然后把命令传递给操作系统去执行。几乎所有的 Linux 发行版都提供一个名为 bash 的
来自 GNU 项目的 shell 程序。“bash” 是 “Bourne Again SHell” 的首字母缩写，
所指的是这样一个事实，bash 是最初 Unix 上由 Steve Bourne 写成 shell 程序 sh 的增强版。

### 终端仿真器

When using a graphical user interface, we need another program called a
terminal emulator to interact with the shell. If we look through our desktop
menus, we will probably find one. KDE uses konsole and GNOME uses
gnome-terminal, though it's likely called simply “terminal” on our menu. There
are a number of other terminal emulators available for Linux, but they all
basically do the same thing; give us access to the shell. You will probably
develop a preference for one or another based on the number of bells and
whistles it has.

当使用图形用户界面时，我们需要另一个和 shell 交互的叫做终端仿真器的程序。
如果我们浏览一下桌面菜单，可能会找到一个。虽然在菜单里它可能都
被简单地称为 “terminal”，但是 KDE 用的是 konsole , 而 GNOME 则使用 gnome-terminal。
还有其他一些终端仿真器可供 Linux 使用，但基本上，它们都完成同样的事情，
让我们能访问 shell。也许，你可能会因为附加的一系列花俏功能而喜欢上某个终端。

### 第一次按键

So let's get started. Launch the terminal emulator! Once it comes up, we should see somehing like this:

好，开始吧。启动终端仿真器！一旦它运行起来，我们应该看到一行像这样的文字：

    [me@linuxbox ~]$

This is called a shell prompt and it will appear whenever the shell is ready
to accept input. While it may vary in appearance somewhat depending on the
distribution, it will usually include your username@machinename, followed by
the current working directory (more about that in a little bit) and a dollar
sign.

这叫做 shell 提示符，无论何时当 shell 准备好了去接受输入时，它就会出现。然而，
它可能会以各种各样的面孔显示，这则取决于不同的 Linux 发行版，
它通常包括你的用户名@主机名，紧接着当前工作目录（稍后会有更多介绍）和一个美元符号。

If the last character of the prompt is a pound sign (“#”) rather than a dollar
sign, the terminal session has superuser privileges. This means either we are
logged in as the root user or we selected a terminal emulator that provides
superuser (administrative) privileges.

如果提示符的最后一个字符是“#”, 而不是“$”, 那么这个终端会话就有超级用户权限。
这意味着，我们或者是以 root 用户的身份登录，或者是我们选择的终端仿真器提供超级用户（管理员）权限。

Assuming that things are good so far, let's try some typing. Type some
gibberish at the prompt like so:

假定到目前为止，所有事情都进行顺利，那我们试着键入字符吧。在提示符下敲入
一些像下面一样的乱七八糟的字符：

    [me@linuxbox ~]$ kaekfjaeifj

Since this command makes no sense, the shell will tell us so and give us
another chance:

因为这个命令没有任何意义，所以 shell 会提示错误信息，并让我们再试一下：

    bash: kaekfjaeifj: command not found
    [me@linuxbox ~]$

### 命令历史

If we press the up-arrow key, we will see that the previous command “kaekfjaeifj”
reappears after the prompt. This is called command history. Most Linux distributions
remember the last five hundred commands by default. Press the down-arrow key and the
previous command disappears.

如果按下上箭头按键，我们会看到刚才输入的命令“kaekfjaeifj”重新出现在提示符之后。
这就叫做命令历史。许多 Linux 发行版默认保存最后输入的500个命令。
按下下箭头按键，先前输入的命令就消失了。

### 移动光标

Recall the previous command with the up-arrow key again. Now try the left and right-arrow keys.
See how we can position the cursor anywhere on the command line? This makes editing commands easy.

可借助上箭头按键，来获得上次输入的命令。现在试着使用左右箭头按键。
看一下怎样把光标定位到命令行的任意位置？通过使用箭头按键，使编辑命令变得轻松些。

### 关于鼠标和光标

While the shell is all about the keyboard, you can also use a mouse with your
terminal emulator. There is a mechanism built into the X Window System (the
underlying engine that makes the GUI go) that supports a quick copy and paste
technique. If you highlight some text by holding down the left mouse button and
dragging the mouse over it (or double clicking on a word), it is copied into a
buffer maintained by X. Pressing the middle mouse button will cause the text to
be pasted at the cursor location. Try it.

虽然，shell 是和键盘打交道的，但你也可以在终端仿真器里使用鼠标。X 窗口系统
（使 GUI 工作的底层引擎）内建了一种机制，支持快速拷贝和粘贴技巧。
如果你按下鼠标左键，沿着文本拖动鼠标（或者双击一个单词）高亮了一些文本，
那么这些高亮的文本就被拷贝到了一个由 X 管理的缓冲区里面。然后按下鼠标中键，
这些文本就被粘贴到光标所在的位置。试试看。

Note: Don't be tempted to use Ctrl-c and Ctrl-v to perform copy and paste
inside a terminal window. They don't work. These control codes have different
meanings to the shell and were assigned many years before Microsoft Windows.

注意： 不要在一个终端窗口里使用 Ctrl-c 和 Ctrl-v 快捷键来执行拷贝和粘贴操作。
它们不起作用。对于 shell 来说，这两个控制代码有着不同的含义，它们在早于 
Microsoft Windows （定义复制粘贴的含义）许多年之前就赋予了不同的意义。

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

你的图形桌面环境（像 KDE 或 GNOME），努力想和 Windows 一样，可能会把它的聚焦策略
设置成“单击聚焦”。这意味着，为了让窗口聚焦（变成活动窗口）你需要单击它。
这与“聚焦跟随着鼠标”的传统 X 行为不同，传统 X 行为是指只要把鼠标移动到一个窗口的上方。
它能接受输入， 但是直到你单击窗口之前它都不会成为前端窗口。
设置聚焦策略为“聚焦跟随着鼠标”，可以使拷贝和粘贴更方便易用。尝试一下。
我想如果你试了一下你会喜欢上它的。你能在窗口管理器的配置程序中找到这个设置。

### 试试运行一些简单命令

Now that we have learned to type, let's try a few simple commands. The first one is
date. This command displays the current time and date.

现在，我们学习了怎样输入命令，那我们执行一些简单的命令吧。第一个命令是 date。
这个命令显示系统当前时间和日期。

    [me@linuxbox ~]$ date
    Thu Oct 25 13:51:54 EDT 2007

A related command is cal which, by default, displays a calendar of the current month.

一个相关联的命令，cal，它默认显示当前月份的日历。

    [me@linuxbox ~]$ cal
    October 2007
    Su Mo Tu We Th Fr Sa
    1 2 3 4 5 6
    7 8 9 10 11 12 13
    14 15 16 17 18 19 20
    21 22 23 24 25 26 27
    28 29 30 31

To see the current amount of free space on your disk drives, type df:

查看磁盘剩余空间的数量，输入 df:

    [me@linuxbox ~]$ df
    Filesystem           1K-blocks      Used Available Use% Mounted on
    /dev/sda2             15115452   5012392   9949716  34% /
    /dev/sda5             59631908  26545424  30008432  47% /home
    /dev/sda1               147764     17370   122765   13% /boot
    tmpfs                   256856         0   256856    0% /dev/shm

Likewise, to display the amount of free memory, type the free command.

同样地，显示空闲内存的数量，输入命令 free。

    [me@linuxbox ~]$ free
    total       used       free     shared    buffers     cached
    Mem:       2059676     846456    1213220          0
    44028      360568
    -/+ buffers/cache:     441860    1617816
    Swap:      1042428          0    1042428

### 结束终端会话

We can end a terminal session by either closing the terminal emulator window, or by
entering the exit command at the shell prompt:

我们可以通过关闭终端仿真器窗口，或者是在 shell 提示符下输入 exit 命令来终止一个终端会话：

    [me@linuxbox ~]$ exit

### 幕后控制台

Even if we have no terminal emulator running, several terminal sessions
continue to run behind the graphical desktop. Called virtual terminals or
virtual consoles, these sessions can be accessed on most Linux distributions
by pressing Ctrl- Alt-F1 through Ctrl-Alt-F6 on most systems. When a session
is accessed, it presents a login prompt into which we can enter our user name
and password.  To switch from one virtual console to another, press Alt and
F1-F6. To return to the graphical desktop, press Alt-F7.

即使终端仿真器没有运行，在后台仍然有几个终端会话运行着。它们叫做虚拟终端
或者是虚拟控制台。在大多数 Linux 发行版中，这些终端会话都可以通过按下
Ctrl-Alt-F1 到 Ctrl-Alt-F6 访问。当一个会话被访问的时候，
它会显示登录提示框，我们需要输入用户名和密码。要从一个虚拟控制台转换到另一个，
按下 Alt 和 F1-F6(中的一个)。返回图形桌面，按下 Alt-F7。

### 拓展阅读

To learn more about Steve Bourne, father of the Bourne Shell, see this
Wikipedia article:

*  想了解更多关于 Steve Bourne 的故事，Bourne Shell 之父，读一下这篇文章：

    <http://en.wikipedia.org/wiki/Steve_Bourne>

Here is an article about the concept of shells in computing:

*  这是一篇关于在计算机领域里，shells 概念的文章：

    <http://en.wikipedia.org/wiki/Shell_(computing)>

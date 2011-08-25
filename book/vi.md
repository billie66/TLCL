---
layout: book
title: vi 简介 
---

13 - a gentle introduction to vi

There is an old joke about a visitor to New York City asking a passerby for directions to
the city's famous classical music venue:

Visitor: Excuse me, how do I get to Carnegie Hall?

Passerby: Practice, practice, practice!

有一个古老的笑话，说是一个在纽约的游客向行人打听这座城市中著名古典音乐场馆的方向：

游客： 请问一下，我怎样去卡内基音乐大厅？

行人： 练习，练习，练习!

Learning the Linux command line, like becoming an accomplished pianist, is not
something that we pick up in an afternoon. It takes years of practice. In this chapter, we
will introduce the vi (pronounced “vee eye”) text editor, one of the core programs in the
Unix tradition. vi is somewhat notorious for its difficult user interface, but when we see
a master sit down at the keyboard and begin to “play,” we will indeed be witness to some
great art. We won't become masters in this chapter, but when we are done, we will know
how to play “chopsticks” in vi.

学习Linux命令行，就像要成为一名造诣很深的钢琴家一样，它不是我们一下午就能学会的技能。这需要
经历几年的勤苦练习。在这一章中，我们将介绍vi（发音“vee eye”）文本编辑器，它是Unix传统中核心程序之一。
vi因它难用的用户界面而有点声名狼藉，但是当我们看到一位大师坐在钢琴前开始演奏时，我们的确成了
伟大艺术的见证人。虽然我们在这里不能成为vi大师，但是当我们学完这一章后，
我们会知道怎样在vi中玩“筷子”。

Why We Should Learn vi

### 为什么我们应该学习vi

In this modern age of graphical editors and easy-to-use text-based editors such as nano,
why should we learn vi? There are three good reasons:

在现在这个图形编辑器和易于使用的基于文本编辑器的时代，比如说nano，为什么我们还应该学习vi呢？
下面有三个充分的理由：

* vi is always available. This can be a lifesaver if we have a system with no
  graphical interface, such as a remote server or a local system with a broken X
  configuration. nano, while increasingly popular is still not universal. POSIX, a
  standard for program compatibility on Unix systems, requires that vi be present.

* vi总是可用的。如果我们的系统没有图形界面，比方说一台远端服务器或者是一个
  X配置损坏了的本地系统，那么vi就成了我们的救星。虽然nano逐渐流行起来，但是它
  还没有普及。POSIX，Unix系统中程序兼容标准，要求自带vi。

* vi is lightweight and fast. For many tasks, it's easier to bring up vi than it is to
  find the graphical text editor in the menus and wait for its multiple megabytes to
  load. In addition, vi is designed for typing speed. As we shall see, a skilled vi
  user never has to lift his or her fingers from the keyboard while editing.

* vi是轻量级且执行快速的编辑器。对于许多任务来说，启动vi比起在菜单中找到一个图形化文本编辑器，
  再等待编辑器数倍兆字节的数据加载而言，要容易的多。另外，vi是为了加快输入速度而设计的。
  我们将会看到，当一名熟练的vi用户在编辑文件时，他或她的手从不需要移开键盘。

* We don't want other Linux and Unix users to think we are sissies.

* 我们不希望其他Linux和Unix用户把我们看作胆小鬼。

Okay, maybe two good reasons.

好吧，可能只有两个充分的理由。

A Little Background

### 一点儿背景介绍

The first version of vi was written in 1976 by Bill Joy, a University of California at
Berkley student who later went on to co-found Sun Microsystems. vi derives its name
from the word “visual,” because it was intended to allow editing on a video terminal with
a moving cursor. Previous to visual editors, there were line editors which operated on a
single line of text at a time. To specify a change, we tell a line editor to go to a particular
line and describe what change to make, such as adding or deleting text. With the advent
of video terminals (rather than printer-based terminals like teletypes) visual editing
became possible. vi actually incorporates a powerful line editor called ex, and we can
use line editing commands while using vi.

第一版vi是在1976由Bill Joy写成的，当时他是加州大学伯克利分校的学生，
后来他共同创建了Sun微系统公司。vi这个名字
来源于单词“visual”，因为它打算在带有可移动光标的视频终端上编辑文本。在发明可视化编辑器之前，
有一次只能操作一行文本的行编辑器。为了指定一个修改，我们告诉行编辑器到一个特殊行并且
说明做什么修改，比方说添加或删除文本。视频终端（而不是基于打印机的终端，像电传打印机）的出现
，可视化编辑成为可能。vi实际上整合了一个强大的叫做ex行编辑器,
所以我们在使用vi时能运行行编辑命令。 

Most Linux distributions don't include real vi; rather, they ship with an enhanced
replacement called vim (which is short for “vi improved”) written by Bram Moolenaar.
vim is a substantial improvement over traditional Unix vi and is usually symbolically
linked (or aliased) to the name “vi” on Linux systems. In the discussions that follow, we
will assume that we have a program called “vi” that is really vim.

大多数Linux发行版不包含真正的vi；而是自带一款高级替代版本，叫做vim（它是“vi
improved”的简写）由Bram Moolenaar开发的。vim相对于传统的Unix
vi来说，取得了实质性进步。通常，vim在Linux系统中是“vi”的符号链接（或别名）。
在随后的讨论中，我们将会假定我们有一个叫做“vi”的程序，但它其实是vim。

Starting And Stopping vi

### 启动和停止vi

To start vi, we simply type the following:

要想启动vi，只要简单地输入以下命令：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ vi</tt>
</pre></div>

And a screen like this should appear:

一个像这样的屏幕应该出现：

<div class="code"><pre>
<tt><center>VIM - Vi Improved
....</center></tt>
</pre></div>

Just as we did with nano earlier, the first thing to learn is how to exit. To exit, we enter
the following command (note that the colon character is part of the command):

正如我们之前操作nano时，首先要学的是怎样退出vi。要退出vi，输入下面的命令（注意冒号是命令的一部分）：

<div class="code"><pre>
<tt>:q</tt>
</pre></div>

The shell prompt should return. If, for some reason, vi will not quit (usually because we
made a change to a file that has not yet been saved), we can tell vi that we really mean it
by adding an exclamation point to the command:

shell提示符应该返回。如果由于某种原因，vi不能退出（通常因为我们对文件做了修改，却没有保存文件）。
通过给命令加上叹号，我们可以告诉vi我们真要退出vi。

<div class="code"><pre>
<tt>:q!</tt>
</pre></div>

Tip: If you get “lost” in vi, try pressing the Esc key twice to find your way again.

小贴示：如果你在vi中“迷失”了，试着按下Esc键两次来找到路（回到普通模式）。

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>Compatibility Mode</h3>
<p>In the example startup screen above (taken from Ubuntu 8.04), we see the text
“Running in Vi compatible mode.” This means that vim will run in a mode that
is closer to the normal behavior of vi rather than the enhanced behavior of vim.
For purposes of this chapter, we will want to run vim with its enhanced behavior.
To do this, you have a few options: </p>

<P>上面实例中的启动屏幕（来自于Ubuntu
8.04），我们看到一行文字“以Vi兼容的模式运行”。这意味着vim将以近似于vi常规的模式
运行，而不是vim的高级规范。为了这章的目的，我们想要使用vim的高级规范。要想这样做，
你有几个选择：</P>

<p>Try running vim instead of vi.</p>

<p>用vim来代替vi。</p>

<p>If that works, consider adding alias vi='vim' to your .bashrc file. </p>

<p>如果命令生效，考虑在你的.bashrc文件中添加别名vi='vim'。</p>

<p>Alternately, use this command to add a line to your vim configuration file: </p>

<p>或者，使用这个命令在你的vim配置文件中添加一行：</p>

<p>echo "set nocp" &gt;&gt; ~/.vimrc </p>

<p>Different Linux distributions package vim in different ways. Some distributions
install a minimal version of vim by default that only supports a limiting set of
vim features. While preforming the lessons that follow, you may encounter
missing features. If this is the case, install the full version of vim.</p>

<p>不同的Linux发行版其vim软件包也迥然不同。一些发行版只是安装了vim的最小版本，
其默认只支持有限的vim特性。当练习随后的课程时，你可能会遇到缺失的功能。
如果是这种情况，就安装vim的完整版。</p>

</td>
</tr>
</table>


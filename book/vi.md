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

Editing Modes

### 编辑模式

Let's start up vi again, this time passing to it the name of a nonexistent file. This is how
we can create a new file with vi:

再次启动vi，这次传递给vi一个不存在的文件名。这也是用vi创建新文件的方法。

<div class="code"><pre>
<tt>[me@linuxbox ~]$ rm -f foo.txt
[me@linuxbox ~]$ vi foo.txt</tt>
</pre></div>

If all goes well, we should get a screen like this:

如果一切运行正常，我们应该获得一个像这样的屏幕：

<div class="code"><pre>
<tt>....
"foo.txt" [New File]</tt>
</pre></div>

The leading tilde characters (”~”) indicate that no text exists on that line. This shows that
we have an empty file. Do not type anything yet!

每行开头的波浪号（"~"）指示那一行不存在文本。这表示我们有一个空文件。还没有输入任何字符？

The second most important thing to learn about vi (after learning how to exit) is that vi
is a modal editor. When vi starts up, it begins in command mode. In this mode, almost
every key is a command, so if we were to start typing, vi would basically go crazy and
make a big mess.

学习vi时，要知道的第二件非常重要的事情是（知道了如何退出vi后）vi是一个模式编辑器。当vi启动后，进入
的是命令模式。这种模式下，几乎每个按键都是一个命令，所以如果我们打算输入字符，vi会发疯，弄得一团糟。

Entering Insert Mode

#### 插入模式

In order to add some text to our file, we must first enter insert mode. To do this, we press
the “i” key. Afterwards, we should see the following at the bottom of the screen if vim is
running in its usual enhanced mode (this will not appear in vi compatible mode):

为了在文件中添加文本，首先我们必须进入插入模式。按下"i"按键进入插入模式。之后，我们应该
在屏幕底部看到下面一行，如果vi运行在高级模式下（这不会出现在vi兼容模式下）：

<div class="code"><pre>
<tt>-- INSERT --</tt>
</pre></div>

Now we can enter some text. Try this:

现在我们能输入一些文本了。试着输入这些文本：

<div class="code"><pre>
<tt>The quick brown fox jumped over the lazy dog.</tt>
</pre></div>

To exit insert mode and return to command mode, press the Esc key.

按下Esc按键，退出插入模式并返回命令模式。

Saving Our Work

#### 保存我们的工作

To save the change we just made to our file, we must enter an ex command while in
command mode. This is easily done by pressing the “:” key. After doing this, a colon
character should appear at the bottom of the screen:

为了保存我们刚才对文件所做的修改，我们必须在命令模式下输入一个ex命令。
通过按下":"键，这很容易完成。按下冒号键之后，一个冒号字符应该出现在屏幕的底部：

<div class="code"><pre>
<tt>:</tt>
</pre></div>

To write our modified file, we follow the colon with a “w” then Enter:

为了写入我们修改的文件，我们在冒号之后输入"w"字符，然后按下回车键：

<div class="code"><pre>
<tt>:w</tt>
</pre></div>

The file will be written to the hard drive and we should get a confirmation message at the
bottom of the screen, like this:

文件将会写入到硬盘，并且我们应该在屏幕底部得到一个确认信息，就像这样：

<div class="code"><pre>
<tt>"foo.txt" [New] 1L, 46C written</tt>
</pre></div>

Tip: If you read the vim documentation, you will notice that (confusingly)
command mode is called normal mode and ex commands are called command
mode. Beware.

小贴示：如果你阅读vim的文档，你注意到（混淆地）命令模式被叫做普通模式，ex命令
叫做命令模式。当心。

Moving The Cursor Around

### 移动光标

While in command mode, vi offers a large number of movement commands, some of
which it shares with less. Here is a subset:

当在vi命令模式下时，vi提供了大量的移动命令，其中一些是与less阅读器共享的。这里
列举了一些：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 13-1: Cursor Movement Keys</caption>
<tr>
<th class="title">Key</th>
<th class="title">Move The Cursor</th>
</tr>
<tr>
<td valign="top" width="25%">l or Right Arrow </td>
<td valign="top">Right one character.</td>
</tr>
<tr>
<td valign="top">h or Left Arrow </td>
<td valign="top">Left one character</td>
</tr>
<tr>
<td valign="top">j or Down Arrow</td>
<td valign="top">Down one line</td>
</tr>
<tr>
<td valign="top">k or Up Arrow </td>
<td valign="top">Up one line</td>
</tr>
<tr>
<td valign="top">0 (zero) </td>
<td valign="top">To the beginning of the current line.</td>
</tr>
<tr>
<td valign="top">^</td>
<td valign="top">To the first non-whitespace character on the current line.</td>
</tr>
<tr>
<td valign="top">$</td>
<td valign="top">To the end of the current line.</td>
</tr>
<tr>
<td valign="top">w</td>
<td valign="top">To the beginning of the next word or puntuation character.</td>
</tr>
<tr>
<td valign="top">W</td>
<td valign="top">To the beginning of the next word, ignoring puntuation character.</td>
</tr>
<tr>
<td valign="top">b</td>
<td valign="top">To the beginning of the previous word or punctuation character.</td>
</tr>
<tr>
<td valign="top">B</td>
<td valign="top">To the beginning of the previous word, ignoring
punctuation characters.</td>
</tr>
<tr>
<td valign="top">Ctrl-f or Page Down </td>
<td valign="top">Down one page.</td>
</tr>
<tr>
<td valign="top">Ctrl-b or Page Up </td>
<td valign="top">Up one page.</td>
</tr>
<tr>
<td valign="top">numberG</td>
<td valign="top">To line number. For example, 1G moves to the first
line of the file.</td>
</tr>
<tr>
<td valign="top">G</td>
<td valign="top">To the last line of the file.</td>
</tr>
</table>
</p>

Why are the h, j, k, and l keys used for cursor movement? Because when vi was
originally written, not all video terminals had arrow keys, and skilled typists could use
regular keyboard keys to move the cursor without ever having to lift their fingers from
the keyboard.

为什么h，j，k，和l按键被用来移动光标呢？因为在开发vi之初，并不是所有的视频终端都有
箭头按键，熟练的打字员可以使用规则的键盘按键来移动光标，他们的手从不需要移开键盘。

Many commands in vi can be prefixed with a number, as with the “G” command listed
above. By prefixing a command with a number, we may specify the number of times a
command is to be carried out. For example, the command “5j” causes vi to move the
cursor down five lines.

vi中的许多命令都可以在前面加上一个数字，比方说上面提到的"G"命令。在命令之前加上一个
数字，我们就可以指定命令执行的次数。例如，命令"5j"导致vi向下移动5行。

Basic Editing

### 基本编辑

Most editing consists of a few basic operations such as inserting text, deleting text and
moving text around by cutting and pasting. vi, of course, supports all of these
operations in its own unique way. vi also provides a limited form of undo. If we press
the “u” key while in command mode, vi will undo the last change that you made. This
will come in handy as we try out some of the basic editing commands.

大多数编辑工作由一些基本的操作组成，比如说插入文本，删除文本和通过剪切和粘贴来移动文本。
vi，当然，以它自己的独特方式来支持所有的操作。vi也提供了有限的撤销形式。如果我们按下“u”
按键，当在命令模式下，vi将会撤销你所做的最后一次修改。当我们试着执行一些基本的
编辑命令时，这会很方便。

Appending Text

#### 追加文本

vi has several different ways of entering insert mode. We have already used the i
command to insert text.

vi有几种不同进入插入模式的方法。我们已经使用了i命令来插入文本。

Let's go back to our foo.txt file for a moment:

让我们返回到我们的foo.txt文件中，呆一会儿：

<div class="code"><pre>
<tt>The quick brown fox jumped over the lazy dog.</tt>
</pre></div>

If we wanted to add some text to the end of this sentence, we would discover that the i
command will not do it, since we can't move the cursor beyond the end of the line. vi
provides a command to append text, the sensibly named “a” command. If we move the
cursor to the end of the line and type “a”, the cursor will move past the end of the line
and vi will enter insert mode. This will allow us to add some more text:

如果我们想要在这个句子的末尾添加一些文本，我们会发现i命令不能完成任务，因为我们不能把
光标移到行尾。

<div class="code"><pre>
<tt>The quick brown fox jumped over the lazy dog. It was cool.</tt>
</pre></div>

Remember to press the Esc key to exit insert mode.

记住按下Esc按键来退出插入模式。

Since we will almost always want to append text to the end of a line, vi offers a shortcut
to move to end of the current line and start appending. It's the “A” command. Let's try it
and add some more lines to our file.

因为我们几乎总是想要在行尾附加文本，所以vi提供了一种快捷方式来移动到当前行的末尾，并且能添加
文本。它是"A"命令。试着用一下它，给文件添加更多行。

First, we'll move the cursor to the beginning of the line using the “0” (zero) command.
Now we type “A” and add the following lines of text:

首先，使用"0"(零)命令，将光标移动到行首。现在我们输入"A"，来添加以下文本行：

<div class="code"><pre>
<tt>The quick brown fox jumped over the lazy dog. It was cool.
Line 2
Line 3
Line 4
Line 5</tt>
</pre></div>

Again, press the Esc key to exit insert mode.

再一次，按下Esc按键退出插入模式。

As we can see, the “A” command is more useful as it moves the cursor to the end of the
line before starting insert mode.

正如我们所看到的，大A命令非常有用，因为在启动插入模式之前，它把光标移动了行尾。

Opening A Line

#### 打开一行

Another way we can insert text is by “opening” a line. This inserts a blank line between
two existing lines and enters insert mode. This has two variants:

我们插入文本的另一种方式是“打开”一行。这会在存在的两行之间插入一个空白行，并且进入插入模式。
这种方式有两个变体：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 13-2: Line Opening Keys</caption>
<tr>
<th class="title">Command </th>
<th class="title">Opens</th>
</tr>
<tr>
<td valign="top" width="25%">o</td>
<td valign="top">The line below the current line.</td>
</tr>
<tr>
<td valign="top">O</td>
<td valign="top">The line above the current line.</td>
</tr>
</table>
</p>

We can demonstrate this as follows: place the cursor on “Line 3” then press the o key.

我们可以演示一下：把光标放到"Line 3"上，按下小o按键。

<div class="code"><pre>
<tt>The quick brown fox jumped over the lazy dog. It was cool.
Line 2
Line 3

line 4
line 5</tt>
</pre></div>

A new line was opened below the third line and we entered insert mode. Exit insert mode
by pressing the Esc key. Press the u key to undo our change.

在第三行之下打开了新的一行，并且进入插入模式。按下Esc，退出插入模式。按下u按键，撤销我们的修改。

Press the O key to open the line above the cursor:

按下大O按键在光标之上打开新的一行：

<div class="code"><pre>
<tt>The quick brown fox jumped over the lazy dog. It was cool.
Line 2

Line 3
Line 4
Line 5</tt>
</pre></div>

Exit insert mode by pressing the Esc key and undo our change by pressing u.

按下Esc按键，退出插入模式，并且按下u按键，撤销我们的更改。

Deleting Text

#### 删除文本

As we might expect, vi offers a variety of ways to delete text, all of which contain one
of two keystrokes. First, the x key will delete a character at the cursor location. x may
be preceded by a number specifying how many characters are to be deleted. The d key is
more general purpose. Like x, it may be preceded by a number specifying the number of
times the deletion is to be performed. In addition, d is always followed by a movement
command that controls the size of the deletion. Here are some examples:

正如我们期望的，vi提供了各种各样的方式来删除文本，所有的方式包含一个或两个按键。首先，
x按键会删除光标位置的一个字符。可以在x命令之前带上一个数字，来指明要删除的字符个数。
d按键更通用一些。类似x命令，d命令之前可以带上一个数字，来指定要执行的删除次数。另外，
d命令之后总是带上一个移动命令，用来控制删除的范围。这里有些实例：


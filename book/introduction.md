---
layout: book
title: 引言 
---
## 1-引言

我要给大家讲个故事。

故事内容不是关于Linus Torvalds在1991年怎样写了linux内核的第一个版本，
因为你可以在许多Linux书籍中读到它。我也不想告诉你，更早之前，Richard Stallman
怎样开始GNU项目，去设计一个免费的类似unix的操作系统。这也是一个很重要的故事，
但大多数Linux书籍也讲到了它。

我想告诉大家一个你如何拿回你的计算机管理权的故事。

在18世纪70年代末，作为一个大学生，当我开始和计算机打交道时，有一场变革正在进行。
微处理器的发明，使普通老百姓，就像你和我，能拥有自己的计算机，成为可能。今天，
人们难以想象，当只有大企业和政府才能够管理计算机的世界，是怎样的一个世界。让我说说看，你想不出多少来。

今天，世界已经日新月异。计算机遍布各个领域，从小手表到大型数据中心，及大小介于它们之间的每件东西。
除了随处可见的计算机之外，我们还有一个无处不在 的连接所有计算机的网络。这已经开创了一个奇妙的，'
个人授权和创作自由的新时代，但是在过去的二三十年里，一些事情一直在发生着。一个大公司一直在把它的
管理权强加于世界上大多数的计算机上，并且决定你能用电脑做什么。幸运地，来自世界各地的人们，
针对这种情况，正在做些事情。他们通过写自己的软件，一直在为维护自己电脑的管理权而战斗着。
他们建立了Linux。

对于Linux，人们都会说到“自由”，但我不认为他们都知道“自由”的真正涵义。“自由”是一种权力，
它决定你的计算机能做什么，同时能够拥有这种“自由”的唯一
方式就是知道计算机正在做什么。“自由”是指一台没有任何秘密的计算机，你可以从它那里了解一切，
只要你用心的去寻找。

### 为什么使用命令行

你是否注意到，在电影中，一个“超级黑客”，坐在电脑前，他能够在30秒内侵入到超安全的军事计算机，
却从不摸一下鼠标。这是因为电影制片人意识到，我们人类本能的知道，让计算机真正地完成
任何工作的唯一方法，就是通过操作键盘。

现在，大多数的计算机用户只是熟悉图形用户界面（GUI），并且产品供应商和此领域的学者会灌输给用户这样的思想，
命令行界面（CLI）是过去使用的一种很恐怖的东西。这就很不幸，因为一个友好的命令行界面，
是和计算机交流沟通，正如像人类社会使用文字互通信息一样。据说，“图形用户界面让简单的任务更容易完成，
而命令行界面使完成复杂的任务成为可能”，到现在这句话仍然很正确。

因为Linux是以Unix家族的操作系统为模型写成的，所以它分享了Unix丰富的命令行工具。
Unix在18世纪80年代初，显赫一时(虽然，开发它在更早之前），在广泛地使用图形界面之前，
导致，开发一种全面的命令行界面。事实上，一个主要的原因，Linux开发者优先采用命令行界面
而不是其他的系统，比如说Windows NT，是因为强大的命令行界面，可以使“完成复杂的任务成为可能”。

### 这本书讲什么

This book is a broad overview of “living” on the Linux command line. Unlike
some books that concentrate on just a single program, such as the shell
program, bash, this book will try to convey how to get along with the command
line interface in a larger sense. How does it all work? What can it do? What's
the best way to use it?

这本书对Linux命令行进行了综述。不像一些书籍仅仅涉及一个程序，比如像shell程序，bash。
从更广泛的意义上来说，这本书将试着向你传授如何与命令行界面友好相处。
它是怎样工作的？ 它能做什么？ 使用它的最好方法是什么？

This is not a book about Linux system administration. While any serious
discussion of the command line will invariably lead to system administration
topics, this book only touches on a few administration issues. It will,
however, prepare the reader for additional study by providing a solid
foundation in the use of the command line, an essential tool for any serious
system administration task.

__这不是一本关于Linux系统管理的书__。然而任何一个关于命令行的重要讨论，都一定会牵涉到
系统管理方面的内容，这本书仅仅提到一点儿管理方面的问题。这本书为读者准备好了其它的学习内容，
帮助你在使用命令行方面打下坚实的基础，这可是完成任一个系统管理任务所必需的至关重要的工具。

This book is very Linux-centric. Many other books try to broaden their appeal
by including other platforms such as generic Unix and MacOS X. In doing so,
they “water down” their content to feature only general topics. This book, on
the other hand, only covers contemporary Linux distributions. Ninety-five
percent of the content is useful for users of other Unix-like systems, but
this book is highly targeted at the modern Linux command line user.

__这本书是围绕Linux而写的__。许多书籍，会包含一些其它系统方面的知识，比如一般的Unix, 
MacOS X等，以此来扩大他们的影响力。这样做，他们就减少了书本的内容，仅是突出一般的话题。
另一方面，这本书只研究了当代Linux发行版。虽然，对于其他类似于Unix系统的用户来说，
这本书95％的内容是有用的，但是这本书高度针对现代Linux命令行用户。

Who Should Read This Book

### 谁应该读这本书

This book is for new Linux users who have migrated from other platforms. Most
likely you are a “power user” of some version of Microsoft Windows. Perhaps
your boss has told you to administer a Linux server, or maybe you're just a
desktop user who is tired of all the security problems and want to give Linux
a try. That's fine.here.All are welcome

这本书是为已经从其它系统移民到Linux的新手而写的。也许你是某个微软Windows的高手。
也许你的老板让你去管理一个Linux服务器，或许你只是一个桌面用户，厌倦了系统出现的各种
安全防御问题，想去体验一下Linux。很好，这里欢迎你们！

That being said, there is no shortcut to Linux enlightenment. Learning the
command line is challenging and takes real effort. It's not that it's so hard,
but rather it's so vast. The average Linux system has literally thousands of
programs you can employ on the command line. Consider yourself warned;
learning the command line is not a casual endeavor.

不过一般来说，对于Linux的启蒙教育，没有捷径可言。学习命令行富于挑战性，而且很费气力。
这并不是说Linux命令行很难学，而是它的知识量很大，不容易掌握。Linux操作系统，
差不多有数以千计的命令可供用户操作。由此可见，要给自己提个醒，命令行可不是轻轻松松就能学好的。

On the other hand, learning the Linux command line is extremely rewarding. If
you think you're a “power user” now, just wait. You don't know what real power
is — yet. And, unlike many other computer skills, knowledge of the command
line is long lasting. The skills learned today will still be useful ten years
from now. The command line has survived the test of time.

另一方面，学习Linux命令行会让你受益匪浅，给你极大的回报。如果你认为，
现在你已经是一个高手了。别急，其实你还不知道什么才是真正的高手。不像其他一些计算机技能，
一段时间以后可能就被淘汰了。命令行知识却不会落伍，你今天所学到的，在十年以后，
都会有用处。命令行通过了时间的检验。

It is also assumed that you have no programming experience, but not to worry,
we'll start you down that path as well.

如果你没有编程经验，也不要担心，我会带你入门。

What's In This Book

### 这本书的内容

This material is presented in a carefully chosen sequence, much like a tutor
sitting next to you guiding you along. Many authors treat this material in a
“systematic” fashion, which makes sense from a writer’s perspective, but can
be very confusing to new users.

这本书的章节顺序是经过精心安排的，就如一位导师，坐在你身旁，耐心地指导你。
许多作者认为本书的结构安排很成体系，从作者的观点来看，这种方式很有意义。
但对于Linux新手来说，可能会感到困惑。

Another goal is to acquaint you with the Unix way of thinking, which is
different from the Windows way of thinking. Along the way, we'll go on a few
side trips to help you understand why certain things work the way they do and
how they got that way. Linux is not just a piece of software, it's also a
small part of the larger Unix culture, which has its own language and history.
I might throw in a rant or two, as well.

另一个目的，是想让读者熟悉Unix的思维方式，这种思维方式不同于Windows的。在学习过程中，
我们会帮助你理解为什么某些命令会按照他们的方式工作，以及它们是怎样实现那样的工作方式的。
Linux不仅是一款软件，也是Unix文化的一小部分，它有自己的语言和历史渊源。
我也可能会说些过激的话。

This book is divided into five parts, each covering some aspect of the command
line experience. Besides the first part, which you are reading now, this book
contains:

这本书共分为五部分，每一部分讲述了命令行某个方面的知识点。除了第一部分，
也就是你正在阅读的这一部分，这本书包括：

Part 2 – Learning The Shell starts our exploration of the basic language of
the command line including such things as the structure of commands, file
system navigation, command line editing, and finding help and documentation
for commands.

*    第二部分 —— 学习shell 开始探究命令行基本语言，包括这些东西，例如命令组成结构，
     文件系统浏览，编写命令行，查找命令帮助文档

Part 3 – Configuration And The Environment covers editing configuration files
that control the computer's operation from the command line.

*    第三部分 —— 配置文件及环境 讲述了如何编写配置文件，通过配置文件，用命令行来操控计算机

 Part 4 – Common Tasks And Essential Tools explores many of the ordinary tasks
 that are commonly performed from the command line. Unix-like operating
 systems, such as Linux, contain many “classic” command line programs that are
 used to perform powerful operations on data.

*    第四部分 —— 常见任务及主要工具  探究了许多命令行经常执行的普通任务。类似于Unix的操作系统，
     例如Linux, 包括许多经典的命令行程序，
     这些程序被用来对数据进行强大的操作。

Part 5 – Writing Shell Scripts introduces shell programming, an admittedly
rudimentary, but easy to learn, technique for automating many common
computing tasks. By learning shell programming, you will become familiar with
concepts that can be applied to many other programming languages.

*    第五部分 —— 编写Shell脚本  介绍了shell编程，一个无可否认的基本技能，能够自动化许多
     常见的计算任务，很容易学。通过学习shell编程，你会逐渐熟悉一些计算机语言概念，
     这些概念也适用于其他的编程语言。

How To Read This Book
### 怎样阅读这本书

Start at the beginning of the book and follow it to the end. It isn’t written as a reference
work, it's really more like a story with a beginning, middle, and an end.

从头到尾的阅读。它并不是一本技术参考手册，实际上它更像一本故事书，有开头，过程，结尾。

Prerequisites

#### 前提条件


<h1>peter</h1>

To use this book, all you will need is a working Linux installation. You can get this in
one of two ways:

为了使用这本书，你需要安装Linux操作系统。你可以通过两种方式，来完成安装。

1. Install Linux on a (not so new) computer. It doesn't matter which
   distribution you choose, though most people today start out with either
   Ubuntu, Fedora, or . If in doubt, try Ubuntu first. Installing a modern
   Linux distribution can be ridiculously easy or ridiculously difficult
   depending on your hardware. I suggest a desktop computer that is a couple
   of years old and has at least 256 megabytes of RAM and 6 gigabytes of free
   hard disk space. Avoid laptops and wireless networks if at all possible, as
   these are often more difficult to get working.

1.    在一台（不是很新）的电脑上安装Linux。你选择哪个Linux发行版安装，是无关紧要的事。
虽然大多数人一开始选择安装Ubuntu, Fedora, 或者OpenSUSE。如果你拿不定主意，那就先试试Ubuntu。
由于主机硬件配置不同，安装Linux时，你可能不费吹灰之力就装上了，也可能费了九牛二虎之力还装不上。
所以我建议，一台使用了几年的台式机，至少要有256M的内存，6G的硬盘可用空间。尽可能避免使用
笔记本电脑和无线网络，在Linux环境下，它们经常不能工作。

2. Use a “Live CD.” One of the cool things you can do with many Linux
   distributions is run them directly from a CDROM without installing them at
   all.  Just go into your BIOS setup and set your computer to “Boot from
   CDROM,” insert the live CD, and reboot. Using a live CD is a great way to
   test a computer for Linux compatibility prior to installation. The
   disadvantage of using a live CD is that it may be very slow compared to
   having Linux installed on your hard drive.  Both Ubuntu and Fedora (among
   others) have live CD versions.

2.    使用“Live CD.” 许多Linux发行版都自带一个比较酷的功能，你可以直接从系统安装盘CDROM中运行Linux，
而不必安装Linux。开机进入BIOS设置界面，更改引导项，设置为“Boot from CDROM”。

Regardless of how you install Linux, you will need to have occasional
superuser (i.e., administrative) privileges to carry out the lessons in this
book.

不管你怎样安装Linux，你需要有超级用户（管理员）权限，才能练习书中的课程。


After you have a working installation, start reading and follow along with
your own computer. Most of the material in this book is “hands on,” so sit
down and get typing!

当你创建了一个Linux工作环境之后，跟随着你的电脑，开始阅读这本书吧。这本书中大部分内容
都可以自己动手练习，坐下来，敲入命令，体验一下吧。


<table cellspacing="0" cellpadding="0" border="1			" width="100%">
<tr>
<td>

<h3>Why I Don't Call It “GNU/Linux”</h3>

<h3>为什么我不叫它“GNU/Linux”</h3>

<p>In some quarters, it's politically correct to call the Linux operating system
the “GNU/Linux operating system.” The problem with “Linux” is that there is no
completely correct way to name it because it was written by many different
people in a vast, distributed development effort. Technically speaking, Linux
is the name of the operating system's kernel, nothing more.  The kernel is
very important of course, since it makes the operating system go, but it's not
enough to form a complete operating system.</p>

<p>在某些领域，从政治上讲，把Linux操作系统称为“GNU/Linux 操作系统.”是正确的。但“Linux”的问题是，
没有一个完全正确的方式能命名它，因为它是由许许多多，分布在世界各地的贡献者们，合作开发而成的。
从技术层面讲，Linux只是操作系统的内核名字，没别的含义。当然，内核非常重要，因为有它，
操作系统才能运行起来，但它并不能构成一个完备的操作系统。</P>

<p>Enter Richard Stallman, the genius-philosopher who founded the Free Software
movement, started the Free Software Foundation, formed the GNU Project, wrote
the first version of the GNU C Compiler (gcc), created the GNU General Public
License (the GPL), etc., etc., etc. He insists that you call it “GNU/Linux” to
properly reflect the contributions of the GNU Project. While the GNU Project
predates the Linux kernel, and the project's contributions are extremely deserving
of recognition, placing them in the name is unfair to everyone else who made
significant contributions. Besides, I think “Linux/GNU” would be more
technically accurate since the kernel boots first and everything else runs on top ofit.</p>

<p>关于Richard Stallman，天才的哲学家，自由软件运动创始人，自由软件基金会创办者，创建了GNU工程，
编写了第一版GNU C 编译器（gcc），创立了GNU通用公共协议（the GPL),等等。
他坚持把Linux称为“GNU/Linux”，为的是准确地反映GNU工程对Linux操作系统的贡献。
然而，GNU项目早于Linux内核，而GNU项目的贡献得到极高的赞誉，把GNU用在Linux名字里，
这对其他每个，对Linux的发展，做出重大贡献的程序员来说，就不公平了。</p>

<p>In popular usage, “Linux” refers to the kernel and all the other free and open
source software found in the typical Linux distribution; that is, the entire Linux
ecosystem, not just the GNU components. The operating system marketplace
seems to prefer one-word names such as DOS, Windows, MacOS, Solaris, Irix,
AIX. I have chosen to use the popular format. If, however, you prefer to use
“GNU/Linux” instead, please perform a mental search and replace while reading this book. I won't mind.</P>

<p>在目前流行的用法中，“Linux”指的是内核以及一个典型的Linux发行版中所包含的所有免费及开源软件；
也就是说，整个Linux生态系统，不只有GNU项目软件。操作系统商界，看起来喜欢一个单词的名字，
比如说 DOS, Windows, MacOS, Solaris, Irix, AIX. 所以，我选择用流行的
命名规则。然而，如果你喜欢用“GNU/Linux”，当你读这本书时，可以搜索并代替“Linux”。我不介意。</p>

</td>
</tr>
</table>

Further Reading

进一步阅读

Here are some Wikipedia articles on the famous people mentioned in this chapter:

* Wikipedia网站上有些介绍本章提到的名人的文章，以下是链接地址：

   http://en.wikipedia.org/wiki/Linux_Torvalds
   http://en.wikipedia.org/wiki/Richard_Stallman

The Free Software Foundation and the GNU Project:

* 介绍自由软件基金会及GNU项目的网站和文章：

   http://en.wikipedia.org/wiki/Free_Software_Foundation
   http://www.fsf.org
   http://www.gnu.org

Richard Stallman has written extensively on the “GNU/Linux” naming issue:

* Richard Stallman用了大量的文字来叙述“GNU/Linux”的命名问题，可以浏览以下网页：

   http://www.gnu.org/gnu/why-gnu-linux.html
   http://www.gnu.org/gnu/gnu-linux-faq.html#tools



 

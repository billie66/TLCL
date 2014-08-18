---
layout: book
title: 编译程序
---

In this chapter, we will look at how to build programs by compiling source code.
The availability of source code is the essential freedom that makes Linux possible.
The entire ecosystem of Linux development relies on free exchange between developers.
For many desktop users, compiling is a lost art. It used to be quite common,
but today, distribution providers maintain huge repositories of precompiled binaries,
ready to download and use. At the time of this writing, the Debian repository
(one of the largest of any of the distributions) contains almost 23,000 packages.

在这一章中，我们将看一下如何通过编译源代码来创建程序。源代码的可用性是至关重要的自由，从而使得 Linux 成为可能。
整个 Linux 开发生态圈就是依赖于开发者之间的自由交流。对于许多桌面用户来说，编译是一种失传的艺术。以前很常见，
但现在，由系统发行版提供商维护巨大的预编译的二进制仓库，准备供用户下载和使用。在写这篇文章的时候，
Debian 仓库（最大的发行版之一）包含了几乎23,000个预编译的包。

So why compile software? There are two reasons:

那么为什么要编译软件呢？ 有两个原因：

1.  Availability. Despite the number of precompiled programs in distribution
repositories, some distributions may not include all the desired applications.
In this case, the only way to get the desired program is to compile it from source.

2. Timeliness. While some distributions specialize in cutting edge versions of programs, many do not.
This means that in order to have the very latest version of a program, compiling is necessary.

<ol>
  <li>可用性。尽管系统发行版仓库中已经包含了大量的预编译程序，但是一些发行版本不可能包含所有期望的应用。
    在这种情况下，得到所期望程序的唯一方式是编译程序源码。</li>
  <li>及时性。虽然一些系统发行版专门打包前沿版本的应用程序，但是很多不是。这意味着，
    为了拥有一个最新版本的程序，编译是必需的。</li>
</ol>

Compiling software from source code can become very complex and technical;
well beyond the reach of many users. However, many compiling tasks are
quite easy and involve only a few steps. It all depends on the package.
We will look at a very simple case in order to provide an overview of
the process and as a starting point for those who wish to undertake further study.

从源码编译软件可以变得非常复杂且具有技术性；许多用户难以企及。然而，许多编译任务是
相当简单的，只涉及到几个步骤。这都取决于程序包。我们将看一个非常简单的案例，为的是给大家提供一个
对编译过程的整体认识，并为那些愿意进一步学习的人们构筑一个起点。

We will introduce one new command:

我们将介绍一个新命令：

* make – Utility to maintain programs

* make - 维护程序的工具

### What Is Compiling?

### 什么是编译？

Simply put, compiling is the process of translating source code (the
human-readable description of a program written by a programmer)
into the native language of the computer’s processor.

简而言之，编译就是把源码（一个由程序员编写的人类可读的程序描述）翻译成计算机处理器的母语的过程。

The computer’s processor (or CPU) works at a very elemental level,
executing programs in what is called machine language. This is a numeric
code that describes very small operations, such as “add this byte,”
“point to this location in memory,” or “copy this byte.”

计算机处理器（或 CPU）工作在一个非常基本的水平，执行用机器语言编写的程序。这是一种数值编码，描述非常小的操作，
比如“加这个字节”，“指向内存中的这个位置”，或者“复制这个字节”。

Each of these instructions is expressed in binary (ones and zeros).
The earliest computer programs were written using this numeric code,
which may explain why programmers who wrote it were said to smoke a lot,
drink gallons of coffee, and wear thick glasses.This problem was overcome
by the advent of assembly language, which replaced the
numeric codes with (slightly) easier to use character mnemonics such as CPY (for copy)
and MOV (for move). Programs written in assembly language are processed into
machine language by a program called an assembler. Assembly language is
still used today for certain specialized programming tasks, such as device drivers and embedded systems.

这些指令中的每一条都是用二进制表示的（1和0）。最早的计算机程序就是用这种数值编码写成的，这可能就
解释了为什么编写它们的程序员据说吸很多烟，喝大量咖啡，并带着厚厚的眼镜。这个问题克服了，随着汇编语言的出现，
汇编语言代替了数值编码（略微）简便地使用助记符，比如 CPY（复制）和 MOV（移动）。用汇编语言编写的程序通过
汇编器处理为机器语言。今天为了完成某些特定的程序任务，汇编语言仍在被使用，例如设备驱动和嵌入式系统。

We next come to what are called high-level programming languages.
They are called this because they allow the programmer to be less
concerned with the details of what the processor is doing and
more with solving the problem at hand. The early ones (developed during the 1950s)
included FORTRAN (designed for scientific and technical tasks) and COBOL
(designed for business applications). Both are still in limited use today.

下一步我们谈论一下什么是所谓的高级编程语言。之所以这样称呼它们，是因为它们可以让程序员少操心处理器的
一举一动，而更多关心如何解决手头的问题。早期的高级语言（二十世纪60年代期间研发的）包括
FORTRAN（为科学和技术问题而设计）和 COBOL（为商业应用而设计）。今天这两种语言仍在有限的使用。

While there are many popular programming languages, two predominate.
Most programs written for modern systems are written in either C or C++.
In the examples to follow, we will be compiling a C program.

虽然有许多流行的编程语言，两个占主导地位。大多数为现代系统编写的程序，要么用 C 编写，要么是用 C++ 编写。
在随后的例子中，我们将编写一个 C 程序。

Programs written in high-level programming languages are converted into machine
language by processing them with another program, called a compiler.
Some compilers translate high-level instructions into assembly language and then
use an assembler to perform the final stage of translation into machine language.

用高级语言编写的程序，经过另一个称为编译器的程序的处理，会转换成机器语言。一些编译器把
高级指令翻译成汇编语言，然后使用一个汇编器完成翻译成机器语言的最后阶段。

A process often used in conjunction with compiling is called linking.
There are many common tasks performed by programs. Take, for instance, opening a file.
Many programs perform this task, but it would be wasteful to have each program
implement its own routine to open files. It makes more sense to have a single piece
of programming that knows how to open files and to allow all programs that need it to share it.
Providing support for common tasks is accomplished by what are called libraries.
They contain multiple routines, each performing some common task that multiple programs can share.
If we look in the /lib and /usr/lib directories, we can see where many of them live.
A program called a linker is used to form the connections between the output of
the compiler and the libraries that the compiled program requires.
The final result of this process is the executable program file, ready for use.

一个称为链接的过程经常与编译结合在一起。有许多程序执行的常见任务。以打开文件为例。许多程序执行这个任务，
但是让每个程序实现它自己的打开文件功能，是很浪费资源的。更有意义的是，拥有单独的一段知道如何打开文件的程序，
并允许所有需要它的程序共享它。对常见任务提供支持由所谓的库完成。这些库包含多个程序，每个程序执行
一些可以由多个程序共享的常见任务。如果我们看一下 /lib 和 /usr/lib 目录，我们可以看到许多库定居在那里。
一个叫做链接器的程序用来在编译器的输出结果和要编译的程序所需的库之间建立连接。这个过程的最终结果是
一个可执行程序文件，准备使用。

#### Are All Programs Compiled?

#### 所有的程序都是可编译的吗？

No. As we have seen, there are programs such as shell scripts that do not require compiling.
They are executed directly. These are written in what are known as scripting or
interpreted languages. These languages have grown in popularity in recent
years and include Perl, Python, PHP, Ruby, and many others.

不是。正如我们所看到的，有些程序比如 shell 脚本就不需要编译。它们直接执行。
这些程序是用所谓的脚本或解释型语言编写的。近年来，这些语言变得越来越流行，包括 Perl，
Python，PHP，Ruby，和许多其它语言。

Scripted languages are executed by a special program called an interpreter.
An interpreter inputs the program file and reads and executes each instruction
contained within it. Ingeneral, interpreted programs execute much more slowly
than compiled programs. This is because that each source code instruction in an
interpreted program is translated every time it is carried out, whereas with a
compiled program, a source code instruction is only translated once, and this
translation is permanently recorded in the final executable file.

脚本语言由一个叫做解释器的特殊程序执行。一个解释器输入程序文件，读取并执行程序中包含的每一条指令。
通常来说，解释型程序执行起来要比编译程序慢很多。这是因为每次解释型程序执行时，程序中每一条源码指令都需要翻译，
而一个编译程序，一条源码指令只翻译一次，翻译后的指令会永久地记录到最终的执行文件中。

So why are interpreted languages so popular? For many programming chores,
the results are “fast enough,” but the real advantage is that it is generally
faster and easier to develop interpreted programs than compiled programs.
Programs are usually developed in a repeating cycle of code, compile, test.
As a program grows in size, the compilation phase of the cycle can become
quite long. Interpreted languages remove the compilation step and thus speed up program development.

那么为什么解释程序这样流行呢？对于许多编程任务来说，原因是“足够快”，但是真正的优势是一般来说开发解释程序
要比编译程序快速且容易。通常程序开发需要经历一个不断重复的写码，编译，测试周期。随着程序变得越来越大，
编译阶段会变得相当耗时。解释型语言删除了编译步骤，这样就加快了程序开发。

### Compiling A C Program

### 编译一个 C 语言

Let’s compile something. Before we do that however, we’re going to need some
tools like the compiler, the linker, and make. The C compiler used almost
universally in the Linux environment is called gcc (GNU C Compiler), originally
written by Richard Stallman. Most distributions do not install gcc by default.
We can check to see if the compiler is present like this:

让我们编译一些东西。在我们行动之前，然而我们需要一些工具，像编译器，链接器，还有 make。
在 Linux 环境中，普遍使用的 C 编译器叫做 gcc（GNU C 编译器），最初由 Richard Stallman 写出来的。
大多数 Linux 系统发行版默认不安装 gcc。我们可以这样查看该编译器是否存在：


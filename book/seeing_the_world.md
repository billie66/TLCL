---
layout: book
title: 从shell眼中看世界 
---

In this chapter we are going to look at some of the “magic” that occurs on the command
line when you press the enter key. While we will examine several interesting and
complex features of the shell, we will do it with just one new command:

在这一章我们将看一下，当你按下enter键后，发生在命令行中的一些“魔法”。虽然我们会
仔细查看几个复杂有趣的shell特点，但我们只使用一个新命令来处理这些特性。

### echo – Display a line of text

### echo － 显示一行文本

### Expansion

### (字符)展开

Each time you type a command line and press the enter key, bash performs several
processes upon the text before it carries out your command. We have seen a couple of
cases of how a simple character sequence, for example “\*”, can have a lot of meaning to
the shell. The process that makes this happen is called expansion. With expansion, you
type something and it is expanded into something else before the shell acts upon it. To
demonstrate what we mean by this, let's take a look at the echo command. echo is a
shell builtin that performs a very simple task. It prints out its text arguments on standard
output:

每一次你输入一个命令，然后按下enter键，在bash执行你的命令之前，bash会对输入
的字符完成几个步骤处理。我们已经知道两三个案例，怎样一个简单的字符序列，例如"\*",
对shell来说，有很多的涵义。使这个发生的过程叫做（字符）展开。通过展开，
你输入的字符，在shell对它起作用之前，会展开成为别的字符。为了说明我们所要
表达的意思，让我们看一看echo命令。echo是一个shell内部命令，来完成非常简单的认为。
它在标准输出中打印出它的文本参数。

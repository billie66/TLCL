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

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo this is a test
this is a test</tt>
</pre></div>

That's pretty straightforward. Any argument passed to echo gets displayed. Let's try
another example:

这个命令的作用相当简单明了。

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo *
Desktop Documents ls-output.txt Music Pictures Public Templates Videos</tt>
</pre></div>

So what just happened? Why didn't echo print “\*”? As you recall from our work with
wildcards, the “\*” character means match any characters in a filename, but what we didn't
see in our original discussion was how the shell does that. The simple answer is that the
shell expands the “\*” into something else (in this instance, the names of the files in the

### Expansion

current working directory) before the echo command is executed. When the enter key is
pressed, the shell automatically expands any qualifying characters on the command line
before the command is carried out, so the echo command never saw the “\*”, only its
expanded result. Knowing this, we can see that echo behaved as expected.

### Pathname Expansion

The mechanism by which wildcards work is called pathname expansion. If we try some
of the techniques that we employed in our earlier chapters, we will see that they are really
expansions. Given a home directory that looks like this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls
Desktop   ls-output.txt   Pictures   Templates
....</tt>
</pre></div>

we could carry out the following expansions:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo D\*
Desktop  Documents</tt>
</pre></div>

and:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo \*s
Documents Pictures Templates Videos</tt>
</pre></div>

or even:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo [[:upper:]]\*
Desktop Documents Music Pictures Public Templates Videos</tt>
</pre></div>

and looking beyond our home directory:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo /usr/\*/share
/usr/kerberos/share  /usr/local/share </tt>
</pre></div>

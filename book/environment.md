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


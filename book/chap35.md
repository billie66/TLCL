---
layout: book
title: 字符串和数字
---

Computer programs are all about working with data. In past chapters, we have focused on
processing data at the file level. However, many programming problems need to be
solved using smaller units of data such as strings and numbers.

所有的计算机程序都是用来和数据打交道的。在过去的章节中，我们专注于处理文件级别的数据。
然而，许多程序问题需要使用更小的数据单位来解决，比方说字符串和数字。

In this chapter, we will look at several shell features that are used to manipulate strings
and numbers. The shell provides a variety of parameter expansions that perform string
operations. In addition to arithmetic expansion (which we touched upon in Chapter 7),
there is a common command line program called bc, which performs higher level math.

在这一章中，我们将查看几个用来操作字符串和数字的 shell 功能。shell 提供了各种执行字符串操作的参数展开功能。
除了算术展开（在第七章中接触过），有一个常见的命令行程序叫做 bc，能执行更高级别的数学运算。

### Parameter Expansion

### 参数展开

Though parameter expansion came up in Chapter 7, we did not cover it in detail because
most parameter expansions are used in scripts rather than on the command line. We have
already worked with some forms of parameter expansion; for example, shell variables.
The shell provides many more.

尽管参数展开在第七章中出现过，但我们并没有详尽地介绍它，因为大多数的参数展开会用在脚本中，而不是命令行中。
我们已经使用了一些形式的参数展开；例如，shell 变量。shell 提供了更多方式。

#### Basic Parameters

#### 基本参数

The simplest form of parameter expansion is reflected in the ordinary use of variables.
For example:

最简单的参数展开形式反映在平常使用的变量上。例如：

$a

when expanded, becomes whatever the variable a contains. Simple parameters may also
be surrounded by braces:

当 $a 展开后，会变成变量 a 所包含的值。简单参数也可能用花括号引起来：

${a}

This has no effect on the expansion, but is required if the variable is adjacent to other
text, which may confuse the shell. In this example, we attempt to create a filename by ap-
pending the string “_file” to the contents of the variable a.

虽然这对展开没有影响，但若该变量 a 与其它的文本相邻，可能会把 shell 搞糊涂了。在这个例子中，我们试图
创建一个文件名，通过把字符串 “_file” 附加到变量 a 的值的后面。

    [me@linuxbox ~]$ a="foo"
    [me@linuxbox ~]$ echo "$a_file"

If we perform this sequence, the result will be nothing, because the shell will try to ex-
pand a variable named a_file rather than a. This problem can be solved by adding
braces:

如果我们执行这个序列，没有任何输出结果，因为 shell 会试着展开一个称为 a_file 的变量，而不是 a。通过
添加花括号可以解决这个问题：

    [me@linuxbox ~]$ echo "${a}_file"
    foo_file

We have also seen that positional parameters greater than 9 can be accessed by surround-
ing the number in braces. For example, to access the eleventh positional parameter, we
can do this:

我们已经知道通过把数字包裹在花括号中，可以访问大于9的位置参数。例如，访问第十一个位置参数，我们可以这样做：

${11}

#### Expansions To Manage Empty Variables

#### 管理空变量的展开

Several parameter expansions deal with nonexistent and empty variables. These expan-
sions are handy for handling missing positional parameters and assigning default values
to parameters.

几种用来处理不存在和空变量的参数展开形式。这些展开形式对于解决丢失的位置参数和给参数指定默认值的情况很方便。

${parameter:-word}

If parameter is unset (i.e., does not exist) or is empty, this expansion results in the value
of word. If parameter is not empty, the expansion results in the value of parameter.

若参数没有设置（例如，不存在）或者为空，展开结果是 word 的值。若参数不为空，则展开结果是参数的值。

    [me@linuxbox ~]$ foo=
    [me@linuxbox ~]$ echo ${foo:-"substitute value if unset"}
    if unset
    substitute value
    [me@linuxbox ~]$ echo $foo
    [me@linuxbox ~]$ foo=bar
    [me@linuxbox ~]$ echo ${foo:-"substitute value if unset"}
    bar
    [me@linuxbox ~]$ echo $foo
    bar

${parameter:=word}

If parameter is unset or empty, this expansion results in the value of word. In addition,
the value of word is assigned to parameter. If parameter is not empty, the expansion re-
sults in the value of parameter.

若参数没有设置或为空，展开结果是 word 的值。另外，word 的值会赋值给参数。若参数不为空，展开结果是参数的值。

    [me@linuxbox ~]$ foo=
    [me@linuxbox ~]$ echo ${foo:="default value if unset"}
    default value if unset
    [me@linuxbox ~]$ echo $foo
    default value if unset
    [me@linuxbox ~]$ foo=bar
    [me@linuxbox ~]$ echo ${foo:="default value if unset"}
    bar
    [me@linuxbox ~]$ echo $foo
    bar

---

Note: Positional and other special parameters cannot be assigned this way.

注意： 位置参数或其它的特殊参数不能以这种方式赋值。

---

${parameter:?word}

If parameter is unset or empty, this expansion causes the script to exit with an error, and
the contents of word are sent to standard error. If parameter is not empty, the expansion
results in the value of parameter.

若参数没有设置或为空，这种展开导致脚本带有错误退出，并且 word 的内容会发送到标准错误。若参数不为空，
展开结果是参数的值。

    [me@linuxbox ~]$ foo=
    [me@linuxbox ~]$ echo ${foo:?"parameter is empty"}
    bash: foo: parameter is empty
    [me@linuxbox ~]$ echo $?
    1
    [me@linuxbox ~]$ foo=bar
    [me@linuxbox ~]$ echo ${foo:?"parameter is empty"}
    bar
    [me@linuxbox ~]$ echo $?
    0

${parameter:+word}

If parameter is unset or empty, the expansion results in nothing. If parameter is not
empty, the value of word is substituted for parameter; however, the value of parameter is
not changed.

若参数没有设置或为空，展开结果为空。若参数不为空，展开结果是 word 的值会替换掉参数的值；然而，参数的值不会改变。

    [me@linuxbox ~]$ foo=
    [me@linuxbox ~]$ echo ${foo:+"substitute value if set"}

    [me@linuxbox ~]$ foo=bar
    [me@linuxbox ~]$ echo ${foo:+"substitute value if set"}
    substitute value if set

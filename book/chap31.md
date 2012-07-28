---
layout: book
title: 疑难排解 
---

As our scripts become more complex, it’s time to take a look at what happens when
things go wrong and they don’t do what we want. In this chapter, we’ll look at
some of the common kinds of errors that occur in scripts, and describe a few useful
techniques that can be used to track down and eradicate problems.

随着我们的脚本变得越来越复杂，是时候看看怎么回事了，当脚本运行出错，执行结果出人意料的时候。
本章中，我们将看一些出现在脚本中的常见错误，还会介绍几个有用的技巧，可以用来跟踪和消除问题。

### Syntactic Errors

### 语法错误 

One general class of errors is syntactic. Syntactic errors involve mis-typing some
element of shell syntax. In most cases, these kinds of errors will lead to the shell refusing
to execute the script.

一个普通的错误类型是语法。语法错误涉及到一些 shell 语法元素的拼写错误。大多数情况下，这类错误
会导致 shell 拒绝执行此脚本。

In the following the discussions, we will use this script to demonstrate common types of
errors:

在以下讨论中，我们将使用下面这个脚本，来说明常见的错误类型：

    #!/bin/bash

    # trouble: script to demonstrate common errors

    number=1

    if [ $number = 1 ]; then
        echo "Number is equal to 1."
    else
        echo "Number is not equal to 1."
    fi

As written, this script runs successfully:

参看脚本内容，我们知道这个脚本执行成功了：

    [me@linuxbox ~]$ trouble
    Number is equal to 1.

#### Missing Quotes

#### 丢失引号 

If we edit our script and remove the trailing quote from the argument following the first
echo command:

如果我们编辑我们的脚本，并从跟随第一个 echo 命令的参数中，删除其末尾的双引号：

    #!/bin/bash

    # trouble: script to demonstrate common errors

    number=1

    if [ $number = 1 ]; then
        echo "Number is equal to 1.
    else
        echo "Number is not equal to 1."
    fi

watch what happens:

观察发生了什么：

    [me@linuxbox ~]$ trouble
    /home/me/bin/trouble: line 10: unexpected EOF while looking for
    matching `"'
    /home/me/bin/trouble: line 13: syntax error: unexpected end of file

It generates two errors. Interestingly, the line numbers reported are not where the missing
quote was removed, but rather much later in the program. We can see why, if we follow
the program after the missing quote. bash will continue looking for the closing quote
until it finds one, which it does immediately after the second echo command. bash
becomes very confused after that, and the syntax of the if command is broken because
the fi statement is now inside a quoted (but open) string.

这个脚本产生了两个错误。有趣地是，所报告的行号不是引号被删除的地方，而是程序中后面的文本行。
我们能知道为什么，如果我们跟随丢失引号文本行之后的程序。bash 会继续寻找右引号，直到它找到一个，
其就是这个紧随第二个 echo 命令之后的引号。找到这个引号之后，bash 变得很困惑，并且 if 命令的语法
被破坏了，因为现在这个 fi 语句在一个用引号引起来的（但是开放的）字符串里面。

In long scripts, this kind of error can be quite hard to find. Using an editor with syntax
highlighting will help. If a complete version of vim is installed, syntax highlighting can
be enabled by entering the command:

在冗长的脚本中，此类错误很难找到。使用带有语法高亮的编辑器将会帮助查找错误。如果安装了 vim 的完整版，
通过输入下面的命令，可以使语法高亮生效：

    :syntax on

#### Missing Or Unexpected Tokens

#### 丢失或意外的标记

Another common mistake is forgetting to complete a compound command, such as if or
while. Let’s look at what happens if we remove the semicolon after the test in the if
command:

另一个常见错误是忘记补全一个复合命令，比如说 if 或者是 while。让我们看一下，如果
我们删除 if 命令中测试之后的分号，会出现什么情况：

    #!/bin/bash

    # trouble: script to demonstrate common errors

    number=1

    if [ $number = 1 ] then
        echo "Number is equal to 1."
    else
        echo "Number is not equal to 1."
    fi

The result is this:

结果是这样的：

    [me@linuxbox ~]$ trouble
    /home/me/bin/trouble: line 9: syntax error near unexpected token
    `else'
    /home/me/bin/trouble: line 9: `else'

Again, the error message points to a error that occurs later than the actual problem. What
happens is really pretty interesting. As we recall, if accepts a list of commands and
evaluates the exit code of the last command in the list. In our program, we intend this list
to consist of a single command, [, a synonym for test. The [ command takes what
follows it as a list of arguments. In our case, three arguments: $number, =, and ]. With
the semicolon removed, the word then is added to the list of arguments, which is
syntactically legal. The following echo command is legal, too. It’s interpreted as
another command in the list of commands that if will evaluate for an exit code. The
else is encountered next, but it’s out of place, since the shell recognizes it as a reserved
word (a word that has special meaning to the shell) and not the name of a command,
hence the error message.

再次，错误信息指向一个错误，其出现的位置靠后于实际问题所在的文本行。所发生的事情真是相当有意思。我们记得，
if 能够接受一系列命令，并且会计算列表中最后一个命令的退出代码。在我们的程序中，我们打算这个列表由
单个命令组成，即[，测试的同义词。这个[命令把它后面的东西看作是一个参数列表。在我们这种情况下，
有三个参数： $number，=，和 ]。由于删除了分号，单词 then 被添加到参数列表中，从语法上讲，
这是合法的。随后的 echo 命令也是合法的。它被解释为命令列表中的另一个命令，if 将会计算命令的
退出代码。接下来遇到单词 else，但是它出局了，因为 shell 把它认定为一个保留字（对于 shell 有特殊含义的单词），
而不是一个命令名，因此报告错误信息。

#### Unanticipated Expansions

#### 预料不到的展开

It’s possible to have errors that only occur intermittently in a script. Sometimes the script
will run fine and other times it will fail because of results of an expansion. If we return
our missing semicolon and change the value of number to an empty variable, we can
demonstrate:

可能有这样的错误，它们仅会间歇性地出现在一个脚本中。有时候这个脚本执行正常，其它时间会失败，
这是因为展开结果造成的。如果我们归还我们丢掉的分号，并把 number 的数值更改为一个空变量，我们
可以示范一下：

    #!/bin/bash
    # trouble: script to demonstrate common errors

    number=

    if [ $number = 1 ]; then
        echo "Number is equal to 1."
    else
        echo "Number is not equal to 1."
    fi

Running the script with this change results in the output:

运行这个做了修改的脚本，得到以下输出：

    [me@linuxbox ~]$ trouble
    /home/me/bin/trouble: line 7: [: =: unary operator expected
    Number is not equal to 1.

We get this rather cryptic error message, followed by the output of the second echo
command. The problem is the expansion of the number variable within the test
command. When the command:

我们得到一个相当神秘的错误信息，其后是第二个 echo 命令的输出结果。这问题是由于 test 命令中
的 number 变量的展开结果造成的。当此命令：

    [ $number = 1 ]

undergoes expansion with number being empty, the result is this:

经过展开之后，number 变为空值，结果就是这样：

    [  = 1 ]

which is invalid and the error is generated. The = operator is a binary operator (it
requires a value on each side), but the first value is missing, so the test command
expects a unary operator (such as -z) instead. Further, since the test failed (because of
the error), the if command receives a non-zero exit code and acts accordingly, and the
second echo command is executed.

这是无效的，所以就产生了错误。这个 = 操作符是一个二元操作符（它要求每边都有一个数值），但是第一个数值是缺失的，
这样 test 命令就期望用一个一元操作符（比如 -z）来代替。进一步说，因为 test 命令运行失败了（由于错误），
这个 if 命令接收到一个非零退出代码，因此执行第二个 echo 命令。

This problem can be corrected by adding quotes around the first argument in the test
command:

通过为 test 命令中的第一个参数添加双引号，可以更正这个问题：

    [ "$number" = 1 ]

Then when expansion occurs, the result will be this:

然后当展开操作发生地时候，执行结果将会是这样：

    [ "" = 1 ]

which yields the correct number of arguments. In addition to empty strings, quotes
should be used in cases where a value could expand into multi-word strings, as with
filenames containing embedded spaces.

其得到了正确的参数个数。除了代表空字符串之外，引号应该被用于这样的场合，一个要展开
成多单词字符串的数值，及其包含嵌入式空格的文件名。

### Logical Errors

### 逻辑错误 

Unlike syntactic errors, logical errors do not prevent a script from running. The script
will run, but it will not produce the desired result, due to a problem with its logic. There
are countless numbers of possible logical errors, but here are a few of the most common
kinds found in scripts:

不同于语法错误，逻辑错误不会阻止脚本执行。虽然脚本会正常运行，但是它不会产生期望的结果，
归咎于脚本的逻辑问题。虽然有不计其数的可能的逻辑错误，但下面是一些在脚本中找到的最常见的
逻辑错误类型：

1. Incorrect conditional expressions. It’s easy to incorrectly code an if/then/else
and have the wrong logic carried out. Sometimes the logic will be reversed or it
will be incomplete.

2. “Off by one” errors. When coding loops that employ counters, it is possible to
overlook that the loop may require the counting start with zero, rather than one,
for the count to conclude at the correct point. These kinds of errors result in either
a loop “going off the end” by counting too far, or else missing the last iteration of
the loop by terminating one iteration too soon.

3. Unanticipated situations. Most logic errors result from a program encountering
data or situations that were unforeseen by the programmer. This can also include
unanticipated expansions, such as a filename that contains embedded spaces that
expands into multiple command arguments rather than a single filename.

<ol>
<li><p>不正确的条件表达式。很容易编写一个错误的 if/then/else 语句，并且执行错误的逻辑。
有时候逻辑会被颠倒，或者是逻辑结构不完整。</p></li>

<li><p>“超出一个值”错误。当编写带有计数器的循环语句的时候，为了计数在恰当的点结束，循环语句
可能要求从 0 开始计数，而不是从 1 开始，这有可能会被忽视。这些类型的错误要不导致循环计数太多，而“超出范围”，
要不就是过早的结束了一次迭代，从而错过了最后一次迭代循环。</p></li>

<li><p>意外情况。大多数逻辑错误来自于程序碰到了程序员没有预见到的数据或者情况。这也
可以包括出乎意料的展开，比如说一个包含嵌入式空格的文件名展开成多个命令参数而不是单个的文件名。</p></li>
</ol>

#### Defensive Programming

#### 防错编程 

It is important to verify assumptions when programming. This means a careful
evaluation of the exit status of programs and commands that are used by a script. Here is
an example, based on a true story. An unfortunate system administrator wrote a script to
perform a maintenance task on an important server. The script contained the following
two lines of code:

当编程的时候，验证假设非常重要。这意味着要仔细得计算脚本所使用的程序和命令的退出状态。
这里有个实例，基于一个真实的故事。为了在一台重要的服务器中执行维护任务，一位不幸的系统管理员写了一个脚本。
这个脚本包含下面两行代码：

    cd $dir_name
    rm *

There is nothing intrinsically wrong with these two lines, as long as the directory named
in the variable, dir_name, exists. But what happens if it does not? In that case, the cd
command fails, the script continues to the next line and deletes the files in the current
working directory. Not the desired outcome at all! The hapless administrator destroyed
an important part of the server because of this design decision.

从本质上来说，这两行代码没有任何问题，只要是变量 dir_name
中存储的目录名字存在就可以。但是如果不是这样会发生什么事情呢？在那种情况下，cd
命令会运行失败，脚本会继续执行下一行代码，将会删除当前工作目录中的所有文件。完成不是期望的结果！
由于这种设计策略，这个倒霉的管理员销毁了服务器中的一个重要部分。

Let’s look at some ways this design could be improved. First, it might be wise to make
the execution of rm contingent on the success of cd:

让我们看一些能够提高这个设计的方法。首先，在cd 命令执行成功之后，再运行 rm
命令，可能是明智的选择。

    cd $dir_name && rm *

This way, if the cd command fails, the rm command is not carried out. This is better, but
still leaves open the possibility that the variable, dir_name, is unset or empty, which
would result in the files in the user’s home directory being deleted. This could also be
avoided by checking to see that dir_name actually contains the name of an existing
directory:

这样，如果 cd 命令运行失败后，rm 命令将不会执行。这样比较好，但是仍然有可能未设置变量
dir_name 或其变量值为空，从而导致删除了用户主目录下面的所有文件。这个问题也能够避免，通过检验变量
dir_name 中包含的目录名是否真正地存在：

    [[ -d $dir_name ]] && cd $dir_name && rm *

Often, it is best to terminate the script with an error when an situation such as the one
above occurs:

通常，当某种情况（比如上述问题）发生的时候，最好是终止脚本执行，并对这种情况提示错误信息：

    if [[ -d $dir_name ]]; then
        if cd $dir_name; then
            rm *
        else
            echo "cannot cd to '$dir_name'" >&2
            exit 1
        fi
    else
        echo "no such directory: '$dir_name'" >&2
        exit 1
    fi

Here, we check both the name, to see that it is that of an existing directory, and the
success of the cd command. If either fails, a descriptive error message is sent to standard
error and the script terminates with an exit status of one to indicate a failure.

这里，我们检验了两种情况，一个名字，看看它是否为一个真正存在的目录，另一个是 cd
命令是否执行成功。如果任一种情况失败，就会发送一个错误说明信息到标准错误，然后脚本
终止执行，并用退出状态 1 表明脚本执行失败。

---
layout: book
title: 流程控制：if分支结构 
---

In the last chapter, we were presented with a problem. How can we make our report
generator script adapt to the privileges of the user running the script? The solution to this
problem will require us to find a way to “change directions” within our script, based on a
the results of a test. In programming terms, we need the program to branch.
Let’s consider a simple example of logic expressed in pseudocode, a simulation of a
computer language intended for human consumption:

在上一章中，我们遇到一个问题。怎样使我们的报告生成器脚本能适应运行此脚本的用户的权限？
这个问题的解决方案要求我们能找到一种方法，在脚本中基于测试条件结果，来“改变方向”。
用编程术语表达，就是我们需要程序可以分支。让我们考虑一个简单的用伪码表示的逻辑实例，
伪码是一种模拟的计算机语言，为的是便于人们理解：

X=5

If X = 5, then:

Say “X equals 5.”

Otherwise:

Say “X is not equal to 5.”

This is an example of a branch. Based on the condition, “Does X = 5?” do one thing,
“Say X equals 5,” otherwise do another thing, “Say X is not equal to 5.”

这就是一个分支的例子。根据条件，“Does X = 5?” 做一件事情，“Say X equals 5,”
否则，做另一件事情，“Say X is not equal to 5.”

### if

Using the shell, we can code the logic above as follows:

使用shell，我们可以编码上面的逻辑，如下所示：

    x=5

    if [ $x = 5 ]; then
        echo "x equals 5."
    else
        echo "x does not equal 5."
    fi

or we can enter it directly at the command line (slightly shortened):

或者我们可以直接在命令行中输入以上代码（略有缩短）：

    [me@linuxbox ~]$ x=5
    [me@linuxbox ~]$ if [ $x = 5 ]; then echo "equals 5"; else echo "does
    not equal 5"; fi
    equals 5	
    [me@linuxbox ~]$ x=0
    [me@linuxbox ~]$ if [ $x = 5 ]; then echo "equals 5"; else echo "does
    not equal 5"; fi	
    does not equal 5	

In this example, we execute the command twice. Once, with the value of x set to 5,
which results in the string “equals 5” being output, and the second time with the value of
x set to 0, which results in the string “does not equal 5” being output.

在这个例子中，我们执行了两次这个命令。第一次是，把x的值设置为5，从而导致输出字符串“equals 5”,
第二次是，把x的值设置为0，从而导致输出字符串“does not equal 5”。

The if statement has the following syntax:

这个if语句语法如下：

    if commands; then
         commands
    [elif commands; then
         commands...]
    [else
         commands]
    fi

where commands is a list of commands. This is a little confusing at first glance. But
before we can clear this up, we have to look at how the shell evaluates the success or
failure of a command.

这里的commands是指一系列命令。第一眼看到会有点儿困惑。但是在我们弄清楚这些语句之前，我们
必须看一下shell是如何评判一个命令的成功与失败的。

### Exit Status

### 退出状态

Commands (including the scripts and shell functions we write) issue a value to the system
when they terminate, called an exit status. This value, which is an integer in the range of
0 to 255, indicates the success or failure of the command’s execution. By convention, a
value of zero indicates success and any other value indicates failure. The shell provides a
parameter that we can use to examine the exit status. Here we see it in action:

当命令执行完毕后，命令（包括我们编写的脚本和shell函数）会给系统发送一个值，叫做退出状态。
这个值是一个0到255之间的整数，说明命令执行成功或是失败。按照惯例，一个零值说明成功，其它所有值说明失败。
Shell提供了一个参数，我们可以用它检查退出状态。用具体实例看一下：

    [me@linuxbox ~]$ ls -d /usr/bin
    /usr/bin
    [me@linuxbox ~]$ echo $?
    0
    [me@linuxbox ~]$ ls -d /bin/usr
    ls: cannot access /bin/usr: No such file or directory
    [me@linuxbox ~]$ echo $?
    2

In this example, we execute the ls command twice. The first time, the command
executes successfully. If we display the value of the parameter $?, we see that it is zero.
We execute the ls command a second time, producing an error and examine the
parameter $? again. This time it contains a 2, indicating that the command encountered
an error. Some commands use different exit status values to provide diagnostics for
errors, while many commands simply exit with a value of one when they fail. Man pages
often include a section entitled “Exit Status,” describing what codes are used. However,
a zero always indicates success.

在这个例子中，我们执行了两次ls命令。第一次，命令执行成功。如果我们显示参数$?的值，我们
看到它是零。我们第二次执行ls命令的时候，产生了一个错误，并再次查看参数$?。这次它包含一个
数字2，表明这个命令遇到了一个错误。有些命令使用不同的退出值，来诊断错误，而许多命令当
它们执行失败的时候，会简单地退出并发送一个数字1。手册页中经常会包含一章标题为“退出状态”的内容，
描述了使用的代码。然而，一个零总是表明成功。

The shell provides two extremely simple builtin commands that do nothing except
terminate with either a zero or one exit status. The true command always executes
successfully and the false command always executes unsuccessfully:

这个shell提供了两个极其简单的内部命令，它们不做任何事情，除了以一个零或1退出状态来终止执行。
True命令总是执行成功，而false命令总是执行失败：

    [me@linuxbox~]$ true
    [me@linuxbox~]$ echo $?
    0           
    [me@linuxbox~]$ false
    [me@linuxbox~]$ echo $?
    1

We can use these commands to see how the if statement works. What the if statement
really does is evaluate the success or failure of commands:

我们能够使用这些命令，来看一下if语句是怎样工作的。If语句真正做的事情是计算命令执行成功或失败：

    [me@linuxbox ~]$ if true; then echo "It's true."; fi
    It's true.
    [me@linuxbox ~]$ if false; then echo "It's true."; fi
    [me@linuxbox ~]$

The command echo "It's true." is executed when the command following if
executes successfully, and is not executed when the command following if does not
execute successfully. If a list of commands follows if, the last command in the list is
evaluated:

当if之后的命令执行成功的时候，命令echo "It's true."将会执行，否则此命令不执行。
如果if之后跟随一系列命令，则将计算列表中的最后一个命令：

    [me@linuxbox ~]$ if false; true; then echo "It's true."; fi
    It's true.
    [me@linuxbox ~]$ if true; false; then echo "It's true."; fi
    [me@linuxbox ~]$
    3

### test

### 测试 

By far, the command used most frequently with if is test. The test command
performs a variety of checks and comparisons. It has two equivalent forms:

到目前为止，经常与if一块使用的命令是test。这个test命令执行各种各样的检查与比较。
它有两种等价模式：

    test expression

and the more popular:

比较流行的格式是：

    [ expression ]

where expression is an expression that is evaluated as either true or false. The test
command returns an exit status of zero when the expression is true and a status of one
when the expression is false.

这里的expression是一个表达式，其执行结果是true或者是false。当表达式为真时，这个test命令返回一个零
退出状态，当表达式为假时，test命令退出状态为1。

#### File Expressions

#### 文件表达式 

The following expressions are used to evaluate the status of files:

以下表达式被用来计算文件状态：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 28-1: test File Expressions</caption>
<tr>
<th class="title">Expression</th>
<th class="title">Is Ture If</th>
</tr>
<tr>
<td valign="top" width="20%">file1 -ef file2 </td>
<td valign="top">file1 and file2 have the same inode numbers (the two
filenames refer to the same file by hard linking).  </td>
</tr>
<tr>
<td valign="top">file1 -nt file2 </td>
<td valign="top">not equal 5"; fi	x=0 </td>
</tr>
<tr>
<td valign="top">file1 -ot file2 </td>
<td valign="top">file1 is older than file2.  </td>
</tr>
<tr>
<td valign="top">-b file </td>
<td valign="top">file exists and is a block special (device) file.  </td>
</tr>
<tr>
<td valign="top">-c file </td>
<td valign="top">file exists and is a character special (device) file.  </td>
</tr>
<tr>
<td valign="top">-d file</td>
<td valign="top">file exists and is a directory.  </td>
</tr>
<tr>
<td valign="top">-e file</td>
<td valign="top">file exists.</td>
</tr>
<tr>
<td valign="top">-f file</td>
<td valign="top">file exists and is a regular file.</td>
</tr>
<tr>
<td valign="top">-g file</td>
<td valign="top">file exists and is set-group-ID.</td>
</tr>
<tr>
<td valign="top">-G file</td>
<td valign="top">file exists and is owned by the effective group ID.  </td>
</tr>
<tr>
<td valign="top">-k file</td>
<td valign="top">file exists and has its “sticky bit” set.</td>
</tr>
<tr>
<td valign="top">-L file</td>
<td valign="top">file exists and is a symbolic link.</td>
</tr>
<tr>
<td valign="top">-O file</td>
<td valign="top">file exists and is owned by the effective user ID.</td>
</tr>
<tr>
<td valign="top">-p file </td>
<td valign="top">file exists and is a named pipe.</td>
</tr>
<tr>
<td valign="top">-r file </td>
<td valign="top">file exists and is readable (has readable permission for
the effective user).
</td>
</tr>
<tr>
<td valign="top">-s file</td>
<td valign="top">file exists and has a length greater than zero.
</td>
</tr>
<tr>
<td valign="top">-S file</td>
<td valign="top">file exists and is a network socket.</td>
</tr>
<tr>
<td valign="top">-t fd</td>
<td valign="top">fd is a file descriptor directed to/from the terminal. This
can be used to determine whether standard input/output/
error is being redirected.  </td>
</tr>
<tr>
<td valign="top">-u file </td>
<td valign="top">file exists and is setuid.</td>
</tr>
<tr>
<td valign="top">-w file </td>
<td valign="top">file exists and is writable (has write permission for the
effective user).</td>
</tr>
<tr>
<td valign="top">-x file </td>
<td valign="top">file exists and is executable (has execute/search
permission for the effective user).</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">表28-1: 测试文件表达式</caption>
<tr>
<th class="title">表达式</th>
<th class="title">如果为真</th>
</tr>
<tr>
<td valign="top" width="20%">file1 -ef file2 </td>
<td valign="top">file1 和 file2
拥有相同的索引号（通过硬链接两个文件名指向相同的文件）。</td>
</tr>
<tr>
<td valign="top">file1 -nt file2 </td>
<td valign="top">file1新于file2。</td>
</tr>
<tr>
<td valign="top">file1 -ot file2 </td>
<td valign="top">file1早于file2。</td>
</tr>
<tr>
<td valign="top">-b file </td>
<td valign="top">file存在并且是一个块（设备）文件。</td>
</tr>
<tr>
<td valign="top">-c file </td>
<td valign="top">file存在并且是一个字符（设备）文件。</td>
</tr>
<tr>
<td valign="top">-d file</td>
<td valign="top">file存在并且是一个目录。</td>
</tr>
<tr>
<td valign="top">-e file</td>
<td valign="top">file存在。</td>
</tr>
<tr>
<td valign="top">-f file</td>
<td valign="top">file存在并且是一个普通文件。</td>
</tr>
<tr>
<td valign="top">-g file</td>
<td valign="top">file存在并且设置了组ID。</td>
</tr>
<tr>
<td valign="top">-G file</td>
<td valign="top">file存在并且由有效组ID拥有。</td>
</tr>
<tr>
<td valign="top">-k file</td>
<td valign="top">file存在并且设置了它的“sticky bit”。</td>
</tr>
<tr>
<td valign="top">-L file</td>
<td valign="top">file存在并且是一个符号链接。</td>
</tr>
<tr>
<td valign="top">-O file</td>
<td valign="top">file存在并且由有效用户ID拥有。</td>
</tr>
<tr>
<td valign="top">-p file </td>
<td valign="top">file存在并且是一个命名管道。</td>
</tr>
<tr>
<td valign="top">-r file </td>
<td valign="top">file存在并且可读（有效用户有可读权限）。 </td>
</tr>
<tr>
<td valign="top">-s file</td>
<td valign="top">file存在且其长度大于零。</td>
</tr>
<tr>
<td valign="top">-S file</td>
<td valign="top">file存在且是一个网络socket。</td>
</tr>
<tr>
<td valign="top">-t fd</td>
<td valign="top">fd是一个定向到终端／从终端定向的文件描述符 。
这可以被用来决定是否重定向了标准输入／输出错误。</td>
</tr>
<tr>
<td valign="top">-u file </td>
<td valign="top">file存在并且设置了setuid位。</td>
</tr>
<tr>
<td valign="top">-w file </td>
<td valign="top">file存在并且可写（有效用户拥有可写权限）。</td>
</tr>
<tr>
<td valign="top">-x file </td>
<td valign="top">file存在并且可执行（有效用户有执行／搜索权限）。</td>
</tr>
</table>
</p>

Here we have a script that demonstrates some of the file expressions:

这里我们有一个脚本说明了一些文件表达式：

    #!/bin/bash

    # test-file: Evaluate the status of a file

    FILE=~/.bashrc

    if [ -e "$FILE" ]; then
        if [ -f "$FILE" ]; then
            echo "$FILE is a regular file."
        fi
        if [ -d "$FILE" ]; then
            echo "$FILE is a directory."
        fi
        if [ -r "$FILE" ]; then
            echo "$FILE is readable."
        fi
        if [ -w "$FILE" ]; then
            echo "$FILE is writable."
        fi
        if [ -x "$FILE" ]; then
            echo "$FILE is executable/searchable."
        fi
    else
        echo "$FILE does not exist"
        exit 1
    fi

    exit

The script evaluates the file assigned to the constant FILE and displays its results as the
evaluation is performed. There are two interesting things to note about this script. First,
notice how the parameter $FILE is quoted within the expressions. This is not required,
but is a defense against the parameter being empty. If the parameter expansion of $FILE
were to result in an empty value, it would cause an error (the operators would be
interpreted as non-null strings rather than operators). Using the quotes around the
parameter insures that the operator is always followed by a string, even if the string is
empty. Second, notice the presence of the exit commands near the end of the script.
The exit command accepts a single, optional argument, which becomes the script’s exit
status. When no argument is passed, the exit status defaults to zero. Using exit in this
way allows the script to indicate failure if $FILE expands to the name of a nonexistent
file. The exit command appearing on the last line of the script is there as a formality.
When a script “runs off the end” (reaches end of file), it terminates with an exit status of
zero by default, anyway.

这个脚本会计算赋值给常量FILE的文件，并显示计算结果。对于此脚本有两点需要注意。第一个，
在表达式中参数$FILE是怎样被引用的。引号并不是必需的，但这是为了防范空参数。如果$FILE的参数展开
是一个空值，就会导致一个错误（操作符将会被解释为非空的字符串而不是操作符）。用引号把参数引起来就
确保了操作符之后总是跟随着一个字符串，即使字符串为空。第二个，注意脚本末尾的exit命令。
这个exit命令接受一个单独的，可选的参数，其成为脚本的退出状态。当不传递参数时，退出状态默认为零。
以这种方式使用exit命令，则允许此脚本提示失败如果$FILE展开成一个不存在的文件名。这个exit命令
出现在脚本中的最后一行，是一个当一个脚本“运行到最后”（到达文件末尾），不管怎样，
默认情况下它以退出状态零终止。

Similarly, shell functions can return an exit status by including an integer argument to the
return command. If we were to convert the script above to a shell function to include
it in a larger program, we could replace the exit commands with return statements
and get the desired behavior:

类似地，通过带有一个整数参数的return命令，shell函数可以返回一个退出状态。如果我们打算把
上面的脚本转变为一个shell函数，为了在更大的程序中包含此函数，我们用return语句来代替exit命令，
则得到期望的行为：

    test_file () {

        # test-file: Evaluate the status of a file

        FILE=~/.bashrc

        if [ -e "$FILE" ]; then
            if [ -f "$FILE" ]; then
                echo "$FILE is a regular file."
            fi
            if [ -d "$FILE" ]; then
                echo "$FILE is a directory."
            fi
            if [ -r "$FILE" ]; then
                echo "$FILE is readable."
            fi
            if [ -w "$FILE" ]; then
                echo "$FILE is writable."
            fi
            if [ -x "$FILE" ]; then
                echo "$FILE is executable/searchable."
            fi
        else
            echo "$FILE does not exist"
            return 1
        fi

    }

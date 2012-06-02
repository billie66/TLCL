---
layout: book
title: 读取键盘输入 
---

The scripts we have written so far lack a feature common in most computer programs — 
interactivity. That is, the ability of the program to interact with the user. While many
programs don’t need to be interactive, some programs benefit from being able to accept
input directly from the user. Take, for example, this script from the previous chapter:

到目前为止我们编写的脚本都缺乏一项在大多数计算机程序中都很常见的功能－交互性。也就是，
程序与用户进行交互的能力。虽然许多程序不必是可交互的，但一些程序却得到益处，能够直接
接受用户的输入。以这个前面章节中的脚本为例：

    #!/bin/bash

    # test-integer2: evaluate the value of an integer.

    INT=-5

    if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
        if [ $INT -eq 0 ]; then
            echo "INT is zero."
        else
            if [ $INT -lt 0 ]; then
                echo "INT is negative."
            else
                echo "INT is positive."
            fi
            if [ $((INT % 2)) -eq 0 ]; then
                echo "INT is even."
            else
            echo "INT is odd."
            fi
        fi
    else
        echo "INT is not an integer." >&2
        exit 1
    fi

Each time we want to change the value of `INT`, we have to edit the script. It would be
much more useful if the script could ask the user for a value. In this chapter, we will
begin to look at how we can add interactivity to our programs.

每次我们想要改变`INT`数值的时候，我们必须编辑这个脚本。如果脚本能请求用户输入数值，那
么它会更加有用处。在这个脚本中，我们将看一下我们怎样给程序增加交互性功能。

### read – Read Values From Standard Input

### read – 从标准输入读取数值 

The `read` builtin command is used to read a single line of standard input. This
command can be used to read keyboard input or, when redirection is employed, a line of
data from a file. The command has the following syntax:

这个`read`内部命令被用来从标准输入读取单行数据。这个命令可以用来读取键盘输入，当使用
重定向的时候，读取文件中的一行数据。这个命令有以下语法形式：

    read [-options] [variable...]

where `options` is one or more of the available options listed below and `variable` is the
name of one or more variables used to hold the input value. If no variable name is
supplied, the shell variable `REPLY` contains the line of data.

这里的`options`是下面列出的可用选项中的一个或多个，且`variable`是用来存储输入数值的一个或多个变量名。
如果没有提供变量名，shell变量`REPLY`会包含数据行。

Basically, `read` assigns fields from standard input to the specified variables. If we
modify our integer evaluation script to use `read`, it might look like this:

基本上，`read`会把来自标准输入的字段赋值给具体的变量。如果我们修改我们的整数求值脚本，让其使用
`read`，它可能看起来像这样：

    #!/bin/bash

    # read-integer: evaluate the value of an integer.

    echo -n "Please enter an integer -> "
    read int

    if [[ "$int" =~ ^-?[0-9]+$ ]]; then
        if [ $int -eq 0 ]; then
            echo "$int is zero."
        else
            if [ $int -lt 0 ]; then
                echo "$int is negative."
            else
                echo "$int is positive."
            fi
            if [ $((int % 2)) -eq 0 ]; then
                echo "$int is even."
            else
                echo "$int is odd."
            fi
        fi
    else
        echo "Input value is not an integer." >&2
        exit 1
    fi

We use `echo` with the `-n` option (which suppresses the trailing newline on output) to
display a prompt, then use `read` to input a value for the variable int. Running this
script results in this:

我们使用带有`-n`选项（其会删除输出结果末尾的换行符）的`echo`命令，来显示提示信息，
然后使用`read`来读入变量`int`的数值。运行这个脚本得到以下输出：

    [me@linuxbox ~]$ read-integer
    Please enter an integer -> 5
    5 is positive.
    5 is odd.

`read` can assign input to multiple variables, as shown in this script:

`read`可以给多个变量赋值，正如下面脚本中所示：

    #!/bin/bash

    # read-multiple: read multiple values from keyboard

    echo -n "Enter one or more values > "
    read var1 var2 var3 var4 var5

    echo "var1 = '$var1'"
    echo "var2 = '$var2'"
    echo "var3 = '$var3'"
    echo "var4 = '$var4'"
    echo "var5 = '$var5'"

In this script, we assign and display up to five values. Notice how `read` behaves when
given different numbers of values:

在这个脚本中，我们给五个变量赋值并显示其结果。注意当给定不同个数的数值后，`read`怎样操作：

    [me@linuxbox ~]$ read-multiple
    Enter one or more values > a b c d e
    var1 = 'a'
    var2 = 'b'
    var3 = 'c'
    var4 = 'd'
    var5 = 'e'
    [me@linuxbox ~]$ read-multiple
    Enter one or more values > a
    var1 = 'a'
    var2 = ''
    var3 = ''
    var4 = ''
    var5 = ''
    [me@linuxbox ~]$ read-multiple
    Enter one or more values > a b c d e f g
    var1 = 'a'
    var2 = 'b'
    var3 = 'c'
    var4 = 'd'
    var5 = 'e f g'

If `read` receives fewer than the expected number, the extra variables are empty, while an
excessive amount of input results in the final variable containing all of the extra input.
If no variables are listed after the read command, a shell variable, `REPLY`, will be
assigned all the input:

如果`read`命令接受到变量值数目少于期望的数字，那么额外的变量值为空，而多余的输入数据则会
被包含到最后一个变量中。如果`read`命令之后没有列出变量名，则一个shell变量，`REPLY`，将会包含
所有的输入：

    #!/bin/bash

    # read-single: read multiple values into default variable
    
    echo -n "Enter one or more values > "
    read

    echo "REPLY = '$REPLY'"

Running this script results in this:

    [me@linuxbox ~]$ read-single
    Enter one or more values > a b c d
    REPLY = 'a b c d'

#### Options

#### 选项 

`read` supports the following options:

`read`支持以下选送：

<p>
<table class="multi" cellpadding="10" border="1" width="100%">
<caption class="cap">Table 29-1: read Options</caption>
<tr>
<th class="title">Option</th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="25%">-a array </td>
<td valign="top">Assign the input to array, starting with index zero. We
will cover arrays in Chapter 36.</td>
</tr>
<tr>
<td valign="top">-d delimiter </td>
<td valign="top">The first character in the string delimiter is used to
indicate end of input, rather than a newline character.</td>
</tr>
<tr>
<td valign="top">-e</td>
<td valign="top">Use Readline to handle input. This permits input editing
in the same manner as the command line.</td>
</tr>
<tr>
<td valign="top">-n num</td>
<td valign="top">Read num characters of input, rather than an entire line.</td>
</tr>
<tr>
<td valign="top">-p prompt </td>
<td valign="top">Display a prompt for input using the string prompt.</td>
</tr>
<tr>
<td valign="top">-r</td>
<td valign="top">Raw mode. Do not interpret backslash characters as
escapes.</td>
</tr>
<tr>
<td valign="top">-s</td>
<td valign="top">Silent mode. Do not echo characters to the display as
they are typed. This is useful when inputting passwords and other confidential information.</td>
</tr>
<tr>
<td valign="top">-t seconds</td>
<td valign="top">Timeout. Terminate input after seconds. read returns a
non-zero exit status if an input times out.</td>
</tr>
<tr>
<td valign="top">-u fd</td>
<td valign="top">Use input from file descriptor fd, rather than standard
input.</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="100%">
<caption class="cap">表29-1: read 选项</caption>
<tr>
<th class="title">选项</th>
<th class="title">说明</th>
</tr>
<tr>
<td valign="top" width="25%">-a array </td>
<td valign="top">把输入赋值到数组array中，从索引号零开始。我们
将在第36章中讨论数组问题。</td>
</tr>
<tr>
<td valign="top">-d delimiter </td>
<td valign="top">用字符串delimiter中的第一个字符指示输入结束，而不是一个换行符。</td>
</tr>
<tr>
<td valign="top">-e</td>
<td valign="top">使用Readline来处理输入。这使得与命令行相同的方式编辑输入。</td>
</tr>
<tr>
<td valign="top">-n num</td>
<td valign="top">读取num个输入字符，而不是整行。</td>
</tr>
<tr>
<td valign="top">-p prompt </td>
<td valign="top">为输入显示提示信息，使用字符串prompt。</td>
</tr>
<tr>
<td valign="top">-r</td>
<td valign="top">Raw mode. 不把反斜杠字符解释为转义字符。</td>
</tr>
<tr>
<td valign="top">-s</td>
<td valign="top">Silent mode.
不会在屏幕上显示输入的字符。当输入密码和其它确认信息的时候，这会很有帮助。</td>
</tr>
<tr>
<td valign="top">-t seconds</td>
<td valign="top">超时. 几秒钟后终止输入。read会返回一个非零退出状态，若输入超时。 </td>
</tr>
<tr>
<td valign="top">-u fd</td>
<td valign="top">使用文件描述符fd中的输入，而不是标准输入。</td>
</tr>
</table>
</p>

Using the various options, we can do interesting things with `read`. For example, with
the -p option, we can provide a prompt string:

使用各种各样的选项，我们能用`read`完成有趣的事情。例如，通过-p选项，我们能够提供提示信息：

    #!/bin/bash

    # read-single: read multiple values into default variable

    read -p "Enter one or more values > "

    echo "REPLY = '$REPLY'"

With the -t and -s options we can write a script that reads “secret” input and times out
if the input is not completed in a specified time:

通过-t和-s选项，我们可以编写一个这样的脚本，读取“秘密”输入，并且如果在特定的时间内
输入没有完成，就终止输入。

    #!/bin/bash

    # read-secret: input a secret pass phrase

    if read -t 10 -sp "Enter secret pass phrase > " secret_pass; then

        echo -e "\nSecret pass phrase = '$secret_pass'"
    else
        echo -e "\nInput timed out" >&2
        exit 1
    if

The script prompts the user for a secret pass phrase and waits ten seconds for input. If
the entry is not completed within the specified time, the script exits with an error. Since
the -s option is included, the characters of the pass phrase are not echoed to the display
as they are typed.

这个脚本提示用户输入一个密码，并等待输入10秒钟。如果在特定的时间内没有完成输入，
则脚本会退出并返回一个错误。因为包含了一个-s选项，所以输入的密码不会出现在屏幕上。

### IFS

Normally, the shell performs word splitting on the input provided to `read`. As we have
seen, this means that multiple words separated by one or more spaces become separate
items on the input line, and are assigned to separate variables by read. This behavior is
configured by a shell variable named __IFS__ (for Internal Field Separator). The default
value of __IFS__ contains a space, a tab, and a newline character, each of which will separate
items from one another.

通常，shell对提供给`read`的输入按照单词进行分离。正如我们所见到的，这意味着多个由一个或几个空格
分离开的单词在输入行中变成独立的个体，并被`read`赋值给单独的变量。这种行为由shell变量__IFS__
（内部字符分隔符）配置。__IFS__的默认值包含一个空格，一个tab，和一个换行符，每一个都会把
字段分割开。

We can adjust the value of __IFS__ to control the separation of fields input to `read`. For
example, the __/etc/passwd__ file contains lines of data that use the colon character as a
field separator. By changing the value of __IFS__ to a single colon, we can use read to
input the contents of __/etc/passwd__ and successfully separate fields into different
variables. Here we have a script that does just that:

我们可以调整__IFS__的值来控制输入字段的分离。例如，这个__/etc/passwd__文件包含的数据行
使用冒号作为字段分隔符。通过把__IFS__的值更改为单个冒号，我们可以使用`read`读取
__/etc/passwd__中的内容，并成功地把字段分给不同的变量。这个就是做这样的事情：

    #!/bin/bash

    # read-ifs: read fields from a file

    FILE=/etc/passwd

    read -p "Enter a user name > " user_name

    file_info=$(grep "^$user_name:" $FILE)

    if [ -n "$file_info" ]; then
        IFS=":" read user pw uid gid name home shell <<< "$file_info"
        echo "User = '$user'"
        echo "UID = '$uid'"
        echo "GID = '$gid'"
        echo "Full Name = '$name'"
        echo "Home Dir. = '$home'"
        echo "Shell = '$shell'"
    else
        echo "No such user '$user_name'" >&2
        exit 1
    fi
This script prompts the user to enter the user name of an account on the system, then
displays the different fields found in the user’s record in the __/etc/passwd__ file. The
script contains two interesting lines. The first is:

这个脚本提示用户输入系统中一个帐户的用户名，然后显示在文件__/etc/passwd/__文件中关于用户记录的
不同字段，。这个脚本包含两个有趣的文本行。 第一个是：

    file_info=$(grep "^$user_name:" $FILE)

This line assigns the results of a grep command to the variable __file_info__. The
regular expression used by grep assures that the user name will only match a single line
in the __/etc/passwd__ file.

这一行把__grep__命令的输入结果赋值给变量__file_info__。__grep__命令使用的正则表达式
确保用户名只会在__/etc/passwd__文件中匹配一个文本行。







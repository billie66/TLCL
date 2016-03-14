---
layout: book-zh
title: 流程控制：case 分支
---

在这一章中，我们将继续看一下程序的流程控制。在第28章中，我们构建了一些简单的菜单并创建了用来
应对各种用户选择的程序逻辑。为此，我们使用了一系列的 if 命令来识别哪一个可能的选项已经被选中。
这种类型的构造经常出现在程序中，出现频率如此之多，以至于许多编程语言（包括 shell）
专门为多选决策提供了一种流程控制机制。

### case

Bash 的多选复合命令称为 case。它的语法规则如下所示：

    case word in
        [pattern [| pattern]...) commands ;;]...
    esac

如果我们看一下第28章中的读菜单程序，我们就知道了用来应对一个用户选项的逻辑流程：

    #!/bin/bash
    # read-menu: a menu driven system information program
    clear
    echo "
    Please Select:
    1. Display System Information
    2. Display Disk Space
    3. Display Home Space Utilization
    0. Quit
    "
    read -p "Enter selection [0-3] > "
    if [[ $REPLY =~ ^[0-3]$ ]]; then
        if [[ $REPLY == 0 ]]; then
            echo "Program terminated."
            exit
        fi
        if [[ $REPLY == 1 ]]; then
            echo "Hostname: $HOSTNAME"
            uptime
            exit
        fi
        if [[ $REPLY == 2 ]]; then
            df -h
            exit
        fi
        if [[ $REPLY == 3 ]]; then
            if [[ $(id -u) -eq 0 ]]; then
                echo "Home Space Utilization (All Users)"
                du -sh /home/*
            else
                echo "Home Space Utilization ($USER)"
                du -sh $HOME
            fi
            exit
        fi
    else
        echo "Invalid entry." >&2
        exit 1
    fi

使用 case 语句，我们可以用更简单的代码替换这种逻辑：

    #!/bin/bash
    # case-menu: a menu driven system information program
    clear
    echo "
    Please Select:
    1. Display System Information
    2. Display Disk Space
    3. Display Home Space Utilization
    0. Quit
    "
    read -p "Enter selection [0-3] > "
    case $REPLY in
        0)  echo "Program terminated."
            exit
            ;;
        1)  echo "Hostname: $HOSTNAME"
            uptime
            ;;
        2)  df -h
            ;;
        3)  if [[ $(id -u) -eq 0 ]]; then
                echo "Home Space Utilization (All Users)"
                du -sh /home/*
            else
                echo "Home Space Utilization ($USER)"
                du -sh $HOME
            fi
            ;;
        *)  echo "Invalid entry" >&2
            exit 1
            ;;
    esac

case 命令检查一个变量值，在我们这个例子中，就是 REPLY 变量的变量值，然后试图去匹配其中一个具体的模式。
当与之相匹配的模式找到之后，就会执行与该模式相关联的命令。若找到一个模式之后，就不会再继续寻找。

### 模式

这里 case 语句使用的模式和路径展开中使用的那些是一样的。模式以一个 “)” 为终止符。这里是一些有效的模式。

<table class="multi">
<caption class="cap">表32-1: case 模式实例</caption>
<tr>
<th class="title">模式</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top">a)</td>
<td valign="top">若单词为 “a”，则匹配</td>
</tr>
<tr>
<td valign="top">[[:alpha:]])</td>
<td valign="top">若单词是一个字母字符，则匹配</td>
</tr>
 <tr>
<td valign="top">???)</td>
<td valign="top">若单词只有3个字符，则匹配</td>
</tr>
<tr>
<td valign="top">*.txt)</td>
<td valign="top">若单词以 “.txt” 字符结尾，则匹配</td>
</tr>
<tr>
<td valign="top">*)</td>
<td valign="top">匹配任意单词。把这个模式做为 case 命令的最后一个模式，是一个很好的做法，
可以捕捉到任意一个与先前模式不匹配的数值；也就是说，捕捉到任何可能的无效值。
</td>
</tr>
</table>

这里是一个模式使用实例：

    #!/bin/bash
    read -p "enter word > "
    case $REPLY in
        [[:alpha:]])        echo "is a single alphabetic character." ;;
        [ABC][0-9])         echo "is A, B, or C followed by a digit." ;;
        ???)                echo "is three characters long." ;;
        *.txt)              echo "is a word ending in '.txt'" ;;
        *)                  echo "is something else." ;;
    esac

还可以使用竖线字符作为分隔符，把多个模式结合起来。这就创建了一个 “或” 条件模式。这对于处理诸如大小写字符很有用处。例如：

    #!/bin/bash
    # case-menu: a menu driven system information program
    clear
    echo "
    Please Select:
    A. Display System Information
    B. Display Disk Space
    C. Display Home Space Utilization
    Q. Quit
    "
    read -p "Enter selection [A, B, C or Q] > "
    case $REPLY in
    q|Q) echo "Program terminated."
         exit
         ;;
    a|A) echo "Hostname: $HOSTNAME"
         uptime
         ;;
    b|B) df -h
         ;;
    c|C) if [[ $(id -u) -eq 0 ]]; then
             echo "Home Space Utilization (All Users)"
             du -sh /home/*
         else
             echo "Home Space Utilization ($USER)"
             du -sh $HOME
         fi
         ;;
    *)   echo "Invalid entry" >&2
         exit 1
         ;;
    esac

这里，我们更改了 case-menu 程序的代码，用字母来代替数字做为菜单选项。注意新模式如何使得大小写字母都是有效的输入选项。

### 执行多个动作

早于版本号4.0的 bash，case 语法只允许执行与一个成功匹配的模式相关联的动作。
匹配成功之后，命令将会终止。这里我们看一个测试一个字符的脚本：

    #!/bin/bash
    # case4-1: test a character
    read -n 1 -p "Type a character > "
    echo
    case $REPLY in
        [[:upper:]])    echo "'$REPLY' is upper case." ;;
        [[:lower:]])    echo "'$REPLY' is lower case." ;;
        [[:alpha:]])    echo "'$REPLY' is alphabetic." ;;
        [[:digit:]])    echo "'$REPLY' is a digit." ;;
        [[:graph:]])    echo "'$REPLY' is a visible character." ;;
        [[:punct:]])    echo "'$REPLY' is a punctuation symbol." ;;
        [[:space:]])    echo "'$REPLY' is a whitespace character." ;;
        [[:xdigit:]])   echo "'$REPLY' is a hexadecimal digit." ;;
    esac

运行这个脚本，输出这些内容：

    [me@linuxbox ~]$ case4-1
    Type a character > a
    'a' is lower case.

大多数情况下这个脚本工作是正常的，但若输入的字符不止与一个 POSIX 字符集匹配的话，这时脚本就会出错。
例如，字符 “a” 既是小写字母，也是一个十六进制的数字。早于4.0的 bash，对于 case 语法绝不能匹配
多个测试条件。现在的 bash 版本，添加 “;;&” 表达式来终止每个行动，所以现在我们可以做到这一点：

    #!/bin/bash
    # case4-2: test a character
    read -n 1 -p "Type a character > "
    echo
    case $REPLY in
        [[:upper:]])    echo "'$REPLY' is upper case." ;;&
        [[:lower:]])    echo "'$REPLY' is lower case." ;;&
        [[:alpha:]])    echo "'$REPLY' is alphabetic." ;;&
        [[:digit:]])    echo "'$REPLY' is a digit." ;;&
        [[:graph:]])    echo "'$REPLY' is a visible character." ;;&
        [[:punct:]])    echo "'$REPLY' is a punctuation symbol." ;;&
        [[:space:]])    echo "'$REPLY' is a whitespace character." ;;&
        [[:xdigit:]])   echo "'$REPLY' is a hexadecimal digit." ;;&
    esac

当我们运行这个脚本的时候，我们得到这些：

    [me@linuxbox ~]$ case4-2
    Type a character > a
    'a' is lower case.
    'a' is alphabetic.
    'a' is a visible character.
    'a' is a hexadecimal digit.

添加的 “;;&” 的语法允许 case 语句继续执行下一条测试，而不是简单地终止运行。

### 总结

case 命令是我们编程技巧口袋中的一个便捷工具。在下一章中我们将看到，
对于处理某些类型的问题来说，case 命令是一个完美的工具。

### 拓展阅读

* Bash 参考手册的条件构造一节详尽的介绍了 case 命令：

    <http://tiswww.case.edu/php/chet/bash/bashref.html#SEC21>

* 高级 Bash 脚本指南提供了更深一层的 case 应用实例：

    <http://tldp.org/LDP/abs/html/testbranch.html>

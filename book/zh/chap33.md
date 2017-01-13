---
layout: book-zh
title: 位置参数
---

现在我们的程序还缺少一种本领，就是接收和处理命令行选项和参数的能力。在这一章中，我们将探究一些能
让程序访问命令行内容的 shell 性能。

### 访问命令行

shell 提供了一个称为位置参数的变量集合，这个集合包含了命令行中所有独立的单词。这些变量按照从0到9给予命名。
可以以这种方式讲明白：

    #!/bin/bash
    # posit-param: script to view command line parameters
    echo "
    \$0 = $0
    \$1 = $1
    \$2 = $2
    \$3 = $3
    \$4 = $4
    \$5 = $5
    \$6 = $6
    \$7 = $7
    \$8 = $8
    \$9 = $9
    "

一个非常简单的脚本，显示从 $0 到 $9 所有变量的值。当不带命令行参数执行该脚本时，输出结果如下：

    [me@linuxbox ~]$ posit-param
    $0 = /home/me/bin/posit-param
    $1 =
    $2 =
    $3 =
    $4 =
    $5 =
    $6 =
    $7 =
    $8 =
    $9 =

即使不带命令行参数，位置参数 $0 总会包含命令行中出现的第一个单词，也就是已执行程序的路径名。
当带参数执行脚本时，我们看看输出结果：

    [me@linuxbox ~]$ posit-param a b c d
    $0 = /home/me/bin/posit-param
    $1 = a
    $2 = b
    $3 = c
    $4 = d
    $5 =
    $6 =
    $7 =
    $8 =
    $9 =

注意： 实际上通过参数展开方式你可以访问的参数个数多于9个。只要指定一个大于9的数字，用花括号把该数字括起来就可以。
例如 ${10}， ${55}， ${211}，等等。

#### 确定参数个数

另外 shell 还提供了一个名为 $#，可以得到命令行参数个数的变量:

    #!/bin/bash
    # posit-param: script to view command line parameters
    echo "
    Number of arguments: $#
    \$0 = $0
    \$1 = $1
    \$2 = $2
    \$3 = $3
    \$4 = $4
    \$5 = $5
    \$6 = $6
    \$7 = $7
    \$8 = $8
    \$9 = $9
    "

结果是：

    [me@linuxbox ~]$ posit-param a b c d
    Number of arguments: 4
    $0 = /home/me/bin/posit-param
    $1 = a
    $2 = b
    $3 = c
    $4 = d
    $5 =
    $6 =
    $7 =
    $8 =
    $9 =

#### shift - 访问多个参数的利器

但是如果我们给一个程序添加大量的命令行参数，会怎么样呢？ 正如下面的例子：

    [me@linuxbox ~]$ posit-param *
    Number of arguments: 82
    $0 = /home/me/bin/posit-param
    $1 = addresses.ldif
    $2 = bin
    $3 = bookmarks.html
    $4 = debian-500-i386-netinst.iso
    $5 = debian-500-i386-netinst.jigdo
    $6 = debian-500-i386-netinst.template
    $7 = debian-cd_info.tar.gz
    $8 = Desktop
    $9 = dirlist-bin.txt

在这个例子运行的环境下，通配符 * 展开成82个参数。我们如何处理那么多的参数？
为此，shell 提供了一种方法，尽管笨拙，但可以解决这个问题。执行一次 shift 命令，
就会导致所有的位置参数 “向下移动一个位置”。事实上，用 shift 命令也可以
处理只有一个参数的情况（除了其值永远不会改变的变量 $0）：

    #!/bin/bash
    # posit-param2: script to display all arguments
    count=1
    while [[ $# -gt 0 ]]; do
        echo "Argument $count = $1"
        count=$((count + 1))
        shift
    done

每次 shift 命令执行的时候，变量 $2 的值会移动到变量 $1 中，变量 $3 的值会移动到变量 $2 中，依次类推。
变量 $# 的值也会相应的减1。

在该 posit-param2 程序中，我们编写了一个计算剩余参数数量，只要参数个数不为零就会继续执行的 while 循环。
我们显示当前的位置参数，每次循环迭代变量 count 的值都会加1，用来计数处理的参数数量，
最后，执行 shift 命令加载 $1，其值为下一个位置参数的值。这里是程序运行后的输出结果:

    [me@linuxbox ~]$ posit-param2 a b c d
    Argument 1 = a
    Argument 2 = b
    Argument 3 = c
    Argument 4 = d

#### 简单应用

即使没有 shift 命令，也可以用位置参数编写一个有用的应用。举例说明，这里是一个简单的输出文件信息的程序：

    #!/bin/bash
    # file_info: simple file information program
    PROGNAME=$(basename $0)
    if [[ -e $1 ]]; then
        echo -e "\nFile Type:"
        file $1
        echo -e "\nFile Status:"
        stat $1
    else
        echo "$PROGNAME: usage: $PROGNAME file" >&2
        exit 1
    fi

这个程序显示一个具体文件的文件类型（由 file 命令确定）和文件状态（来自 stat 命令）。该程序一个有意思
的特点是 PROGNAME 变量。它的值就是 basename $0 命令的执行结果。这个 basename 命令清除
一个路径名的开头部分，只留下一个文件的基本名称。在我们的程序中，basename 命令清除了包含在 $0 位置参数
中的路径名的开头部分，$0 中包含着我们示例程序的完整路径名。当构建提示信息正如程序结尾的使用信息的时候，
basename $0 的执行结果就很有用处。按照这种方式编码，可以重命名该脚本，且程序信息会自动调整为
包含相应的程序名称。

#### Shell 函数中使用位置参数

正如位置参数被用来给 shell 脚本传递参数一样，它们也能够被用来给 shell 函数传递参数。为了说明这一点，
我们将把 file_info 脚本转变成一个 shell 函数：

    file_info () {
      # file_info: function to display file information
      if [[ -e $1 ]]; then
          echo -e "\nFile Type:"
          file $1
          echo -e "\nFile Status:"
          stat $1
      else
          echo "$FUNCNAME: usage: $FUNCNAME file" >&2
          return 1
      fi
    }

现在，如果一个包含 shell 函数 file_info 的脚本调用该函数，且带有一个文件名参数，那这个参数会传递给 file_info 函数。

通过此功能，我们可以写出许多有用的 shell 函数，这些函数不仅能在脚本中使用，也可以用在 .bashrc 文件中。

注意那个 PROGNAME 变量已经改成 shell 变量 FUNCNAME 了。shell 会自动更新 FUNCNAME 变量，以便
跟踪当前执行的 shell 函数。注意位置参数 $0 总是包含命令行中第一项的完整路径名（例如，该程序的名字），
但不会包含这个我们可能期望的 shell 函数的名字。

### 处理集体位置参数

有时候把所有的位置参数作为一个集体来管理是很有用的。例如，我们可能想为另一个程序编写一个 “包裹程序”。
这意味着我们会创建一个脚本或 shell 函数，来简化另一个程序的执行。包裹程序提供了一个神秘的命令行选项
列表，然后把这个参数列表传递给下一级的程序。

为此 shell 提供了两种特殊的参数。他们二者都能扩展成完整的位置参数列表，但以相当微妙的方式略有不同。它们是：

<table class="multi">
<caption class="cap">表 32-1: * 和 @ 特殊参数</caption>
<tr>
<th class="title" width="15%">参数</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top">$*</td>
<td valign="top">展开成一个从1开始的位置参数列表。当它被用双引号引起来的时候，展开成一个由双引号引起来
的字符串，包含了所有的位置参数，每个位置参数由 shell 变量 IFS 的第一个字符（默认为一个空格）分隔开。</td>
</tr>
<tr>
<td valign="top">$@</td>
<td valign="top">展开成一个从1开始的位置参数列表。当它被用双引号引起来的时候，
它把每一个位置参数展开成一个由双引号引起来的分开的字符串。</td>
</tr>
</table>

下面这个脚本用程序中展示了这些特殊参数：

    #!/bin/bash
    # posit-params3 : script to demonstrate $* and $@
    print_params () {
        echo "\$1 = $1"
        echo "\$2 = $2"
        echo "\$3 = $3"
        echo "\$4 = $4"
    }
    pass_params () {
        echo -e "\n" '$* :';      print_params   $*
        echo -e "\n" '"$*" :';    print_params   "$*"
        echo -e "\n" '$@ :';      print_params   $@
        echo -e "\n" '"$@" :';    print_params   "$@"
    }
    pass_params "word" "words with spaces"

在这个相当复杂的程序中，我们创建了两个参数： “word” 和 “words with spaces”，然后把它们
传递给 pass_params 函数。这个函数，依次，再把两个参数传递给 print_params 函数，
使用了特殊参数 $* 和 $@ 提供的四种可用方法。脚本运行后，揭示了这两个特殊参数存在的差异：

    [me@linuxbox ~]$ posit-param3
     $* :
    $1 = word
    $2 = words
    $3 = with
    $4 = spaces
     "$*" :
    $1 = word words with spaces
    $2 =
    $3 =
    $4 =
     $@ :
    $1 = word
    $2 = words
    $3 = with
    $4 = spaces
     "$@" :
    $1 = word
    $2 = words with spaces
    $3 =
    $4 =

通过我们的参数，$* 和 $@ 两个都产生了一个有四个词的结果：

    word words with spaces
    "$*" produces a one word result:
        "word words with spaces"
    "$@" produces a two word result:
        "word" "words with spaces"

这个结果符合我们实际的期望。我们从中得到的教训是尽管 shell 提供了四种不同的得到位置参数列表的方法，
但到目前为止， "$@" 在大多数情况下是最有用的方法，因为它保留了每一个位置参数的完整性。

### 一个更复杂的应用

经过长时间的间断，我们将恢复程序 sys_info_page 的工作。我们下一步要给程序添加如下几个命令行选项：

* __输出文件__。 我们将添加一个选项，以便指定一个文件名，来包含程序的输出结果。
选项格式要么是 -f file，要么是 -\-file file

* __交互模式__。这个选项将提示用户输入一个输出文件名，然后判断是否指定的文件已经存在了。如果文件存在，
在覆盖这个存在的文件之前会提示用户。这个选项可以通过 -i 或者 -\-interactive 来指定。

* __帮助__。指定 -h 选项 或者是 -\-help 选项，可导致程序输出提示性的使用信息。

这里是处理命令行选项所需的代码：

    usage () {
        echo "$PROGNAME: usage: $PROGNAME [-f file | -i]"
        return
    }
    # process command line options
    interactive=
    filename=
    while [[ -n $1 ]]; do
        case $1 in
        -f | --file)            shift
                                filename=$1
                                ;;
        -i | --interactive)     interactive=1
                                ;;
        -h | --help)            usage
                                exit
                                ;;
        *)                      usage >&2
                                exit 1
                                ;;
        esac
        shift
    done

首先，我们添加了一个叫做 usage 的 shell 函数，以便显示帮助信息，当启用帮助选项或敲写了一个未知选项的时候。

下一步，我们开始处理循环。当位置参数 $1 不为空的时候，这个循环会持续运行。在循环的底部，有一个 shift 命令，
用来提升位置参数，以便确保该循环最终会终止。在循环体内，我们使用了一个 case 语句来检查当前位置参数的值，
看看它是否匹配某个支持的选项。若找到了匹配项，就会执行与之对应的代码。若没有，就会打印出程序使用信息，
该脚本终止且执行错误。

处理 -f 参数的方式很有意思。当监测到 -f 参数的时候，会执行一次 shift 命令，从而提升位置参数 $1 为
伴随着 -f 选项的 filename 参数。

我们下一步添加代码来实现交互模式：

    # interactive mode
    if [[ -n $interactive ]]; then
        while true; do
            read -p "Enter name of output file: " filename
            if [[ -e $filename ]]; then
                read -p "'$filename' exists. Overwrite? [y/n/q] > "
                case $REPLY in
                Y|y)    break
                        ;;
                Q|q)    echo "Program terminated."
                        exit
                        ;;
                *)      continue
                        ;;
                esac
            elif [[ -z $filename ]]; then
                continue
            else
                break
            fi
        done
    fi

若 interactive 变量不为空，就会启动一个无休止的循环，该循环包含文件名提示和随后存在的文件处理代码。
如果所需要的输出文件已经存在，则提示用户覆盖，选择另一个文件名，或者退出程序。如果用户选择覆盖一个
已经存在的文件，则会执行 break 命令终止循环。注意 case 语句是怎样只检测用户选择了覆盖还是退出选项。
其它任何选择都会导致循环继续并提示用户再次选择。

为了实现这个输出文件名的功能，首先我们必须把现有的这个写页面（page-writing）的代码转变成一个 shell 函数，
一会儿就会明白这样做的原因：

    write_html_page () {
        cat <<- _EOF_
            <HTML>
                <HEAD>
                    <TITLE>$TITLE</TITLE>
                </HEAD>
                <BODY>
                    <H1>$TITLE</H1>
                    <P>$TIMESTAMP</P>
                    $(report_uptime)
                    $(report_disk_space)
                    $(report_home_space)
                </BODY>
            </HTML>
        _EOF_
        return
    }
    # output html page
    if [[ -n $filename ]]; then
        if touch $filename && [[ -f $filename ]]; then
            write_html_page > $filename
        else
            echo "$PROGNAME: Cannot write file '$filename'" >&2
            exit 1
        fi
    else
        write_html_page
    fi

解决 -f 选项逻辑的代码出现在以上程序片段的末尾。在这段代码中，我们测试一个文件名是否存在，若文件名存在，
则执行另一个测试看看该文件是不是可写文件。为此，会运行 touch 命令，紧随其后执行一个测试，来决定 touch 命令
创建的文件是否是个普通文件。这两个测试考虑到了输入是无效路径名（touch 命令执行失败），和一个普通文件已经存在的情况。

正如我们所看到的，程序调用 write_html_page 函数来生成实际的网页。函数输出要么直接定向到
标准输出（若 filename 变量为空的话）要么重定向到具体的文件中。

### 总结

伴随着位置参数的加入，现在我们能编写相当具有功能性的脚本。例如，重复性的任务，位置参数使得我们可以编写
非常有用的，可以放置在一个用户的 .bashrc 文件中的 shell 函数。

我们的 sys_info_page 程序日渐精进。这里是一个完整的程序清单，最新的更改用高亮显示：

    #!/bin/bash
    # sys_info_page: program to output a system information page
    PROGNAME=$(basename $0)
    TITLE="System Information Report For $HOSTNAME"
    CURRENT_TIME=$(date +"%x %r %Z")
    TIMESTAMP="Generated $CURRENT_TIME, by $USER"
    report_uptime () {
        cat <<- _EOF_
            <H2>System Uptime</H2>
            <PRE>$(uptime)</PRE>
        _EOF_
        return
    }
    report_disk_space () {
        cat <<- _EOF_
            <H2>Disk Space Utilization</H2>
            <PRE>$(df -h)</PRE>
        _EOF_
        return
    }
    report_home_space () {
        if [[ $(id -u) -eq 0 ]]; then
            cat <<- _EOF_
                <H2>Home Space Utilization (All Users)</H2>
                <PRE>$(du -sh /home/*)</PRE>
            _EOF_
        else
            cat <<- _EOF_
                <H2>Home Space Utilization ($USER)</H2>
                <PRE>$(du -sh $HOME)</PRE>
            _EOF_
        fi
        return
    }
    usage () {
        echo "$PROGNAME: usage: $PROGNAME [-f file | -i]"
        return
    }
    write_html_page () {
        cat <<- _EOF_
            <HTML>
                <HEAD>
                    <TITLE>$TITLE</TITLE>
                </HEAD>
                <BODY>
                    <H1>$TITLE</H1>
                    <P>$TIMESTAMP</P>
                    $(report_uptime)
                    $(report_disk_space)
                    $(report_home_space)
                </BODY>
            </HTML>
        _EOF_
        return
    }
    # process command line options
    interactive=
    filename=
    while [[ -n $1 ]]; do
        case $1 in
            -f | --file)          shift
                                  filename=$1
                                  ;;
            -i | --interactive)   interactive=1
                                  ;;
            -h | --help)          usage
                                  exit
                                  ;;
            *)                    usage >&2
                                  exit 1
                                  ;;
        esac
        shift
    done
    # interactive mode
    if [[ -n $interactive ]]; then
        while true; do
            read -p "Enter name of output file: " filename
            if [[ -e $filename ]]; then
                read -p "'$filename' exists. Overwrite? [y/n/q] > "
                case $REPLY in
                    Y|y)    break
                            ;;
                    Q|q)    echo "Program terminated."
                            exit
                            ;;
                    *)      continue
                            ;;
                esac
            fi
        done
    fi
    # output html page
    if [[ -n $filename ]]; then
        if touch $filename && [[ -f $filename ]]; then
            write_html_page > $filename
        else
            echo "$PROGNAME: Cannot write file '$filename'" >&2
            exit 1
        fi
    else
        write_html_page
    fi

我们还没有完成。仍然还有许多事情我们可以做，可以改进。

### 拓展阅读

* _Bash Hackers Wiki_ 上有一篇不错的关于位置参数的文章：

    <http://wiki.bash-hackers.org/scripting/posparams>

* Bash 的参考手册有一篇关于特殊参数的文章，包括 $* 和 $@：

    <http://www.gnu.org/software/bash/manual/bashref.html#Special-Parameters>

* 除了本章讨论的技术之外，bash 还包含一个叫做 getopts 的内部命令，此命令也可以用来处理命令行参数。
bash 参考页面的 SHELL BUILTIN COMMANDS 一节介绍了这个命令，Bash Hackers Wiki 上也有对它的描述：

    <http://wiki.bash-hackers.org/howto/getopts_tutorial>


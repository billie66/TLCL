---
layout: book-zh
title: 疑难排解
---

随着我们的脚本变得越来越复杂，当脚本运行错误，执行结果出人意料的时候, 我们就应该查看一下原因了。
在这一章中，我们将会看一些脚本中出现地常见错误类型，同时还会介绍几个可以跟踪和消除问题的有用技巧。

### 语法错误

一个普通的错误类型是语法。语法错误涉及到一些 shell 语法元素的拼写错误。大多数情况下，这类错误
会导致 shell 拒绝执行此脚本。

在以下讨论中，我们将使用下面这个脚本，来说明常见的错误类型：

    #!/bin/bash
    # trouble: script to demonstrate common errors
    number=1
    if [ $number = 1 ]; then
        echo "Number is equal to 1."
    else
        echo "Number is not equal to 1."
    fi

参看脚本内容，我们知道这个脚本执行成功了：

    [me@linuxbox ~]$ trouble
    Number is equal to 1.

#### 丢失引号

如果我们编辑我们的脚本，并从跟随第一个 echo 命令的参数中，删除其末尾的双引号：

    #!/bin/bash
    # trouble: script to demonstrate common errors
    number=1
    if [ $number = 1 ]; then
        echo "Number is equal to 1.
    else
        echo "Number is not equal to 1."
    fi

观察发生了什么：

    [me@linuxbox ~]$ trouble
    /home/me/bin/trouble: line 10: unexpected EOF while looking for
    matching `"'
    /home/me/bin/trouble: line 13: syntax error: unexpected end of file

这个脚本产生了两个错误。有趣地是，所报告的行号不是引号被删除的地方，而是程序中后面的文本行。
我们能知道为什么，如果我们跟随丢失引号文本行之后的程序。bash 会继续寻找右引号，直到它找到一个，
其就是这个紧随第二个 echo 命令之后的引号。找到这个引号之后，bash 变得很困惑，并且 if 命令的语法
被破坏了，因为现在这个 fi 语句在一个用引号引起来的（但是开放的）字符串里面。

在冗长的脚本中，此类错误很难找到。使用带有语法高亮的编辑器将会帮助查找错误。如果安装了 vim 的完整版，
通过输入下面的命令，可以使语法高亮生效：

    :syntax on

#### 丢失或意外的标记

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

结果是这样的：

    [me@linuxbox ~]$ trouble
    /home/me/bin/trouble: line 9: syntax error near unexpected token
    `else'
    /home/me/bin/trouble: line 9: `else'

再次，错误信息指向一个错误，其出现的位置在实际问题所在的文本行的后面。所发生的事情真是相当有意思。我们记得，
if 能够接受一系列命令，并且会计算列表中最后一个命令的退出代码。在我们的程序中，我们打算这个列表由
单个命令组成，即 [，测试的同义词。这个 [ 命令把它后面的东西看作是一个参数列表。在我们这种情况下，
有三个参数： $number，=，和 ]。由于删除了分号，单词 then 被添加到参数列表中，从语法上讲，
这是合法的。随后的 echo 命令也是合法的。它被解释为命令列表中的另一个命令，if
将会计算命令的 退出代码。接下来遇到单词 else，但是它出局了，因为 shell 把它认定为一个
保留字（对于 shell 有特殊含义的单词），而不是一个命令名，因此报告错误信息。

#### 预料不到的展开

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

运行这个做了修改的脚本，得到以下输出：

    [me@linuxbox ~]$ trouble
    /home/me/bin/trouble: line 7: [: =: unary operator expected
    Number is not equal to 1.

我们得到一个相当神秘的错误信息，其后是第二个 echo 命令的输出结果。这问题是由于 test 命令中
 number 变量的展开结果造成的。当此命令：

    [ $number = 1 ]

经过展开之后，number 变为空值，结果就是这样：

    [  = 1 ]

这是无效的，所以就产生了错误。这个 = 操作符是一个二元操作符（它要求每边都有一个数值），但是第一个数值是缺失的，
这样 test 命令就期望用一个一元操作符（比如 -z）来代替。进一步说，因为 test 命令运行失败了（由于错误），
这个 if 命令接收到一个非零退出代码，因此执行第二个 echo 命令。

通过为 test 命令中的第一个参数添加双引号，可以更正这个问题：

    [ "$number" = 1 ]

然后当展开操作发生地时候，执行结果将会是这样：

    [ "" = 1 ]

其得到了正确的参数个数。除了代表空字符串之外，引号应该被用于这样的场合，一个要展开
成多单词字符串的数值，及其包含嵌入式空格的文件名。

### 逻辑错误

不同于语法错误，逻辑错误不会阻止脚本执行。虽然脚本会正常运行，但是它不会产生期望的结果，
归咎于脚本的逻辑问题。虽然有不计其数的可能的逻辑错误，但下面是一些在脚本中找到的最常见的
逻辑错误类型：

1. 不正确的条件表达式。很容易编写一个错误的 if/then/else 语句，并且执行错误的逻辑。
有时候逻辑会被颠倒，或者是逻辑结构不完整。

1. “超出一个值”错误。当编写带有计数器的循环语句的时候，为了计数在恰当的点结束，循环语句
可能要求从 0 开始计数，而不是从 1 开始，这有可能会被忽视。这些类型的错误要不导致循环计数太多，而“超出范围”，
要不就是过早的结束了一次迭代，从而错过了最后一次迭代循环。

1. 意外情况。大多数逻辑错误来自于程序碰到了程序员没有预见到的数据或者情况。这也
可以包括出乎意料的展开，比如说一个包含嵌入式空格的文件名展开成多个命令参数而不是单个的文件名。

#### 防错编程

当编程的时候，验证假设非常重要。这意味着要仔细地计算脚本所使用的程序和命令的退出状态。
这里有个基于一个真实的故事的实例。为了在一台重要的服务器中执行维护任务，一位不幸的系统管理员写了一个脚本。
这个脚本包含下面两行代码：

    cd $dir_name
    rm *

从本质上来说，这两行代码没有任何问题，只要是变量 dir_name
中存储的目录名字存在就可以。但是如果不是这样会发生什么事情呢？在那种情况下，cd 命令会运行失败，
脚本会继续执行下一行代码，将会删除当前工作目录中的所有文件。完成不是期望的结果！
由于这种设计策略，这个倒霉的管理员销毁了服务器中的一个重要部分。

让我们看一些能够提高这个设计的方法。首先，在 cd 命令执行成功之后，再运行 rm 命令，可能是明智的选择。

    cd $dir_name && rm *

这样，如果 cd 命令运行失败后，rm 命令将不会执行。这样比较好，但是仍然有可能未设置变量
dir_name 或其变量值为空，从而导致删除了用户家目录下面的所有文件。这个问题也能够避免，通过检验变量
dir_name 中包含的目录名是否真正地存在：

    [[ -d $dir_name ]] && cd $dir_name && rm *

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

这里，我们检验了两种情况，一个名字，看看它是否为一个真正存在的目录，另一个是 cd 命令是否执行成功。
如果任一种情况失败，就会发送一个错误说明信息到标准错误，然后脚本终止执行，并用退出状态 1 表明脚本执行失败。

#### 验证输入

一个良好的编程习惯是如果一个程序可以接受输入数据，那么这个程序必须能够应对它所接受的任意数据。这
通常意味着必须非常仔细地筛选输入数据，以确保只有有效的输入数据才能被程序用来做进一步地处理。在前面章节
中我们学习 read 命令的时候，我们遇到过一个这样的例子。一个脚本中包含了下面一条测试语句，
用来验证一个选择菜单：

    [[ $REPLY =~ ^[0-3]$ ]]

这条测试语句非常明确。只有当用户输入是一个位于 0 到 3 范围内（包括 0 和 3）的数字的时候，
这条语句才返回一个 0 退出状态。而其它任何输入概不接受。有时候编写这类测试条件非常具有挑战性，
但是为了能产出一个高质量的脚本，付出还是必要的。

>
> _设计是时间的函数_
>
> 当我还是一名大学生，在学习工业设计的时候，一位明智的教授说过一个项目的设计程度是由
给定设计师的时间量来决定的。如果给你五分钟来设计一款能够 “杀死苍蝇”
的产品，你会设计出一个苍蝇拍。如果给你五个月的时间，你可能会制作出激光制导的
“反苍蝇系统”。
>
> 同样的原理适用于编程。有时候一个 “快速但粗糙” 的脚本就可以解决问题，
但这个脚本只能被其作者使用一次。这类脚本很常见，为了节省气力也应该被快速地开发出来。
所以这些脚本不需要太多的注释和防错检查。相反，如果一个脚本打算用于生产使用，也就是说，
某个重要任务或者多个客户会不断地用到它，此时这个脚本就需要非常谨慎小心地开发了。

### 测试

在各类软件开发中（包括脚本），测试是一个重要的环节。在开源世界中有一句谚语，“早发布，常发布”，这句谚语就反映出这个事实（测试的重要性）。
通过提早和经常发布，软件能够得到更多曝光去使用和测试。经验表明如果在开发周期的早期发现 bug，那么这些 bug 就越容易定位，而且越能低成本
的修复。

在之前的讨论中，我们知道了如何使用 stubs 来验证程序流程。在脚本开发的最初阶段，它们是一项有价值的技术
来检测我们的工作进度。

让我们看一下上面的文件删除问题，为了轻松测试，看看如何修改这些代码。测试原本那个代码片段将是危险的，因为它的目的是要删除文件，
但是我们可以修改代码，让测试安全：

    if [[ -d $dir_name ]]; then
        if cd $dir_name; then
            echo rm * # TESTING
        else
            echo "cannot cd to '$dir_name'" >&2
            exit 1
        fi
    else
        echo "no such directory: '$dir_name'" >&2
        exit 1
    fi
    exit # TESTING

因为在满足出错条件的情况下代码可以打印出有用信息，所以我们没有必要再添加任何额外信息了。
最重要的改动是仅在 rm 命令之前放置了一个 echo 命令，
为的是把 rm 命令及其展开的参数列表打印出来，而不是执行实际的 rm 命令语句。这个改动可以安全的执行代码。
在这段代码的末尾，我们放置了一个 exit 命令来结束测试，从而防止执行脚本其它部分的代码。
这个需求会因脚本的设计不同而变化。

我们也在代码中添加了一些注释，用来标记与测试相关的改动。当测试完成之后，这些注释可以帮助我们找到并删除所有的更改。

#### 测试案例

为了执行有用的测试，开发和使用好的测试案例是很重要的。这个要求可以通过谨慎地选择输入数据或者运行边缘案例和极端案例来完成。
在我们的代码片段中（是非常简单的代码），我们想要知道在下面的三种具体情况下这段代码是怎样执行的：

1. dir_name 包含一个已经存在的目录的名字

1. dir_name 包含一个不存在的目录的名字

1. dir_name 为空

通过执行以上每一个测试条件，就达到了一个良好的测试覆盖率。

正如设计，测试也是一个时间的函数。不是每一个脚本功能都需要做大量的测试。问题关键是确定什么功能是最重要的。因为
测试若发生故障会存在如此潜在的破坏性，所以我们的代码片在设计和测试段期间都应值得仔细推敲。

### 调试

如果测试暴露了脚本中的一个问题，那下一步就是调试了。“一个问题”通常意味着在某种情况下，这个脚本的执行
结果不是程序员所期望的结果。若是这种情况，我们需要仔细确认这个脚本实际到底要完成什么任务，和为什么要这样做。
有时候查找 bug 要牵涉到许多监测工作。一个设计良好的脚本会对查找错误有帮助。设计良好的脚本应该具备防卫能力，
能够监测异常条件，并能为用户提供有用的反馈信息。
然而有时候，出现的问题相当稀奇，出人意料，这时候就需要更多的调试技巧了。

#### 找到问题区域

在一些脚本中，尤其是一些代码比较长的脚本，有时候隔离脚本中与出现的问题相关的代码区域对查找问题很有帮助。
隔离的代码区域并不总是真正的错误所在，但是隔离往往可以深入了解实际的错误原因。可以用来隔离代码的一项
技巧是“添加注释”。例如，我们的文件删除代码可以修改成这样，从而决定注释掉的这部分代码是否导致了一个错误：

    if [[ -d $dir_name ]]; then
        if cd $dir_name; then
            rm *
        else
            echo "cannot cd to '$dir_name'" >&2
            exit 1
        fi
    # else
    #
        echo "no such directory: '$dir_name'" >&2
    #
        exit 1
    fi

通过给脚本中的一个逻辑区块内的每条语句的开头添加一个注释符号，我们就阻止了这部分代码的执行。然后可以再次执行测试，
来看看清除的代码是否影响了错误的行为。

#### 追踪

在一个脚本中，错误往往是由意想不到的逻辑流导致的。也就是说，脚本中的一部分代码或者从未执行，或是以错误的顺序，
或在错误的时间给执行了。为了查看真实的程序流，我们使用一项叫做追踪（tracing）的技术。

一种追踪方法涉及到在脚本中添加可以显示程序执行位置的提示性信息。我们可以添加提示信息到我们的代码片段中：

    echo "preparing to delete files" >&2
    if [[ -d $dir_name ]]; then
        if cd $dir_name; then
    echo "deleting files" >&2
            rm *
        else
            echo "cannot cd to '$dir_name'" >&2
            exit 1
        fi
    else
        echo "no such directory: '$dir_name'" >&2
        exit 1
    fi
    echo "file deletion complete" >&2

我们把提示信息输出到标准错误输出，让其从标准输出中分离出来。我们也没有缩进包含提示信息的语句，这样
想要删除它们的时候，能比较容易找到它们。

当这个脚本执行的时候，就可能看到文件删除操作已经完成了：

    [me@linuxbox ~]$ deletion-script
    preparing to delete files
    deleting files
    file deletion complete
    [me@linuxbox ~]$

bash 还提供了一种名为追踪的方法，这种方法可通过 -x 选项和 set 命令加上 -x 选项两种途径实现。
拿我们之前的 trouble 脚本为例，给该脚本的第一行语句添加 -x 选项，我们就能追踪整个脚本。

    #!/bin/bash -x
    # trouble: script to demonstrate common errors
    number=1
    if [ $number = 1 ]; then
        echo "Number is equal to 1."
    else
        echo "Number is not equal to 1."
    fi

当脚本执行后，输出结果看起来像这样:

    [me@linuxbox ~]$ trouble
    + number=1
    + '[' 1 = 1 ']'
    + echo 'Number is equal to 1.'
    Number is equal to 1.

追踪生效后，我们看到脚本命令展开后才执行。行首的加号表明追踪的迹象，使其与常规输出结果区分开来。
加号是追踪输出的默认字符。它包含在 PS4（提示符4）shell 变量中。可以调整这个变量值让提示信息更有意义。
这里，我们修改该变量的内容，让其包含脚本中追踪执行到的当前行的行号。注意这里必须使用单引号是为了防止变量展开，直到
提示符真正使用的时候，就不需要了。

    [me@linuxbox ~]$ export PS4='$LINENO + '
    [me@linuxbox ~]$ trouble
    5 + number=1
    7 + '[' 1 = 1 ']'
    8 + echo 'Number is equal to 1.'
    Number is equal to 1.

我们可以使用 set 命令加上 -x 选项，为脚本中的一块选择区域，而不是整个脚本启用追踪。

    #!/bin/bash
    # trouble: script to demonstrate common errors
    number=1
    set -x # Turn on tracing
    if [ $number = 1 ]; then
        echo "Number is equal to 1."
    else
        echo "Number is not equal to 1."
    fi
    set +x # Turn off tracing

我们使用 set 命令加上 -x 选项来启动追踪，+x 选项关闭追踪。这种技术可以用来检查一个有错误的脚本的多个部分。

#### 执行时检查数值

伴随着追踪，在脚本执行的时候显示变量的内容，以此知道脚本内部的工作状态，往往是很用的。
使用额外的 echo 语句通常会奏效。

    #!/bin/bash
    # trouble: script to demonstrate common errors
    number=1
    echo "number=$number" # DEBUG
    set -x # Turn on tracing
    if [ $number = 1 ]; then
        echo "Number is equal to 1."
    else
        echo "Number is not equal to 1."
    fi
    set +x # Turn off tracing

在这个简单的示例中，我们只是显示变量 number 的数值，并为其添加注释，随后利于其识别和清除。
当查看脚本中的循环和算术语句的时候，这种技术特别有用。

### 总结

在这一章中，我们仅仅看了几个在脚本开发期间会出现的问题。当然，还有很多。这章中描述的技术对查找
大多数的常见错误是有效的。调试是一种艺术，可以通过开发经验，在知道如何避免错误(整个开发过程中不断测试)
以及在查找 bug（有效利用追踪）两方面都会得到提升。

### 拓展阅读

* Wikipedia 上面有两篇关于语法和逻辑错误的短文：

  <http://en.wikipedia.org/wiki/Syntax_error>

  <http://en.wikipedia.org/wiki/logic_error>

* 网上有很多关于技术层面的 bash 编程的资源：

  <http://mywiki.wooledge.org/BashPitfalls>

  <http://tldp.org/LDP/abs/html/gotchas.html>

  <http://www.gnu.org/software/bash/manual/html_node/Reserved-Word-Index.html>

* 想要学习从编写良好的 Unix 程序中得知的基本概念，可以参考 Eric Raymond 的《Unix 编程的艺术》这本
伟大的著作。书中的许多想法都能适用于 shell 脚本：

  <http://www.faqs.org/docs/artu/>

  <http://www.faqs.org/docs/artu/ch01s06.html>

* 对于真正的高强度的调试，参考这个 Bash Debugger：

  <http://bashdb.sourceforge.net/>

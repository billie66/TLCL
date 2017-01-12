---
layout: book-zh
title: 字符串和数字
---

所有的计算机程序都是用来和数据打交道的。在过去的章节中，我们专注于处理文件级别的数据。
然而，许多编程问题需要使用更小的数据单位来解决，比方说字符串和数字。

在这一章中，我们将查看几个用来操作字符串和数字的 shell 功能。shell 提供了各种执行字符串操作的参数展开功能。
除了算术展开（在第七章中接触过），还有一个常见的命令行程序叫做 bc，能执行更高级别的数学运算。

### 参数展开

尽管参数展开在第七章中出现过，但我们并没有详尽地介绍它，因为大多数的参数展开会用在脚本中，而不是命令行中。
我们已经使用了一些形式的参数展开；例如，shell 变量。shell 提供了更多方式。

#### 基本参数

最简单的参数展开形式反映在平常使用的变量上。

例如：

_$a_

当 $a 展开后，会变成变量 a 所包含的值。简单参数也可能用花括号引起来：

_${a}_

虽然这对展开没有影响，但若该变量 a 与其它的文本相邻，可能会把 shell 搞糊涂了。在这个例子中，我们试图
创建一个文件名，通过把字符串 “_file” 附加到变量 a 的值的后面。

    [me@linuxbox ~]$ a="foo"
    [me@linuxbox ~]$ echo "$a_file"

如果我们执行这个序列，没有任何输出结果，因为 shell 会试着展开一个称为 a_file 的变量，而不是 a。通过
添加花括号可以解决这个问题：

    [me@linuxbox ~]$ echo "${a}_file"
    foo_file

我们已经知道通过把数字包裹在花括号中，可以访问大于9的位置参数。例如，访问第十一个位置参数，我们可以这样做：

_${11}_

#### 管理空变量的展开

几种用来处理不存在和空变量的参数展开形式。这些展开形式对于解决丢失的位置参数和给参数指定默认值的情况很方便。

_${parameter:-word}_

若 parameter 没有设置（例如，不存在）或者为空，展开结果是 word 的值。若 parameter 不为空，则展开结果是 parameter 的值。

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

_${parameter:=word}_

若 parameter 没有设置或为空，展开结果是 word 的值。另外，word 的值会赋值给 parameter。
若 parameter 不为空，展开结果是 parameter 的值。

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

注意： 位置参数或其它的特殊参数不能以这种方式赋值。

---

_${parameter:?word}_

若 parameter 没有设置或为空，这种展开导致脚本带有错误退出，并且 word 的内容会发送到标准错误。若 parameter 不为空，
展开结果是 parameter 的值。

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

_${parameter:+word}_

若 parameter 没有设置或为空，展开结果为空。若 parameter 不为空，
展开结果是 word 的值会替换掉 parameter 的值；然而，parameter 的值不会改变。

    [me@linuxbox ~]$ foo=
    [me@linuxbox ~]$ echo ${foo:+"substitute value if set"}

    [me@linuxbox ~]$ foo=bar
    [me@linuxbox ~]$ echo ${foo:+"substitute value if set"}
    substitute value if set

### 返回变量名的参数展开

shell 具有返回变量名的能力。这会用在一些相当独特的情况下。

_${!prefix*}_

_${!prefix@}_

这种展开会返回以 prefix 开头的已有变量名。根据 bash 文档，这两种展开形式的执行结果相同。
这里，我们列出了所有以 BASH 开头的环境变量名：

    [me@linuxbox ~]$ echo ${!BASH*}
    BASH BASH_ARGC BASH_ARGV BASH_COMMAND BASH_COMPLETION
    BASH_COMPLETION_DIR BASH_LINENO BASH_SOURCE BASH_SUBSHELL
    BASH_VERSINFO BASH_VERSION

#### 字符串展开

有大量的展开形式可用于操作字符串。其中许多展开形式尤其适用于路径名的展开。

_${#parameter}_

展开成由 parameter 所包含的字符串的长度。通常，parameter 是一个字符串；然而，如果 parameter 是 @ 或者是 * 的话，
则展开结果是位置参数的个数。

    [me@linuxbox ~]$ foo="This string is long."
    [me@linuxbox ~]$ echo "'$foo' is ${#foo} characters long."
    'This string is long.' is 20 characters long.

_${parameter:offset}_

_${parameter:offset:length}_

这些展开用来从 parameter 所包含的字符串中提取一部分字符。提取的字符始于
第 offset 个字符（从字符串开头算起）直到字符串的末尾，除非指定提取的长度。

    [me@linuxbox ~]$ foo="This string is long."
    [me@linuxbox ~]$ echo ${foo:5}
    string is long.
    [me@linuxbox ~]$ echo ${foo:5:6}
    string

若 offset 的值为负数，则认为 offset 值是从字符串的末尾开始算起，而不是从开头。注意负数前面必须有一个空格，
为防止与 ${parameter:-word} 展开形式混淆。length，若出现，则必须不能小于零。

如果 parameter 是 @，展开结果是 length 个位置参数，从第 offset 个位置参数开始。

    [me@linuxbox ~]$ foo="This string is long."
    [me@linuxbox ~]$ echo ${foo: -5}
    long.
    [me@linuxbox ~]$ echo ${foo: -5:2}
    lo

_${parameter#pattern}_

_${parameter##pattern}_

这些展开会从 paramter 所包含的字符串中清除开头一部分文本，这些字符要匹配定义的 pattern。pattern 是
通配符模式，就如那些用在路径名展开中的模式。这两种形式的差异之处是该 # 形式清除最短的匹配结果，
而该 ## 模式清除最长的匹配结果。

    [me@linuxbox ~]$ foo=file.txt.zip
    [me@linuxbox ~]$ echo ${foo#*.}
    txt.zip
    [me@linuxbox ~]$ echo ${foo##*.}
    zip

_${parameter%pattern}_

_${parameter%%pattern}_

这些展开和上面的 # 和 ## 展开一样，除了它们清除的文本从 parameter 所包含字符串的末尾开始，而不是开头。

    [me@linuxbox ~]$ foo=file.txt.zip
    [me@linuxbox ~]$ echo ${foo%.*}
    file.txt
    [me@linuxbox ~]$ echo ${foo%%.*}
    file

_${parameter/pattern/string}_

_${parameter//pattern/string}_

_${parameter/#pattern/string}_

_${parameter/%pattern/string}_

这种形式的展开对 parameter 的内容执行查找和替换操作。如果找到了匹配通配符 pattern 的文本，
则用 string 的内容替换它。在正常形式下，只有第一个匹配项会被替换掉。在该 // 形式下，所有的匹配项都会被替换掉。
该 /# 要求匹配项出现在字符串的开头，而 /% 要求匹配项出现在字符串的末尾。/string 可能会省略掉，这样会
导致删除匹配的文本。

    [me@linuxbox~]$ foo=JPG.JPG
    [me@linuxbox ~]$ echo ${foo/JPG/jpg}
    jpg.JPG
    [me@linuxbox~]$ echo ${foo//JPG/jpg}
    jpg.jpg
    [me@linuxbox~]$ echo ${foo/#JPG/jpg}
    jpg.JPG
    [me@linuxbox~]$ echo ${foo/%JPG/jpg}
    JPG.jpg

知道参数展开是件很好的事情。字符串操作展开可以用来替换其它常见命令比方说 sed 和 cut。
通过减少使用外部程序，展开提高了脚本的效率。举例说明，我们将修改在之前章节中讨论的 longest-word 程序，
用参数展开 ${#j} 取代命令 $(echo $j | wc -c) 及其 subshell ，像这样：

    #!/bin/bash
    # longest-word3 : find longest string in a file
    for i; do
        if [[ -r $i ]]; then
            max_word=
            max_len=
            for j in $(strings $i); do
                len=${#j}
                if (( len > max_len )); then
                    max_len=$len
                    max_word=$j
                fi
            done
            echo "$i: '$max_word' ($max_len characters)"
        fi
        shift
    done

下一步，我们将使用 time 命令来比较这两个脚本版本的效率：

    [me@linuxbox ~]$ time longest-word2 dirlist-usr-bin.txt
    dirlist-usr-bin.txt: 'scrollkeeper-get-extended-content-list' (38
    characters)
    real 0m3.618s
    user 0m1.544s
    sys 0m1.768s
    [me@linuxbox ~]$ time longest-word3 dirlist-usr-bin.txt
    dirlist-usr-bin.txt: 'scrollkeeper-get-extended-content-list' (38
    characters)
    real 0m0.060s
    user 0m0.056s
    sys 0m0.008s

原来的脚本扫描整个文本文件需耗时3.168秒，而该新版本，使用参数展开，仅仅花费了0.06秒 —— 一个非常巨大的提高。

#### 大小写转换

最新的 bash 版本已经支持字符串的大小写转换了。bash 有四个参数展开和 declare 命令的两个选项来支持大小写转换。

那么大小写转换对什么有好处呢？ 除了明显的审美价值，它在编程领域还有一个重要的角色。
让我们考虑一个数据库查询的案例。假设一个用户已经敲写了一个字符串到数据输入框中，
而我们想要在一个数据库中查找这个字符串。该用户输入的字符串有可能全是大写字母或全是小写或是两者的结合。
我们当然不希望把每个可能的大小写拼写排列填充到我们的数据库中。那怎么办？

解决这个问题的常见方法是规范化用户输入。也就是，在我们试图查询数据库之前，把用户的输入转换成标准化。
我们能做到这一点，通过把用户输入的字符全部转换成小写字母或大写字母，并且确保数据库中的条目
按同样的方式规范化。

这个 declare 命令可以用来把字符串规范成大写或小写字符。使用 declare 命令，我们能强制一个
变量总是包含所需的格式，无论如何赋值给它。

    #!/bin/bash
    # ul-declare: demonstrate case conversion via declare
    declare -u upper
    declare -l lower
    if [[ $1 ]]; then
        upper="$1"
        lower="$1"
        echo $upper
        echo $lower
    fi

在上面的脚本中，我们使用 declare 命令来创建两个变量，upper 和 lower。我们把第一个命令行参数的值（位置参数1）赋给
每一个变量，然后把变量值在屏幕上显示出来：

    [me@linuxbox ~]$ ul-declare aBc
    ABC
    abc

正如我们所看到的，命令行参数（“aBc”）已经规范化了。

有四个参数展开，可以执行大小写转换操作：

<table class="multi">
<caption class="cap">表 35-1: 大小写转换参数展开</caption>
<tr>
<th class="title">格式</th>
<th class="title">结果</th>
</tr>
<tr>
<td valign="top">${parameter,,} </td>
<td valign="top">把 parameter 的值全部展开成小写字母。</td>
</tr>
<tr>
<td valign="top">${parameter,} </td>
<td valign="top">仅仅把 parameter 的第一个字符展开成小写字母。</td>
</tr>
<tr>
<td valign="top">${parameter^^} </td>
<td valign="top">把 parameter 的值全部转换成大写字母。</td>
</tr>
<tr>
<td valign="top">${parameter^}</td>
<td valign="top">仅仅把 parameter 的第一个字符转换成大写字母（首字母大写）。</td>
</tr>
</table>

这里是一个脚本，演示了这些展开格式：

    #!/bin/bash
    # ul-param - demonstrate case conversion via parameter expansion
    if [[ $1 ]]; then
        echo ${1,,}
        echo ${1,}
        echo ${1^^}
        echo ${1^}
    fi

这里是脚本运行后的结果：

    [me@linuxbox ~]$ ul-param aBc
    abc
    aBc
    ABC
    ABc

再次，我们处理了第一个命令行参数，输出了由参数展开支持的四种变体。尽管这个脚本使用了第一个位置参数，
但参数可以是任意字符串，变量，或字符串表达式。

### 算术求值和展开

我们在第七章中已经接触过算术展开了。它被用来对整数执行各种算术运算。它的基本格式是：

    $((expression))

这里的 expression 是一个有效的算术表达式。

这个与复合命令 (( )) 有关，此命令用做算术求值（真测试），我们在第27章中遇到过。

在之前的章节中，我们看到过一些类型的表达式和运算符。这里，我们将看到一个更完整的列表。

#### 数基

回到第9章，我们看过八进制（以8为底）和十六进制（以16为底）的数字。在算术表达式中，shell 支持任意进制的整型常量。

<table class="multi">
<caption class="cap">表 35-2: 指定不同的数基</caption>
<tr>
<th class="title">表示法</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top">number</td>
<td valign="top">默认情况下，没有任何表示法的数字被看做是十进制数（以10为底）。</td>
</tr>
<tr>
<td valign="top">0number</td>
<td valign="top">在算术表达式中，以零开头的数字被认为是八进制数。</td>
</tr>
<tr>
<td valign="top">0xnumber</td>
<td valign="top">十六进制表示法</td>
</tr>
<tr>
<td valign="top">base#number</td>
<td valign="top">number 以 base 为底</td>
</tr>
</table>

一些例子：

    [me@linuxbox ~]$ echo $((0xff))
    255
    [me@linuxbox ~]$ echo $((2#11111111))
    255

在上面的示例中，我们打印出十六进制数 ff（最大的两位数）的值和最大的八位二进制数（以2为底）。

#### 一元运算符

有两个一元运算符，+ 和 -，它们被分别用来表示一个数字是正数还是负数。例如，-5。

#### 简单算术

下表中列出了普通算术运算符：

<table class="multi">
<caption class="cap">表 35-3: 算术运算符</caption>
<tr>
<th class="title">运算符</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top">+</td>
<td valign="top">加</td>
</tr>
<tr>
<td valign="top">-</td>
<td valign="top">减</td>
</tr>
<tr>
<td valign="top">*</td>
<td valign="top">乘</td>
</tr>
<tr>
<td valign="top">/</td>
<td valign="top">整除</td>
</tr>
<tr>
<td valign="top">**</td>
<td valign="top">乘方</td>
</tr>
<tr>
<td valign="top">%</td>
<td valign="top">取模（余数）</td>
</tr>
</table>

其中大部分运算符是不言自明的，但是整除和取模运算符需要进一步解释一下。

因为 shell 算术只操作整型，所以除法运算的结果总是整数：

    [me@linuxbox ~]$ echo $(( 5 / 2 ))
    2

这使得确定除法运算的余数更为重要：

    [me@linuxbox ~]$ echo $(( 5 % 2 ))
    1

通过使用除法和取模运算符，我们能够确定5除以2得数是2，余数是1。

在循环中计算余数是很有用处的。在循环执行期间，它允许某一个操作在指定的间隔内执行。在下面的例子中，
我们显示一行数字，并高亮显示5的倍数：

    #!/bin/bash
    # modulo : demonstrate the modulo operator
    for ((i = 0; i <= 20; i = i + 1)); do
        remainder=$((i % 5))
        if (( remainder == 0 )); then
            printf "<%d> " $i
        else
            printf "%d " $i
        fi
    done
    printf "\n"

当脚本执行后，输出结果看起来像这样：

    [me@linuxbox ~]$ modulo
    <0> 1 2 3 4 <5> 6 7 8 9 <10> 11 12 13 14 <15> 16 17 18 19 <20>

#### 赋值运算符

尽管它的使用不是那么明显，算术表达式可能执行赋值运算。虽然在不同的上下文中，我们已经执行了许多次赋值运算。
每次我们给变量一个值，我们就执行了一次赋值运算。我们也能在算术表达式中执行赋值运算：

    [me@linuxbox ~]$ foo=
    [me@linuxbox ~]$ echo $foo
    [me@linuxbox ~]$ if (( foo = 5 ));then echo "It is true."; fi
    It is true.
    [me@linuxbox ~]$ echo $foo
    5

在上面的例子中，首先我们给变量 foo 赋了一个空值，然后验证 foo 的确为空。下一步，我们执行一个 if 复合命令 (( foo = 5 ))。
这个过程完成两件有意思的事情：1）它把5赋值给变量 foo，2）它计算测试条件为真，因为 foo 的值非零。

---

注意： 记住上面表达式中 = 符号的真正含义非常重要。单个 = 运算符执行赋值运算。foo = 5 是说“使得 foo 等于5”，
而 == 运算符计算等价性。foo == 5 是说“是否 foo 等于5？”。这会让人感到非常迷惑，因为 test 命令接受单个 = 运算符
来测试字符串等价性。这也是使用更现代的 [[ ]] 和 (( )) 复合命令来代替 test 命令的另一个原因。

---

除了 = 运算符，shell 也提供了其它一些表示法，来执行一些非常有用的赋值运算：

<table class="multi">
<caption class="cap">表35-4: 赋值运算符</caption>
<tr>
<th class="title" width="25%">表示法</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top">parameter = value</td>
<td valign="top">简单赋值。给 parameter 赋值。</td>
</tr>
<tr>
<td valign="top">parameter += value</td>
<td valign="top">加。等价于 parameter = parameter + value。</td>
</tr>
<tr>
<td valign="top">parameter -= value</td>
<td valign="top">减。等价于 parameter = parameter – value。</td>
</tr>
<tr>
<td valign="top">parameter *= value</td>
<td valign="top">乘。等价于 parameter = parameter * value。</td>
</tr>
<tr>
<td valign="top">parameter /= value</td>
<td valign="top">整除。等价于 parameter = parameter / value。</td>
</tr>
<tr>
<td valign="top">parameter %= value</td>
<td valign="top"> 取模。等价于 parameter = parameter % value。</td>
</tr>
<tr>
<td valign="top">parameter++ </td>
<td valign="top">后缀自增变量。等价于 parameter = parameter + 1 (但，要看下面的讨论)。</td>
</tr>
<tr>
<td valign="top">parameter-- </td>
<td valign="top">后缀自减变量。等价于 parameter = parameter - 1。</td>
</tr>
<tr>
<td valign="top">++parameter</td>
<td valign="top">前缀自增变量。等价于 parameter = parameter + 1。</td>
</tr>
<tr>
<td valign="top">--parameter</td>
<td valign="top">前缀自减变量。等价于 parameter = parameter - 1。</td>
</tr>
</table>

这些赋值运算符为许多常见算术任务提供了快捷方式。特别关注一下自增（++）和自减（-\-）运算符，它们会把它们的参数值加1或减1。
这种风格的表示法取自C 编程语言并且被其它几种编程语言吸收，包括 bash。

自增和自减运算符可能会出现在参数的前面或者后面。然而它们都是把参数值加1或减1，这两个位置有个微小的差异。
若运算符放置在参数的前面，参数值会在参数返回之前增加（或减少）。若放置在后面，则运算会在参数返回之后执行。
这相当奇怪，但这是它预期的行为。这里是个演示的例子：

    [me@linuxbox ~]$ foo=1
    [me@linuxbox ~]$ echo $((foo++))
    1
    [me@linuxbox ~]$ echo $foo
    2

如果我们把1赋值给变量 foo，然后通过把自增运算符 ++ 放到参数名 foo 之后来增加它，foo 返回1。
然而，如果我们第二次查看变量 foo 的值，我们看到它的值增加了1。若我们把 ++ 运算符放到参数 foo 之前，
我们得到更期望的行为：

    [me@linuxbox ~]$ foo=1
    [me@linuxbox ~]$ echo $((++foo))
    2
    [me@linuxbox ~]$ echo $foo
    2

对于大多数 shell 应用来说，前缀运算符最有用。

自增 ++ 和 自减 -\- 运算符经常和循环操作结合使用。我们将改进我们的 modulo 脚本，让代码更紧凑些：

    #!/bin/bash
    # modulo2 : demonstrate the modulo operator
    for ((i = 0; i <= 20; ++i )); do
        if (((i % 5) == 0 )); then
            printf "<%d> " $i
        else
            printf "%d " $i
        fi
    done
    printf "\n"

#### 位运算符

位运算符是一类以不寻常的方式操作数字的运算符。这些运算符工作在位级别的数字。它们被用在某类底层的任务中，
经常涉及到设置或读取位标志。

<table class="multi">
<caption class="cap">表35-5: 位运算符</caption>
<tr>
<th class="title">运算符</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top">~</td>
<td valign="top">按位取反。对一个数字所有位取反。</td>
</tr>
<tr>
<td valign="top"><<</td>
<td valign="top">位左移. 把一个数字的所有位向左移动。</td>
</tr>
<tr>
<td valign="top">>></td>
<td valign="top">位右移. 把一个数字的所有位向右移动。</td>
</tr>
<tr>
<td valign="top">&</td>
<td valign="top">位与。对两个数字的所有位执行一个 AND 操作。</td>
</tr>
<tr>
<td valign="top">|</td>
<td valign="top">位或。对两个数字的所有位执行一个 OR 操作。</td>
</tr>
<tr>
<td valign="top">^</td>
<td valign="top">位异或。对两个数字的所有位执行一个异或操作。</td>
</tr>
</table>

注意除了按位取反运算符之外，其它所有位运算符都有相对应的赋值运算符（例如，<\<=）。

这里我们将演示产生2的幂列表的操作，使用位左移运算符：

    [me@linuxbox ~]$ for ((i=0;i<8;++i)); do echo $((1<<i)); done
    1
    2
    4
    8
    16
    32
    64
    128

#### 逻辑运算符

正如我们在第27章中所看到的，复合命令 (( )) 支持各种各样的比较运算符。还有一些可以用来计算逻辑运算。
这里是比较运算符的完整列表：

<table class="multi">
<caption class="cap">表35-6: 比较运算符</caption>
<tr>
<th class="title">运算符</th>
<th class="title">描述</th>
</tr>
<tr>
<td valign="top"><=</td>
<td valign="top">小于或相等</td>
</tr>
<tr>
<td valign="top">>=</td>
<td valign="top">大于或相等</td>
</tr>
<tr>
<td valign="top"><</td>
<td valign="top">小于</td>
</tr>
<tr>
<td valign="top">></td>
<td valign="top">大于</td>
</tr>
<tr>
<td valign="top">==</td>
<td valign="top">相等</td>
</tr>
<tr>
<td valign="top">!=</td>
<td valign="top">不相等</td>
</tr>
<tr>
<td valign="top">&&</td>
<td valign="top">逻辑与</td>
</tr>
<tr>
<td valign="top">||</td>
<td valign="top">逻辑或</td>
</tr>
<tr>
<td valign="top">expr1?expr2:expr3</td>
<td valign="top">条件（三元）运算符。若表达式 expr1 的计算结果为非零值（算术真），则
执行表达式 expr2，否则执行表达式 expr3。</td>
</tr>
</table>

当表达式用于逻辑运算时，表达式遵循算术逻辑规则；也就是，表达式的计算结果是零，则认为假，而非零表达式认为真。
该 (( )) 复合命令把结果映射成 shell 正常的退出码：

    [me@linuxbox ~]$ if ((1)); then echo "true"; else echo "false"; fi
    true
    [me@linuxbox ~]$ if ((0)); then echo "true"; else echo "false"; fi
    false

最陌生的逻辑运算符就是这个三元运算符了。这个运算符（仿照于 C 编程语言里的三元运算符）执行一个单独的逻辑测试。
它用起来类似于 if/then/else 语句。它操作三个算术表达式（字符串不会起作用），并且若第一个表达式为真（或非零），
则执行第二个表达式。否则，执行第三个表达式。我们可以在命令行中实验一下：

    [me@linuxbox~]$ a=0
    [me@linuxbox~]$ ((a<1?++a:--a))
    [me@linuxbox~]$ echo $a
    1
    [me@linuxbox~]$ ((a<1?++a:--a))
    [me@linuxbox~]$ echo $a
    0

这里我们看到一个实际使用的三元运算符。这个例子实现了一个切换。每次运算符执行的时候，变量 a 的值从零变为1，或反之亦然。

请注意在表达式内执行赋值却并非易事。

当企图这样做时，bash 会声明一个错误：

    [me@linuxbox ~]$ a=0
    [me@linuxbox ~]$ ((a<1?a+=1:a-=1))
    bash: ((: a<1?a+=1:a-=1: attempted assignment to non-variable (error token is "-=1")

通过把赋值表达式用括号括起来，可以解决这个错误：

    [me@linuxbox ~]$ ((a<1?(a+=1):(a-=1)))

下一步，我们看一个使用算术运算符更完备的例子，该示例产生一个简单的数字表格：

    #!/bin/bash
    # arith-loop: script to demonstrate arithmetic operators
    finished=0
    a=0
    printf "a\ta**2\ta**3\n"
    printf "=\t====\t====\n"
    until ((finished)); do
        b=$((a**2))
        c=$((a**3))
        printf "%d\t%d\t%d\n" $a $b $c
        ((a<10?++a:(finished=1)))
    done

在这个脚本中，我们基于变量 finished 的值实现了一个 until 循环。首先，把变量 finished 的值设为零（算术假），
继续执行循环之道它的值变为非零。在循环体内，我们计算计数器 a 的平方和立方。在循环末尾，计算计数器变量 a 的值。
若它小于10（最大迭代次数），则 a 的值加1，否则给变量 finished 赋值为1，使得变量 finished 算术为真，
从而终止循环。运行该脚本得到这样的结果：

    [me@linuxbox ~]$ arith-loop
    a    a**2     a**3
    =    ====     ====
    0    0        0
    1    1        1
    2    4        8
    3    9        27
    4    16       64
    5    25       125
    6    36       216
    7    49       343
    8    64       512
    9    81       729
    10   100      1000

### bc - 一种高精度计算器语言

我们已经看到 shell 是可以处理所有类型的整型算术的，但是如果我们需要执行更高级的数学运算或仅使用浮点数，该怎么办？
答案是，我们不能这样做。至少不能直接用 shell 完成此类运算。为此，我们需要使用外部程序。
有几种途径可供我们采用。嵌入的 Perl 或者 AWK 程序是一种可能的方案，但是不幸的是，超出了本书的内容大纲。
另一种方式就是使用一种专业的计算器程序。这样一个程序叫做 bc，在大多数 Linux 系统中都可以找到。

该 bc 程序读取一个用它自己的类似于 C 语言的语法编写的脚本文件。一个 bc 脚本可能是一个分离的文件或者是从
标准输入读入。bc 语言支持相当少的功能，包括变量，循环和程序员定义的函数。这里我们不会讨论整个 bc 语言，
仅仅体验一下。查看 bc 的手册页，其文档整理得非常好。

让我们从一个简单的例子开始。我们将编写一个 bc 脚本来执行2加2运算：

    /* A very simple bc script */
    2 + 2

脚本的第一行是一行注释。bc 使用和 C 编程语言一样的注释语法。注释，可能会跨越多行，开始于 `/*` 结束于 `*/`。

#### 使用 bc

如果我们把上面的 bc 脚本保存为 foo.bc，然后我们就能这样运行它：

    [me@linuxbox ~]$ bc foo.bc
    bc 1.06.94
    Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006 Free Software
    Foundation, Inc.
    This is free software with ABSOLUTELY NO WARRANTY.
    For details type `warranty'.
    4

如果我们仔细观察，我们看到算术结果在最底部，版权信息之后。可以通过 -q（quiet）选项禁止这些版权信息。
bc 也能够交互使用：

    [me@linuxbox ~]$ bc -q
    2 + 2
    4
    quit

当使用 bc 交互模式时，我们简单地输入我们希望执行的运算，结果就立即显示出来。bc 的 quit 命令结束交互会话。

也可能通过标准输入把一个脚本传递给 bc 程序：

    [me@linuxbox ~]$ bc < foo.bc
    4

这种接受标准输入的能力，意味着我们可以使用 here 文档，here字符串，和管道来传递脚本。这里是一个使用 here 字符串的例子：

    [me@linuxbox ~]$ bc <<< "2+2"
    4

#### 一个脚本实例

作为一个真实世界的例子，我们将构建一个脚本，用于计算每月的还贷金额。在下面的脚本中，
我们使用了 here 文档把一个脚本传递给 bc：

    #!/bin/bash
    # loan-calc : script to calculate monthly loan payments
    PROGNAME=$(basename $0)
    usage () {
        cat <<- EOF
        Usage: $PROGNAME PRINCIPAL INTEREST MONTHS
        Where:
        PRINCIPAL is the amount of the loan.
        INTEREST is the APR as a number (7% = 0.07).
        MONTHS is the length of the loan's term.
        EOF
    }
    if (($# != 3)); then
        usage
        exit 1
    fi
    principal=$1
    interest=$2
    months=$3
    bc <<- EOF
        scale = 10
        i = $interest / 12
        p = $principal
        n = $months
        a = p * ((i * ((1 + i) ^ n)) / (((1 + i) ^ n) - 1))
        print a, "\n"
    EOF

当脚本执行后，输出结果像这样：

    [me@linuxbox ~]$ loan-calc 135000 0.0775 180
    475
    1270.7222490000

若贷款 135,000 美金，年利率为 7.75%，借贷180个月（15年），这个例子计算出每月需要还贷的金额。
注意这个答案的精确度。这是由脚本中变量 scale 的值决定的。bc 的手册页提供了对 bc 脚本语言的详尽描述。
虽然 bc 的数学符号与 shell 的略有差异（bc 与 C 更相近），但是基于目前我们所学的内容，
大多数符号是我们相当熟悉的。

### 总结

在这一章中，我们学习了很多小东西，在脚本中这些小零碎可以完成“真正的工作”。随着我们编写脚本经验的增加，
能够有效地操作字符串和数字的能力将具有极为重要的价值。我们的 loan-calc 脚本表明，
甚至可以创建简单的脚本来完成一些真正有用的事情。

### 额外加分

虽然该 loan-calc 脚本的基本功能已经很到位了，但脚本还远远不够完善。为了额外加分，试着
给脚本 loan-calc 添加以下功能：

* 完整的命令行参数验证

* 用一个命令行选项来实现“交互”模式，提示用户输入本金、利率和贷款期限

* 输出格式美化

### 拓展阅读

* 《Bash Hackers Wiki》对参数展开有一个很好的论述：

    <http://wiki.bash-hackers.org/syntax/pe>

* 《Bash 参考手册》也介绍了这个：

    <http://www.gnu.org/software/bash/manual/bashref.html#Shell-Parameter-Expansion>

* Wikipedia 上面有一篇很好的文章描述了位运算：

    <http://en.wikipedia.org/wiki/Bit_operation>

* 和一篇关于三元运算的文章：

    <http://en.wikipedia.org/wiki/Ternary_operation>

* 还有一个对计算还贷金额公式的描述，我们的 loan-calc 脚本中用到了这个公式：

    <http://en.wikipedia.org/wiki/Amortization_calculator>


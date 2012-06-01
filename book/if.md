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


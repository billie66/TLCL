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

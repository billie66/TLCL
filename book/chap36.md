---
layout: book
title: 数组
---

In the last chapter, we looked at how the shell can manipulate strings and numbers.
The data types we have looked at so far are known in computer science circles as
scalar variables; that is, variables that contain a single value.

在上一章中，我们查看了 shell 怎样操作字符串和数字的。目前我们所见到的数据类型在计算机科学圈里被
成为标量变量；也就是说，只能包含一个值的变量。

In this chapter, we will look at another kind of data structure called an array,
which holds multiple values. Arrays are a feature of virtually every programming language.
The shell supports them, too, though in a rather limited fashion.
Even so, they can be very useful for solving programming problems.

在本章中，我们将看看另一种数据结构叫做数组，数组能存放多个值。数组几乎是所有编程语言的一个特性。
shell 也支持它们，尽管以一个相当有限的形式。即便如此，为解决编程问题，它们是非常有用的。

### What Are Arrays?

### 什么是数组？

Arrays are variables that hold more than one value at a time. Arrays are organized like a table.
Let’s consider a spreadsheet as an example. A spreadsheet acts like a two-dimensional array.
It has both rows and columns, and an individual cell in the spreadsheet
can be located according to its row and column address. An array behaves the same way.
An array has cells, which are called elements, and each element contains data.
An individual array element is accessed using an address called an index or subscript.

数组是一次能存放多个数据的变量。数组的组织结构就像一张表。我们拿电子表格举例。一张电子表格就像是一个
二维数组。它既有行也有列，并且电子表格中的一个单元格，可以通过单元格所在的行和列的地址定位它的位置。
数组行为也是如此。数组有单元格，被称为元素，而且每个元素会包含数据。
使用一个称为索引或下标的地址可以访问一个单独的数组元素。

Most programming languages support multidimensional arrays. A spreadsheet is an
example of a multidimensional array with two dimensions, width and height.
Many languages support arrays with an arbitrary number of dimensions,
though two- and three-dimensional arrays are probably the most commonly used.

大多数编程语言支持多维数组。一个电子表格就是一个多维数组的例子，它有两个维度，宽度和高度。
许多语言支持任意维度的数组，虽然二维和三维数组可能是最常用的。

Arrays in bash are limited to a single dimension. We can think of them as a
spreadsheet with a single column. Even with this limitation,
there are many applications for them. Array support first appeared in bash version 2.
The original Unix shell program, sh, did not support arrays at all.

Bash 中的数组仅限制为单一维度。我们可以把它们看作是只有一列的电子表格。尽管有这种局限，但是有许多应用使用它们。
对数组的支持第一次出现在 bash 版本2中。原来的 Unix shell 程序，sh，根本就不支持数组。

### Creating An Array

### 创建一个数组

Array variables are named just like other bash variables,
and are created automatically when they are accessed. Here is an example:

数组变量就像其它 bash 变量一样命名，当被访问的时候，它们会被自动地创建。这里是一个例子：

    [me@linuxbox ~]$ a[1]=foo
    [me@linuxbox ~]$ echo ${a[1]}
    foo

Here we see an example of both the assignment and access of an array element. With the
first command, element 1 of array a is assigned the value “foo”. The second command
displays the stored value of element 1. The use of braces in the second command is re-
quired to prevent the shell from attempting pathname expansion on the name of the array
element.

这里我们看到一个赋值并访问数组元素的例子。通过第一个命令，把数组 a 的元素1赋值为 “foo”。
第二个命令显示存储在元素1中的值。在第二个命令中使用花括号是必需的，
以便防止 shell 试图对数组元素名执行路径名展开操作。

An array can also be created with the declare command:

也可以用 declare 命令创建一个数组：

    [me@linuxbox ~]$ declare -a a

Using the -a option, this example of declare creates the array a.

使用 -a 选项，declare 命令的这个例子创建了数组 a。

### Assigning Values To An Array

### 数组赋值

Values may be assigned in one of two ways. Single values may be assigned using the fol-
lowing syntax:

有两种方式可以给数组赋值。单个值赋值使用以下语法：

    name[subscript]=value

where name is the name of the array and subscript is an integer (or arithmetic expression)
greater than or equal to zero. Note that the first element of an array is subscript zero, not
one. value is a string or integer assigned to the array element.

这里的 name 是数组的名字，subscript 是一个大于或等于零的整数（或算术表达式）。注意数组第一个元素的下标是0，
而不是1。数组元素的值可以是一个字符串或整数。

Multiple values may be assigned using the following syntax:

多个值赋值使用下面的语法：

    name=(value1 value2 ...)

where name is the name of the array and value... are values assigned sequentially to
elements of the array, starting with element zero. For example, if we wanted to assign
abbreviated days of the week to the array days, we could do this:

这里的 name 是数组的名字，value... 是要按照顺序赋给数组的值，从元素0开始。例如，如果我们希望
把星期几的英文简写赋值给数组 days，我们可以这样做：

    [me@linuxbox ~]$ days=(Sun Mon Tue Wed Thu Fri Sat)

It is also possible to assign values to a specific element by specifying a subscript for each
value:

还可以通过指定下标，把值赋给数组中的特定元素：

    [me@linuxbox ~]$ days=([0]=Sun [1]=Mon [2]=Tue [3]=Wed [4]=Thu [5]=Fri [6]=Sat)

### Accessing Array Elements

### 访问数组元素

So what are arrays good for? Just as many data-management tasks can be performed with
a spreadsheet program, many programming tasks can be performed with arrays.

那么数组有什么好处呢？ 就像许多数据管理任务一样，可以用电子表格程序来完成，许多编程任务则可以用数组完成。

Let’s consider a simple data-gathering and presentation example. We will construct a
script that examines the modification times of the files in a specified directory. From this
data, our script will output a table showing at what hour of the day the files were last
modified. Such a script could be used to determine when a system is most active. This
script, called hours, produces this result:

让我们考虑一个简单的数据收集和展示的例子。我们将构建一个脚本，用来检查一个特定目录中文件的修改次数。
从这些数据中，我们的脚本将输出一张表，显示这些文件最后是在一天中的哪个小时被修改的。这样一个脚本
可以被用来确定什么时段一个系统最活跃。这个脚本，称为 hours，输出这样的结果：

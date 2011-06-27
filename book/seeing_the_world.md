---
layout: book
title: 从shell眼中看世界 
---

In this chapter we are going to look at some of the “magic” that occurs on the command
line when you press the enter key. While we will examine several interesting and
complex features of the shell, we will do it with just one new command:

在这一章我们将看一下，当你按下enter键后，发生在命令行中的一些“魔法”。虽然我们会
仔细查看几个复杂有趣的shell特点，但我们只使用一个新命令来处理这些特性。

### echo – Display a line of text

### echo － 显示一行文本

### Expansion

### （字符）展开

Each time you type a command line and press the enter key, bash performs several
processes upon the text before it carries out your command. We have seen a couple of
cases of how a simple character sequence, for example “*”, can have a lot of meaning to
the shell. The process that makes this happen is called expansion. With expansion, you
type something and it is expanded into something else before the shell acts upon it. To
demonstrate what we mean by this, let's take a look at the echo command. echo is a
shell builtin that performs a very simple task. It prints out its text arguments on standard
output:

每一次你输入一个命令，然后按下enter键，在bash执行你的命令之前，bash会对输入
的字符完成几个步骤处理。我们已经知道两三个案例，怎样一个简单的字符序列，例如"*",
对shell来说，有很多的涵义。使这个发生的过程叫做（字符）展开。通过展开，
你输入的字符，在shell对它起作用之前，会展开成为别的字符。为了说明我们所要
表达的意思，让我们看一看echo命令。echo是一个shell内部命令，来完成非常简单的认为。
它在标准输出中打印出它的文本参数。

[me@linuxbox ~]$ echo this is a test
this is a test

That's pretty straightforward. Any argument passed to echo gets displayed. Let's try
another example:

这个命令的作用相当简单明了。

[me@linuxbox ~]$ echo *
Desktop Documents ls-output.txt Music Pictures Public Templates Videos

So what just happened? Why didn't echo print “*”? As you recall from our work with
wildcards, the “*” character means match any characters in a filename, but what we didn't
see in our original discussion was how the shell does that. The simple answer is that the
shell expands the “*” into something else (in this instance, the names of the files in the

Expansion

current working directory) before the echo command is executed. When the enter key is
pressed, the shell automatically expands any qualifying characters on the command line
before the command is carried out, so the echo command never saw the “*”, only its
expanded result. Knowing this, we can see that echo behaved as expected.

Pathname Expansion

The mechanism by which wildcards work is called pathname expansion. If we try some
of the techniques that we employed in our earlier chapters, we will see that they are really
expansions. Given a home directory that looks like this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls
Desktop   ls-output.txt   Pictures   Templates
....</tt>
</pre></div>

we could carry out the following expansions:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo D*
Desktop  Documents</tt>
</pre></div>

and:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo *s
Documents Pictures Templates Videos</tt>
</pre></div>

or even:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo [[:upper:]]*
Desktop Documents Music Pictures Public Templates Videos</tt>
</pre></div>

and looking beyond our home directory:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo /usr/*/share
/usr/kerberos/share  /usr/local/share </tt>
</pre></div>

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>Pathname Expansion Of Hidden Files</h3>

<p> As we know, filenames that begin with a period character are hidden.
Pathname expansion also respects this behavior. An expansion such as: </p>

<p> echo * </p>

<p>does not reveal hidden files.  </p>

<p>It might appear at first glance that we could include hidden files in an
expansion by starting the pattern with a leading period, like this: </p>

<p>echo .* </p>

<p> It almost works. However, if we examine the results closely, we will see
that the names “.” and “..” will also appear in the results. Since these names
refer to the current working directory and its parent directory, using this
pattern will likely produce an incorrect result. We can see this if we try the
command: </p>

<p> ls -d .* | less </p>

<p> To correctly perform pathname expansion in this situation, we have to
employ a more specific pattern. This will work correctly: </p>

<p> ls -d .[!.]?* </p>

<p>This pattern expands into every filename that begins with a period, does not
include a second period, contains at least one additional character and can be
followed by any other characters.</p>
</td>
</tr>
</table>

Tilde Expansion
As you may recall from our introduction to the cd command, the tilde character (“~”) has
a special meaning. When used at the beginning of a word, it expands into the name of the
home directory of the named user, or if no user is named, the home directory of the
current user:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo ~
/home/me</tt>
</pre></div>

If user “foo” has an account, then:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo ~foo
/home/foo</tt>
</pre></div>

Arithmetic Expansion
The shell allows arithmetic to be performed by expansion. This allow us to use the shell
prompt as a calculator:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo $((2 + 2))
4</tt>
</pre></div>

Arithmetic expansion uses the form:
$((expression))
where expression is an arithmetic expression consisting of values and arithmetic
operators.
Arithmetic expansion only supports integers (whole numbers, no decimals), but can
perform quite a number of different operations. Here are a few of the supported
operators:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 8-1: Arithmetic Operators</caption>
<tr>
<th class="title">Operator </th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="25%">+</td>
<td valign="top">Addition</td>
</tr>
<tr>
<td valign="top">-</td>
<td valign="top">Subtraction</td>
</tr>
<tr>
<td valign="top">*</td>
<td valign="top">Multiplication</td>
</tr>
<tr>
<td valign="top">/</td>
<td valign="top">Division(but remember, since expansion only supports integer
arithmetic, results are integers.)</td>
</tr>
<tr>
<td valign="top">%</td>
<td valign="top">Modulo, which simply means, "remainder".</td>
</tr>
<tr>
<td valign="top">**</td>
<td valign="top">Exponentiation</td>
</tr>
</table>
</p>

Spaces are not significant in arithmetic expressions and expressions may be nested. For
example, to multiply five squared by three:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo $(($((5**2)) * 3))
75</tt>
</pre></div>

Single parentheses may be used to group multiple subexpressions. With this technique,
we can rewrite the example above and get the same result using a single expansion
instead of two:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo Five divided by two equals $((5/2))
Five divided by two equals 2
[me@linuxbox ~]$ echo with $((5%2)) left over.
with 1 left over.</tt>
</pre></div>

Arithmetic expansion is covered in greater detail in Chapter 35.
Brace Expansion
Perhaps the strangest expansion is called brace expansion. With it, you can create
multiple text strings from a pattern containing braces. Here's an example:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo Front-{A,B,C}-Back
Front-A-Back Front-B-Back Front-C-Back</tt>
</pre></div>

Patterns to be brace expanded may contain a leading portion called a preamble and a
trailing portion called a postscript. The brace expression itself may contain either a
comma-separated list of strings, or a range of integers or single characters. The pattern
may not contain embedded whitespace. Here is an example using a range of integers:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo Number_{1..5}
Number_1  Number_2  Number_3  Number_4  Number_5</tt>
</pre></div>

A range of letters in reverse order:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo {Z..A}
Z Y X W V U T S R Q P O N M L K J I H G F E D C B A</tt>
</pre></div>

Brace expansions may be nested:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo a{A{1,2},B{3,4}}b
aA1b aA2b aB3b aB4b</tt>
</pre></div>

So what is this good for? The most common application is to make lists of files or
directories to be created. For example, if we were photographers and had a large
collection of images that we wanted to organize into years and months, the first thing we
might do is create a series of directories named in numeric “Year-Month” format. This
way, the directory names will sort in chronological order. We could type out a complete
list of directories, but that's a lot of work and it's error-prone too. Instead, we could do
this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ mkdir Pics
[me@linuxbox ~]$ cd Pics
[me@linuxbox Pics]$ mkdir {2007..2009}-0{1..9} {2007..2009}-{10..12}
[me@linuxbox Pics]$ ls
2007-01 2007-07 2008-01 2008-07 2009-01 2009-07
2007-02 2007-08 2008-02 2008-08 2009-02 2009-08
2007-03 2007-09 2008-03 2008-09 2009-03 2009-09
2007-04 2007-10 2008-04 2008-10 2009-04 2009-10
2007-05 2007-11 2008-05 2008-11 2009-05 2009-11
2007-06 2007-12 2008-06 2008-12 2009-06 2009-12</tt>
</pre></div>

Pretty slick!
Parameter Expansion
We're only going to touch briefly on parameter expansion in this chapter, but we'll be
covering it extensively later. It's a feature that is more useful in shell scripts than directly
on the command line. Many of its capabilities have to do with the system's ability to
store small chunks of data and to give each chunk a name. Many such chunks, more
properly called variables, are available for your examination. For example, the variable
named “USER” contains your user name. To invoke parameter expansion and reveal the
contents of USER you would do this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo $USER
me</tt>
</pre></div>

To see a list of available variables, try this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ printenv | less</tt>
</pre></div>

You may have noticed that with other types of expansion, if you mistype a pattern, the
expansion will not take place and the echo command will simply display the mistyped
pattern. With parameter expansion, if you misspell the name of a variable, the expansion
will still take place, but will result in an empty string:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo $SUER

[me@linuxbox ~]$</tt>
</pre></div>

Command Substitution
Command substitution allows us to use the output of a command as an expansion:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo $(ls)
Desktop Documents ls-output.txt Music Pictures Public Templates
Videos</tt>
</pre></div>

One of my favorites goes something like this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls -l $(which cp)
-rwxr-xr-x 1 root root 71516 2007-12-05 08:58 /bin/cp</tt>
</pre></div>

Here we passed the results of which cp as an argument to the ls command, thereby
getting the listing of of the cp program without having to know its full pathname. We are
not limited to just simple commands. Entire pipelines can be used (only partial output
shown):

<div class="code"><pre>
<tt>[me@linuxbox ~]$ file $(ls /usr/bin/* | grep zip)
/usr/bin/bunzip2:     symbolic link to `bzip2'
....</tt>
</pre></div>

In this example, the results of the pipeline became the argument list of the file
command.
There is an alternate syntax for command substitution in older shell programs which is
also supported in bash. It uses back-quotes instead of the dollar sign and parentheses:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls -l `which cp`
-rwxr-xr-x 1 root root 71516 2007-12-05 08:58 /bin/cp</tt>
</pre></div>

Quoting
Now that we've seen how many ways the shell can perform expansions, it's time to learn
how we can control it. Take for example:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo this is a    test
this is a test</tt>
</pre></div>

or:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo The total is $100.00
The total is 00.00</tt>
</pre></div>

In the first example, word-splitting by the shell removed extra whitespace from the echo
command's list of arguments. In the second example, parameter expansion substituted an
empty string for the value of “$1” because it was an undefined variable. The shell
provides a mechanism called quoting to selectively suppress unwanted expansions.
Double Quotes
The first type of quoting we will look at is double quotes. If you place text inside double
quotes, all the special characters used by the shell lose their special meaning and are
treated as ordinary characters. The exceptions are “$”, “\” (backslash), and “`” (back-
quote). This means that word-splitting, pathname expansion, tilde expansion, and brace
expansion are suppressed, but parameter expansion, arithmetic expansion, and command
substitution are still carried out. Using double quotes, we can cope with filenames
containing embedded spaces. Say we were the unfortunate victim of a file called
two words.txt. If we tried to use this on the command line, word-splitting would
cause this to be treated as two separate arguments rather than the desired single argument:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls -l two words.txt
ls: cannot access two: No such file or directory
ls: cannot access words.txt: No such file or directory</tt>
</pre></div>

By using double quotes, we stop the word-splitting and get the desired result; further, we
can even repair the damage:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls -l "two words.txt"
-rw-rw-r-- 1 me   me   18 2008-02-20 13:03 two words.txt
[me@linuxbox ~]$ mv "two words.txt" two_words.txt</tt>
</pre></div>

There! Now we don't have to keep typing those pesky double quotes.
Remember, parameter expansion, arithmetic expansion, and command substitution still
take place within double quotes:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo "$USER $((2+2)) $(cal)"
me 4    February 2008
Su Mo Tu We Th Fr Sa
....</tt>
</pre></div>

We should take a moment to look at the effect of double quotes on command substitution.
First let's look a little deeper at how word splitting works. In our earlier example, we saw
how word-splitting appears to remove extra spaces in our text:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo this is a   test
this is a test </tt>
</pre></div>

By default, word-splitting looks for the presence of spaces, tabs, and newlines (linefeed
characters) and treats them as delimiters between words. This means that unquoted
spaces, tabs, and newlines are not considered to be part of the text. They only serve as
separators. Since they separate the words into different arguments, our example
command line contains a command followed by four distinct arguments. If we add
double quotes:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo "this is a    test"
this is a    test </tt>
</pre></div>

word-splitting is suppressed and the embedded spaces are not treated as delimiters, rather
they become part of the argument. Once the double quotes are added, our command line
contains a command followed by a single argument.
The fact that newlines are considered delimiters by the word-splitting mechanism causes
an interesting, albeit subtle, effect on command substitution. Consider the following:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo $(cal)
February 2008 Su Mo Tu We Th Fr Sa 1 2 3 4 5 6 7 8 9 10 11 12 13 14
15 16 17 18 19 20 21 22 23 24 25 26 27 28 29
[me@linuxbox ~]$ echo "$(cal)"
February 2008
....</tt>
</pre></div>

In the first instance, the unquoted command substitution resulted in a command line
containing thirty-eight arguments. In the second, a command line with one argument that
includes the embedded spaces and newlines.
Single Quotes
If we need to suppress all expansions, we use single quotes. Here is a comparison of
unquoted, double quotes, and single quotes:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER
text /home/me/ls-output.txt a b foo 4 me
[me@linuxbox ~]$ echo "text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER"
text ~/*.txt   {a,b} foo 4 me
[me@linuxbox ~]$ echo 'text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER'
text ~/*.txt  {a,b} $(echo foo) $((2+2)) $USER</tt>
</pre></div>

As we can see, with each succeeding level of quoting, more and more of the expansions
are suppressed.
Escaping Characters
Sometimes we only want to quote a single character. To do this, we can precede a
character with a backslash, which in this context is called the escape character. Often
this is done inside double quotes to selectively prevent an expansion:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo "The balance for user $USER is: \$5.00"
The balance for user me is: $5.00</tt>
</pre></div>

It is also common to use escaping to eliminate the special meaning of a character in a
filename. For example, it is possible to use characters in filenames that normally have
special meaning to the shell. These would include “$”, “!”, “&”, “ “, and others. To
include a special character in a filename you can to this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ mv bad\&filename good_filename</tt>
</pre></div>

To allow a backslash character to appear, escape it by typing “\\”. Note that within single
quotes, the backslash loses its special meaning and is treated as an ordinary character.

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>Backslash Escape Sequences</h3>
<p>In addition to its role as the escape character, the backslash is also used as part of
a notation to represent certain special characters called control codes. The first
thirty-two characters in the ASCII coding scheme are used to transmit commands
to teletype-like devices. Some of these codes are familiar (tab, backspace,
linefeed, and carriage return), while others are not (null, end-of-transmission, and
acknowledge).
</p>
<br />
<p>
<table cellpadding="10" border="1" width="%80">
<tr>
<th class="title">Escape Sequence</th>
<th class="title">Meaning</th>
</tr>
<tr>
<td valign="top" width="25%">\a</td>
<td valign="top">Bell("Alert"-causes the computer to beep)</td>
</tr>
<tr>
<td valign="top">\b</td>
<td valign="top">Backspace</td>
</tr>
<tr>
<td valign="top">\n</td>
<td valign="top">Newline. On Unix-like systems, this produces a linefeed.</td>
</tr>
<tr>
<td valign="top">\r</td>
<td valign="top">Carriage return</td>
</tr>
<tr>
<td valign="top">\t</td>
<td valign="top">Tab</td>
</tr>
</table>
</p>

<p> The table above lists some of the common backslash escape sequences. The idea
behind this representation using the backslash originated in the C programming
language and has been adopted by many others, including the shell.
 </p>
 <p>Adding the “-e” option to echo will enable interpretation of escape sequences.
You may also place them inside $' '. Here, using the sleep command, a
simple program that just waits for the specified number of seconds and then exits,
we can create a primitive countdown timer:
</p>
<p><b>sleep 10; echo -e  "Time's up\a"</b></p>
<p>We could also do this:</p>
<p><b>sleep 10; echo "Time's up" $'\a'</b></p>
</td>
</tr>
</table>

Summing Up
As we move forward with using the shell, we will find that expansions and quoting will
be used with increasing frequency, so it makes sense to get a good understanding of the
way they works. In fact, it could be argued that they are the most important subjects to
learn about the shell. Without a proper understanding of expansion, the shell will always
be a source of mystery and confusion, and much of it potential power wasted.
Further Reading
● The bash man page has major sections on both expansion and quoting which
   cover these topics in a more formal manner.
● The Bash Reference Manual also contains chapters on expansion and quoting:
   http://www.gnu.org/software/bash/manual/bashref.html


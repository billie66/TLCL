---
layout: book
title: 文本处理 
---

All Unix-like operating systems rely heavily on text files for several types of data
storage. So it makes sense that there are many tools for manipulating text. In this
chapter, we will look at programs that are used to “slice and dice” text. In the next
chapter, we will look at more text processing, focusing on programs that are used to
format text for printing and other kinds of human consumption.



This chapter will revisit some old friends and introduce us to some new ones:

* cat – Concatenate files and print on the standard output

* sort – Sort lines of text files

* uniq – Report or omit repeated lines

* cut – Remove sections from each line of files

* paste – Merge lines of files

* join – Join lines of two files on a common field

* comm – Compare two sorted files line by line

* diff – Compare files line by line

* patch – Apply a diff file to an original

* tr – Translate or delete characters

* sed – Stream editor for filtering and transforming text

* aspell – Interactive spell checker

Applications Of Text

So far, we have learned a couple of text editors (nano and vim), looked a bunch of
configuration files, and have witnessed the output of dozens of commands, all in text.
But what else is text used for? For many things, it turns out.

Documents

Many people write documents using plain text formats. While it is easy to see how a
small text file could be useful for keeping simple notes, it is also possible to write large
documents in text format, as well. One popular approach is to write a large document in
a text format and then use a markup language to describe the formatting of the finished
document. Many scientific papers are written using this method, as Unix-based text
processing systems were among the first systems that supported the advanced
typographical layout needed by writers in technical disciplines.

Web Pages

The world’s most popular type of electronic document is probably the web page. Web
pages are text documents that use either HTML (Hypertext Markup Language) or XML
(Extensible Markup Language) as markup languages to describe the document’s visual
format.

Email

Email is an intrinsically text-based medium. Even non-text attachments are converted
into a text representation for transmission. We can see this for ourselves by downloading
an email message and then viewing it in less. We will see that the message begins with
a header that describes the source of the message and the processing it received during its
journey, followed by the body of the message with its content.

Printer Output

On Unix-like systems, output destined for a printer is sent as plain text or, if the page
contains graphics, is converted into a text format page description language known as
PostScript, which is then sent to a program that generates the graphic dots to be printed.

Program Source Code

Many of the command line programs found on Unix-like systems were created to support
system administration and software development, and text processing programs are no
exception. Many of them are designed to solve software development problems. The
reason text processing is important to software developers is that all software starts out as
text. Source code, the part of the program the programmer actually writes, is always in
text format.

Revisiting Some Old Friends

Back in Chapter 7 (Redirection), we learned about some commands that are able to
accept standard input in addition to command line arguments. We only touched on them
briefly then, but now we will take a closer look at how they can be used to perform text
processing.

cat

The cat program has a number of interesting options. Many of them are used to help
better visualize text content. One example is the -A option, which is used to display non-
printing characters in the text. There are times when we want to know if control
characters are embedded in our otherwise visible text. The most common of these are tab
characters (as opposed to spaces) and carriage returns, often present as end-of-line
characters in MS-DOS style text files. Another common situation is a file containing
lines of text with trailing spaces.

Let’s create a test file using cat as a primitive word processor. To do this, we’ll just
enter the command cat (along with specifying a file for redirected output) and type our
text, followed by Enter to properly end the line, then Ctrl-d, to indicate to cat that
we have reached end-of-file. In this example, we enter a leading tab character and follow
the line with some trailing spaces:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cat > foo.txt
The quick brown fox jumped over the lazy dog.
[me@linuxbox ~]$ </tt>
</pre></div>

Next, we will use cat with the -A option to display the text:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cat -A foo.txt
^IThe quick brown fox jumped over the lazy dog.       $
[me@linuxbox ~]$        </tt>
</pre></div>

As we can see in the results, the tab character in our text is represented by ^I. This is a
common notation that means “Control-I” which, as it turns out, is the same as a tab
character. We also see that a $ appears at the true end of the line, indicating that our text
contains trailing spaces.

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>MS-DOS Text Vs. Unix Text </h3>
<p> One of the reasons you may want to use cat to look for non-printing characters
in text is to spot hidden carriage returns. Where do hidden carriage returns come
from? DOS and Windows! Unix and DOS don’t define the end of a line the
same way in text files. Unix ends a line with a linefeed character (ASCII 10)
while MS-DOS and its derivatives use the sequence carriage return (ASCII 13)
and linefeed to terminate each line of text. </p>
<p> There are a several ways to convert files from DOS to Unix format. On many
Linux systems, there are programs called dos2unix and unix2dos, which can
convert text files to and from DOS format. However, if you don’t have
dos2unix on your system, don’t worry. The process of converting text from
DOS to Unix format is very simple; it simply involves the removal of the
offending carriage returns. That is easily accomplished by a couple of the
programs discussed later in this chapter.  </p>
</td>
</tr>
</table>

cat also has options that are used to modify text. The two most prominent are -n,
which numbers lines, and -s, which suppresses the output of multiple blank lines. We
can demonstrate thusly:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ cat > foo.txt
The quick brown fox
jumped over the lazy dog.
[me@linuxbox ~]$ cat -ns foo.txt
1 The quick brown fox
2
3 jumped over the lazy dog.
[me@linuxbox ~]$ </tt>
</pre></div>

In this example, we create a new version of our foo.txt test file, which contains two
lines of text separated by two blank lines. After processing by cat with the -ns options,
the extra blank line is removed and the remaining lines are numbered. While this is not
much of a process to perform on text, it is a process.

sort

The sort program sorts the contents of standard input, or one or more files specified on
the command line, and sends the results to standard output. Using the same technique
that we used with cat, we can demonstrate processing of standard input directly from
the keyboard:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sort > foo.txt
c
b
a
[me@linuxbox ~]$ cat foo.txt
a
b
c </tt>
</pre></div>

After entering the command, we type the letters “c”, “b”, and “a”, followed once again by
Ctrl-d to indicate end-of-file. We then view the resulting file and see that the lines
now appear in sorted order.

Since sort can accept multiple files on the command line as arguments, it is possible to
merge multiple files into a single sorted whole. For example, if we had three text files
and wanted to combine them into a single sorted file, we could do something like this:

<div class="code"><pre>
<tt><b>sort file1.txt file2.txt file3.txt > final_sorted_list.txt</b> </tt>
</pre></div>

sort has several interesting options. Here is a partial list:


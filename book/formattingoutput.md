---
layout: book
title: 格式化输出 
---

In this chapter, we continue our look at text related tools, focusing on programs that are
used to format text output, rather than changing the text itself. These tools are often used
to prepare text for eventual printing, a subject that we will cover in the next chapter. The
programs that we will cover in this chapter include:

● nl – Number lines

● fold – Wrap each line to a specified length

● fmt – A simple text formatter

● pr – Prepare text for printing

● printf – Format and print data

● groff – A document formatting system

Simple Formatting Tools

We’ll look at some of the simple formatting tools first. These are mostly single purpose
programs, and a bit unsophisticated in what they do, but they can be used for small tasks
and as parts of pipelines and scripts.

nl – Number Lines

The nl program is a rather arcane tool used to perform a simple task. It numbers lines.
In its simplest use, it resembles cat -n:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ nl distros.txt | head
</tt>
</pre></div>

Like cat, nl can accept either multiple files as command line arguments, or standard
input. However, nl has a number of options and supports a primitive form of markup to
allow more complex kinds of numbering.

nl supports a concept called “logical pages” when numbering. This allows nl to reset
(start over) the numerical sequence when numbering. Using options, it is possible to set
the starting number to a specific value and, to a limited extent, its format. A logical page
is further broken down into a header, body, and footer. Within each of these sections, line
numbering may be reset and/or be assigned a different style. If nl is given multiple files,
it treats them as a single stream of text. Sections in the text stream are indicated by the
presence of some rather odd-looking markup added to the text:

Each of the above markup elements must appear alone on its own line. After processing
a markup element, nl deletes it from the text stream.

Here are the common options for nl:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 22-2: Common nl Options</caption>
<tr>
<th class="title">Option</th>
<th class="title">Meaning</th>
</tr>
<tr>
<td valign="top" width="25%">-b style</td>
<td valign="top">Set body numbering to style, where style is one of the following:
<p>a = number all lines</p>
<p>t = number only non-blank lines. This is the default.</p>
<p>n = none</p>
<p>pregexp = number only lines matching basic regular expression regexp.</p>
</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top"></td>
</tr>
</table>
</p>

Admittedly, we probably won’t be numbering lines that often, but we can use nl to look
at how we can combine multiple tools to perform more complex tasks. We will build on
our work in the previous chapter to produce a Linux distributions report. Since we will
be using nl, it will be useful to include its header/body/footer markup. To do this, we
will add it to the sed script from the last chapter. Using our text editor, we will change
the script as follows and save it as distros-nl.sed:

    # sed script to produce Linux distributions report
    1 i\
    \\:\\:\\:\
    \
    Linux Distributions Report\
    \
    Name
    Ver. Released\
    ----
    ---- --------\
    \\:\\:
    s/\([0-9]\{2\}\)\/\([0-9]\{2\}\)\/\([0-9]\{4\}\)$/\3-\1-\2/
    $ i\
    \\:\
    \
    End Of Report

The script now inserts the nl logical page markup and adds a footer at the end of the
report. Note that we had to double up the backslashes in our markup, because they are
normally interpreted as an escape character by sed.

Next, we’ll produce our enhanced report by combining sort, sed, and nl:


Our report is the result of our pipeline of commands. First, we sort the list by distribution
name and version (fields one and two), then we process the results with sed, adding the
report header (including the logical page markup for nl) and footer. Finally, we process
the result with nl, which, by default, only numbers the lines of the text stream that
belong to the body section of the logical page.

We can repeat the command and experiment with different options for nl. Some
interesting ones are:

    nl -n rz

and

    nl -w 3 -s ' '

fold – Wrap Each Line To A Specified Length

Folding is the process of breaking lines of text at a specified width. Like our other
commands, fold accepts either one or more text files or standard input. If we send
fold a simple stream of text, we can see how it works:

    [me@linuxbox ~]$ echo "The quick brown fox jumped over the lazy dog."
    | fold -w 12
    The quick br
    own fox jump
    ed over the
    lazy dog.

Here we see fold in action. The text sent by the echo command is broken into
segments specified by the -w option. In this example, we specify a line width of twelve
characters. If no width is specified, the default is eighty characters. Notice how the lines
are broken regardless of word boundaries. The addition of the -s option will cause
fold to break the line at the last available space before the line width is reached:

    [me@linuxbox ~]$ echo "The quick brown fox jumped over the lazy dog."
    | fold -w 12 -s
    The quick
    brown fox
    jumped over
    the lazy
    dog.

fmt – A Simple Text Formatter

The fmt program also folds text, plus a lot more. It accepts either files or standard input
and performs paragraph formatting on the text stream. Basically, it fills and joins lines in
text while preserving blank lines and indentation.

To demonstrate, we’ll need some text. Let’s lift some from the fmt info page:

We’ll copy this text into our text editor and save the file as fmt-info.txt. Now, let’s
say we wanted to reformat this text to fit a fifty character wide column. We could do this
by processing the file with fmt and the -w option:

    [me@linuxbox ~]$ fmt -w 50 fmt-info.txt | head
    'fmt' reads from the specified FILE arguments
    (or standard input if
    none are given), and writes to standard output.
    By default, blank lines, spaces between words,
    and indentation are
    preserved in the output; successive input lines
    with different indentation are not joined; tabs
    are expanded on input and introduced on output.

Well, that’s an awkward result. Perhaps we should actually read this text, since it explains what’s going on:

“By default, blank lines, spaces between words, and indentation are preserved in the
output; successive input lines with different indentation are not joined; tabs are
expanded on input and introduced on output.”

So, fmt is preserving the indentation of the first line. Fortunately, fmt provides an
option to correct this:


Much better. By adding the -c option, we now have the desired result.

fmt has some interesting options:

The -p option is particularly interesting. With it, we can format selected portions of a
file, provided that the lines to be formatted all begin with the same sequence of
characters. Many programming languages use the pound sign (#) to indicate the
5eginning of a comment and thus can be formatted using this option. Let’s create a file
that simulates a program that uses comments:

    [me@linuxbox ~]$ cat > fmt-code.txt
    # This file contains code with comments.

    # This line is a comment.
    # Followed by another comment line.
    # And another.

    This, on the other hand, is a line of code.
    And another line of code.
    And another.

Our sample file contains comments which begin the string “# “ (a # followed by a space)
and lines of “code” which do not. Now, using fmt, we can format the comments and
leave the code untouched:


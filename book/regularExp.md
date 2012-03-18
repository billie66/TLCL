---
layout: book
title: 正则表达式 
---

In the next few chapters, we are going to look at tools used to manipulate text. As we
have seen, text data plays an important role on all Unix-like systems, such as Linux. But
before we can fully appreciate all of the features offered by these tools, we have to first
examine a technology that is frequently associated with the most sophisticated uses of
these tools — regular expressions.

As we have navigated the many features and facilities offered by the command line, we
have encountered some truly arcane shell features and commands, such as shell
expansion and quoting, keyboard shortcuts, and command history, not to mention the vi
editor. Regular expressions continue this “tradition” and may be (arguably) the most
arcane feature of them all. This is not to suggest that the time it takes to learn about them
is not worth the effort. Quite the contrary. A good understanding will enable us to
perform amazing feats, though their full value may not be immediately apparent.
What Are Regular Expressions?

Simply put, regular expressions are symbolic notations used to identify patterns in text.
In some ways, they resemble the shell’s wildcard method of matching file and pathnames,
but on a much grander scale. Regular expressions are supported by many command line
tools and by most programming languages to facilitate the solution of text manipulation
problems. However, to further confuse things, not all regular expressions are the same;
they vary slightly from tool to tool and from programming language to language. For our
discussion, we will limit ourselves to regular expressions as described in the POSIX
standard (which will cover most of the command line tools), as opposed to many
programming languages (most notably Perl), which use slightly larger and richer sets of
notations.

### grep

The main program we will use to work with regular expressions is our old pal, grep.
The name “grep” is actually derived from the phrase “global regular expression print,” so
we can see that grep has something to do with regular expressions. In essence, grep
searches text files for the occurrence of a specified regular expression and outputs any
line containing a match to standard output.

So far, we have used grep with fixed strings, like so:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls /usr/bin | grep zip </tt>
</pre></div>

This will list all the files in the /usr/bin directory whose names contain the substring
“zip”.

The grep program accepts options and arguments this way:

grep [options] regex [file...]

where regex is a regular expression.

Here is a list of the commonly used grep options:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table20-1: grep Options </caption>
<tr>
<th class="title">Option</th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="20%">-i</td>
<td valign="top">Ignore case. Do not distinguish between upper and lower case
characters. May also be specified --ignore-case.</td>
</tr>
<tr>
<td valign="top">-v</td>
<td valign="top">Invert match. Normally, grep prints lines that contain a match.
This option causes grep to print every line that does not contain a
match. May also be specified --invert-match. </td>
</tr>
<tr>
<td valign="top">-c</td>
<td valign="top">Print the number of matches (or non-matches if the -v option is
also specified) instead of the lines themselves. May also be specified --count.  </td>
</tr>
<tr>
<td valign="top">-l</td>
<td valign="top">Print the name of each file that contains a match instead of the lines
themselves. May also be specified --files-with-matches.  </td>
</tr>
<tr>
<td valign="top">-L</td>
<td valign="top">Like the -l option, but print only the names of files that do not
contain matches. May also be specified --files-without-match.
</td>
</tr>
<tr>
<td valign="top">-n</td>
<td valign="top">Prefix each matching line with the number of the line within the
file. May also be specified --line-number.  </td>
</tr>
<tr>
<td valign="top">-h</td>
<td valign="top">For multi-file searches, suppress the output of filenames. May also
be specified --no-filename. </td>
</tr>
</table>
</p>

In order to more fully explore grep, let’s create some text files to search:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls /bin > dirlist-bin.txt
[me@linuxbox ~]$ ls /usr/bin > dirlist-usr-bin.txt
[me@linuxbox ~]$ ls /sbin > dirlist-sbin.txt
[me@linuxbox ~]$ ls /usr/sbin > dirlist-usr-sbin.txt
[me@linuxbox ~]$ ls dirlist\*.txt
dirlist-bin.txt     dirlist-sbin.txt    dirlist-usr-sbin.txt
dirlist-usr-bin.txt </tt>
</pre></div>

We can perform a simple search of our list of files like this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ grep bzip dirlist\*.txt
dirlist-bin.txt:bzip2
dirlist-bin.txt:bzip2recover </tt>
</pre></div>

In this example, grep searches all of the listed files for the string bzip and finds two
matches, both in the file dirlist-bin.txt. If we were only interested in the list of
files that contained matches rather than the matches themselves, we could specify the -l
option:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ grep -l bzip dirlist\*.txt
dirlist-bin.txt </tt>
</pre></div>

Conversely, if we wanted only to see a list of the files that did not contain a match, we
could do this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ grep -L bzip dirlist\*.txt
dirlist-sbin.txt
dirlist-usr-bin.txt
dirlist-usr-sbin.txt </tt>
</pre></div>

Metacharacters And Literals

While it may not seem apparent, our grep searches have been using regular expressions
all along, albeit very simple ones. The regular expression “bzip” is taken to mean that a
match will occur only if the line in the file contains at least four characters and that
somewhere in the line the characters “b”, “z”, “i”, and “p” are found in that order, with no
other characters in between. The characters in the string “bzip” are all literal characters,
in that they match themselves. In addition to literals, regular expressions may also
include metacharacters that are used to specify more complex matches.
Regular expression metacharacters consist of the following: 

^ $ . [ ] { } - ? \* + ( ) | \

All other characters are considered literals, though the backslash character is used in a
few cases to create meta sequences, as well as allowing the metacharacters to be escaped
and treated as literals instead of being interpreted as metacharacters.

<hr style="height:5px;width:100%;background:gray" />
Note: As we can see, many of the regular expression metacharacters are also
characters that have meaning to the shell when expansion is performed. When we
pass regular expressions containing metacharacters on the command line, it is vital
that they be enclosed in quotes to prevent the shell from attempting to expand them.
<hr style="height:5px;width:100%;background:gray" />

The Any Character

The first metacharacter we will look at is the dot or period character, which is used to
match any character. If we include it in a regular expression, it will match any character
in that character position. Here’s an example:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ grep -h '.zip' dirlist\*.txt
bunzip2
bzip2
bzip2recover
gunzip
gzip
funzip
gpg-zip
preunzip
prezip
prezip-bin
unzip
unzipsfx </tt>
</pre></div>

We searched for any line in our files that matches the regular expression “.zip”. There are
a couple of interesting things to note about the results. Notice that the zip program was
not found. This is because the inclusion of the dot metacharacter in our regular
expression increased the length of the required match to four characters, and because the
name “zip” only contains three, it does not match. Also, if there had been any files in our
lists that contained the file extension .zip, they would have also been matched as well,
because the period character in the file extension is treated as “any character,” too.

Anchors

The caret (^) and dollar sign ($) characters are treated as anchors in regular expressions.
This means that they cause the match to occur only if the regular expression is found at
the beginning of the line (^) or at the end of the line ($):

<div class="code"><pre>
<tt>[me@linuxbox ~]$ grep -h '^zip' dirlist\*.txt
zip
zipcloak
zipgrep
zipinfo
zipnote
zipsplit
[me@linuxbox ~]$ grep -h 'zip$' dirlist\*.txt
gunzip
gzip
funzip
gpg-zip
preunzip
prezip
unzip
zip
[me@linuxbox ~]$ grep -h '^zip$' dirlist\*.txt
zip </tt>
</pre></div>

Here we searched the list of files for the string “zip” located at the beginning of the line,
the end of the line, and on a line where it is at both the beginning and the end of the line
(i.e., by itself on the line.) Note that the regular expression ‘^$’ (a beginning and an end
with nothing in between) will match blank lines.

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>A Crossword Puzzle Helper </h3>
<p> Even with our limited knowledge of regular expressions at this point, we can do
something useful. </p>

<p> My wife loves crossword puzzles and she will sometimes ask me for help with a
particular question. Something like, “what’s a five letter word whose third letter
is 'j' and last letter is 'r' that means...?” This kind of question got me thinking. </p>

<p>Did you know that your Linux system contains a dictionary? It does. Take a look
in the /usr/share/dict directory and you might find one, or several. The
dictionary files located there are just long lists of words, one per line, arranged in
alphabetical order. On my system, the words file contains just over 98,500
words. To find possible answers to the crossword puzzle question above, we
could do this:</p>

<p>[me@linuxbox ~]$ grep -i '^..j.r$' /usr/share/dict/words </p>

<p>Major</p>
<p>major</p>
<p>Using this regular expression, we can find all the words in our dictionary file that
are five letters long and have a “j” in the third position and an “r” in the last
position.</p>
</td>
</tr>
</table>

Bracket Expressions And Character Classes

In addition to matching any character at a given position in our regular expression, we
can also match a single character from a specified set of characters by using bracket
expressions. With bracket expressions, we can specify a set of characters (including
characters that would otherwise be interpreted as metacharacters) to be matched. In this
example, using a two character set:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ grep -h '[bg]zip' dirlist\*.txt
bzip2
bzip2recover
gzip </tt>
</pre></div>

we match any line that contains the string “bzip” or “gzip”.
A set may contain any number of characters, and metacharacters lose their special
meaning when placed within brackets. However, there are two cases in which
metacharacters are used within bracket expressions, and have different meanings. The
first is the caret (^), which is used to indicate negation; the second is the dash (-), which
is used to indicate a character range.

Negation

If the first character in a bracket expression is a caret (^), the remaining characters are
taken to be a set of characters that must not be present at the given character position. We
do this by modifying our previous example:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ grep -h '[^bg]zip' dirlist\*.txt
bunzip2
gunzip
funzip
gpg-zip
preunzip
prezip
prezip-bin
unzip
unzipsfx </tt>
</pre></div>

With negation activated, we get a list of files that contain the string “zip” preceded by any
character except “b” or “g”. Notice that the file zip was not found. A negated character
set still requires a character at the given position, but the character must not be a member
of the negated set.

The caret character only invokes negation if it is the first character within a bracket
expression; otherwise, it loses its special meaning and becomes an ordinary character in
the set.

Traditional Character Ranges

If we wanted to construct a regular expression that would find every file in our lists
beginning with an upper case letter, we could do this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ grep -h '^[ABCDEFGHIJKLMNOPQRSTUVWXZY]' dirlist\*.txt </tt>
</pre></div>

It’s just a matter of putting all twenty-six upper case letters in a bracket expression. But
the idea of all that typing is deeply troubling, so there is another way:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ grep -h '^[A-Z]' dirlist\*.txt
MAKEDEV
ControlPanel
GET
HEAD
POST
X
X11
Xorg
MAKEFLOPPIES
NetworkManager
NetworkManagerDispatcher </tt>
</pre></div>

By using a three character range, we can abbreviate the twenty-six letters. Any range of
characters can be expressed this way including multiple ranges, such as this expression
that matches all filenames starting with letters and numbers:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ grep -h '^[A-Za-z0-9]' dirlist\*.txt </tt>
</pre></div>

In character ranges, we see that the dash character is treated specially, so how do we
actually include a dash character in a bracket expression? By making it the first character
in the expression. Consider these two examples:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ grep -h '[A-Z]' dirlist\*.txt </tt>
</pre></div>

This will match every filename containing an upper case letter. While:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ grep -h '[-AZ]' dirlist\*.txt </tt>
</pre></div>

will match every filename containing a dash, or a upper case “A” or an uppercase “Z”.

POSIX Character Classes

The traditional character ranges are an easily understood and effective way to handle the
problem of quickly specifying sets of characters. Unfortunately, they don’t always work.
While we have not encountered any problems with our use of grep so far, we might run
into problems using other programs.

Back in Chapter 5, we looked at how wildcards are used to perform pathname expansion.
In that discussion, we said that character ranges could be used in a manner almost
identical to the way they are used in regular expressions, but here’s the problem:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls /usr/sbin/[ABCDEFGHIJKLMNOPQRSTUVWXYZ]\*
/usr/sbin/MAKEFLOPPIES
/usr/sbin/NetworkManagerDispatcher
/usr/sbin/NetworkManager</tt>
</pre></div>

(Depending on the Linux distribution, we will get a different list of files, possibly an
empty list. This example is from Ubuntu) This command produces the expected result 
— a list of only the files whose names begin with an uppercase letter, but:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls /usr/sbin/[A-Z]\*
/usr/sbin/biosdecode
/usr/sbin/chat
/usr/sbin/chgpasswd
/usr/sbin/chpasswd
/usr/sbin/chroot
/usr/sbin/cleanup-info
/usr/sbin/complain
/usr/sbin/console-kit-daemon</tt>
</pre></div>

with this command we get an entirely different result (only a partial listing of the results
is shown). Why is that? It’s a long story, but here’s the short version:
Back when Unix was first developed, it only knew about ASCII characters, and this
feature reflects that fact. In ASCII, the first thirty-two characters (numbers 0-31) are
control codes (things like tabs, backspaces, and carriage returns). The next thirty-two
(32-63) contain printable characters, including most punctuation characters and the
numerals zero through nine. The next thirty-two (numbers 64-95) contain the uppercase
letters and a few more punctuation symbols. The final thirty-one (numbers 96-127)
contain the lowercase letters and yet more punctuation symbols. Based on this
arrangement, systems using ASCII used a collation order that looked like this:

ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz

This differs from proper dictionary order, which is like this:

aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ

As the popularity of Unix spread beyond the United States, there grew a need to support
characters not found in U.S. English. The ASCII table was expanded to use a full eight
bits, adding characters numbers 128-255, which accommodated many more languages.

To support this ability, the POSIX standards introduced a concept called a locale, which
could be adjusted to select the character set needed for a particular location. We can see
the language setting of our system using this command:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo $LANG
en\_US.UTF-8 </tt>
</pre></div>

With this setting, POSIX compliant applications will use a dictionary collation order
rather than ASCII order. This explains the behavior of the commands above. A character
range of [A-Z] when interpreted in dictionary order includes all of the alphabetic
characters except the lowercase “a”, hence our results.

To partially work around this problem, the POSIX standard includes a number of
character classes which provide useful ranges of characters. They are described in the
table below:


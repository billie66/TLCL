---
layout: book
title: 查找文件 
---

As we have wandered around our Linux system, one thing has become abundantly clear:
a typical Linux system has a lot of files! This begs the question, “how do we find
things?” We already know that the Linux file system is well organized according to
conventions that have been passed down from one generation of Unix-like system to the
next, but the sheer number of files can present a daunting problem.
In this chapter, we will look at two tools that are used to find files on a system. These
tools are:

* locate – Find files by name

* find – Search for files in a directory hierarchy

We will also look at a command that is often used with file search commands to process
the resulting list of files:

* xargs – Build and execute command lines from standard input

In addition, we will introduce a couple of commands to assist us in or exploration:

* touch – Change file times

* stat – Display file or file system status

locate – Find Files The Easy Way

The locate program performs a rapid database search of pathnames and outputs every
name that matches a given substring. Say, for example, we want to find all the programs
with names that begin with “zip.” Since we are looking for programs, we can assume
that the directory containing the programs would end with “bin/”. Therefore, we could
try to use locate this way to find our files:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ locate bin/zip</tt>
</pre></div>

locate will search its database of pathnames and output any that contain the string “bin/zip”:

<div class="code"><pre>
<tt>/usr/bin/zip
/usr/bin/zipcloak
/usr/bin/zipgrep
/usr/bin/zipinfo
/usr/bin/zipnote
/usr/bin/zipsplit</tt>
</pre></div>

If the search requirement is not so simple, locate can be combined with other tools
such as grep to design more interesting searches:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ locate zip | grep bin
/bin/bunzip2
/bin/bzip2
/bin/bzip2recover
/bin/gunzip
/bin/gzip
/usr/bin/funzip
/usr/bin/gpg-zip
/usr/bin/preunzip
/usr/bin/prezip
/usr/bin/prezip-bin
/usr/bin/unzip
/usr/bin/unzipsfx
/usr/bin/zip
/usr/bin/zipcloak
/usr/bin/zipgrep
/usr/bin/zipinfo
/usr/bin/zipnote
/usr/bin/zipsplit</tt>
</pre></div>

The locate program has been around for a number of years, and there are several
different variants in common use. The two most common ones found in modern Linux
distributions are slocate and mlocate, though they are usually accessed by a
symbolic link named locate. The different versions of locate have overlapping
options sets. Some versions include regular expression matching (which we’ll cover in
an upcoming chapter) and wild card support. Check the man page for locate to
determine which version of locate is installed.

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>Where Does The locate Database Come From?</h3>
<p> Where Does The locate Database Come From?
You may notice that, on some distributions, locate fails to work just after the
system is installed, but if you try again the next day, it works fine. What gives?
The locate database is created by another program named updatedb.
Usually, it is run periodically as a cron job; that is, a task performed at
regular itextntervals by the cron daemon.  Most systems equipped with locate
run updatedb once a day. Since the database is not updated continuously, you
will notice that very recent files do not show up when using locate. To
overcome this, it’s possible to run the updatedb program manually by becoming
the superuser and running updatedb at the prompt.
</p>
</td>
</tr>
</table>

### find – Find Files The Hard Way

While the locate program can find a file based solely on its name, the find program
searches a given directory (and its subdirectories) for files based on a variety of
attributes. We’re going to spend a lot of time with find because it has a lot of
interesting features that we will see again and again when we start to cover programming
concepts in later chapters.

In its simplest use, find is given one or more names of directories to search. For
example, to produce a list of our home directory:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ find ~</tt>
</pre></div>

On most active user accounts, this will produce a large list. Since the list is sent to
standard output, we can pipe the list into other programs. Let’s use wc to count the
number of files:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ find ~ | wc -l
47068</tt>
</pre></div>

Wow, we’ve been busy! The beauty of find is that it can be used to identify files that
meet specific criteria. It does this through the (slightly strange) application of options,
tests, and actions. We’ll look at the tests first.

#### Tests

Let’s say that we want a list of directories from our search. To do this, we could add the
following test:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ find ~ -type d | wc -l
1695</tt>
</pre></div>

Adding the test -type d limited the search to directories. Conversely, we could have
limited the search to regular files with this test:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ find ~ -type f | wc -l
38737</tt>
</pre></div>

Here are the common file type tests supported by find:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 18-1: find File Types</caption>
<tr>
<th class="title">File Type </th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="25%">b</td>
<td valign="top">Block special device file
</td>
</tr>
<tr>
<td valign="top">c</td>
<td valign="top">Character special device file</td>
</tr>
<tr>
<td valign="top">d</td>
<td valign="top">Directory</td>
</tr>
<tr>
<td valign="top">f</td>
<td valign="top">Regular file</td>
</tr>
<tr>
<td valign="top">l</td>
<td valign="top">Symbolic link</td>
</tr>
</table>
</p>

We can also search by file size and filename by adding some additional tests: Let’s look
for all the regular files that match the wild card pattern “\*.JPG” and are larger than one
megabyte:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ find ~ -type f -name "\*.JPG" -size +1M | wc -l
840</tt>
</pre></div>

In this example, we add the -name test followed by the wild card pattern. Notice how
we enclose it in quotes to prevent pathname expansion by the shell. Next, we add the
-size test followed by the string “+1M”. The leading plus sign indicates that we are
looking for files larger than the specified number. A leading minus sign would change
the meaning of the string to be smaller than the specified number. No sign means,
“match the value exactly.” The trailing letter “M” indicates that the unit of measurement
is megabytes. The following characters may be used to specify units:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 18-2: find Size Units</caption>
<tr>
<th class="title">Character</th>
<th class="title">Unit</th>
</tr>
<tr>
<td valign="top" width="25%">b</td>
<td valign="top">512 byte blocks. This is the default if no unit is specified.</td>
</tr>
<tr>
<td valign="top">c</td>
<td valign="top">Bytes</td>
</tr>
<tr>
<td valign="top">w</td>
<td valign="top">Two byte words</td>
</tr>
<tr>
<td valign="top">k</td>
<td valign="top">Kilobytes (Units of 1024 bytes)</td>
</tr>
<tr>
<td valign="top">M</td>
<td valign="top">Megabytes (Units of 1048576 bytes)</td>
</tr>
<tr>
<td valign="top">G</td>
<td valign="top">Gigabytes (Units of 1073741824 bytes)</td>
</tr>
</table>
</p>

find supports a large number of different tests. Below is a rundown of the common
ones. Note that in cases where a numeric argument is required, the same “+” and “-”
notation discussed above can be applied:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 18-3: find Tests</caption>
<tr>
<th class="title">Test</th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="25%">-cmin n </td>
<td valign="top">Match files or directories whose content or attributes were
last modified exactly n minutes ago. To specify less than n
minutes ago, use -n and to specify more than n minutes
ago, use +n.</td>
</tr>
<tr>
<td valign="top">-cnewer file </td>
<td valign="top">Match files or directories whose contents or attributes were
last modified more recently than those of file.</td>
</tr>
<tr>
<td valign="top">-ctime n </td>
<td valign="top">Match files or directories whose contents or attributes were
last modified n\*24 hours ago.</td>
</tr>
<tr>
<td valign="top">-empty </td>
<td valign="top">Match empty files and directories.</td>
</tr>
<tr>
<td valign="top">-group name </td>
<td valign="top">Match file or directories belonging to group. group may
be expressed as either a group name or as a numeric group
ID.</td>
</tr>
<tr>
<td valign="top">-iname pattern </td>
<td valign="top">Like the -name test but case insensitive.</td>
</tr>
<tr>
<td valign="top">-inum n </td>
<td valign="top">Match files with inode number n. This is helpful for
finding all the hard links to a particular inode.</td>
</tr>
<tr>
<td valign="top">-mmin n </td>
<td valign="top">Match files or directories whose contents were modified n
minutes ago.</td>
</tr>
<tr>
<td valign="top">-mtime n </td>
<td valign="top">Match files or directories whose contents were modified
n\*24 hours ago.</td>
</tr>
<tr>
<td valign="top">-name pattern </td>
<td valign="top">Match files and directories with the specified wild card pattern.</td>
</tr>
<tr>
<td valign="top">-newer file </td>
<td valign="top">Match files and directories whose contents were modified
more recently than the specified file. This is very useful
when writing shell scripts that perform file backups. Each
time you make a backup, update a file (such as a log), then
use find to determine which files that have changed since
the last update.</td>
</tr>
<tr>
<td valign="top">-nouser </td>
<td valign="top">Match file and directories that do not belong to a valid user.
This can be used to find files belonging to deleted accounts
or to detect activity by attackers.</td>
</tr>
<tr>
<td valign="top">-nogroup </td>
<td valign="top">Match files and directories that do not belong to a valid
group.</td>
</tr>
<tr>
<td valign="top">-perm mode </td>
<td valign="top">Match files or directories that have permissions set to the
specified mode. mode may be expressed by either octal or
symbolic notation.</td>
</tr>
<tr>
<td valign="top">-samefile name </td>
<td valign="top">Similar to the -inum test. Matches files that share the
same inode number as file name.</td>
</tr>
<tr>
<td valign="top">-size n </td>
<td valign="top">Match files of size n.</td>
</tr>
<tr>
<td valign="top">-type c </td>
<td valign="top">Match files of type c.</td>
</tr>
<tr>
<td valign="top">-user name </td>
<td valign="top">Match files or directories belonging to user name. The
user may be expressed by a user name or by a numeric user
ID.</td>
</tr>
</table>
</p>

This is not a complete list. The find man page has all the details.

Operators
Even with all the tests that find provides, we may still need a better way to describe the
logical relationships between the tests. For example, what if we needed to determine if
all the files and subdirectories in a directory had secure permissions? We would look for
all the files with permissions that are not 0600 and the directories with permissions that
are not 0700. Fortunately, find provides a way to combine tests using logical operators
to create more complex logical relationships. To express the aforementioned test, we
could do this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ find ~ \( -type f -not -perm 0600 \) -or \( -type d
-not -perm 0700 \)</tt>
</pre></div>

Yikes! That sure looks weird. What is all this stuff? Actually, the operators are not that
complicated once you get to know them. Here is the list:


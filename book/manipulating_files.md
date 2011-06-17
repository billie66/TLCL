---
layout: book
title: 操作文件和目录 
---
At this point, we are ready for some real work! This chapter will introduce
the following commands:

* cp – Copy files and directories

* mv – Move/rename files and directories

* mkdir – Create directories

* rm – Remove files and directories

* ln – Create hard and symbolic links

These five commands are among the most frequently used Linux commands. They
are used for manipulating both files and directories.

Now, to be frank, some of the tasks performed by these commands are more
easily done with a graphical file manager. With a file manager, we can drag and drop a
file from one directory to another, cut and paste files, delete files, etc. So why use these
old command line programs?

The answer is power and flexibility. While it is easy to perform simple file
manipulations with a graphical file manager, complicated tasks can be easier with the
command line programs. For example, how could we copy all the HTML files from one directory
to another, but only copy files that do not exist in the destination directory or
are newer than the versions in the destination directory? Pretty hard with with a file
manager. Pretty easy with the command line:

<div class="code"><pre>
<tt>cp -u *.html destination </tt>
</pre></div>

Wildcards

Before we begin using our commands, we need to talk about a shell feature that
makes these commands so powerful. Since the shell uses filenames so much, it
provides special characters to help you rapidly specify groups of filenames. These special
characters are called wildcards. Using wildcards (which is also known as globbing) allow you
to select filenames based on patterns of characters. The table below lists the wildcards
and what they select:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 5-1: Wildcards</caption>
<tr>
<th class="title">Wildcard</th>
<th class="title">Meaning</th>
</tr>
<tr>
<td valign="top">\*</td>
<td valign="top">Matches any characters</td>
</tr>
<tr>
<td valign="top">?</td>
<td valign="top">Matches any single character</td>
</tr>
<tr>
<td valign="top">[characters]</td>
<td valign="top">Matches any characters</td>
</tr>
<tr>
<td valign="top">[!characters]</td>
<td valign="top">Matches any character that is not a member of the set
characters</td>
</tr>
<tr>
<td valign="top">[[:class:]]</td>
<td valign="top">Matches any character that is a member of the specified class</td>
</tr>
</table>
</p>

Table 5-2 lists the most commonly used character classes:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 5-2: Commonly Used Character Classes</caption>
<tr>
<th class="title">Character Class</th>
<th class="title">Meaning</th>
</tr>
<tr>
<td valign="top">[:alnum:]</td>
<td valign="top">Matches any alphanumeric character</td>
</tr>
<tr>
<td valign="top">[:alpha:]</td>
<td valign="top">Matches any alphabetic character</td>
</tr>
<tr>
<td valign="top">[:digit:]</td>
<td valign="top">Matches any numeral</td>
</tr>
<tr>
<td valign="top">[:lower:]</td>
<td valign="top">Matches any lowercase letter</td>
</tr>
<tr>
<td valign="top">[:upper]</td>
<td valign="top">Matches any uppercase letter</td>
</tr>
</table>
</p>

Using wildcards makes it possible to construct very sophisticated selection criteria for
filenames. Here are some examples of patterns and what they match:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 5-3: Wildcard Examples</caption>
<tr>
<th class="title">Pattern</th>
<th class="title">Matches</th>
</tr>
<tr>
<td valign="top">\*</td>
<td valign="top">All files</td>
</tr>
<tr>
<td valign="top">g\*</td>
<td valign="top">All file beginning with "g"</td>
</tr>
<tr>
<td valign="top">b\*.txt</td>
<td valign="top">Any file beginning with "b" followed by any characters and
ending with ".txt"</td>
</tr>
<tr>
<td valign="top">Data???</td>
<td valign="top">Any file beginning with "Data" followed by exactly three
characters</td>
</tr>
<tr>
<td valign="top">[abc]\*</td>
<td valign="top">Any file beginning with either an "a", a "b", or a "c"</td>
</tr>
<tr>
<td valign="top">BACKUP.[0-9][0-9][0-9]</td>
<td valign="top">Any file beginning with "BACKUP." followed by exactly three
numerals</td>
</tr>
<tr>
<td valign="top">[[:upper:]]\*</td>
<td valign="top">Any file beginning with an uppercase letter</td>
</tr>
<tr>
<td valign="top">[![:digit:]]\*</td>
<td valign="top">Any file not beginning with a numeral</td>
</tr>
<tr>
<td valign="top">\*[[:lower:]123]</td>
<td valign="top">Any file ending with a lowercase letter or the numerals "1",
"2", or "3"</td>
</tr>
</table>
</p>


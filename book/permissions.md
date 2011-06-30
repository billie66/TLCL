Operating systems in the Unix tradition differ from those in the MS-DOS tradition in
that they are not only multitasking systems, but also multi-user systems, as well.
What exactly does this mean? It means that more than one person can be using the
computer at the same time. While a typical computer will likely have only one keyboard
and monitor, it can still be used by more than one user. For example, if a computer is
attached to a network or the Internet, remote users can log in via ssh (secure shell) and
operate the computer. In fact, remote users can execute graphical applications and have
the graphical output appear on a remote display. The X Window System supports this as
part of its basic design.

The multi-user capability of Linux is not a recent "innovation," but rather a feature that is
deeply embedded into the design of the operating system. Considering the environment
in which Unix was created, this makes perfect sense. Years ago, before computers were
"personal," they were large, expensive, and centralized. A typical university computer
system, for example, consisted of a large central computer located in one building and
terminals which were located throughout the campus, each connected to the large central
computer. The computer would support many users at the same time.

In order to make this practical, a method had to be devised to protect the users from each
other. After all, the actions of one user could not be allowed to crash the computer, nor
could one user interfere with the files belonging to another user.

In this chapter we are going to look at this essential part of system security and introduce
the following commands:

● id – Display user identity

● chmod – Change a file's mode

● umask – Set the default file permissions

● su – Run a shell as another user

● sudo – Execute a command as another user

● chown – Change a file's owner

● chgrp – Change a file's group ownership

● passwd – Change a user's password

Owners, Group Members, And Everybody Else

When we were exploring the system back in Chapter 4, we may have encountered a
problem when trying to examine a file such as /etc/shadow:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ file /etc/shadow
/etc/shadow:  regular file, no read permission
[me@linuxbox ~]$ less /etc/shadow
/etc/shadow:  Permission denied</tt>
</pre></div>

The reason for this error message is that, as regular users, we do not have permission to
read this file.

In the Unix security model, a user may own files and directories. When a user owns a file
or directory, the user has control over its access. Users can, in turn, belong to a group
consisting of one or more users who are given access to files and directories by their
owners. In addition to granting access to a group, an owner may also grant some set of
access rights to everybody, which in Unix terms is referred to as the world. To find out
information about your identity, use the id command:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ id
uid=500(me) gid=500(me) groups=500(me)</tt>
</pre></div>

Let's look at the output. When user accounts are created, users are assigned a number
called a user ID or uid which is then, for the sake of the humans, mapped to a user name.
The user is assigned a primary group ID or gid and may belong to additional groups. The
above example is from a Fedora system. On other systems, such as Ubuntu, the output
may look a little different:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ id
uid=1000(me) gid=1000(me)
groups=4(adm),20(dialout),24(cdrom),25(floppy),29(audio),30(dip),44(v
ideo),46(plugdev),108(lpadmin),114(admin),1000(me)</tt>
</pre></div>

As we can see, the uid and gid numbers are different. This is simply because Fedora
starts its numbering of regular user accounts at 500, while Ubuntu starts at 1000. We can
also see that the Ubuntu user belongs to a lot more groups. This has to do with the way
Ubuntu manages privileges for system devices and services.

So where does this information come from? Like so many things in Linux, from a couple
of text files. User accounts are defined in the /etc/passwd file and groups are defined
in the /etc/group file. When user accounts and groups are created, these files are
modified along with /etc/shadow which holds information about the user's password.
For each user account, the /etc/passwd file defines the user (login) name, uid, gid,
the account's real name, home directory, and login shell. If you examine the contents of
/etc/passwd and /etc/group, you will notice that besides the regular user
accounts, there are accounts for the superuser (uid 0) and various other system users.

In the next chapter, when we cover processes, you will see that some of these other
“users” are, in fact, quite busy.

While many Unix-like systems assign regular users to a common group such as “users”,
modern Linux practice is to create a unique, single-member group with the same name as
the user. This makes certain types of permission assignment easier.

Reading, Writing, And Executing

Access rights to files and directories are defined in terms of read access, write access, and
execution access. If we look at the output of the ls command, we can get some clue as
to how this is implemented:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ > foo.txt
[me@linuxbox ~]$ ls -l foo.txt
-rw-rw-r-- 1 me   me   0 2008-03-06 14:52 foo.txt</tt>
</pre></div>

The first ten characters of the listing are the file attributes. The first of these characters is
the file type. Here are the file types you are most likely to see (there are other, less
common types too):

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 10-1: File Types</caption>
<tr>
<th class="title">Attribute</th>
<th class="title">File Type</th>
</tr>
<tr>
<td valign="top" width="25%">-</td>
<td valign="top">a regular file</td>
</tr>
<tr>
<td valign="top">d </td>
<td valign="top">A directory</td>
</tr>
<tr>
<td valign="top">l</td>
<td valign="top">A symbolic link. Notice that with symbolic links, the
remainning file attributes are always “rwxrwxrwx” and are dummy values. The
real file attributes are those of the file the symbolic link points to.
</td>
</tr>
<tr>
<td valign="top">c</td>
<td valign="top">A character special file. This file type refers to a device that
handles data as a stream of bytes, such as a terminal or modem.
</td>
</tr>
<tr>
<td valign="top">b</td>
<td valign="top">A block special file. This file type refers to a device that handles
data in blocks, such as a hard drive or CD-ROM drive.
</td>
</tr>
</table>
</p>

The remaining nine characters of the file attributes, called the file mode, represent the
read, write, and execute permissions for the file's owner, the file's group owner, and
everybody else:

When set, the r, w, and x mode attributes have the following effect on files and
directories:

chmod – Change file mode
To change the mode (permissions) of a file or directory, the chmod command is used.
Be aware that only the file’s owner or the superuser can change the mode of a file or
directory. chmod supports two distinct ways of specifying mode changes: octal number
representation, or symbolic representation. We will cover octal number representation
first.



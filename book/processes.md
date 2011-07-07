
Modern operating systems are usually multitasking, meaning that they create the illusion
of doing more than one thing at once by rapidly switching from one executing program to
another. The Linux kernel manages this through the use of processes. Processes are how
Linux organizes the different programs waiting for their turn at the CPU.

Sometimes a computer will become sluggish or an application will stop responding. In
this chapter, we will look at some of the tools available at the command line that let us
examine what programs are doing, and how to terminate processes that are misbehaving.

This chapter will introduce the following commands:

* ps – Report a snapshot of current processes
* top – Display tasks
* jobs – List active jobs
* bg – Place a job in the background
* fg – Place a job in the foreground
* kill – Send a signal to a process
* killall – Kill processes by name
* shutdown – Shutdown or reboot the system

### How A Process Works

### 进程是怎样工作的

When a system starts up, the kernel initiates a few of its own activities as processes and
launches a program called init. init, in turn, runs a series of shell scripts (located in
/etc) called init scripts, which start all the system services. Many of these services are
implemented as daemon programs, programs that just sit in the background and do their
thing without having any user interface. So even if we are not logged in, the system is at
least a little busy performing routine stuff.

The fact that a program can launch other programs is expressed in the process scheme as
a parent process producing a child process.

The kernel maintains information about each process to help keep things organized. For
example, each process is assigned a number called a process ID or PID. PIDs are
assigned in ascending order, with init always getting PID 1. The kernel also keeps
track of the memory assigned to each process, as well as the processes' readiness to
resume execution. Like files, processes also have owners and user IDs, effective user
IDs, etc.

### Viewing Processes

### 查看进程

The most commonly used command to view processes (there are several) is ps. The ps
program has a lot of options, but in it simplest form it is used like this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ps
PID TTY           TIME CMD
5198 pts/1    00:00:00 bash
10129 pts/1   00:00:00 ps</tt>
</pre></div>

The result in this example lists two processes, process 5198 and process 10129, which are
bash and ps respectively. As we can see, by default, ps doesn't show us very much,
just the processes associated with the current terminal session. To see more, we need to
add some options, but before we do that, let's look at the other fields produced by ps.
TTY is short for “Teletype,” and refers to the controlling terminal for the process. Unix
is showing its age here. The TIME field is the amount of CPU time consumed by the
process. As we can see, neither process makes the computer work very hard.

If we add an option, we can get a bigger picture of what the system is doing:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ps x
PID TTY   STAT   TIME COMMAND
2799 ?    Ssl    0:00 /usr/libexec/bonobo-activation-server –ac
2820 ?    Sl     0:01 /usr/libexec/evolution-data-server-1.10 --

and many more...</tt>
</pre></div>

Adding the “x” option (note that there is no leading dash) tells ps to show all of our
processes regardless of what terminal (if any) they are controlled by. The presence of a
“?” in the TTY column indicates no controlling terminal. Using this option, we see a list
of every process that we own.

Since the system is running a lot of processes, ps produces a long list. It is often helpful
to pipe the output from ps into less for easier viewing. Some option combinations also
produce long lines of output, so maximizing the terminal emulator window may be a
good idea, too.

A new column titled STAT has been added to the output. STAT is short for “state” and
reveals the current status of the process:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 11-1: Process States</caption>
<tr>
<th class="title">title</th>
<th class="title">title</th>
</tr>
<tr>
<td valign="top" width="25%">text</td>
<td valign="top">text</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top"></td>
</tr>
</table>
</p>

The process state may be followed by other characters. These indicate various exotic
process characteristics. See the ps man page for more detail.
Another popular set of options is “aux” (without a leading dash). This gives us even
more information:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ps aux
USER   PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
</tt>
</pre></div>


This set of options displays the processes belonging to every user. Using the options
without the leading dash invokes the command with “BSD style” behavior. The Linux
version of ps can emulate the behavior of the ps program found in several different
Unix implementations. With these options, we get these additional columns:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap"></caption>
<tr>
<th class="title">title</th>
<th class="title">title</th>
</tr>
<tr>
<td valign="top" width="25%">text</td>
<td valign="top">text</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top"></td>
</tr>
</table>
</p>

### Viewing Processes Dynamically With top

While the ps command can reveal a lot about what the machine is doing, it provides only
a snapshot of the machine's state at the moment the ps command is executed. To see a
more dynamic view of the machine's activity, we use the top command:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ top</tt>
</pre></div>

The top program displays a continuously updating (by default, every 3 seconds) display
of the system processes listed in order of process activity. The name “top” comes from
the fact that the top program is used to see the “top” processes on the system. The top
display consists of two parts: a system summary at the top of the display, followed by a
table of processes sorted by CPU activity:

<div class="code"><pre>
<tt></tt>
</pre></div>

The system summary contains a lot of good stuff. Here's a rundown:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap"></caption>
<tr>
<th class="title">title</th>
<th class="title">title</th>
</tr>
<tr>
<td valign="top" width="25%">text</td>
<td valign="top">text</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top"></td>
</tr>
</table>
</p>

The top program accepts a number of keyboard commands. The two most interesting are
h, which displays the program's help screen, and q, which quits top.
Both major desktop environments provide graphical applications that display information
similar to top (in much the same way that Task Manager in Windows works), but I find
that top is better than the graphical versions because it is faster and it consumes far
fewer system resources. After all, our system monitor program shouldn't be the source of
the system slowdown that we are trying to track.

### Controlling Processes

Now that we can see and monitor processes, let's gain some control over them. For our
experiments, we're going to use a little program called xlogo as our guinea pig. The
xlogo program is a sample program supplied with the X Window System (the
underlying engine that makes the graphics on our display go) which simply displays a re-
sizable window containing the X logo. First, we'll get to know our test subject:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ xlogo</tt>
</pre></div>

After entering the command, a small window containing the logo should appear
somewhere on the screen. On some systems, xlogo may print a warning message, but it
may be safely ignored.

Tip: If your system does not include the xlogo program, try using gedit or
kwrite instead.
We can verify that xlogo is running by resizing its window. If the logo is redrawn in the
new size, the program is running.
Notice how our shell prompt has not returned? This is because the shell is waiting for the
program to finish, just like all the other programs we have used so far. If we close the
xlogo window, the prompt returns.
Interrupting A Process
Let's observe what happens when we run xlogo again. First, enter the xlogo
command and verify that the program is running. Next, return to the terminal window
and type Ctrl-c.

<div class="code"><pre>
<tt>[me@linuxbox ~]$ xlogo
[me@linuxbox ~]$</tt>
</pre></div>

In a terminal, typing Ctrl-c, interrupts a program. This means that we politely asked
the program to terminate. After typing Ctrl-c, the xlogo window closed and the shell
prompt returned.
Many (but not all) command line programs can be interrupted by using this technique.
Putting A Process In The Background
Let's say we wanted to get the shell prompt back without terminating the xlogo
program. We’ll do this by placing the program in the background. Think of the terminal
as having a foreground (with stuff visible on the surface like the shell prompt) and a
background (with hidden stuff behind the surface.) To launch a program so that it is
immediately placed in the background, we follow the command with an- “&” character:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ xlogo &
[1] 28236
[me@linuxbox ~]$</tt>
</pre></div>

After entering the command, the xlogo window appeared and the shell prompt returned,
but some funny numbers were printed too. This message is part of a shell feature called
job control. With this message, the shell is telling us that we have started job number 1
(“[1]”) and that it has PID 28236. If we run ps, we can see our process:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ps</tt>
</pre></div>

The shell's job control facility also gives us a way to list the jobs that are have been
launched from our terminal. Using the jobs command, we can see this list:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ jobs
[1]+ Running            xlogo &</tt>
</pre></div>

The results show that we have one job, numbered “1”, that it is running, and that the
command was xlogo &.
Returning A Process To The Foreground
A process in the background is immune from keyboard input, including any attempt
interrupt it with a Ctrl-c. To return a process to the foreground, use the fg command,
this way:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ jobs
[1]+ Running        xlogo &
[me@linuxbox ~]$ fg %1 
xlogo</tt>
</pre></div>

The command fg followed by a percent sign and the job number (called a jobspec) does
the trick. If we only have one background job, the jobspec is optional. To terminate
xlogo, type Ctrl-c.
Stopping (Pausing) A Process
Sometimes we'll want to stop a process without terminating it. This is often done to
allow a foreground process to be moved to the background. To stop a foreground
process, type Ctrl-z. Let's try it. At the command prompt, type xlogo, the Enter
key, then Ctrl-z:

<div class="code"><pre>
<tt></tt>
</pre></div>

After stopping xlogo, we can verify that the program has stopped by attempting to
resize the xlogo window. We will see that it appears quite dead. We can either restore
the program to the foreground, using the fg command, or move the program to the
background with the bg command:

<div class="code"><pre>
<tt></tt>
</pre></div>

As with the fg command, the jobspec is optional if there is only one job.
Moving a process from the foreground to the background is handy if we launch a
graphical program from the command, but forget to place it in the background by
appending the trailing “&”.
Why would you want to launch a graphical program from the command line? There are
two reasons. First, the program you wish to run might not be listed on the window
manager's menus (such as xlogo). Secondly, by launching a program from the
command line, you might be able to see error messages that would otherwise be invisible
if the program were launched graphically. Sometimes, a program will fail to start up
when launched from the graphical menu. By launching it from the command line instead,
we may see an error message that will reveal the problem. Also, some graphical
programs have many interesting and useful command line options.

Signals
The kill command is used to “kill” programs. This allows us to terminate programs
that need killing. Here's an example:

<div class="code"><pre>
<tt></tt>
</pre></div>

We first launch xlogo in the background. The shell prints the jobspec and the PID of
the background process. Next, we use the kill command and specify the PID of the
process we want to terminate. We could have also specified the process using a jobspec
(for example, “%1”) instead of a PID.
While this is all very straightforward, there is more to it than that. The kill command
doesn't exactly “kill” programs, rather it sends them signals. Signals are one of several
ways that the operating system communicates with programs. We have already seen
signals in action with the use of Ctrl-c and Ctrl-z. When the terminal receives one
of these keystrokes, it sends a signal to the program in the foreground. In the case of
Ctrl-c, a signal called INT (Interrupt) is sent; with Ctrl-z, a signal called TSTP
(Terminal Stop.) Programs, in turn, “listen” for signals and may act upon them as they
are received. The fact that a program can listen and act upon signals allows a program to
do things like save work in progress when it is sent a termination signal.
Sending Signals To Processes With kill
The kill command is used to send signals to programs. Its most common syntax looks
like this:

<div class="code"><pre>
<tt>kill [-signal] PID...</tt>
</pre></div>

If no signal is specified on the command line, then the TERM (Terminate) signal is sent by
default. The kill command is most often used to send the following signals:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap"></caption>
<tr>
<th class="title">title</th>
<th class="title">title</th>
</tr>
<tr>
<td valign="top" width="25%">text</td>
<td valign="top">text</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top"></td>
</tr>
</table>
</p>

Let's try out the kill command:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ xlogo &
[1] 13546
[me@linuxbox ~]$ kill -1 13546
[1]+ Hangup         xlogo</tt>
</pre></div>

In this example, we start the xlogo program in the background and then send it a HUP
signal with kill. The xlogo program terminates and the shell indicates that the
background process has received a hangup signal. You may need to press the enter key a
couple of times before you see the message. Note that signals may be specified either by
number or by name, including the name prefixed with the letters “SIG”:

<div class="code"><pre>
<tt></tt>
</pre></div>

Repeat the example above and try out the other signals. Remember, you can also use
jobspecs in place of PIDs.
Processes, like files, have owners, and you must be the owner of a process (or the
superuser) in order to send it signals with kill.
In addition to the list of signals above, which are most often used with kill, there are
other signals frequently used by the system. Here is a list of other common signals:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap"></caption>
<tr>
<th class="title">title</th>
<th class="title">title</th>
</tr>
<tr>
<td valign="top" width="25%">text</td>
<td valign="top">text</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top"></td>
</tr>
</table>
</p>

For the curious, a complete list of signals can be seen with the following command:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ kill -l</tt>
</pre></div>

Sending Signals To Multiple Processes With killall
It's also possible to send signals to multiple processes matching a specified program or
user name by using the killall command. Here is the syntax:

<div class="code"><pre>
<tt>killall [-u user] [-signal] name...</tt>
</pre></div>

To demonstrate, we will start a couple of instances of the xlogo program and then
terminate them:

<div class="code"><pre>
<tt></tt>
</pre></div>

Remember, as with kill, you must have superuser privileges to send signals to
processes that do not belong to you.
More Process Related Commands
Since monitoring processes is an important system administration task, there are a lot of
commands for it. Here are some to play with:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 11-6: Other Process Related Commands</caption>
<tr>
<th class="title">Command </th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="25%">pstree </td>
<td valign="top">Outputs a process list arranged in a tree-like pattern showing the
parent/child relationships between processes.</td>
</tr>
<tr>
<td valign="top">vmstat</td>
<td valign="top">Outputs a snapshot of system resource usage including, memory,
swap and disk I/O. To see a continuous display, follow the
command with a time delay (in seconds) for updates. For example:
vmstat 5. Terminate the output with Ctrl-c.</td>
</tr>
<tr>
<td valign="top">xload</td>
<td valign="top">A graphical program that draws a graph showing system load over
time</td>
</tr>
<tr>
<td valign="top">tload</td>
<td valign="top">Similar to the xload program, but draws the graph in the terminal.
Terminate the output with Ctrl-c.</td>
</tr>
</table>
</p>



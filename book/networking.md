---
layout: book
title: 网络系统 
---

When it comes to networking, there is probably nothing that cannot be done
with Linux.  Linux is used to build all sorts of networking systems and appliances,
including firewalls, routers, name servers, NAS (Network Attached Storage) boxes and on and on.



Just as the subject of networking is vast, so are the number of commands that
can be used to configure and control it. We will focus our attention on just a few of the
most frequently used ones. The commands chosen for examination include those used
to monitor networks and those used to transfer files. In addition, we are going
to explore the ssh program that is used to perform remote logins. This chapter will
cover:



* ping - Send an ICMP ECHO\_REQUEST to network hosts

* traceroute - Print the route packets trace to a network host

* netstat - Print network connections, routing tables, interface statistics,
  masquerade connections, and multicast memberships

* ftp - Internet file transfer program

* wget - Non-interactive network downloader

* ssh - OpenSSH SSH client (remote login program)

We’re going to assume a little background in networking. In this, the Internet age,
everyone using a computer needs a basic understanding of networking concepts. To
make full use of this chapter we should be familiar with the following terms:



* IP (Internet Protocol) address

* Host and domain name

* URI (Uniform Resource Identifier)

Please see the “Further Reading” section below for some useful articles regarding these
terms.

<hr style="width:90%;height:5px;background:teal" />
Note: Some of the commands we will cover may (depending on your distribution)
require the installation of additional packages from your distribution’s repositories,
and some may require superuser privileges to execute.
<hr style="width:90%;height:5px;background:teal" />

### Examining And Monitoring A Network

Even if you’re not the system administrator, it’s often helpful to examine the performance
and operation of a network.

#### ping

The most basic network command is ping. The ping command sends a special
network packet called an IMCP ECHO\_REQUEST to a specified host. Most network
devices receiving this packet will reply to it, allowing the network connection to be
verified.

<hr style="width:90%;height:5px;background:teal" />
Note: It is possible to configure most network devices (including Linux hosts) to
ignore these packets. This is usually done for security reasons, to partially obscure
a host from a potential attacker. It is also common for firewalls to be configured to
block IMCP traffic.
<hr style="width:90%;height:5px;background:teal" />

For example, to see if we can reach linuxcommand.org (one of our favorite sites ;-),
we can use use ping like this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ping linuxcommand.org</tt>
</pre></div>

Once started, ping continues to send packets at a specified interval (default is one
second) until it is interrupted:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ping linuxcommand.org
PING linuxcommand.org (66.35.250.210) 56(84) bytes of data.
64 bytes from vhost.sourceforge.net (66.35.250.210): icmp\_seq=1
ttl=43 time=107 ms
64 bytes from vhost.sourceforge.net (66.35.250.210): icmp\_seq=2
ttl=43 time=108 ms
64 bytes from vhost.sourceforge.net (66.35.250.210): icmp\_seq=3
ttl=43 time=106 ms
64 bytes from vhost.sourceforge.net (66.35.250.210): icmp\_seq=4
ttl=43 time=106 ms
64 bytes from vhost.sourceforge.net (66.35.250.210): icmp\_seq=5
ttl=43 time=105 ms
...</tt>
</pre></div>

After it is interrupted (in this case after the sixth packet) by pressing Ctrl-c, ping
prints performance statistics. A properly performing network will exhibit zero percent
packet loss. A successful “ping” will indicate that the elements of the network (its
interface cards, cabling, routing and gateways) are in generally good working order.

traceroute

The traceroute program (some systems use the similar tracepath program
instead) displays a listing of all the “hops” network traffic takes to get
from the local system to a specified host. For example, to see the route
taken to reach slashdot.org, we would do this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ traceroute slashdot.org</tt>
</pre></div>

The output looks like this:

<div class="code"><pre>
<tt>traceroute to slashdot.org (216.34.181.45), 30 hops max, 40 byte
packets
1 ipcop.localdomain (192.168.1.1) 1.066 ms 1.366 ms 1.720 ms
2 * * *
3 ge-4-13-ur01.rockville.md.bad.comcast.net (68.87.130.9) 14.622
ms 14.885 ms 15.169 ms
4 po-30-ur02.rockville.md.bad.comcast.net (68.87.129.154) 17.634
ms 17.626 ms 17.899 ms
5 po-60-ur03.rockville.md.bad.comcast.net (68.87.129.158) 15.992
ms 15.983 ms 16.256 ms
6 po-30-ar01.howardcounty.md.bad.comcast.net (68.87.136.5) 22.835
...</tt>
</pre></div>

In the output, we can see that connecting from our test system to slashdot.org
requires traversing sixteen routers. For routers that provided identifying information, we
see their host names, IP addresses and performance data, which includes three samples of
round-trip time from the local system to the router. For routers that do not provide
identifying information (because of router configuration, network congestion, firewalls,
etc.), we see asterisks as in the line for hop number two.

netstat

The netstat program is used to examine various network settings and statistics.
Through the use of its many options, we can look at a variety of features in our network
setup. Using the “-ie” option, we can examine the network interfaces in our system:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ netstat -ie
eth0    Link encap:Ethernet HWaddr 00:1d:09:9b:99:67
        inet addr:192.168.1.2 Bcast:192.168.1.255 Mask:255.255.255.0
        inet6 addr: fe80::21d:9ff:fe9b:9967/64 Scope:Link
        UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
        RX packets:238488 errors:0 dropped:0 overruns:0 frame:0
        TX packets:403217 errors:0 dropped:0 overruns:0 carrier:0
        collisions:0 txqueuelen:100 RX bytes:153098921 (146.0 MB) TX
        bytes:261035246 (248.9 MB) Memory:fdfc0000-fdfe0000

lo      Link encap:Local Loopback
        inet addr:127.0.0.1 Mask:255.0.0.0
...</tt>
</pre></div>

In the example above, we see that our test system has two network interfaces.
The first, called eth0, is the Ethernet interface and the second, called lo,
is the loopback interface, a virtual interface that the system uses to “talk
to itself.”

When performing causal network diagnostics, the important things to look for
are the presence of the word “UP” at the beginning of the fourth line for each
interface, indicating that the network interface is enabled, and the presence
of a valid IP address in the inet addr field on the second line. For systems
using DHCP (Dynamic Host Configuration Protocol), a valid IP address in this
field will verify that the DHCP is working.

Using the “-r” option will display the kernel’s network routing table. This
shows how the network is configured to send packets from network to network:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ netstat -r
Kernel IP routing table
Destination     Gateway     Genmask         Flags    MSS  Window  irtt Iface

192.168.1.0     *           255.255.255.0   U        0    0          0 eth0
default         192.168.1.1 0.0.0.0         UG       0    0          0 eth0</tt>
</pre></div>

In this simple example, we see a typical routing table for a client machine on
a LAN (Local Area Network) behind a firewall/router. The first line of the
listing shows the destination 192.168.1.0. IP addresses that end in zero refer
to networks rather than individual hosts, so this destination means any host
on the LAN. The next field, Gateway, is the name or IP address of the gateway
(router) used to go from the current host to the destination network. An
asterisk in this field indicates that no gateway is needed.

The last line contains the destination default. This means any traffic
destined for a network that is not otherwise listed in the table. In our
example, we see that the gateway is defined as a router with the address of
192.168.1.1, which presumably knows what to do with the destination traffic.

The netstat program has many options and we have only looked at a couple.
Check out the netstat man page for a complete list.

Transporting Files Over A Network

What good is a network unless we know how to move files across it? There are many
programs that move data over networks. We will cover two of them now and several
more in later sections.

ftp

One of the true “classic” programs, ftp gets it name from the protocol it uses, the File
Transfer Protocol. FTP is used widely on the Internet for file downloads. Most, if not
all, web browsers support it and you often see URIs starting with the protocol ftp://.
Before there were web browsers, there was the ftp program. ftp is used to
communicate with FTP servers, machines that contain files that can be uploaded and
downloaded over a network.

FTP (in its original form) is not secure, because it sends account names and passwords in
cleartext. This means that they are not encrypted and anyone sniffing the network can see
them. Because of this, almost all FTP done over the Internet is done by anonymous FTP
servers. An anonymous server allows anyone to login using the login name
“anonymous” and a meaningless password.

In the example below, we show a typical session with the ftp program downloading an
Ubuntu iso image located in the /pub/cd\_images/Ubuntu-8.04 directory of the
anonymous FTP server fileserver:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ftp fileserver
Connected to fileserver.localdomain.
220 (vsFTPd 2.0.1)
Name (fileserver:me): anonymous
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> cd pub/cd\_images/Ubuntu-8.04
250 Directory successfully changed.
ftp> ls
200 PORT command successful. Consider using PASV.
150 Here comes the directory listing.
-rw-rw-r-- 1 500 500 733079552 Apr 25 03:53 ubuntu-8.04- desktop-i386.iso
226 Directory send OK.
ftp> lcd Desktop
Local directory now /home/me/Desktop
ftp> get ubuntu-8.04-desktop-i386.iso
local: ubuntu-8.04-desktop-i386.iso remote: ubuntu-8.04-desktop-
i386.iso
200 PORT command successful. Consider using PASV.
150 Opening BINARY mode data connection for ubuntu-8.04-desktop-
i386.iso (733079552 bytes).
226 File send OK.
733079552 bytes received in 68.56 secs (10441.5 kB/s)
ftp> bye
</tt>
</pre></div>

Here is an explanation of the commands entered during this session:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<tr>
<th class="title">Command</th>
<th class="title">Meaning</th>
</tr>
<tr>
<td valign="top" width="25%">ftp fileserver</td>
<td valign="top">Invoke the ftp program and have it connect to FTP server
fileserver.</td>
</tr>
<tr>
<td valign="top">anonymous</td>
<td valign="top">Login name. After the login prompt, a password prompt will
appear. Some servers will accept a blank password, others will require a
password in the form of a email address. In that case, try something like
“user@example.com”.  </td>
</tr>
<tr>
<td valign="top">cd pub/cd\_images/Ubuntu-8.04 </td>
<td valign="top">Change to the directory on the remote system containing the
desired file. Note that on most anonymous FTP servers, the files for public
downloading are found somewhere under the pub directory.  </td>
</tr>
<tr>
<td valign="top">ls</td>
<td valign="top">List the directory on the remote system.</td>
</tr>
<tr>
<td valign="top">lcd Desktop</td>
<td valign="top">Change the directory on the local system to ~/Desktop. In the
example, the ftp program was invoked when the working directory was ~. This
command changes the working directory to ~/Desktop.  </td>
</tr>
<tr>
<td valign="top">get ubuntu-8.04-desktop- i386.iso </td>
<td valign="top">Tell the remote system to transfer the file
ubuntu-8.04-desktop- i386.iso to the local system. Since the working directory
on the local system was changed to ~/Desktop, the file will be downloaded
there. </td>
</tr>
<tr>
<td valign="top">bye</td>
<td valign="top">Log off the remote server and end the ftp program session.
The commands quit and exit may also be used. </td>
</tr>
</table>
</p>

Typing “help” at the “ftp&gt;” prompt will display a list of the supported commands. Using
ftp on a server where sufficient permissions have been granted, it is possible to perform
many ordinary file management tasks. It’s clumsy, but it does work.

lftp – A Better ftp

ftp is not the only command line FTP client. In fact, there are many. One of better (and
more popular) ones is lftp by Alexander Lukyanov. It works much like the traditional
ftp program, but has many additional convenience features including multiple protocol
support (including HTTP), automatic re-try on failed downloads, background processes,
tab completion of path names, and many more.

wget

Another popular command line program for file downloading is wget. It is useful for
downloading content from both web and FTP sites. Single files, multiple files, and even
entire sites can be downloaded. To download the first page of linuxcommand.org
we could do this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ wget http://linuxcommand.org/index.php
--11:02:51-- http://linuxcommand.org/index.php
        =&gt; `index.php'
Resolving linuxcommand.org... 66.35.250.210
Connecting to linuxcommand.org|66.35.250.210|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [text/html]

  [ &lt;                        =&gt; ]        3,120       --.--K/s

11:02:51 (161.75 MB/s) - 'index.php' saved [3120]</tt>
</pre></div>

The program's many options allow wget to recursively download, download files in the
background (allowing you to log off but continue downloading), and complete the
download of a partially downloaded file. These features are well documented in its
better-than-average man page.

Secure Communication With Remote Hosts

For many years, Unix-like operating systems have had the ability to be administered
remotely via a network. In the early days, before the general adoption of the Internet,
there were a couple of popular programs used to log in to remote hosts. These were the
rlogin and telnet programs. These programs, however, suffer from the same fatal
flaw that the ftp program does; they transmit all their communications (including login
names and passwords) in cleartext. This makes them wholly inappropriate for use in the
Internet age.

ssh

To address this problem, a new protocol called SSH (Secure Shell) was developed. SSH
solves the two basic problems of secure communication with a remote host. First, it
authenticates that the remote host is who it says it is (thus preventing so-called “man in
the middle” attacks), and second, it encrypts all of the communications between the local
and remote hosts.

SSH consists of two parts. An SSH server runs on the remote host, listening for incoming
connections on port twenty-two, while an SSH client is used on the local system to
communicate with the remote server.

Most Linux distributions ship an implementation of SSH called OpenSSH from the BSD
project. Some distributions include both the client and the server packages by default
(for example, Red Hat), while others (such as Ubuntu) only supply the client. To enable a
system to receive remote connections, it must have the OpenSSH-server package
installed, configured and running, and (if the system is either running or is behind a
firewall) it must allow incoming network connections on TCP port 22.

<hr style="width:90%;height:5px;background:teal" />
Tip: If you don’t have a remote system to connect to but want to try these
examples, make sure the OpenSSH-server package is installed on your system
and use localhost as the name of the remote host. That way, your machine will
create network connections with itself.
<hr style="width:90%;height:5px;background:teal" />

The SSH client program used to connect to remote SSH servers is called, appropriately
enough, ssh. To connect to a remote host named remote-sys, we would use the ssh
client program like so:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ssh remote-sys
The authenticity of host 'remote-sys (192.168.1.4)' can't be
established.
RSA key fingerprint is
41:ed:7a:df:23:19:bf:3c:a5:17:bc:61:b3:7f:d9:bb.
Are you sure you want to continue connecting (yes/no)?</tt>
</pre></div>

The first time the connection is attempted, a message is displayed indicating that the
authenticity of the remote host cannot be established. This is because the client program
has never seen this remote host before. To accept the credentials of the remote host, enter
“yes” when prompted. Once the connection is established, the user is prompted for
his/her password:

<div class="code"><pre>
<tt>Warning: Permanently added 'remote-sys,192.168.1.4' (RSA) to the list
of known hosts.
me@remote-sys's password:</tt>
</pre></div>

After the password is successfully entered, we receive the shell prompt from the remote
system:

<div class="code"><pre>
<tt>Last login: Sat Aug 30 13:00:48 2008
[me@remote-sys ~]$</tt>
</pre></div>

The remote shell session continues until the user enters the exit command at the remote
shell prompt, thereby closing the remote connection. At this point, the local shell session
resumes and the local shell prompt reappears.

It is also possible to connect to remote systems using a different user name. For example,
if the local user “me” had an account named “bob” on a remote system, user me could log
in to the account bob on the remote system as follows:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ssh bob@remote-sys
bob@remote-sys's password:
Last login: Sat Aug 30 13:03:21 2008
[bob@remote-sys ~]$</tt>
</pre></div>

As stated before, ssh verifies the authenticity of the remote host. If the remote host does
not successfully authenticate, the following message appears:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ssh remote-sys
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@
WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle
attack)!
...</tt>
</pre></div>

This message is caused by one of two possible situations. First, an attacker may be
attempting a “man-in-the-middle” attack. This is rare, since everybody knows that ssh
alerts the user to this. The more likely culprit is that the remote system has been changed
somehow; for example, its operating system or SSH server has been reinstalled. In the
interests of security and safety however, the first possibility should not be dismissed out
of hand. Always check with the administrator of the remote system when this message
occurs.

After it has been determined that the message is due to a benign cause, it is safe to correct
the problem on the client side. This is done by using a text editor (vim perhaps) to
remove the obsolete key from the ~/.ssh/known\_hosts file. In the example
message above, we see this:

<div class="code"><pre>
<tt>Offending key in /home/me/.ssh/known\_hosts:1</tt>
</pre></div>

This means that line one of the known\_hosts file contains the offending key. Delete
this line from the file, and the ssh program will be able to accept new authentication
credentials from the remote system.

Besides opening a shell session on a remote system, ssh also allows us to execute a
single command on a remote system. For example, to execute the free command on a
remote host named remote-sys and have the results displayed on the local system:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ssh remote-sys free
me@twin4's password:
            total   used       free     shared buffers cached 

Mem:        775536  507184   268352          0  110068 154596

-/+ buffers/cache: 242520  533016
Swap: 0 1572856 0 110068 154596

[me@linuxbox ~]$</tt>
</pre></div>

It’s possible to use this technique in more interesting ways, such as this example in which
we perform an ls on the remote system and redirect the output to a file on the local
system:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ssh remote-sys 'ls \*' &gt; dirlist.txt
me@twin4's password:
[me@linuxbox ~]$</tt>
</pre></div>

Notice the use of the single quotes in the command above. This is done because we do
not want the pathname expansion performed on the local machine; rather, we want it to
be performed on the remote system. Likewise, if we had wanted the output redirected to
a file on the remote machine, we could have placed the redirection operator and the
filename within the single quotes:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ssh remote-sys 'ls * > dirlist.txt'</tt>
</pre></div>

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>Tunneling With SSH</h3>
<p>Part of what happens when you establish a connection with a remote host via SSH
is that an encrypted tunnel is created between the local and remote systems.
Normally, this tunnel is used to allow commands typed at the local system to be
transmitted safely to the remote system, and for the results to be transmitted
safely back. In addition to this basic function, the SSH protocol allows most
types of network traffic to be sent through the encrypted tunnel, creating a sort of
VPN (Virtual Private Network) between the local and remote systems.</p>

<p>Perhaps the most common use of this feature is to allow X Window system traffic
to be transmitted. On a system running an X server (that is, a machine displaying
a GUI), it is possible to launch and run an X client program (a graphical
application) on a remote system and have its display appear on the local system.
It’s easy to do, here’s an example: let’s say we are sitting at a Linux system
called linuxbox which is running an X server, and we want to run the xload
program on a remote system named remote-sys and see the program’s
graphical output on our local system. We could do this:</p>

<p> [me@linuxbox ~]$ ssh -X remote-sys</p>
<p> me@remote-sys's password:</p>
<p>Last login: Mon Sep 08 13:23:11 2008</p>
<p>[me@remote-sys ~]$ xload</p>

<p>After the xload command is executed on the remote system, its window
appears on the local system. On some systems, you may need to use the “-Y”
option rather than the “-X” option to do this.</p>
</td>
</tr>
</table>

scp And sftp

The OpenSSH package also includes two programs that can make use of an SSH
encrypted tunnel to copy files across the network. The first, scp (secure copy) is used
much like the familiar cp program to copy files. The most notable difference is that the
source or destination pathnames may be preceded with the name of a remote host,
followed by a colon character. For example, if we wanted to copy a document named
document.txt from our home directory on the remote system, remote-sys, to the
current working directory on our local system, we could do this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ scp remote-sys:document.txt .
me@remote-sys's password:
document.txt
100%        5581        5.5KB/s         00:00
[me@linuxbox ~]$</tt>
</pre></div>

As with ssh, you may apply a user name to the beginning of the remote host’s name if
the desired remote host account name does not match that of the local system:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ scp bob@remote-sys:document.txt .</tt>
</pre></div>

The second SSH file copying program is sftp which, as its name implies, is a secure
replacement for the ftp program. sftp works much like the original ftp program that
we used earlier; however, instead of transmitting everything in cleartext, it uses an SSH
encrypted tunnel. sftp has an important advantage over conventional ftp in that it
does not require an FTP server to be running on the remote host. It only requires the SSH
server. This means that any remote machine that can connect with the SSH client can
also be used as a FTP-like server. Here is a sample session:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ sftp remote-sys
Connecting to remote-sys...
me@remote-sys's password:
sftp> ls
ubuntu-8.04-desktop-i386.iso
sftp> lcd Desktop
sftp> get ubuntu-8.04-desktop-i386.iso
Fetching /home/me/ubuntu-8.04-desktop-i386.iso to ubuntu-8.04-
desktop-i386.iso
/home/me/ubuntu-8.04-desktop-i386.iso 100% 699MB 7.4MB/s 01:35
sftp> bye</tt>
</pre></div>

<hr style="width:90%;height:5px;background:teal" />
Tip: The SFTP protocol is supported by many of the graphical file managers found
in Linux distributions. Using either Nautilus (GNOME) or Konqueror (KDE), we
can enter a URI beginning with sftp:// into the location bar and operate on files
stored on a remote system running an SSH server.
<hr style="width:90%;height:5px;background:teal" />

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>An SSH Client For Windows?</h3>
<p>Let’s say you are sitting at a Windows machine but you need to log in to your
Linux server and get some real work done, what do you do? Get an SSH client
program for your Windows box, of course! There are a number of these. The
most popular one is probably PuTTY by Simon Tatham and his team. The
PuTTY program displays a terminal window and allow a Windows user to open
an SSH (or telnet) session on a remote host. The program also provides analogs
for the scp and sftp programs.</p>
<p>PuTTY is available at http://www.chiark.greenend.org.uk/~sgtatham/putty/</p>
</td>
</tr>
</table>

### Further Reading

Wikipedia contains many good networking articles. Here are some of the basics:

http://tldp.org/LDP/nag2/index.html
       
For a broad (albeit dated) look at network administration, the Linux
Documentation Project provides the Linux Network Administrator’s Guide:

http://en.wikipedia.org/wiki/Internet\_protocol\_address

http://en.wikipedia.org/wiki/Host\_name

http://en.wikipedia.org/wiki/Uniform\_Resource\_Identifier


---
layout: book
title: 存储媒介 
---
Storage Media

In previous chapters we’ve looked at manipulating data at the file level. In this chapter,
we will consider data at the device level. Linux has amazing capabilities for handling
storage devices, whether physical storage, such as hard disks, or network storage, or
virtual storage devices like RAID (Redundant Array of Independent Disks) and LVM
(Logical Volume Manager).

在前面章节中，我们已经从文件级别看了操作数据。在这章里，我们将从设备级别来考虑数据。
Linux有着令人惊奇的能力来处理存储设备，不管是物理设备，比如说硬盘，还是网络设备，或者是
虚拟存储设备，像RAID（独立磁盘冗余阵列)和LVM（逻辑卷管理器）。

However, since this is not a book about system administration, we will not try to cover
this entire topic in depth. What we will try to do is introduce some of the concepts and
key commands that are used to manage storage devices.

然而，这不是一本关于系统管理的书籍，我们不会试图深入地覆盖整个主题。我们将努力做的就是
介绍一些概念和用来管理存储设备的重要命令。

To carry out the exercises in this chapter, we will use a USB flash drive, a CD-RW disk
(for systems equipped with a CD-ROM burner) and a floppy disk (again, if the system is
so equipped.)

我们将会使用USB闪存，CD-RW光盘（因为系统配备了CD-ROM烧写器）和一张软盘（若系统这样配备），
来做这章的练习题。

We will look at the following commands:

我们将看看以下命令：

* mount – Mount a file system   挂载一个文件系统

* umount – Unmount a file system  卸载一个文件系统

* fsck – Check and repair a file system  检查和修复一个文件系统

* fdisk – Partition table manipulator  分区表控制器 

* mkfs – Create a file system  创建文件系统

* fdformat – Format a floppy disk  格式化一张软盘

* dd – Write block oriented data directly to a device

* dd — 把面向块的数据直接写入设备

* genisoimage (mkisofs) – Create an ISO 9660 image file

* genisoimage (mkisofs) – 创建一个ISO 9660的映像文件

* wodim (cdrecord) – Write data to optical storage media

* wodim (cdrecord) – 把数据写入光存储媒介

* md5sum – Calculate an MD5 checksum

* md5sum – 计算MD5检验码

Mounting And Unmounting Storage Devices

### 挂载和卸载存储设备

Recent advances in the Linux desktop have made storage device management extremely
easy for desktop users. For the most part, we attach a device to our system and it “just
works.” Back in the old days (say, 2004), this stuff had to be done manually. On non-
desktop systems (i.e., servers) this is still a largely manual procedure since servers often
have extreme storage needs and complex configuration requirements.

Linux桌面系统的最新进展已经使存储设备管理对于桌面用户来说极其容易。大多数情况下，我们
只要把设备连接到系统中，它就能工作。在过去（比如说，2004年），这个工作必须手动完成。
在非桌面系统中（例如，服务器中），这仍然是一个主要地手动过程，因为服务器经常有极端的存储需求
和复杂的配置要求。

The first step in managing a storage device is attaching the device to the file system tree.
This process, called mounting, allows the device to participate with the operating system.
As we recall from Chapter 3, Unix-like operating systems, like Linux, maintain a single
file system tree with devices attached at various points. This contrasts with other
operating systems such as MS-DOS and Windows that maintain separate trees for each
device (for example C:\, D:\, etc.).

管理存储设备的第一步是把设备连接到文件系统树中。这个过程叫做挂载，允许设备参与到操作系统中。
回想一下第三章，类似于Unix的操作系统，像Linux，维护单一文件系统树，设备连接到各个结点上。
这与其它操作系统形成对照，比如说MS-DOS和Windows系统中，每个设备（例如C:\，D:\，等）
保持着单独的文件系统树。

There is a file named /etc/fstab that lists the devices (typically hard disk partitions)
that are to be mounted at boot time. Here is an example /etc/fstab file from a
Fedora 7 system:

有一个叫做/etc/fstab的文件可以列出系统启动时要挂载的设备（典型地，硬盘分区）。下面是
来自于Fedora 7系统的/etc/fstab文件实例：

<div class="code"><pre><tt>
LABEL=/12               /               ext3        defaults        1   1
LABEL=/home             /home           ext3        defaults        1   2
LABEL=/boot             /boot           ext3        defaults        1   2
tmpfs                   /dev/shm        tmpfs       defaults        0   0
devpts                  /dev/pts        devpts      gid=5,mode=620  0   0
sysfs                   /sys            sysfs       defaults        0   0
proc                    /proc           proc        defaults        0   0
LABEL=SWAP-sda3         /swap           swap        defaults        0   0        </tt>
</pre></div>

Most of the file systems listed in this example file are virtual and are not applicable to our
discussion. For our purposes, the interesting ones are the first three:

在这个实例中所列出的大多数文件系统是虚拟的，并不适用于我们的讨论。就我们的目的而言，
前三个是我们感兴趣的：

<div class="code"><pre><tt>
LABEL=/12               /               ext3        defaults        1   1
LABEL=/home             /home           ext3        defaults        1   2
LABEL=/boot             /boot           ext3        defaults        1   2</tt>
</pre></div>

These are the hard disk partitions. Each line of the file consists of six fields, as follows:

这些是硬盘分区。每行由六个字段组成，如下所示：

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 16-1: /etc/fstab Fields</caption>
<tr>
<th class="title">Field</th>
<th class="title">Contents</th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="8%">1</td>
<td valign="top" width="8%">Device</td>
<td valign="top">Traditionally, this field contains the actual name of a
device file associated with the physical device, such as
/dev/hda1 (the first partition of the master device
on the first IDE channel). But with today's computers,
which have many devices that are hot pluggable (like
USB drives), many modern Linux distributions
associate a device with a text label instead. This label
(which is added to the storage media when it is
formatted) is read by the operating system when the
device is attached to the system. That way, no matter
which device file is assigned to the actual physical
device, it can still be correctly identified.
</td>
</tr>
<tr>
<td valign="top">2</td>
<td valign="top">Mount Point</td>
<td valign="top">The directory where the device is attached to the file
system tree.
</td>
</tr>
<tr>
<td valign="top">3</td>
<td valign="top">File System Type</td>
<td valign="top">Linux allows many file system types to be mounted.
Most native Linux file systems are ext3, but many
others are supported, such as FAT16 (msdos), FAT32
(vfat), NTFS (ntfs), CD-ROM (iso9660), etc.
</td>
</tr>
<tr>
<td valign="top">4</td>
<td valign="top">Options</td>
<td valign="top">File systems can be mounted with various options. It
is possible, for example, to mount file systems as
read-only, or prevent any programs from being
executed from them (a useful security feature for removable media.)
</td>
</tr>
<tr>
<td valign="top">5</td>
<td valign="top">Frequency</td>
<td valign="top">A single number that specifies if and when a file
system is to be backed up with the dump command.</td>
</tr>
<tr>
<td valign="top">6</td>
<td valign="top">Order</td>
<td valign="top">A single number that specifies in what order file
systems should be checked with the fsck command.</td>
</tr>
</table>
</p>

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">表16－1： /etc/fstab 字段</caption>
<tr>
<th class="title">字段</th>
<th class="title">内容</th>
<th class="title">说明</th>
</tr>
<tr>
<td valign="top" width="8%">1</td>
<td valign="top" width="8%">设备名</td>
<td valign="top">
传统上，这个字段包含与物理设备相关联的设备文件的实际名字，比如说/dev/hda1（第一个IDE
通道上第一个主设备分区）。然而今天的计算机，有很多热插拔设备（像USB驱动设备），许多
现代的Linux发行版用一个文本标签和设备相关联。当这个设备连接到系统中时，
这个标签（当储存媒介格式化时，这个标签会被添加到存储媒介中）会被操作系统读取。
那样的话，不管赋给实际物理设备哪个设备文件，这个设备仍然能被系统正确地识别。
</td>
</tr>
<tr>
<td valign="top">2</td>
<td valign="top">挂载点</td>
<td valign="top">设备所连接到的文件系统树的目录。
</td>
</tr>
<tr>
<td valign="top">3</td>
<td valign="top">文件系统类型</td>
<td valign="top">Linux允许挂载许多文件系统类型。大多数本地的Linux文件系统是ext3，
但是也支持很多其它的，比方说FAT16 (msdos), FAT32
(vfat)，NTFS (ntfs)，CD-ROM (iso9660)，等等。
</td>
</tr>
<tr>
<td valign="top">4</td>
<td valign="top">选项</td>
<td valign="top">文件系统可以通过各种各样的选项来挂载。有可能，例如，挂载只读的文件系统，
或者挂载阻止执行任何程序的文件系统（一个有用的安全特性，避免删除媒介。）</td>
</tr>
<tr>
<td valign="top">5</td>
<td valign="top">频率</td>
<td valign="top">一位数字，指定是否和在什么时间用dump命令来备份一个文件系统。</td>
</tr>
<tr>
<td valign="top">6</td>
<td valign="top">次序</td>
<td valign="top">一位数字，指定fsck命令按照什么次序来检查文件系统。</td>
</tr>
</table>
</p>

Viewing A List Of Mounted File Systems

### 查看挂载的文件系统列表

The mount command is used to mount file systems. Entering the command without
arguments will display a list of the file systems currently mounted:

这个mount命令被用来挂载文件系统。执行这个不带参数的命令，将会显示
一系列当前挂载的文件系统：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ mount
/dev/sda2 on / type ext3 (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/sda5 on /home type ext3 (rw)
/dev/sda1 on /boot type ext3 (rw)
tmpfs on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
fusectl on /sys/fs/fuse/connections type fusectl (rw)
/dev/sdd1 on /media/disk type vfat (rw,nosuid,nodev,noatime,
uhelper=hal,uid=500,utf8,shortname=lower)
twin4:/musicbox on /misc/musicbox type nfs4 (rw,addr=192.168.1.4)</tt>
</pre></div>

The format of the listing is: device on mount_point type file_system_type (options). For
example, the first line shows that device /dev/sda2 is mounted as the root file system
and it is of type ext3 and is both readable and writable (the option “rw”). This listing also
has two interesting entries at the bottom of the list. The next to last entry shows a 2
gigabyte SD memory card in a card reader mounted at /media/disk, and the last entry
is a network drive mounted at /misc/musicbox.

这个列表的格式是：设备on挂载点type文件系统类型（可选的）。例如，第一行所示设备/dev/sda2
作为根文件系统被挂载，文件系统类型是ext3，并且可读可写（这个“rw”选项）。在这个列表的底部有
两个有趣的条目。倒数第二行显示了在读卡器中的一张2G的SD内存卡，挂载到了/media/disk上。最后一行
是一个网络设备，挂载到了/misc/musicbox上。

For our first experiment, we will work with a CD-ROM. First, let's look at a system
before a CD-ROM is inserted:

第一次实验，我们将使用一张CD-ROM。首先，在插入CD-ROW之前，我们将看一下系统：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ mount
/dev/mapper/VolGroup00-LogVol00 on / type ext3 (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda1 on /boot type ext3 (rw)
tmpfs on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)</tt>
</pre></div>

This listing is from a CentOS 5 system, which is using LVM (Logical Volume Manager)
to create its root file system. Like many modern Linux distributions, this system will
attempt to automatically mount the CD-ROM after insertion. After we insert the disk, we
see the following:

这个列表来自于CentOS 5系统，使用LVM（逻辑卷管理器）来创建它的根文件系统。正如许多现在的Linux发行版一样，这个
系统试图自动挂载插入的CD-ROM。当我们插入光盘后，我们看看下面的输出：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ mount
/dev/mapper/VolGroup00-LogVol00 on / type ext3 (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda1 on /boot type ext3 (rw)
tmpfs on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
/dev/hdc on /media/live-1.0.10-8 type iso9660 (ro,noexec,nosuid,
nodev,uid=500)</tt>
</pre></div>

After we insert the disk, we see the same listing as before with one additional entry. At
the end of the listing we see that the CD-ROM (which is device /dev/hdc on this
system) has been mounted on /media/live-1.0.10-8, and is type iso9660 (a CD-
ROM). For purposes of our experiment, we're interested in the name of the device.
When you conduct this experiment yourself, the device name will most likely be
different.

当我们插入光盘后，除了额外的一行之外，我们看到和原来一样的列表。在列表的末尾，我们
看到CD-ROW已经挂载到了/media/live-1.0.10-8上，它的文件类型是iso9660（CD-ROW）。
就我们的实验目的而言，我们对这个设备的名字感兴趣。当你自己进行这个实验时，这个
设备名字是最有可能不同的。

Warning: In the examples that follow, it is vitally important that you pay close
attention to the actual device names in use on your system and do not use the
names used in this text!

警告：在随后的实例中，至关重要的是你要密切注意用在你系统中的实际设备名，并且
不要使用此文本中使用的名字！

Also note that audio CDs are not the same as CD-ROMs. Audio CDs do not
contain file systems and thus cannot be mounted in the usual sense.

还要注意音频CD和CD-ROW不一样。音频CD不包含文件系统，这样在通常意义上，它就不能被挂载了。

Now that we have the device name of the CD-ROM drive, let's unmount the disk and
remount it another location in the file system tree. To do this, we become the superuser
(using the command appropriate for our system) and unmount the disk with the umount
(notice the spelling) command:
 
现在我们拥有CD-ROW光盘的设备名字，让我们卸载这张光盘，并把它重新挂载到文件系统树
的另一个位置。我们需要超级用户身份（使用系统相应的命令）来进行操作，并且用
umount（注意这个命令的拼写）来卸载光盘：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ su -
Password:
[root@linuxbox ~]# umount /dev/hdc</tt>
</pre></div>

The next step is to create a new mount point for the disk. A mount point is simply a
directory somewhere on the file system tree. Nothing special about it. It doesn't even
have to be an empty directory, though if you mount a device on a non-empty directory,
you will not be able to see the directory's previous contents until you unmount the device.
For our purposes, we will create a new directory:

下一步是创建一个新的光盘挂载点。简单地说，一个挂载点就是文件系统树中的一个目录。它没有
什么特殊的。它甚至不必是一个空目录，即使你把设备挂载到了一个非空目录上，你也不能看到
这个目录中原来的内容，直到你卸载这个设备。就我们的目的而言，我们将创建一个新目录：

<div class="code"><pre>
<tt>[root@linuxbox ~]# mkdir /mnt/cdrom</tt>
</pre></div>

Finally, we mount the CD-ROM at the new mount point. The -t option is used to
specify the file system type:

最后，我们把这个CD-ROW挂载到一个新的挂载点上。这个-t选项用来指定文件系统类型：

<div class="code"><pre>
<tt>[root@linuxbox ~]# mount -t iso9660 /dev/hdc /mnt/cdrom</tt>
</pre></div>

Afterward, we can examine the contents of the CD-ROM via the new mount point:

之后，我们可以通过这个新挂载点来查看CD-ROW的内容：

<div class="code"><pre>
<tt>[root@linuxbox ~]# cd /mnt/cdrom
[root@linuxbox cdrom]# ls</tt>
</pre></div>

Notice what happens when we try to unmount the CD-ROM:

注意当我们试图卸载这个CD-ROW时，发生了什么事情。

<div class="code"><pre>
<tt>[root@linuxbox cdrom]# umount /dev/hdc
umount: /mnt/cdrom: device is busy</tt>
</pre></div>

Why is this? The reason is that we cannot unmount a device if the device is being used
by someone or some process. In this case, we changed our working directory to the
mount point for the CD-ROM, which causes the device to be busy. We can easily remedy
the issue by changing the working directory to something other than the mount point:

这是怎么回事呢？原因是我们不能卸载一个设备，如果某个用户或进程正在使用这个设备的话。在这种
情况下，我们把工作目录更改到了CD-ROW的挂载点，这个挂载点导致设备忙碌。我们可以很容易地修复这个问题
通过把工作目录改到其它目录而不是这个挂载点。


<div class="code"><pre>
<tt>[root@linuxbox cdrom]# cd
[root@linuxbox ~]# umount /dev/hdc</tt>
</pre></div>

Now the device unmounts successfully.

现在这个设备成功卸载了。

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>Why Unmounting Is Important</h3>

<h3>为什么卸载重要</h3>

<p> If you look at the output of the free command, which displays statistics about
memory usage, you will see a statistic called “buffers.” Computer systems are
designed to go as fast as possible. One of the impediments to system speed is
slow devices. Printers are a good example. Even the fastest printer is extremely
slow by computer standards. A computer would be very slow indeed if it had to
stop and wait for a printer to finish printing a page. In the early days of PCs
(before multi-tasking), this was a real problem. If you were working on a
spreadsheet or text document, the computer would stop and become unavailable
every time you printed. The computer would send the data to the printer as fast as
the printer could accept it, but it was very slow since printers don't print very fast.
This problem was solved by the advent of the printer buffer, a device containing
some RAM memory that would sit between the computer and the printer. With
the printer buffer in place, the computer would send the printer output to the
buffer and it would quickly be stored in the fast RAM so the computer could go
back to work without waiting. Meanwhile, the printer buffer would slowly spool
the data to the printer from the buffer's memory at the speed at which the printer
could accept it.</p>
<p>如果你看一下free命令的输出结果，free命令用来显示内存使用情况的统计信息，你
会看到一个统计值叫做”buffers“。计算机系统旨在尽可能快地运行。系统运行速度的
一个阻碍是缓慢的设备。打印机是一个很好的例子。即使最快速的打印机相比于计算机标准也
极其地缓慢。一台计算机确实会运行地非常慢，如果它要停下来等待一台打印机打印完一页。
在早期的个人电脑时代（多任务之前），这真是个问题。如果你正在编辑电子表格
或者是文本文档，每次你要打印文件时，计算机都会停下来而且变得不能使用。
计算机能以打印机可接受的最快速度把数据发送给打印机，但由于打印机不能快速地打印，
这个发送速度会非常慢。这个问题被解决了，由于打印机缓存的出现，一个包含一些RAM内存
的设备，位于计算机和打印机之间。通过打印机缓存，计算机把要打印的结果发送到这个缓存区，
数据会迅速地存储到这个RAM中，这样计算机就能回去工作，而不用等待。与此同时，打印机缓存将会
以打印机可接受的速度把缓存中的数据缓慢地输出给打印机。</p>

<p>This idea of buffering is used extensively in computers to make them faster.
Don't let the need to occasionally read or write data to/from slow devices impede
the speed of the system. Operating systems store data read from, and to be
written to storage devices in memory for as long as possible before actually
having to interact with the slower device. On a Linux system for example, you
will notice that the system seems to fill up memory the longer it is used. This
does not mean Linux is “using“ all the memory, it means that Linux is taking
advantage of all the available memory to do as much buffering as it can.
</p>

<p>缓存被广泛地应用于计算机中，使其运行地更快。别让偶尔地需要读取或写入慢设备阻碍了
系统的运行速度。在实际与慢设备交互之前，操作系统会尽可能多的读取或写入数据到内存中的
存储设备里。以Linux操作系统为例，你会注意到系统看似填充了多于它所需要的内存。
这不意味着Linux正在使用所有的内存，它意味着Linux正在利用所有可用的内存，来作为缓存区。</p>

<p> This buffering allows writing to storage devices to be done very quickly, because
the writing to the physical device is being deferred to a future time. In the
meantime, the data destined for the device is piling up in memory. From time to
time, the operating system will write this data to the physical device.
</p>
<p>这个缓存区允许非常快速地写入存储设备，因为写入物理设备的操作被延迟到后面进行。同时，
这些注定要传送到设备中的数据正在内存中堆积起来。时不时地，操作系统会把这些数据
写入物理设备。
</p>

<p>Unmounting a device entails writing all the remaining data to the device so that it
can be safely removed. If the device is removed without unmounting it first, the
possibility exists that not all the data destined for the device has been transferred.
In some cases, this data may include vital directory updates, which will lead to
file system corruption, one of the worst things that can happen on a computer.
</p>
<p>卸载一个设备需要把所有剩余的数据写入这个设备，所以设备可以被安全地移除。如果
没有卸载设备，就移除了它，就有可能没有把注定要发送到设备中的数据输送完毕。在某些情况下，
这些数据可能包含重要的目录更新信息，这将导致文件系统损坏，这是发生在计算机中的最坏的事情之一。</p>
</td>
</tr>
</table>

Determining Device Names

### 确定设备名称

It's sometimes difficult to determine the name of a device. Back in the old days, it wasn't
very hard. A device was always in the same place and it didn't change. Unix-like
systems like it that way. Back when Unix was developed, “changing a disk drive”
involved using a forklift to remove a washing machine-sized device from the computer
room. In recent years, the typical desktop hardware configuration has become quite
dynamic and Linux has evolved to become more flexible than its ancestors.
In the examples above we took advantage of the modern Linux desktop's ability to
“automagically” mount the device and then determine the name after the fact. But what
if we are managing a server or some other environment where this does not occur? How
can we figure it out?

有时很难来确定设备名称。在以前，这并不是很难。一台设备总是在某个固定的位置，也不会
挪动它。类似于Unix的系统喜欢设备那样安排。之前在开发Unix系统的时候，“更改一个磁盘驱动器”要用一辆
叉车从机房中移除一台如洗衣机大小的设备。最近几年，典型的桌面硬件配置已经变得相当动态，并且
Linux已经发展地比其祖先更加灵活。在以上事例中，我们利用现代Linux桌面系统的功能来“自动地”挂载
设备，然后再确定设备名称。但是如果我们正在管理一台服务器或者是其它一些（这种自动挂载功能）不会
发生的环境，我们又如何能查清设备名呢？

First, let's look at how the system names devices. If we list the contents of the /dev
directory (where all devices live), we can see that there are lots and lots of devices:

首先，让我们看一下系统怎样来命名设备。如果我们列出目录/dev（所有设备的住所）的内容，我们
会看到许许多多的设备：

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls /dev</tt>
</pre></div>

The contents of this listing reveal some patterns of device naming. Here are a few:

这个列表的内容揭示了一些设备命名的方式。这里有几个：



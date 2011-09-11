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

However, since this is not a book about system administration, we will not try to cover
this entire topic in depth. What we will try to do is introduce some of the concepts and
key commands that are used to manage storage devices.

To carry out the exercises in this chapter, we will use a USB flash drive, a CD-RW disk
(for systems equipped with a CD-ROM burner) and a floppy disk (again, if the system is
so equipped.)

We will look at the following commands:

* mount – Mount a file system

* umount – Unmount a file system

* fsck – Check and repair a file system

* fdisk – Partition table manipulator

* mkfs – Create a file system

* fdformat – Format a floppy disk

* dd – Write block oriented data directly to a device

* genisoimage (mkisofs) – Create an ISO 9660 image file

* wodim (cdrecord) – Write data to optical storage media

* md5sum – Calculate an MD5 checksum

Mounting And Unmounting Storage Devices

Recent advances in the Linux desktop have made storage device management extremely

easy for desktop users. For the most part, we attach a device to our system and it “just
works.” Back in the old days (say, 2004), this stuff had to be done manually. On non-
desktop systems (i.e., servers) this is still a largely manual procedure since servers often
have extreme storage needs and complex configuration requirements.

The first step in managing a storage device is attaching the device to the file system tree.
This process, called mounting, allows the device to participate with the operating system.
As we recall from Chapter 3, Unix-like operating systems, like Linux, maintain a single
file system tree with devices attached at various points. This contrasts with other
operating systems such as MS-DOS and Windows that maintain separate trees for each
device (for example C:\, D:\, etc.).

There is a file named /etc/fstab that lists the devices (typically hard disk partitions)
that are to be mounted at boot time. Here is an example /etc/fstab file from a
Fedora 7 system:

<div class="code"><pre>
<tt>LABEL=/12           /               ext3        defaults        1   1
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

<div class="code"><pre>
<tt>LABEL=/12           /               ext3        defaults        1   1
LABEL=/home             /home           ext3        defaults        1   2
LABEL=/boot             /boot           ext3        defaults        1   2</tt>
</pre></div>

These are the hard disk partitions. Each line of the file consists of six fields, as follows:

<p>
<table class="multi" cellpadding="10" border="1" width="%100">
<caption class="cap">Table 16-1: /etc/fstab Fields</caption>
<tr>
<th class="title">Field</th>
<th class="title">Contents</th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="10%">1</td>
<td valign="top">Device</td>
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
<td valign="top" width="10%">2</td>
<td valign="top">Mount Point</td>
<td valign="top">The directory where the device is attached to the file
system tree.
</td>
</tr>
<tr>
<td valign="top" width="10%">3</td>
<td valign="top">File System Type</td>
<td valign="top">Linux allows many file system types to be mounted.
Most native Linux file systems are ext3, but many
others are supported, such as FAT16 (msdos), FAT32
(vfat), NTFS (ntfs), CD-ROM (iso9660), etc.
</td>
</tr>
<tr>
<td valign="top" width="10%">4</td>
<td valign="top">Options</td>
<td valign="top">File systems can be mounted with various options. It
is possible, for example, to mount file systems as
read-only, or prevent any programs from being
executed from them (a useful security feature for removable media.)
</td>
</tr>
<tr>
<td valign="top" width="10%">5</td>
<td valign="top">Frequency</td>
<td valign="top">A single number that specifies if and when a file
system is to be backed up with the dump command.</td>
</tr>
<tr>
<td valign="top" width="10%">6</td>
<td valign="top">Order</td>
<td valign="top">A single number that specifies in what order file
systems should be checked with the fsck command.</td>
</tr>
</table>
</p>

Viewing A List Of Mounted File Systems

The mount command is used to mount file systems. Entering the command without
arguments will display a list of the file systems currently mounted:

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

For our first experiment, we will work with a CD-ROM. First, let's look at a system
before a CD-ROM is inserted:

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

Warning: In the examples that follow, it is vitally important that you pay close
attention to the actual device names in use on your system and do not use the
names used in this text!

Also note that audio CDs are not the same as CD-ROMs. Audio CDs do not
contain file systems and thus cannot be mounted in the usual sense.

Now that we have the device name of the CD-ROM drive, let's unmount the disk and
remount it another location in the file system tree. To do this, we become the superuser
(using the command appropriate for our system) and unmount the disk with the umount
(notice the spelling) command:

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

<div class="code"><pre>
<tt>[root@linuxbox ~]# mkdir /mnt/cdrom</tt>
</pre></div>

Finally, we mount the CD-ROM at the new mount point. The -t option is used to
specify the file system type:

<div class="code"><pre>
<tt>[root@linuxbox ~]# mount -t iso9660 /dev/hdc /mnt/cdrom</tt>
</pre></div>

Afterward, we can examine the contents of the CD-ROM via the new mount point:

<div class="code"><pre>
<tt>[root@linuxbox ~]# cd /mnt/cdrom
[root@linuxbox cdrom]# ls</tt>
</pre></div>

Notice what happens when we try to unmount the CD-ROM:

<div class="code"><pre>
<tt>[root@linuxbox cdrom]# umount /dev/hdc
umount: /mnt/cdrom: device is busy</tt>
</pre></div>

Why is this? The reason is that we cannot unmount a device if the device is being used
by someone or some process. In this case, we changed our working directory to the
mount point for the CD-ROM, which causes the device to be busy. We can easily remedy
the issue by changing the working directory to something other than the mount point:

<div class="code"><pre>
<tt>[root@linuxbox cdrom]# cd
[root@linuxbox ~]# umount /dev/hdc</tt>
</pre></div>

Now the device unmounts successfully.

<table class="single" cellpadding="10" width="%100">
<tr>
<td>
<h3>Why Unmounting Is Important</h3>

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

<p>This idea of buffering is used extensively in computers to make them faster.
Don't let the need to occasionally read or write data to/from slow devices impede
the speed of the system. Operating systems store data read from, and to be
written to storage devices in memory for as long as possible before actually
having to interact with the slower device. On a Linux system for example, you
will notice that the system seems to fill up memory the longer it is used. This
does not mean Linux is “using“ all the memory, it means that Linux is taking
advantage of all the available memory to do as much buffering as it can.
</p>

<p> This buffering allows writing to storage devices to be done very quickly, because
the writing to the physical device is being deferred to a future time. In the
meantime, the data destined for the device is piling up in memory. From time to
time, the operating system will write this data to the physical device.
</p>

<p>Unmounting a device entails writing all the remaining data to the device so that it
can be safely removed. If the device is removed without unmounting it first, the
possibility exists that not all the data destined for the device has been transferred.
In some cases, this data may include vital directory updates, which will lead to
file system corruption, one of the worst things that can happen on a computer.
</p>
</td>
</tr>
</table>

Determining Device Names

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

First, let's look at how the system names devices. If we list the contents of the /dev
directory (where all devices live), we can see that there are lots and lots of devices:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ ls /dev</tt>
</pre></div>

The contents of this listing reveal some patterns of device naming. Here are a few:



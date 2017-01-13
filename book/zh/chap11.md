---
layout: book-zh
title: 进程
---

通常，现在的操作系统都支持多任务，意味着操作系统（给用户）造成了一种假象，(让用户觉得)
它同时能够做多件事情，事实上，它是快速地轮换执行这些任务的。Linux 内核通过使用进程，来
管理多任务。通过进程，Linux 安排不同的程序等待使用 CPU。

有时候，计算机变得呆滞，运行缓慢，或者一个应用程序停止响应。在这一章中，我们将看一些
可用的命令行工具，这些工具帮助我们查看程序的执行状态，以及怎样终止行为不当的进程。

这一章将介绍以下命令：

* ps – 报告当前进程快照

* top – 显示任务

* jobs – 列出活跃的任务

* bg – 把一个任务放到后台执行

* fg – 把一个任务放到前台执行

* kill – 给一个进程发送信号

* killall – 杀死指定名字的进程

* shutdown – 关机或重启系统

### 进程是怎样工作的

当系统启动的时候，内核先把一些它自己的程序初始化为进程，然后运行一个叫做 init 的程序。init，
依次地，再运行一系列的称为 init 脚本的 shell 脚本（位于/etc），它们可以启动所有的系统服务。
其中许多系统服务以守护（daemon）程序的形式实现，守护程序仅在后台运行，没有任何用户接口。
这样，即使我们没有登录系统，至少系统也在忙于执行一些例行事务。

在进程方案中，一个程序可以发动另一个程序被表述为一个父进程可以产生一个子进程。

内核维护每个进程的信息，以此来保持事情有序。例如，系统分配给每个进程一个数字，这个数字叫做
进程 ID 或 PID。PID 号按升序分配，init 进程的 PID 总是1。内核也对分配给每个进程的内存进行跟踪。
像文件一样，进程也有所有者和用户 ID，有效用户 ID，等等。

### 查看进程

查看进程，最常使用地命令（有几个命令）是 ps。ps 程序有许多选项，它最简单地使用形式是这样的：

    [me@linuxbox ~]$ ps
    PID TTY           TIME CMD
    5198 pts/1    00:00:00 bash
    10129 pts/1   00:00:00 ps

上例中，列出了两个进程，进程 5198 和进程 10129，各自代表命令 bash 和 ps。正如我们所看到的，
默认情况下，ps 不会显示很多进程信息，只是列出与当前终端会话相关的进程。为了得到更多信息，
我们需要加上一些选项，但是在这样做之前，我们先看一下 ps 命令运行结果的其它字段。
TTY 是 "Teletype" 的简写，是指进程的控制终端。这里，Unix 展示它的年龄。TIME 字段表示
进程所消耗的 CPU 时间数量。正如我们所看到的，这两个进程使计算机工作起来很轻松。

如果给 ps 命令加上选项，我们可以得到更多关于系统运行状态的信息：

    [me@linuxbox ~]$ ps x
    PID TTY   STAT   TIME COMMAND
    2799 ?    Ssl    0:00 /usr/libexec/bonobo-activation-server –ac
    2820 ?    Sl     0:01 /usr/libexec/evolution-data-server-1.10 --

    and many more...

加上 "x" 选项（注意没有开头的 "-" 字符），告诉 ps 命令，展示所有进程，不管它们由什么
终端（如果有的话）控制。在 TTY 一栏中出现的 "?" ，表示没有控制终端。使用这个 "x" 选项，可以
看到我们所拥有的每个进程的信息。

因为系统中正运行着许多进程，所以 ps 命令的输出结果很长。这经常很有帮助，要是把 ps 的输出结果
管道到 less 命令，借助 less 工具，更容易浏览。一些选项组合也会产生很长的输出结果，所以最大化
终端仿真器窗口，也是一个好主意。

输出结果中，新添加了一栏，标题为 STAT 。STAT 是 "state" 的简写，它揭示了进程当前状态：

<table class="multi">
<caption class="cap">表11-1: 进程状态</caption>
<thead>
<tr>
<th class="title">状态</th>
<th class="title">意义</th>
</tr>
</thead>
<tbody>
<tr>
<td valign="top" width="15%">R</td>
<td valign="top">运行。这意味着，进程正在运行或准备运行。
</td>
</tr>
<tr>
<td valign="top">S</td>
<td valign="top">正在睡眠。 进程没有运行，而是，正在等待一个事件，
比如说，一个按键或者网络数据包。
</td>
</tr>
<tr>
<td valign="top">D</td>
<td valign="top">不可中断睡眠。进程正在等待 I/O，比方说，一个磁盘驱动器的 I/O。</td>
</tr>
<tr>
<td valign="top">T</td>
<td valign="top">已停止. 已经指示进程停止运行。稍后介绍更多。</td>
</tr>
<tr>
<td valign="top">Z</td>
<td
valign="top">一个死进程或“僵尸”进程。这是一个已经终止的子进程，但是它的父进程还没有清空它。
（父进程没有把子进程从进程表中删除）</td>
</tr>
<tr>
<td valign="top"><</td>
<td
valign="top">一个高优先级进程。这可能会授予一个进程更多重要的资源，给它更多的 CPU 时间。
进程的这种属性叫做 niceness。具有高优先级的进程据说是不好的（less nice），
因为它占用了比较多的 CPU 时间，这样就给其它进程留下很少时间。
</td>
</tr>
<tr>
<td valign="top">N</td>
<td valign="top">低优先级进程。
一个低优先级进程（一个“好”进程）只有当其它高优先级进程执行之后，才会得到处理器时间。
</td>
</tr>
</tbody>
</table>

进程状态信息之后，可能还跟随其他的字符。这表示各种外来进程的特性。详细信息请看 ps 手册页。

另一个流行的选项组合是 "aux"（不带开头的"-"字符）。这会给我们更多信息：

    [me@linuxbox ~]$ ps aux
    USER   PID  %CPU  %MEM     VSZ    RSS  TTY   STAT   START   TIME  COMMAND
    root     1   0.0   0.0    2136    644  ?     Ss     Mar05   0:31  init
    root     2   0.0   0.0       0      0  ?     S&lt;     Mar05   0:00  [kt]

    and many more...

这个选项组合，能够显示属于每个用户的进程信息。使用这个选项，可以唤醒 “BSD 风格” 的输出结果。
Linux 版本的 ps 命令，可以模拟几个不同 Unix 版本中的 ps 程序的行为。通过这些选项，我们得到
这些额外的列。

<table class="multi">
<caption class="cap">表11-2: BSD 风格的 ps 命令列标题
</caption>
<thead>
<tr>
<th class="title">标题</th>
<th class="title">意思</th>
</tr>
</thead>
<tbody>
<tr>
<td valign="top" width="15%">USER</td>
<td valign="top">用户 ID. 进程的所有者。
</td>
</tr>
<tr>
<td valign="top">%CPU</td>
<td valign="top">以百分比表示的 CPU 使用率</td>
</tr>
<tr>
<td valign="top">%MEM</td>
<td valign="top">以百分比表示的内存使用率</td>
</tr>
<tr>
<td valign="top">VSZ</td>
<td valign="top">虚拟内存大小</td>
</tr>
<tr>
<td valign="top">RSS</td>
<td valign="top">进程占用的物理内存的大小，以千字节为单位。</td>
</tr>
<tr>
<td valign="top">START</td>
<td valign="top">进程运行的起始时间。若超过24小时，则用天表示。</td>
</tr>
</tbody>
</table>

### 用 top 命令动态查看进程

虽然 ps 命令能够展示许多计算机运行状态的信息，但是它只是提供 ps 命令执行时刻的机器状态快照。
为了看到更多动态的信息，我们使用 top 命令：

    [me@linuxbox ~]$ top

top 程序连续显示系统进程更新的信息（默认情况下，每三秒钟更新一次），"top"这个名字
来源于 top 程序是用来查看系统中“顶端”进程的。top 显示结果由两部分组成：
最上面是系统概要，下面是进程列表，以 CPU 的使用率排序。

    top - 14:59:20 up 6:30, 2 users, load average: 0.07, 0.02, 0.00
    Tasks: 109 total,   1 running,  106 sleeping,    0 stopped,    2 zombie
    Cpu(s): 0.7%us, 1.0%sy, 0.0%ni, 98.3%id, 0.0%wa, 0.0%hi, 0.0%si
    Mem:   319496k total,   314860k used,   4636k free,   19392k buff
    Swap:  875500k total,   149128k used,   726372k free,  114676k cach

     PID  USER       PR   NI   VIRT   RES   SHR  S %CPU  %MEM   TIME+    COMMAND
    6244  me         39   19  31752  3124  2188  S  6.3   1.0   16:24.42 trackerd
    ....

其中系统概要包含许多有用信息。下表是对系统概要的说明：

<table class="multi">
<caption class="cap">表11-3: top 命令信息字段</caption>
<thead>
<tr>
<th class="title">行号</th>
<th class="title">字段</th>
<th class="title">意义</th>
</tr>
</thead>
<tbody>
<tr>
<td valign="top" width="10%">1</td>
<td valign="top" width="15%">top</td>
<td class="title">程序名。</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top">14:59:20</td>
<td valign="top">当前时间。
</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top">up 6:30 </td>
<td valign="top">这是正常运行时间。它是计算机从上次启动到现在所运行的时间。
在这个例子里，系统已经运行了六个半小时。  </td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top">2 users</td>
<td valign="top">有两个用户登录系统。</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top">load average: </td>
<td
valign="top">加载平均值是指，等待运行的进程数目，也就是说，处于运行状态的进程个数，
这些进程共享 CPU。展示了三个数值，每个数值对应不同的时间周期。第一个是最后60秒的平均值，
下一个是前5分钟的平均值，最后一个是前15分钟的平均值。若平均值低于1.0，则指示计算机
工作不忙碌。</td>
</tr>
<tr>
<td valign="top">2</td>
<td valign="top">Tasks:</td>
<td valign="top">总结了进程数目和各种进程状态。</td>
</tr>
<tr>
<td valign="top">3</td>
<td valign="top">Cpu(s):</td>
<td valign="top">这一行描述了 CPU 正在执行的进程的特性。</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top">0.7%us </td>
<td valign="top">0.7% of the CPU is being used for user
processes. 这意味着进程在内核之外。</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top">1.0%sy </td>
<td valign="top">1.0%的 CPU 时间被用于系统（内核）进程。
</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top">0.0%ni </td>
<td valign="top">0.0%的 CPU 时间被用于"nice"（低优先级）进程。
</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top">98.3%id </td>
<td valign="top">98.3%的 CPU 时间是空闲的。</td>
</tr>
<tr>
<td valign="top"></td>
<td valign="top">0.0%wa </td>
<td valign="top">0.0%的 CPU 时间来等待 I/O。</td>
</tr>
<tr>
<td valign="top">4</td>
<td valign="top">Mem:</td>
<td valign="top">展示物理内存的使用情况。</td>
</tr>
<tr>
<td valign="top">5</td>
<td valign="top">Swap:</td>
<td valign="top">展示交换分区（虚拟内存）的使用情况。
</td>
</tr>
</tbody>
</table>

top 程序接受一系列从键盘输入的命令。两个最有趣的命令是 h 和 q。h，显示程序的帮助屏幕，q，
退出 top 程序。

两个主要的桌面环境都提供了图形化应用程序，来显示与 top 程序相似的信息
（和 Windows 中的任务管理器差别不多），但是我觉得 top 程序要好于图形化的版本，
因为它运行速度快，并且消费很少的系统资源。毕竟，我们的系统监测程序不能成为
系统怠工的源泉，而这是我们试图追踪的信息。

### 控制进程

现在我们可以看到和监测进程，然后得到一些对它们的控制权。为了我们的实验，我们将使用
一个叫做 xlogo 的小程序，作为我们的实验品。这个 xlogo 程序是 X 窗口系统
（使图形界面显示在屏幕上的底层引擎）提供的实例程序，这个实例仅显示一个大小可调的
包含 X 标志的窗口。首先，我们需要知道测试的主题：

    [me@linuxbox ~]$ xlogo

命令执行之后，一个包含 X 标志的小窗口应该出现在屏幕的某个位置上。在一些系统中，xlogo 命令
会打印一条警告信息，但是不用理会它。

小贴士：如果你的系统不包含 xlogo 程序，试着用 gedit 或者 kwrite 来代替。

通过调整它的窗口大小，我们能够证明 xlogo 程序正在运行。如果这个标志以新的尺寸被重画，
则这个程序正在运行。

注意，为什么我们的 shell 提示符还没有返回？这是因为 shell 正在等待这个程序结束，
就像到目前为止我们用过的其它所有程序一样。如果我们关闭 xlogo 窗口，shell 提示符就返回了。

### 中断一个进程

我们再运行 xlogo 程序一次，观察一下发生了什么事。首先，执行 xlogo 命令，并且
证实这个程序正在运行。下一步，回到终端窗口，按下 Ctrl-c。

    [me@linuxbox ~]$ xlogo
    [me@linuxbox ~]$

在一个终端中，输入 Ctrl-c，中断一个程序。这意味着，我们礼貌地要求终止这个程序。
输入 Ctrl-c 之后，xlogo 窗口关闭，shell 提示符返回。

通过这个技巧，许多（但不是全部）命令行程序可以被中断。

### 把一个进程放置到后台(执行)

比方说，我们想让 shell 提示符返回，却没有终止 xlogo 程序。为达到这个目的，我们把
这个程序放到后台执行。把终端看作是一个有前台（表层放置可见的事物，像 shell 提示符）
和后台（表层之下放置隐藏的事物）（的设备）。启动一个程序，让它立即在后台
运行，我们在程序命令之后，加上"&"字符：

    [me@linuxbox ~]$ xlogo &
    [1] 28236
    [me@linuxbox ~]$

执行命令之后，这个 xlogo 窗口出现，并且 shell 提示符返回，同时打印一些有趣的数字。
这条信息是 shell 特性的一部分，叫做工作控制。通过这条信息，shell 告诉我们，已经启动了
工作号为1（“［1］”），PID 为28236的程序。如果我们运行 ps 命令，可以看到我们的进程：

    [me@linuxbox ~]$ ps
      PID TTY         TIME   CMD
    10603 pts/1   00:00:00   bash
    28236 pts/1   00:00:00   xlogo
    28239 pts/1   00:00:00   ps

工作控制，这个 shell 功能可以列出从终端中启动的任务。执行 jobs 命令，我们可以看到这个输出列表：

    [me@linuxbox ~]$ jobs
    [1]+ Running            xlogo &

结果显示我们有一个任务，编号为“1”，它正在运行，并且这个任务的命令是 xlogo ＆。

### 进程返回到前台

一个在后台运行的进程对一切来自键盘的输入都免疫，也不能用 Ctrl-c 来中断它。使用
fg 命令，让一个进程返回前台执行：

    [me@linuxbox ~]$ jobs
    [1]+ Running        xlogo &
    [me@linuxbox ~]$ fg %1
    xlogo

fg 命令之后，跟随着一个百分号和工作序号（叫做 jobspec）。如果我们只有一个后台任务，那么
jobspec 是可有可无的。输入 Ctrl-c 来终止 xlogo 程序。

### 停止一个进程

有时候，我们想要停止一个进程，而没有终止它。这样会把一个前台进程移到后台等待。
输入 Ctrl-z，可以停止一个前台进程。让我们试一下。在命令提示符下，执行 xlogo 命令，
然后输入 Ctrl-z:

    [me@linuxbox ~]$ xlogo
    [1]+ Stopped                 xlogo
    [me@linuxbox ~]$

停止 xlogo 程序之后，通过调整 xlogo 的窗口大小，我们可以证实这个程序已经停止了。
它看起来像死掉了一样。使用 fg 命令，可以恢复程序到前台运行，或者用 bg 命令把程序移到后台。

    [me@linuxbox ~]$ bg %1
    [1]+ xlogo &
    [me@linuxbox ~]$

和 fg 命令一样，如果只有一个任务的话，jobspec 参数是可选的。

因为把一个进程从前台移到后台很方便，如果我们从命令行启动一个图形界面的程序，但是
忘记把它放到后台执行，即没有在命令后加上字符"＆"，（也不用担心）。

为什么要从命令行启动一个图形界面程序呢？有两个原因。第一个，你想要启动的程序，可能
没有在窗口管理器的菜单中列出来（比方说 xlogo）。第二个，从命令行启动一个程序，
你能够看到一些错误信息，如果从窗口系统中运行程序的话，这些信息是不可见的。有时候，
一个程序不能从图形界面菜单中启动。这时候，应该从命令行中启动它。我们可能会看到
错误信息，这些信息揭示了问题所在。一些图形界面程序还有许多有意思并且有用的命令行选项。

### Signals

kill 命令被用来“杀死”程序。这样我们就可以终止需要杀死的程序。这里有一个实例：

    [me@linuxbox ~]$ xlogo &
    [1] 28401
    [me@linuxbox ~]$ kill 28401
    [1]+ Terminated               xlogo

首先，我们在后台启动 xlogo 程序。shell 打印出 jobspec 和这个后台进程的 PID。下一步，我们使用
kill 命令，并且指定我们想要终止的进程 PID。也可以用 jobspec（例如，“％1”）来代替 PID。

虽然这个命令很直接了当，但不仅仅这些。这个 kill 命令不是确切地“杀死”程序，而是给程序
发送信号。信号是操作系统与程序之间进行通信，所采用的几种方式中的一种。我们已经看到
信号，在使用 Ctrl-c 和 Ctrl-z 的过程中。当终端接受了其中一个按键组合后，它会给在前端运行
的程序发送一个信号。在使用 Ctrl-c 的情况下，会发送一个叫做 INT（中断）的信号；当使用
Ctrl-z 时，则发送一个叫做 TSTP（终端停止）的信号。程序，反过来，倾听信号的到来，当程序
接到信号之后，则做出响应。一个程序能够倾听和响应信号，这个事实允许一个程序做些事情，
比如，当程序接到一个终止信号时，它可以保存所做的工作。

### 通过 kill 命令给进程发送信号

kill 命令被用来给程序发送信号。它最常见的语法形式看起来像这样：

    kill [-signal] PID...

如果在命令行中没有指定信号，那么默认情况下，发送 TERM（终止）信号。kill 命令被经常
用来发送以下命令：

<table class="multi">
<caption class="cap">表 11-4: 常用信号</caption>
<tr>
<th class="title">编号</th>
<th class="title">名字</th>
<th class="title">含义</th>
</tr>
<tr>
<td valign="top" width="10%">1</td>
<td valign="top" width="10%">HUP</td>
<td valign="top">挂起。这是美好往昔的痕迹，那时候终端机通过电话线和调制解调器连接到
远端的计算机。这个信号被用来告诉程序，控制的终端机已经“挂起”。
通过关闭一个终端会话，可以说明这个信号的作用。发送这个信号到终端机上的前台程序，程序会终止。
<p>许多守护进程也使用这个信号，来重新初始化。这意味着，当发送这个信号到一个守护进程后，
这个进程会重新启动，并且重新读取它的配置文件。Apache 网络服务器守护进程就是一个例子。</p>
</td>
</tr>
<tr>
<td valign="top">2</td>
<td valign="top">INT</td>
<td valign="top">中断。实现和 Ctrl-c 一样的功能，由终端发送。通常，它会终止一个程序。
</td>
</tr>
<tr>
<td valign="top">9</td>
<td valign="top">KILL</td>
<td
valign="top">杀死。这个信号很特别。鉴于进程可能会选择不同的方式，来处理发送给它的
信号，其中也包含忽略信号，这样呢，从不发送 Kill 信号到目标进程。而是内核立即终止
这个进程。当一个进程以这种方式终止的时候，它没有机会去做些“清理”工作，或者是保存劳动成果。
因为这个原因，把 KILL 信号看作杀手锏，当其它终止信号失败后，再使用它。
</td>
</tr>
<tr>
<td valign="top">15</td>
<td valign="top">TERM</td>
<td valign="top">终止。这是 kill 命令发送的默认信号。如果程序仍然“活着”，可以接受信号，那么
这个信号终止。 </td>
</tr>
<tr>
<td valign="top">18</td>
<td valign="top">CONT</td>
<td valign="top">继续。在停止一段时间后，进程恢复运行。</td>
</tr>
<tr>
<td valign="top">19</td>
<td valign="top">STOP</td>
<td
valign="top">停止。这个信号导致进程停止运行，而没有终止。像 KILL 信号，它不被
发送到目标进程，因此它不能被忽略。
</td>
</tr>
</table>

让我们实验一下 kill 命令：

    [me@linuxbox ~]$ xlogo &
    [1] 13546
    [me@linuxbox ~]$ kill -1 13546
    [1]+ Hangup         xlogo

在这个例子里，我们在后台启动 xlogo 程序，然后通过 kill 命令，发送给它一个 HUP 信号。
这个 xlogo 程序终止运行，并且 shell 指示这个后台进程已经接受了一个挂起信号。在看到这条
信息之前，你可能需要多按几次 enter 键。注意，既可以用号码，也可以用名字，不过要在名字前面
加上字母“SIG”，来指定所要发送的信号。

    [me@linuxbox ~]$ xlogo &
    [1] 13546
    [me@linuxbox ~]$ kill -1 13546
    [1]+ Hangup                    xlogo

重复上面的例子，试着使用其它的信号。记住，你也可以用 jobspecs 来代替 PID。

进程，和文件一样，拥有所有者，所以为了能够通过 kill 命令来给进程发送信号，
你必须是进程的所有者（或者是超级用户）。

除了上表列出的 kill 命令最常使用的信号之外，还有一些系统频繁使用的信号。以下是其它一些常用
信号列表：

<table class="multi">
<caption class="cap">表 11-5: 其它常用信号</caption>
<tr>
<th class="title">编号</th>
<th class="title">名字</th>
<th class="title">含义</th>
</tr>
<tr>
<td valign="top" width="10%">3</td>
<td valign="top" width="10%">QUIT</td>
<td valign="top">退出</td>
</tr>
<tr>
<td valign="top">11</td>
<td valign="top">SEGV</td>
<td
valign="top">段错误。如果一个程序非法使用内存，就会发送这个信号。也就是说，
程序试图写入内存，而这个内存空间是不允许此程序写入的。</td>
</tr>
<tr>
<td valign="top">20</td>
<td valign="top">TSTP</td>
<td
valign="top">终端停止。当按下 Ctrl-z 组合键后，终端发送这个信号。不像 STOP 信号，
TSTP 信号由目标进程接收，且可能被忽略。</td>
</tr>
<tr>
<td valign="top">28</td>
<td valign="top">WINCH</td>
<td valign="top">改变窗口大小。当改变窗口大小时，系统会发送这个信号。
一些程序，像 top 和 less 程序会响应这个信号，按照新窗口的尺寸，刷新显示的内容。
</td>
</tr>
</table>

为了满足读者的好奇心，通过下面的命令可以得到一个完整的信号列表：

    [me@linuxbox ~]$ kill -l

### 通过 killall 命令给多个进程发送信号

也有可能通过 killall 命令，给匹配特定程序或用户名的多个进程发送信号。下面是 killall 命令的语法形式：

    killall [-u user] [-signal] name...

为了说明情况，我们将启动一对 xlogo 程序的实例，然后再终止它们：

    [me@linuxbox ~]$ xlogo &
    [1] 18801
    [me@linuxbox ~]$ xlogo &
    [2] 18802
    [me@linuxbox ~]$ killall xlogo
    [1]- Terminated                xlogo
    [2]+ Terminated                xlogo

记住，和 kill 命令一样，你必须拥有超级用户权限才能给不属于你的进程发送信号。

### 更多和进程相关的命令

因为监测进程是一个很重要的系统管理任务，所以有许多命令与它相关。玩玩下面几个命令：

<table class="multi">
<caption class="cap">表11-6: 其它与进程相关的命令</caption>
<tr>
<th class="title">命令名</th>
<th class="title">命令描述</th>
</tr>
<tr>
<td valign="top" width="15%">pstree </td>
<td valign="top">输出一个树型结构的进程列表，这个列表展示了进程间父/子关系。</td>
</tr>
<tr>
<td valign="top">vmstat</td>
<td valign="top">输出一个系统资源使用快照，包括内存，交换分区和磁盘 I/O。
为了看到连续的显示结果，则在命令名后加上延时的时间（以秒为单位）。例如，“vmstat 5”。
终止输出，按下 Ctrl-c 组合键。</td>
</tr>
<tr>
<td valign="top">xload</td>
<td valign="top">一个图形界面程序，可以画出系统负载的图形。</td>
</tr>
<tr>
<td valign="top">tload</td>
<td valign="top">与 xload 程序相似，但是在终端中画出图形。使用 Ctrl-c，来终止输出。</td>
</tr>
</table>

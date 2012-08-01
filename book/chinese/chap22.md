---
layout: book
title: 格式化输出 
---

    [me@linuxbox ~]$ nl distros.txt | head

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

    [me@linuxbox ~]$ sort -k 1,1 -k 2n distros.txt | sed -f distros-nl.sed | nl

            Linux Distributions Report

            Name	Ver. 	Released
            ----	---- 	--------

        1	Fedora	5       2006-03-20
        2	Fedora	6       2006-10-24
        3	Fedora	7       2007-05-31
        4	Fedora	8       2007-11-08
        5	Fedora	9       2008-05-13
        6	Fedora	10      2008-11-25
        7	SUSE	10.1 	2006-05-11
        8	SUSE	10.2 	2006-12-07
        9	SUSE	10.3 	2007-10-04
        10	SUSE	11.0 	2008-06-19
        11	Ubuntu	6.06 	2006-06-01
        12	Ubuntu	6.10 	2006-10-26
        13	Ubuntu	7.04 	2007-04-19
        14	Ubuntu	7.10 	2007-10-18
        15	Ubuntu	8.04 	2008-04-24

            End Of Report

    nl -n rz

    nl -w 3 -s ' '

    [me@linuxbox ~]$ echo "The quick brown fox jumped over the lazy dog."
    | fold -w 12
    The quick br
    own fox jump
    ed over the
    lazy dog.

    [me@linuxbox ~]$ echo "The quick brown fox jumped over the lazy dog."
    | fold -w 12 -s
    The quick
    brown fox
    jumped over
    the lazy
    dog.

    [me@linuxbox ~]$ fmt -w 50 fmt-info.txt | head
    'fmt' reads from the specified FILE arguments
    (or standard input if
    none are given), and writes to standard output.
    By default, blank lines, spaces between words,
    and indentation are
    preserved in the output; successive input lines
    with different indentation are not joined; tabs
    are expanded on input and introduced on output.

    [me@linuxbox ~]$ cat > fmt-code.txt
    # This file contains code with comments.

    # This line is a comment.
    # Followed by another comment line.
    # And another.

    This, on the other hand, is a line of code.
    And another line of code.
    And another.


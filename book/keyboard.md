---
layout: book
title: 读取键盘输入 
---

The scripts we have written so far lack a feature common in most computer programs — 
interactivity. That is, the ability of the program to interact with the user. While many
programs don’t need to be interactive, some programs benefit from being able to accept
input directly from the user. Take, for example, this script from the previous chapter:

    #!/bin/bash

    # test-integer2: evaluate the value of an integer.

    INT=-5

    if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
        if [ $INT -eq 0 ]; then
            echo "INT is zero."
        else
            if [ $INT -lt 0 ]; then
                echo "INT is negative."
            else
                echo "INT is positive."
            fi
            if [ $((INT % 2)) -eq 0 ]; then
                echo "INT is even."
            else
            echo "INT is odd."
            fi
        fi
    else
        echo "INT is not an integer." >&2
        exit 1
    fi

Each time we want to change the value of INT, we have to edit the script. It would be
much more useful if the script could ask the user for a value. In this chapter, we will
begin to look at how we can add interactivity to our programs.

### read – Read Values From Standard Input

The read builtin command is used to read a single line of standard input. This
command can be used to read keyboard input or, when redirection is employed, a line of
data from a file. The command has the following syntax:

read [-options] [variable...]

where options is one or more of the available options listed below and variable is the
name of one or more variables used to hold the input value. If no variable name is
supplied, the shell variable REPLY contains the line of data.

Basically, read assigns fields from standard input to the specified variables. If we
modify our integer evaluation script to use read, it might look like this:

    #!/bin/bash

    # read-integer: evaluate the value of an integer.

    echo -n "Please enter an integer -> "
    read int

    if [[ "$int" =~ ^-?[0-9]+$ ]]; then
        if [ $int -eq 0 ]; then
            echo "$int is zero."
        else
            if [ $int -lt 0 ]; then
                echo "$int is negative."
            else
                echo "$int is positive."
            fi
            if [ $((int % 2)) -eq 0 ]; then
                echo "$int is even."
            else
                echo "$int is odd."
            fi
        fi
    else
        echo "Input value is not an integer." >&2
        exit 1
    fi

We use echo with the -n option (which suppresses the trailing newline on output) to
display a prompt, then use read to input a value for the variable int. Running this
script results in this:

    [me@linuxbox ~]$ read-integer
    Please enter an integer -> 5
    5 is positive.
    5 is odd.


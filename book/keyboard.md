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

read can assign input to multiple variables, as shown in this script:

    #!/bin/bash

    # read-multiple: read multiple values from keyboard

    echo -n "Enter one or more values > "
    read var1 var2 var3 var4 var5

    echo "var1 = '$var1'"
    echo "var2 = '$var2'"
    echo "var3 = '$var3'"
    echo "var4 = '$var4'"
    echo "var5 = '$var5'"

In this script, we assign and display up to five values. Notice how read behaves when
given different numbers of values:

    [me@linuxbox ~]$ read-multiple
    Enter one or more values > a b c d e
    var1 = 'a'
    var2 = 'b'
    var3 = 'c'
    var4 = 'd'
    var5 = 'e'
    [me@linuxbox ~]$ read-multiple
    Enter one or more values > a
    var1 = 'a'
    var2 = ''
    var3 = ''
    var4 = ''
    var5 = ''
    [me@linuxbox ~]$ read-multiple
    Enter one or more values > a b c d e f g
    var1 = 'a'
    var2 = 'b'
    var3 = 'c'
    var4 = 'd'
    var5 = 'e f g'

If read receives fewer than the expected number, the extra variables are empty, while an
excessive amount of input results in the final variable containing all of the extra input.
If no variables are listed after the read command, a shell variable, REPLY, will be
assigned all the input:

    #!/bin/bash

    # read-single: read multiple values into default variable
    
    echo -n "Enter one or more values > "
    read

    echo "REPLY = '$REPLY'"

Running this script results in this:

    [me@linuxbox ~]$ read-single
    Enter one or more values > a b c d
    REPLY = 'a b c d'

#### Options

read supports the following options:




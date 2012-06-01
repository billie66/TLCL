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

<p>
<table class="multi" cellpadding="10" border="1" width="100%">
<caption class="cap">Table 29-1: read Options</caption>
<tr>
<th class="title">Option</th>
<th class="title">Description</th>
</tr>
<tr>
<td valign="top" width="25%">-a array </td>
<td valign="top">Assign the input to array, starting with index zero. We
will cover arrays in Chapter 36.</td>
</tr>
<tr>
<td valign="top">-d delimiter </td>
<td valign="top">The first character in the string delimiter is used to
indicate end of input, rather than a newline character.</td>
</tr>
<tr>
<td valign="top">-e</td>
<td valign="top">Use Readline to handle input. This permits input editing
in the same manner as the command line.</td>
</tr>
<tr>
<td valign="top">-n num</td>
<td valign="top">Read num characters of input, rather than an entire line.</td>
</tr>
<tr>
<td valign="top">-p prompt </td>
<td valign="top">Display a prompt for input using the string prompt.</td>
</tr>
<tr>
<td valign="top">-r</td>
<td valign="top">Raw mode. Do not interpret backslash characters as
escapes.</td>
</tr>
<tr>
<td valign="top">-s</td>
<td valign="top">Silent mode. Do not echo characters to the display as
they are typed. This is useful when inputting passwords and other confidential information.</td>
</tr>
<tr>
<td valign="top">-t seconds</td>
<td valign="top">Timeout. Terminate input after seconds. read returns a
non-zero exit status if an input times out.</td>
</tr>
<tr>
<td valign="top">-u fd</td>
<td valign="top">Use input from file descriptor fd, rather than standard
input.</td>
</tr>
</table>
</p>

Using the various options, we can do interesting things with read. For example, with
the -p option, we can provide a prompt string:

    #!/bin/bash

    # read-single: read multiple values into default variable

    read -p "Enter one or more values > "

    echo "REPLY = '$REPLY'"

With the -t and -s options we can write a script that reads “secret” input and times out
if the input is not completed in a specified time:

    #!/bin/bash

    # read-secret: input a secret pass phrase

    if read -t 10 -sp "Enter secret pass phrase > " secret_pass; then

        echo -e "\nSecret pass phrase = '$secret_pass'"
    else
        echo -e "\nInput timed out" >&2
        exit 1
    if

The script prompts the user for a secret pass phrase and waits ten seconds for input. If
the entry is not completed within the specified time, the script exits with an error. Since
the -s option is included, the characters of the pass phrase are not echoed to the display
as they are typed.

### IFS

Normally, the shell performs word splitting on the input provided to read. As we have
seen, this means that multiple words separated by one or more spaces become separate
items on the input line, and are assigned to separate variables by read. This behavior is
configured by a shell variable named IFS (for Internal Field Separator). The default
value of IFS contains a space, a tab, and a newline character, each of which will separate
items from one another.

We can adjust the value of IFS to control the separation of fields input to read. For
example, the /etc/passwd file contains lines of data that use the colon character as a
field separator. By changing the value of IFS to a single colon, we can use read to
input the contents of /etc/passwd and successfully separate fields into different
variables. Here we have a script that does just that:

    #!/bin/bash

    # read-ifs: read fields from a file

    FILE=/etc/passwd

    read -p "Enter a user name > " user_name

    file_info=$(grep "^$user_name:" $FILE)

    if [ -n "$file_info" ]; then
        IFS=":" read user pw uid gid name home shell <<< "$file_info"
        echo "User = '$user'"
        echo "UID = '$uid'"
        echo "GID = '$gid'"
        echo "Full Name = '$name'"
        echo "Home Dir. = '$home'"
        echo "Shell = '$shell'"
    else
        echo "No such user '$user_name'" >&2
        exit 1
    fi
This script prompts the user to enter the user name of an account on the system, then
displays the different fields found in the user’s record in the /etc/passwd file. The
script contains two interesting lines. The first is:

    file_info=$(grep "^$user_name:" $FILE)

This line assigns the results of a grep command to the variable __file_info__. The
regular expression used by grep assures that the user name will only match a single line
in the __/etc/passwd__ file.







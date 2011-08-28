---
layout: book
title: 自定制shell提示符 
---

14 – Customizing The Prompt

In this chapter we will look at a seemingly trivial detail — our shell prompt. This
examination will reveal some of the inner workings of the shell and the terminal emulator
program itself.

Like so many things in Linux, the shell prompt is highly configurable, and while we have
pretty much taken it for granted, the prompt is a really useful device once we learn how
to control it.

Anatomy Of A Prompt

Our default prompt looks something like this:

<div class="code"><pre>
<tt>[me@linuxbox ~]$</tt>
</pre></div>

Notice that it contains our user name, our host name and our current working directory,
but how did it get that way? Very simply, it turns out. The prompt is defined by an
environment variable named PS1 (short for “prompt string one”). We can view the
contents of PS1 with the echo command:

<div class="code"><pre>
<tt>[me@linuxbox ~]$ echo $PS1
[\u@\h \W]\$</tt>
</pre></div>

<hr />
Note: Don't worry if your results are not exactly the same as the example above.
Every Linux distribution defines the prompt string a little differently, some quite
exotically.
<hr />

From the results, we can see that PS1 contains a few of the characters we see in our
prompt such as the brackets, the at-sign, and the dollar sign, but the rest are a mystery.
The astute among us will recognize these as backslash-escaped special characters like
those we saw in Chapter 8. Here is a partial list of the characters that the shell treats
specially in the prompt string:


---
layout: book
title: 正则表达式 
---

In the next few chapters, we are going to look at tools used to manipulate text. As we
have seen, text data plays an important role on all Unix-like systems, such as Linux. But
before we can fully appreciate all of the features offered by these tools, we have to first
examine a technology that is frequently associated with the most sophisticated uses of
these tools — regular expressions.

As we have navigated the many features and facilities offered by the command line, we
have encountered some truly arcane shell features and commands, such as shell
expansion and quoting, keyboard shortcuts, and command history, not to mention the vi
editor. Regular expressions continue this “tradition” and may be (arguably) the most
arcane feature of them all. This is not to suggest that the time it takes to learn about them
is not worth the effort. Quite the contrary. A good understanding will enable us to
perform amazing feats, though their full value may not be immediately apparent.
What Are Regular Expressions?

Simply put, regular expressions are symbolic notations used to identify patterns in text.
In some ways, they resemble the shell’s wildcard method of matching file and pathnames,
but on a much grander scale. Regular expressions are supported by many command line
tools and by most programming languages to facilitate the solution of text manipulation
problems. However, to further confuse things, not all regular expressions are the same;
they vary slightly from tool to tool and from programming language to language. For our
discussion, we will limit ourselves to regular expressions as described in the POSIX
standard (which will cover most of the command line tools), as opposed to many
programming languages (most notably Perl), which use slightly larger and richer sets of
notations.


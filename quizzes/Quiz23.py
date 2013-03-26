#!/usr/bin/env python

"""
CS327e: Quiz #23 (5 pts)
"""

""" ----------------------------------------------------------------------
1. What is the output of the following?
   (4 pts)

[[2, 3, 4, 4], [2, 3, 4, 4]]
[[2, 3, 4, 4], [2, 3, 4, 4]]
[2, 5, 6, 3, 4]
[2, 5, 6, 4]
"""

a = [2, 3]
b = [a] + [a]
for v in b :
    v += [4]
print b

a = [2, 3]
b = 2 * [a]
for v in b :
    v += [4]
print b

a = [2, 3, 4]
a[1:1] = [5, 6]
print a

a = [2, 3, 4]
a[1:2] = [5, 6]
print a

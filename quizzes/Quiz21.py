#!/usr/bin/env python

"""
CS327e: Quiz #21 (5 pts)
"""

""" ----------------------------------------------------------------------
1. What is the output of the following?
   (2 pts)

[8, 10]
"""

a = [2, 3, 4]
b = [5, 6, 7]
print [x + y for x in a if x % 2 for y in b if y % 2]

""" ----------------------------------------------------------------------
2. What is the output of the following?
   (2 pts)

[5, 3]
"""

a = [2, 3, 4, 5, 6]
print a[3 : 0 : -2]

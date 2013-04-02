#!/usr/bin/env python

"""
CS327e: Quiz #25 (5 pts)
"""

""" ----------------------------------------------------------------------
1. What is the output of the following program?
   (2 pts)

[2, 3, {'a': 4}]
"""

def f (x, y, **z) :
    return [x, y, z]

d = {"a" : 4, "y" : 3}
print f(2, **d)

""" ----------------------------------------------------------------------
2. What is the output of the following function?
   (2 pts)

set([True, 'abc', 'def'])
"""

a = [True, "abc", 1, "def", "abc"]
print set(a)

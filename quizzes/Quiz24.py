#!/usr/bin/env python

"""
CS327e: Quiz #24 (5 pts)
"""

""" ----------------------------------------------------------------------
1. What is the output of the following program?
   (4 pts)

['a', 'b', [4], (5,)]
[2, 3, [4], (5,)]
[2, 3, [4], 6]
[2, 3, 6, (5,)]
"""

def f ((x, y), z = [4], t = (5,)) :
    return [x, y, z, t]

print f("ab")
print f([2, 3])
print f((2, 3), t = 6)
print f([2, 3], 6)

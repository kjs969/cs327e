#!/usr/bin/env python

"""
CS327e: Quiz #20 (5 pts)
"""

""" ----------------------------------------------------------------------
1. What is the output of the following?
   (2 pts)

2
"""

print reduce(lambda x, y : y - x, [2, 3, 4], 1)

""" ----------------------------------------------------------------------
2. Define reduce().
   (2 pts)
"""

def reduce_3 (bf, a, v) :
    for w in a :
        v = bf(v, w)
    return v

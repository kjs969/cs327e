#!/usr/bin/env python

"""
CS327e: Quiz #3 (5 pts)
"""

""" ----------------------------------------------------------------------
1. What is the output of the following?
   (2 pts)

2
[3]
"""

def f (j) :
    j += 1

def g (b) :
    b[0] += 1

i = 2
f(i)
print i

a = [2]
g(a)
print a

""" ----------------------------------------------------------------------
2. What is the output of the following?
   (2 pts)

['1', '10']
"""

s = "1 10"
t = s.split()
print t

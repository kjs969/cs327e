#!/usr/bin/env python

"""
CS327e: Quiz #19 (5 pts)
"""

""" ----------------------------------------------------------------------
1. What is the output of the following program?
   (2 pts)

[[2, 5], [3, 5], [4, 5]]
[(2,), (3,), (4,)]
"""

a = [[2], [3], [4]]
for v in a :
    v += [5]
print a

a = [(2,), (3,), (4,)]
for v in a :
    v += (5,)
print a
print

""" ----------------------------------------------------------------------
2. What is the output of the following program?
   (2 pts)

0 1 2 3 4 else
0 1 2
"""

for v in range(5) :
    print v,
else :
    print "else"

for v in range(5) :
    print v,
    if v == 2 :
        break
else :
    print "else"

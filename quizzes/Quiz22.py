#!/usr/bin/env python

"""
CS327e: Quiz #22 (5 pts)
"""

""" ----------------------------------------------------------------------
1. What is the output of the following program?
   Be clear about newlines, if any.
   (4 pts)

b ab

ab
aab

b ab
"""

import re

s = "b ab\naab 123"

m = re.search("(a*)b([^a]*)(a*)b", s) # * is zero or more
print m.group(0)
print

m = re.search("(a+)b([^a]*)(a+)b", s) # + is one or more
print m.group(0)
print

m = re.search("(a?)b([^a]*)(a?)b", s) # ? is zero or one
print m.group(0)

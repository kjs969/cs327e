#!/usr/bin/env python

"""
CS327e: Quiz #26 (5 pts)
"""

""" ----------------------------------------------------------------------
1. Define the function cross_join().
   (4 pts)
"""

students = [ \
    {"sID" : 123, "sName" : 'Amy',  "GPA" : 3.9,  "sizeHS" : 1000},
    {"sID" : 321, "sName" : 'Lori', "GPA" : None, "sizeHS" : 2500}]

colleges = [ \
    {"cName" : 'Stanford', "state" : 'CA', "enrollment" : 15000},
    {"cName" : 'MIT',      "state" : 'TX', "enrollment" : 25000}]

def cross_join (a, b) :
    return [dict(v.items() + w.items()) for v in a for w in b]

a = cross_join(students, colleges)

b = [ \
    {"sID" : 123, "sName" : 'Amy',  "GPA" : 3.9,  "sizeHS" : 1000,
     "cName" : 'Stanford', "state" : 'CA', "enrollment" : 15000},

    {"sID" : 123, "sName" : 'Amy',  "GPA" : 3.9,  "sizeHS" : 1000,
     "cName" : 'MIT', "state" : 'TX', "enrollment" : 25000},

    {"sID" : 321, "sName" : 'Lori', "GPA" : None, "sizeHS" : 2500,
     "cName" : 'Stanford', "state" : 'CA', "enrollment" : 15000},

    {"sID" : 321, "sName" : 'Lori', "GPA" : None, "sizeHS" : 2500,
     "cName" : 'MIT', "state" : 'TX', "enrollment" : 25000}]

assert a == b

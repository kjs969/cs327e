#!/usr/bin/env python

# ----------
# Closure.py
# ----------

print "Closure.py"

def closure (k, *fd) :
    k = set(k)
    x = [(set(a), set(b)) for (a, b) in fd]
    s = len(k)
    t = 0
    while s != t :
        t = s
        for (a, b) in x :
            if a <= k :
                k |= b
        s = len(k)
    return k

assert                       \
    closure(                 \
        ("A", "B"),          \
        (("A", "B"), ("C")), \
        (("A", "E"), ("D")), \
        (("D"),      ("B"))) \
    ==                       \
    set(["A", "B", "C"])

assert                       \
    closure(                 \
        ("A", "C"),          \
        (("A", "B"), ("C")), \
        (("A", "E"), ("D")), \
        (("D"),      ("B"))) \
    ==                       \
    set(["A", "C"])

assert                       \
    closure(                 \
        ("A", "D"),          \
        (("A", "B"), ("C")), \
        (("A", "E"), ("D")), \
        (("D"),      ("B"))) \
    ==                       \
    set(["A", "B", "C", "D"])

assert                       \
    closure(                 \
        ("A", "E"),          \
        (("A", "B"), ("C")), \
        (("A", "E"), ("D")), \
        (("D"),      ("B"))) \
    ==                       \
    set(["A", "B", "C", "D", "E"])

print "Done."

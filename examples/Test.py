#!/usr/bin/env python

"""
OOPL JPL: Quiz #5
"""

""" ----------------------------------------------------------------------
1. Define MyPriorityQueue such that it emulates Queue.PriorityQueue.
"""

from Queue import PriorityQueue

class PriorityQueue_1 (object) :
    def __init__ (self) :
        self.a = []

    def empty (self) :
        return self.qsize() == 0

    def get (self) :
        v = min(self.a)
        self.a.remove(v)
        return v

    def put (self, v) :
        self.a.append(v)

    def qsize (self) :
        return len(self.a)

class PriorityQueue_2 (object) :
    def __init__ (self) :
        self.a = []

    def empty (self) :
        return self.qsize() == 0

    def get (self) :
        return self.a.pop()

    def put (self, v) :
        i = len(self.a) - 1
        self.a.append(None)
        while self.a[i] <= v :
            pass
        self.a[i + 1] = v

    def qsize (self) :
        return len(self.a)

def test_priority_queue (c) :
    x = c()
    assert x.qsize() == 0
    assert x.empty()

    x.put(2)
    x.put(1)
    x.put(4)
    x.put(3)
    assert x.qsize() == 4
    assert not x.empty()

    v = x.get()
    assert v         == 1
    assert x.qsize() == 3
    assert not x.empty()

test_priority_queue(PriorityQueue_1)
test_priority_queue(PriorityQueue_2)
test_priority_queue(PriorityQueue)

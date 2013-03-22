#!/usr/bin/env python

# ---------
# Insert.py
# ---------

import Login
import Query

print "Insert.py"
print

c = Login.login()

t = Query.query(c, "drop table if exists dept;")
assert t is None

t = Query.query(
        c,
        """
        create table dept (
                department  int,
                name        text,
                location    text,
                budget      int,
                primary key (department))
            engine = innodb;
        """)
assert t is None

try :
    t = Query.query(
            c,
            """
            insert into dept values (10, "Research", "New York", 1500000);
            """)
    assert t is None
except Exception, e :
    assert False

try :
    t = Query.query(
            c,
            """
            insert into dept values (10, "Research", "New York", 1500000)
            """)
    assert False
except Exception, e :
    print e
    print

print "Done."

"""
Insert.py

(1062, "Duplicate entry '10' for key 'PRIMARY'")

Done.
"""

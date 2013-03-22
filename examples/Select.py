#!/usr/bin/env python

# ---------
# Select.py
# ---------

import Login
import Query

print "Select.py"
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

t = Query.query(
        c,
        """
        insert into dept values (10, "Research",  "New York", 1500000);
        """)
assert t is None

t = Query.query(
        c,
        """
        insert into dept values (15, "Computing", "Miami", 1200000);
        """)
assert t is None

t = Query.query(c, "select * from dept;")
print t
print

print "Done."

"""
Select.py

(('10', 'Research',  'New York', '1500000'),
 ('15', 'Computing', 'Miami',    '1200000'))

Done.
"""

#!/usr/bin/env python

# ---------
# Create.py
# ---------

import Login
import Query

print "Create.py"

c = Login.login()
assert str(type(c)) == "<type '_mysql.connection'>"

t = Query.query(c, "drop table if exists Student;")
assert t is None
t = Query.query(c, "drop table if exists Apply;")
assert t is None
t = Query.query(c, "drop table if exists College;")
assert t is None

t = Query.query(
        c,
        """
        create table Student (
            sID    int,
            sName  text,
            GPA    float,
            sizeHS int);
        """)
assert t is None
t = Query.query(
        c,
        """
        create table Apply (
            sID      int,
            cName    text,
            major    text,
            decision boolean);
        """)
assert t is None
t = Query.query(
        c,
        """
        create table College (
            cName      text,
            state      char(2),
            enrollment int);
        """)
assert t is None

try :
    t = Query.query(
            c,
            """
            create table Student (
                sID    int,
                sName  text,
                GPA    float,
                sizeHS int);
            """)
    assert False
except Exception, e :
    assert type(e.args) is     tuple
    assert len(e.args)  is     2
    assert e.args       is not (1050, "Table 'Student' already exists")
    assert e.args       ==     (1050, "Table 'Student' already exists")

print "Done."

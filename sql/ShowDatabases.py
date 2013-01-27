#!/usr/bin/env python

# ----------------
# ShowDatabases.py
# ----------------

import Login
import Query

print "ShowDatabases.py"
print

c = Login.login()
t = Query.query(c, "show databases")
print t
print

print "Done."

"""
ShowDatabases.py

(('information_schema',),
 ('downing',),
 ('downing_cs327e',),
 ('downing_cs370',),
 ('downing_cs371p',),
 ('downing_cs373',),
 ('downing_cs378',),
 ('downing_dml',),
 ('downing_test',),
 ('drupal_dml',))

Done.
"""

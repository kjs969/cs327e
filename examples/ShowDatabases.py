#!/usr/bin/env python

# ----------------
# ShowDatabases.py
# ----------------

import Login
import Query

print "ShowDatabases.py"

c = Login.login()
t = Query.query(c, "show databases")
assert t == \
    (('information_schema',), \
     ('downing',), \
     ('downing_cs327e',), \
     ('downing_cs370',), \
     ('downing_cs371p',), \
     ('downing_cs373',), \
     ('downing_cs378',), \
     ('downing_dml',), \
     ('downing_test',), \
     ('drupal_dml',))

print "Done."

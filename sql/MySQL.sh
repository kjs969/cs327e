#!/usr/bin/env sh

mysql -h z -u downing -p<password> -v -H < ShowDatabases.sql > ShowDatabases.html

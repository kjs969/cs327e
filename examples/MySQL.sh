#!/usr/bin/env sh

mysql -h z -u <username> -p<password> -v -H < ShowDatabases.sql > ShowDatabases.html

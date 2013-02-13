#!/usr/bin/env sh

mysql -Version
# mysql  Ver 14.14 Distrib 5.1.67, for debian-linux-gnu (i486) using readline 6.1

mysql -h z -u <username> -p<password> -v -H < ShowDatabases.sql > ShowDatabases.html

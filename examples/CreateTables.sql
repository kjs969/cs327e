use downing_test;

# ----
# drop
# ----

drop table if exists College;
drop table if exists Student;
drop table if exists Apply;

# ------
# create
# ------

create table Student (
	sID    int,
	sName  text,
	GPA    float,
	sizeHS int);

create table Apply (
	sID      int,
	cName    text,
	major    text,
	decision boolean);

create table College (
	cName      text,
	state      char(2),
	enrollment int);

# ----
# show
# ----

show tables;
show columns from Student;
show columns from Apply;
show columns from College;

exit

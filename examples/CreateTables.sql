use downing_test;

# drop

drop table if exists college;
drop table if exists student;

# create

create table student (
    id    int,
    sname text,
    gpa   float,
    photo blob);

create table college (
    cname text,
    state char(2),
    enr   int);

# show

show tables;
show columns from student;
show columns from college;

# drop

drop table student;
drop table college;

exit

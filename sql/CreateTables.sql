use downing_test;

create table student (
    id    int,
    sname text,
    gpa   float,
    photo blob);

create table college (
    cname text,
    state char(2),
    enr   int);

show tables;
show columns from student;
show columns from college;

drop table student;
drop table college;

exit

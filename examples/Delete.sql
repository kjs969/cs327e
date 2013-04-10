use downing_test;

/* -----------------------------------------------------------------------
Drop
*/

drop table if exists Student;
drop table if exists Apply;
drop table if exists College;

/* -----------------------------------------------------------------------
Create
*/

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

/* -----------------------------------------------------------------------
Insert
*/

insert into Student values (123, 'Amy',    3.9,  1000);
insert into Student values (234, 'Bob',    3.6,  1500);
insert into Student values (320, 'Lori',   null, 2500);
insert into Student values (345, 'Craig',  3.5,   500);
insert into Student values (432, 'Kevin',  null, 1500);
insert into Student values (456, 'Doris',  3.9,  1000);
insert into Student values (543, 'Craig',  3.4,  2000);
insert into Student values (567, 'Edward', 2.9,  2000);
insert into Student values (654, 'Amy',    3.9,  1000);
insert into Student values (678, 'Fay',    3.8,   200);
insert into Student values (765, 'Jay',    2.9,  1500);
insert into Student values (789, 'Gary',   3.4,   800);
insert into Student values (876, 'Irene',  3.9,   400);
insert into Student values (987, 'Helen',  3.7,   800);

insert into Apply values (123, 'Berkeley', 'CS',             true);
insert into Apply values (123, 'Cornell',  'EE',             true);
insert into Apply values (123, 'Stanford', 'CS',             true);
insert into Apply values (123, 'Stanford', 'EE',             false);
insert into Apply values (234, 'Berkeley', 'biology',        false);
insert into Apply values (321, 'MIT',      'history',        false);
insert into Apply values (321, 'MIT',      'psychology',     true);
insert into Apply values (345, 'Cornell',  'bioengineering', false);
insert into Apply values (345, 'Cornell',  'CS',             true);
insert into Apply values (345, 'Cornell',  'EE',             false);
insert into Apply values (345, 'MIT',      'bioengineering', true);
insert into Apply values (543, 'MIT',       'CS',            false);
insert into Apply values (678, 'Stanford', 'history',        true);
insert into Apply values (765, 'Cornell',  'history',        false);
insert into Apply values (765, 'Cornell',  'psychology',     true);
insert into Apply values (765, 'Stanford', 'history',        true);
insert into Apply values (876, 'MIT',      'biology',        true);
insert into Apply values (876, 'MIT',      'marine biology', false);
insert into Apply values (876, 'Stanford', 'CS',             false);
insert into Apply values (987, 'Berkeley', 'CS',             true);
insert into Apply values (987, 'Stanford', 'CS',             true);

insert into College values ('Berkeley', 'CA', 36000);
insert into College values ('Cornell',  'NY', 21000);
insert into College values ('Irene',    'TX', 25000);
insert into College values ('MIT',      'MA', 10000);
insert into College values ('Stanford', 'CA', 15000);

/* -----------------------------------------------------------------------
students who applied to two majors
*/

select sID, count(distinct major)
    from Apply
    group by sID
    having count(distinct major) > 2;

/* -----------------------------------------------------------------------
delete those students from Student
*/

select count(*)
    from Student
    order by sID;

select *
    from Student
    order by sID;

delete
    from Student
    where sID in
        (select sID
            from Apply
            group by sID
            having count(distinct major) > 2);

select count(*)
    from Student
    order by sID;

select *
    from Student
    order by sID;

/* -----------------------------------------------------------------------
delete those students from Apply
*/

# this does not work in MySQL
# can not delete from a relation that is in a subquery

# delete
#     from Apply
#     where sID in
#         (select sID
#             from Apply
#             group by sID
#             having count(distinct major) > 2);

# create temporary table first

create temporary table T as
    select sID
        from Apply
        group by sID
        having count(distinct major) > 2;
select count(*)
    from T;
select *
    from T;
select count(*)
    from Apply
    where sID in
        (select *
            from T);
select *
    from Apply
    where sID in
        (select *
            from T);

select count(*)
    from Apply
    order by sID;

select *
    from Apply
    order by sID;

# this does work

delete
    from Apply
    where sID in
        (select *
            from T);

select count(*)
    from Apply
    order by sID;

select *
    from Apply
    order by sID;

/* -----------------------------------------------------------------------
colleges without CS applications
*/

select count(*)
    from College
    where cName not in
        (select cName
            from Apply
            where major = 'CS');

select *
    from College
    where cName not in
        (select cName
            from Apply
            where major = 'CS');

/* -----------------------------------------------------------------------
delete those colleges from College
*/

select count(*)
    from College
    order by cName;

select *
    from College
    order by cName;

delete
    from College
    where cName not in
        (select cName
            from Apply
            where major = 'CS');

select count(*)
    from College
    order by cName;

select *
    from College
    order by cName;

/* -----------------------------------------------------------------------
Drop
*/

drop table if exists College;
drop table if exists Student;
drop table if exists Apply;

exit

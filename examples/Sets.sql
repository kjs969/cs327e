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
set union
names of students OR colleges

project[sName]
    (Student)
union
project[cName]
    (College)
*/

# this is not right
# because the attribute name is misleading

select sName from Student
union
select cName from College
order by sName;

# this is right

select sName as name from Student
union
select cName as name from College
order by name;

/* -----------------------------------------------------------------------
set intersection
names of students AND colleges

project[sName]
    (Student)
intersect
project[cName]
    (College)
*/

# mysql does not support intersect

# using join

select *
    from
        (select sName as name from Student) as R
        natural join
        (select cName as name from College) as S;

# using a subquery, with in

select sName as name
    from Student
    where sName in
        (select cName
            from College);

# using a subquery, with exists

select sName as name
    from Student
    where exists
        (select *
            from College
            where sName = cName);

/* -----------------------------------------------------------------------
set difference
ID of students who did not apply anywhere

project[sID]
    (Student)
diff
project[sID]
    (Apply)
*/

# mysql does not support except

# using a subquery, with not in

select sID
    from Student
    where sID not in
        (select sID
            from Apply)
    order by sID;

# using a subquery, with not exists

select sID
    from Student
    where not exists
        (select *
            from Apply
            where Student.sID = Apply.sID)
    order by sID;

/* -----------------------------------------------------------------------
pairs of names of colleges in the same state

project[cName1, cName2]
    (select[cName1 != cName2]
        rename[cName1, state, enrollment1]
            (College);
        join
        rename[cName2, state, enrollment2]
            (College);
*/

# this is not right
# because of duplicates

select cName1, cName2
    from
        (select cName as cName1, state, enrollment as enrollment1
            from College) as R
        natural join
        (select cName as cName2, state, enrollment as enrollment2
            from College) as S
    where cName1 != cName2;

# this is right

select cName1, cName2
    from
        (select cName as cName1, state, enrollment as enrollment1
            from College) as R
        natural join
        (select cName as cName2, state, enrollment as enrollment2
            from College) as S
    where cName1 < cName2;

/* -----------------------------------------------------------------------
set union
colleges with (enrollments < 20000) AND (Amy OR Irene) applied to

project[cName](
    select[(sName = 'Amy') and (enrollment < 20000)]
        (Student join Apply join College))
union
project[cName](
    select[(sName = 'Irene') and (enrollment < 20000)]
        (Student join Apply join College))
*/

select *
    from Student natural join Apply natural join College
    where (sName = 'Amy') and (enrollment < 20000)
union
select *
    from Student natural join Apply natural join College
    where (sName = 'Irene') and (enrollment < 20000)
order by cName;

select cName
    from Student natural join Apply natural join College
    where (sName = 'Amy') and (enrollment < 20000)
union
select cName
    from Student natural join Apply natural join College
    where (sName = 'Irene') and (enrollment < 20000)
order by cName;

# just using join

select *
    from Student natural join Apply natural join College
    where ((sName = 'Amy') or (sName = 'Irene')) and (enrollment < 20000)
    order by cName;

select distinct cName
    from Student natural join Apply natural join College
    where ((sName = 'Amy') or (sName = 'Irene')) and (enrollment < 20000)
    order by cName;

/* -----------------------------------------------------------------------
set intersection
colleges with (enrollments < 20000) AND (Amy AND Irene) applied to

project[cName](
    select[(sName = 'Amy') and (enrollment < 20000)]
        (Student join Apply join College))
intersect
project[cName](
    select[(sName = 'Irene') and (enrollment < 20000)]
        (Student join Apply join College))
*/

# using join

select *
    from
        (select distinct cName from
            Student natural join Apply natural join College
            where (sName = 'Amy') and (enrollment < 20000)) as R
        natural join
        (select distinct cName from
            Student natural join Apply natural join College
            where (sName = 'Irene') and (enrollment < 20000)) as S;

# using a subquery, with in

select *
    from
        (select distinct cName from
            Student natural join Apply natural join College
            where (sName = 'Amy') and (enrollment < 20000)) as R
    where cName in
        (select cName
            from Student natural join Apply natural join College
            where (sName = 'Irene') and (enrollment < 20000));

# using a subquery, with exists

select *
    from
        (select distinct cName from
            Student natural join Apply natural join College
            where (sName = 'Amy') and (enrollment < 20000)) as R
    where exists
        (select *
            from Student natural join Apply natural join College
            where (sName = 'Irene') and (enrollment < 20000) and (R.cName = cName));

/* -----------------------------------------------------------------------
Drop
*/

drop table if exists Student;
drop table if exists Apply;
drop table if exists College;

exit

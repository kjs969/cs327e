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
name and major of students
*/

select distinct sName, major
    from Student, Apply
    where Student.sID = Apply.sID
    order by sName;

select distinct sName, major
    from Student inner join Apply
    on Student.sID = Apply.sID
    order by sName;

select distinct sName, major
    from Student join Apply
    on Student.sID = Apply.sID
    order by sName;

select distinct sName, major
    from Student natural join Apply
    order by sName;

select distinct sName, major
    from Student join Apply
    using (sID)
    order by sName;

/* -----------------------------------------------------------------------
name and GPA of students with high school size less than 1000 and who
applied to Stanford in CS
*/

select sName, GPA
    from Student, Apply
    where
        (Student.sID = Apply.sID)   and
        (sizeHS      < 1000)        and
        (major       = 'CS')        and
        (cName       = 'Stanford');

select sName, GPA
    from Student inner join Apply
    on Student.sID = Apply.sID
    where
        (sizeHS < 1000)        and
        (major  = 'CS')        and
        (cName  = 'Stanford');

select sName, GPA
    from Student join Apply
    on Student.sID = Apply.sID
    where
        (sizeHS < 1000)        and
        (major  = 'CS')        and
        (cName  = 'Stanford');

select sName, GPA
    from Student natural join Apply
    where
        (sizeHS < 1000)        and
        (major  = 'CS')        and
        (cName  = 'Stanford');

select sName, GPA
    from Student inner join Apply
    using (sID)
    where
        (sizeHS < 1000)        and
        (major  = 'CS')        and
        (cName  = 'Stanford');

/* -----------------------------------------------------------------------
ID, name, GPA, college, and enrollment of all applications
*/

select Student.sID, sName, GPA, Apply.cName, enrollment
    from Student, Apply, College
    where (Student.sID = Apply.sID) and (Apply.cName = College.cName)
    order by Student.sID;

select Student.sID, sName, GPA, Apply.cName, enrollment
    from Student inner join Apply inner join College
    on (Student.sID = Apply.sID) and (Apply.cName = College.cName)
    order by Student.sID;

select Student.sID, sName, GPA, Apply.cName, enrollment
    from Student join Apply join College
    on (Student.sID = Apply.sID) and (Apply.cName = College.cName)
    order by Student.sID;

select sID, sName, GPA, cName, enrollment
    from Student natural join Apply natural join College
    order by sID;

select sID, sName, GPA, cName, enrollment
    from Student
        inner join Apply   using (sID)
        inner join College using (cName)
    order by sID;

/* -----------------------------------------------------------------------
ID, name, and GPA of pairs of students with the same GPA
*/

select R.sID, R.sName, R.GPA, S.sID, S.sName, S.GPA
    from Student as R, Student as S
    where (R.GPA = S.GPA) and (R.sID < S.sID)
    order by R.sID;

select R.sID, R.sName, R.GPA, S.sID, S.sName, S.GPA
    from Student as R inner join Student as S
    on (R.GPA = S.GPA) and (R.sID < S.sID)
    order by R.sID;

select R.sID, R.sName, R.GPA, S.sID, S.sName, S.GPA
    from Student as R join Student as S
    on (R.GPA = S.GPA) and (R.sID < S.sID)
    order by R.sID;

select sID1 as sID, sName1 as sName, GPA, sID2 as sID, sName2 as sName, GPA
    from
    (select sID as sID1, sName as sName1, GPA, sizeHS as sizeHS1
        from Student) as R
    natural join
    (select sID as sID2, sName as sName2, GPA, sizeHS as sizeHS2
        from Student) as S
    where (sID1 < sID2)
    order by sID1;

select R.sID, R.sName, R.GPA, S.sID, S.sName, S.GPA
    from Student as R inner join Student as S
    using (GPA)
    where (R.sID < S.sID)
    order by R.sID;

/* -----------------------------------------------------------------------
name, ID, college, and major of students who applied
*/

select sID, sName, cName, major
    from Student inner join Apply
    using (sID)
    order by sID;

/* -----------------------------------------------------------------------
name, ID, college, and major of students who applied or not
*/

select sID, sName, cName, major
    from Student left outer join Apply
    using (sID)
    order by sID;

select sID, sName, cName, major
    from Student left join Apply
    using (sID)
    order by sID;

select sID, sName, cName, major
    from Student natural left outer join Apply
    order by sID;

select sID, sName, cName, major
    from Student inner join Apply
    using (sID)
union
select sID, sName, null, null
    from Student
    where sID not in
        (select sID from Apply)
order by sID;

/* -----------------------------------------------------------------------
name, ID, college, and major of applications who are students or not
*/

select sID, sName, cName, major
    from Apply left join Student
    using (sID)
    order by sID;

select sID, sName, cName, major
    from Student right join Apply
    using (sID)
    order by sID;

/* -----------------------------------------------------------------------
name, ID, college, and major of students or not and applications or not
*/

# mysql does not support intersect

# select sID, sName, cName, major
#     from Student full outer join Apply
#     using (sID)
#     order by sID;

select sID, sName, cName, major
    from Student left join Apply
    using (sID)
union
select sID, sName, cName, major
    from Student right join Apply
    using (sID)
order by sID;

select sID, sName, cName, major
    from Student inner join Apply
    using (sID)
union
select sID, sName, null, null
    from Student
    where sID not in
        (select sID from Apply)
union
select sID, null, cName, major
    from Apply
    where sID not in
        (select sID from Student)
order by sID;

/* -----------------------------------------------------------------------
Drop
*/

drop table if exists Student;
drop table if exists Apply;
drop table if exists College;

exit

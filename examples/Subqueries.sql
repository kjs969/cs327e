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
ID, name, and GPA of students who applied in CS

project[sID, sName, GPA]
    (select[major = 'CS']
        (Student join Apply))
*/

select *
    from Student natural join Apply
    where major = 'CS'
    order by sID;

# this is not right
# because of duplicates

select sID, sName, GPA
    from Student natural join Apply
    where major = 'CS'
    order by sID;

# this is right

select distinct sID, sName, GPA
    from Student natural join Apply
    where major = 'CS'
    order by sID;

# using subquery, with in

select sID, sName, GPA
    from Student
    where sID in (
        select sID
            from Apply
            where major = 'CS')
    order by sID;

/* -----------------------------------------------------------------------
GPA of students who applied in CS

project[GPA]
    (Student
     diff
     select[major = 'CS']
         (Student))
*/

# this is not right
# because of duplicates

select GPA
    from Student natural join Apply
    where major = 'CS'
    order by GPA desc;

# this is not right either
# because it does not remove duplicates in the right way

select distinct GPA
    from Student natural join Apply
    where major = 'CS'
    order by GPA desc;

# this is right
# using subquery, with in

select GPA
    from Student
    where sID in (
        select sID
            from Apply
            where major = 'CS')
    order by GPA desc;

# this is also right, but cumbersome

# using derived tables

select GPA
    from
        (select distinct sID, GPA
            from Student natural join Apply
            where major = 'CS') as T
    order by GPA desc;

# using temporary tables

create temporary table T as
    select distinct sID, GPA
        from Student natural join Apply
        where major = 'CS';
select GPA
    from T
    order by GPA desc;

/* -----------------------------------------------------------------------
ID of students who have applied to major in CS but not in EE

project[sID]
    (select[major  = 'CS']
        (Student))
diff
project[sID]
    (select[major != 'EE']
        (Student))
*/

# this is not right
# because students may be majoring CS in more than one place

select distinct R.sID
    from Apply as R inner join Apply as S
    where R.sID    = S.sID and
          R.major  = 'CS'  and
          S.major != 'EE';

# this is right
# using subquery, with in and not in

select sID
    from Student
    where
        sID in
            (select sID
                from Apply
                where major = 'CS')
        and
        sID not in
            (select sID
                from Apply
                where major = 'EE');

/* -----------------------------------------------------------------------
colleges, such that there's another college in the same state
*/

# using as
# using subquery, with exists

# this is not right
# because a college is in the same state as itself

select cName, state
    from College as R
    where exists
        (select *
            from College as S
            where R.state = S.state);

# this is right

select cName, state
    from College as R
    where exists
        (select *
            from College as S
            where (R.state = S.state) and (R.cName != S.cName));

/* -----------------------------------------------------------------------
college with highest enrollment
*/

# using subquery, with not exists

select cName
    from College as R
    where not exists
        (select *
            from College as S
            where R.enrollment < S.enrollment);

# using subquery, with all

select cName
    from College
    where enrollment >= all
        (select enrollment
            from College);

/* -----------------------------------------------------------------------
student with highest GPA
*/

# using subquery, with not exists

# this is not right
# because of nulls

select sID, sName, GPA
    from Student as R
    where not exists
        (select *
            from Student as S
            where R.GPA < S.GPA)
    order by sID;

# this is right

select sID, sName, GPA
    from Student as R
    where
        not exists
            (select *
                from Student as S
                where R.GPA < S.GPA)
        and
        (GPA is not null)
    order by sID;

# using subquery, with all

select sID, sName, GPA
    from Student
    where GPA >= all
        (select GPA
            from Student)
    order by sID;

/* -----------------------------------------------------------------------
Drop
*/

drop table if exists Student;
drop table if exists Apply;
drop table if exists College;

exit

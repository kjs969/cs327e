use downing_test;

# drop

drop table if exists College;
drop table if exists Student;
drop table if exists Apply;

# create

create table College (
	cName      text,
	state      char(2),
	enrollment int);

create table Student (
	sId    int,
	sName  text,
	GPA    float,
	sizeHS int);

create table Apply (
	sId      int,
	cName    text,
	major    text,
	decision boolean);

# insert

insert into Student values (123, 'Amy', 3.9, 1000);
insert into Student values (234, 'Bob', 3.6, 1500);
insert into Student values (345, 'Craig', 3.5, 500);
insert into Student values (456, 'Doris', 3.9, 1000);
insert into Student values (567, 'Edward', 2.9, 2000);
insert into Student values (678, 'Fay', 3.8, 200);
insert into Student values (789, 'Gary', 3.4, 800);
insert into Student values (987, 'Helen', 3.7, 800);
insert into Student values (876, 'Irene', 3.9, 400);
insert into Student values (765, 'Jay', 2.9, 1500);
insert into Student values (654, 'Amy', 3.9, 1000);
insert into Student values (543, 'Craig', 3.4, 2000);

insert into College values ('Stanford', 'CA', 15000);
insert into College values ('Berkeley', 'CA', 36000);
insert into College values ('MIT', 'MA', 10000);
insert into College values ('Cornell', 'NY', 21000);

insert into Apply values (123, 'Stanford', 'CS', true);
insert into Apply values (123, 'Stanford', 'EE', false);
insert into Apply values (123, 'Berkeley', 'CS', true);
insert into Apply values (123, 'Cornell', 'EE', true);
insert into Apply values (234, 'Berkeley', 'biology', false);
insert into Apply values (345, 'MIT', 'bioengineering', true);
insert into Apply values (345, 'Cornell', 'bioengineering', false);
insert into Apply values (345, 'Cornell', 'CS', true);
insert into Apply values (345, 'Cornell', 'EE', false);
insert into Apply values (678, 'Stanford', 'history', true);
insert into Apply values (987, 'Stanford', 'CS', true);
insert into Apply values (987, 'Berkeley', 'CS', true);
insert into Apply values (876, 'Stanford', 'CS', false);
insert into Apply values (876, 'MIT', 'biology', true);
insert into Apply values (876, 'MIT', 'marine biology', false);
insert into Apply values (765, 'Stanford', 'history', true);
insert into Apply values (765, 'Cornell', 'history', false);
insert into Apply values (765, 'Cornell', 'psychology', true);
insert into Apply values (543, 'MIT', 'CS', false);

# select

select * from College;
select * from Student;
select * from Apply;

# select

select * from Student where (GPA > 3.7);
select * from Student where (GPA > 3.7)    and (sizeHS < 1000);
select * from Apply   where (cName = 'UT') and (major = 'cs');

# project

select sID, decision from Apply;

# select and project

select sID, sName from Student where (GPA > 3.7);

# select distinct

select          major, decision from Apply;
select distinct major, decision from Apply;

# cross join

select * from
	Student cross join Apply;

# inner join

select * from
	Student inner join Apply
	on (Student.sId = Apply.sId);

# natural join

select * from
	Student natural join Apply;

# names and GPAs of Students with
#   high school size > 1000,
#   who applied to CS,
#   and were rejected

select sName, GPA
	from Student inner join Apply
	on (Student.sId = Apply.sId)
	where (sizeHS > 1000) and (major = 'cs') and (decision = false);

select sName, GPA
	from Student natural join Apply
	where (sizeHS > 1000) and (major = 'cs') and (decision = false);

# names and GPAs of Students with
#   high school size > 1000,
#   who applied to CS,
#   at a College with enrollment > 20000,
#   and were rejected

select sName, GPA from Student
	inner join Apply   on (Student.sId   = Apply.sId)
	inner join College on (College.cName = Apply.cName)
	where (sizeHS   > 1000)  and (major = 'cs')       and
		  (decision = false) and (enrollment > 20000);

select sName, GPA from Student
	natural join Apply
	natural join College
	where (sizeHS   > 1000)  and (major = 'cs')       and
		  (decision = false) and (enrollment > 20000);

# set union

# list of College names and Student names
(select cName as csName from College)
union
(select sName as csName from Student);

# using temporary tables

create temporary table T1 as select cName as csName from College;
create temporary table T2 as select sName as csName from Student;
(select * from T1) union (select * from T2);

# set difference

# ids of Students who didn't Apply anywhere
# (select sId from Student) except (select sId from Apply);
# MySQL doesn't support 'except'

select distinct sId from Student
	where not exists
	(select sId from Apply where (Student.sId = Apply.sId));

# ids and names of Students who didn't Apply anywhere

create temporary table T3 as
	select distinct sId from Student
	where not exists
	(select sId from Apply where (Student.sId = Apply.sId));
select sId, sName from
	T3 natural join Student;

# set intersection

# names that are both a College name and a Student name
# (select cName from College) intersect (select sName from Student);
# MySQL doesn't support 'intersect'

select distinct cName as xName from College
	where exists
	(select sName from Student where (College.cName = Student.sName));

create temporary table T5 as
	select distinct cName as xName from College;
create temporary table T6 as
	select distinct sName as xName from Student;
select xName from
	T5 natural join T6;

# pairs of Colleges in the same state

select distinct A1.cName, A2.cName from
	College as A1 cross join College as A2
	where A1.cName != A2.cName and A1.state = A2.state;

select distinct A1.cName, A2.cName from
	College as A1 cross join College as A2
	where A1.cName < A2.cName and A1.state = A2.state;

create temporary table T7 as
	select cName as cName1, state, enrollment as enrollment1 from College;
create temporary table T8 as
	select cName as cName2, state, enrollment as enrollment2 from College;
select cName1, cName2 from
	T7 natural join T8
	where cName1 < cName2;

# gpas of Students Applying to cs in ca

select GPA from Student
	natural join College
	natural join Apply
	where state = "CA" and major = "CS";

# drop

drop table College;
drop table Student;
drop table Apply;

exit

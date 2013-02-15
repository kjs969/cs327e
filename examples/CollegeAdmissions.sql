use downing_test;

# drop

drop table if exists College;
drop table if exists Student;
drop table if exists Apply;

# create

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

# insert

insert into Student values (123, 'Amy',    3.9, 1000);
insert into Student values (234, 'Bob',    3.6, 1500);
insert into Student values (345, 'Craig',  3.5,  500);
insert into Student values (456, 'Doris',  3.9, 1000);
insert into Student values (567, 'Edward', 2.9, 2000);
insert into Student values (678, 'Fay',    3.8,  200);
insert into Student values (789, 'Gary',   3.4,  800);
insert into Student values (987, 'Helen',  3.7,  800);
insert into Student values (876, 'Irene',  3.9,  400);
insert into Student values (765, 'Jay',    2.9, 1500);
insert into Student values (654, 'Amy',    3.9, 1000);
insert into Student values (543, 'Craig',  3.4, 2000);

insert into Apply values (123, 'Stanford', 'CS',             true);
insert into Apply values (123, 'Stanford', 'EE',             false);
insert into Apply values (123, 'Berkeley', 'CS',             true);
insert into Apply values (123, 'Cornell',  'EE',             true);
insert into Apply values (234, 'Berkeley', 'biology',        false);
insert into Apply values (345, 'MIT',      'bioengineering', true);
insert into Apply values (345, 'Cornell',  'bioengineering', false);
insert into Apply values (345, 'Cornell',  'CS',             true);
insert into Apply values (345, 'Cornell',  'EE',             false);
insert into Apply values (678, 'Stanford', 'history',        true);
insert into Apply values (987, 'Stanford', 'CS',             true);
insert into Apply values (987, 'Berkeley', 'CS',             true);
insert into Apply values (876, 'Stanford', 'CS',             false);
insert into Apply values (876, 'MIT',      'biology',        true);
insert into Apply values (876, 'MIT',      'marine biology', false);
insert into Apply values (765, 'Stanford', 'history',        true);
insert into Apply values (765, 'Cornell',  'history',        false);
insert into Apply values (765, 'Cornell',  'psychology',     true);
insert into Apply values (543, 'MIT',       'CS',            false);

insert into College values ('Stanford', 'CA', 15000);
insert into College values ('Berkeley', 'CA', 36000);
insert into College values ('MIT',      'MA', 10000);
insert into College values ('Cornell',  'NY', 21000);
insert into College values ('Irene',    'NY', 21000);

# show

show tables;
show columns from Student;
show columns from Apply;
show columns from College;

# select

select * from Student;
select * from Apply;
select * from College;

# select

# students with GPA > 3.7
# select[GPA > 3.7](Student)
select * from Student where (GPA > 3.7);

# students with GPA > 3.7 with high school size < 1000
# select[(GPA > 3.7) and (sizeHS < 1000)](Student)
select * from Student where (GPA > 3.7) and (sizeHS < 1000);

# applications to Stanford with major = CS
# select[(GPA > 3.7) and (sizeHS < 1000) and (major = 'CS')](Student)
select * from Apply where (cName = 'Stanford') and (major = 'CS');

# project

# student ID and decision of applications
# project[sID, decision](Apply)
select sID, decision from Apply;

# select and project

# ID and name of students with GPA > 3.7

# project[sID, sName](select[GPA > 3.7](Student))
select sID, sName from Student where (GPA > 3.7);

# select distinct

# major and decision of applications
# project[major, decision](Apply)
select          major, decision from Apply;
select distinct major, decision from Apply;

# cross join

# Student cross Apply
select *
	from Student cross join Apply;

# inner join (theta join)

# Student join[Student.sID = Apply.sID] Apply
select *
	from Student, Apply
	where (Student.sID = Apply.sID);

select *
	from Student inner join Apply
	on (Student.sID = Apply.sID);

select *
	from Student inner join Apply
	using (sID);

select *
	from Student natural join Apply;

# name and GPA of students
#   with high school size > 1000,
#   with major            = CS,
#   with decision         = false

# select[(sizeHS > 1000) and (major = 'CS') and (decision = false)]
# 	(Student join Apply)
select *
	from Student natural join Apply
	where (sizeHS > 1000) and (major = 'CS') and (decision = false);

# project[sName, GPA]
# 	select[(sizeHS > 1000) and (major = 'CS') and (decision = false)]
# 		(Student join Apply)
select sName, GPA
	from Student natural join Apply
	where (sizeHS > 1000) and (major = 'CS') and (decision = false);

# name and GPA of students with
#   with high school size > 500,
#   with major            = CS,
#   with decision         = false,
#   with enrollment       > 20000

# select[(sizeHS > 500) and (major = 'CS') and (decision = false) and (enrollment > 20000)]
# 	(Student join Apply join College)
select *
	from Student natural join Apply natural join College
	where (sizeHS     > 500)   and
	      (major      = 'CS')  and
	      (decision   = true)  and
	      (enrollment > 20000);

select sName, GPA
	from Student natural join Apply natural join College
	where (sizeHS     > 500)   and
	      (major      = 'CS')  and
	      (decision   = true)  and
	      (enrollment > 20000);

# set union

# names of students and colleges

# project[cName](Student) union project[sName](College)
(select cName from College)
union
(select sName from Student);

(select cName as A1 from College)
union
(select sName as A1 from Student);

# using temporary tables

# T1a := select[cName](College)
create temporary table T1a as
	select cName as A1 from College;

# T1b := select[sName](Student)
create temporary table T1b as
	select sName as A1 from Student;

# T1a join T1b
(select * from T1a) union (select * from T1b);

# set difference

# ID and name of students who didn't apply anywhere

# T2a := project[sID](Student) diff project[sID](Apply)
create temporary table T2a as
	select distinct sID from Student
	    where not exists
	        (select sID from Apply where (Student.sID = Apply.sID));

# T2a join Student
select *
	from T2a natural join Student;

# project[sID, sName](T2a join Student)
select sID, sName
	from T2a natural join Student;

# set intersection

# names that are both a student name and a college name

# project[sName](Student) intersect project[cName](College)
select cName from College
	where exists
	    (select sName from Student where (College.cName = Student.sName));

# T3a := rename[A1](project[sName](Student))
create temporary table T3a as
	select sName as A1 from Student;

# T3b := rename[A1](project[cName](College))
create temporary table T3b as
	select cName as A1 from College;

# T3a join T3b
select * from
	T3a natural join T3b;

# pairs of names of colleges in the same state

# T5a := rename[cName1, state, enrollment1](College);
create temporary table T5a as
	select cName as cName1, state, enrollment as enrollment1 from College;

# T5b := rename[cName2, state, enrollment2](College);
create temporary table T5b as
	select cName as cName2, state, enrollment as enrollment2 from College;

# project[cName1, cName2](select[cName1 != cName2](T5a join T5b))
select cName1, cName2 from
	T5a natural join T5b
	where cName1 != cName2;

# project[cName1, cName2](select[cName1 < cName2](T5a join T5b))
select cName1, cName2 from
	T5a natural join T5b
	where cName1 < cName2;

# gpas of students applying to cs in ca

# select[(major = 'CS') and (state = 'CA')](Apply join Student)
select *
	from Student natural join Apply natural join College
	where major = "CS" and state = "CA";

# project[GPA](select[(major = 'CS') and (state = 'CA')](Apply join Student))
select GPA
	from Student natural join Apply natural join College
	where major = "CS" and state = "CA";

# colleges with enrollments < 20000 that Amy or Irene applied to

# select[((sName = 'Amy') or (sName = 'Irene')) and (enrollment < 20000)]
# 	(Student join Apply join College)
select * from
	Student natural join Apply natural join College
	where ((sName = 'Amy') or (sName = 'Irene') and (enrollment < 20000));

# project[cName](
# 	select[((sName = 'Amy') or (sName = 'Irene')) and (enrollment < 20000)]
# 	(Student join Apply join College))

select distinct cName from
	Student natural join Apply natural join College
	where (((sName = 'Amy') or (sName = 'Irene')) and (enrollment < 20000));

# colleges with enrollments < 20000 that Amy and Irene applied to

# project[cName](
# 	select[(sName = 'Amy') and (enrollment < 20000)]
# 	(Student join Apply join College))
# intersect
# project[cName](
# 	select[(sName = 'Irene') and (enrollment < 20000)]
# 	(Student join Apply join College))

# rename[A1](
# 	project[cName](
# 		select[(sName = 'Amy') and (enrollment < 20000)]
# 		(Student join Apply join College)))
create temporary table T6a as
	select distinct cName as A1 from
		Student natural join Apply natural join College
		where ((sName = 'Amy') and (enrollment < 20000));

# rename[A1](
# 	project[cName](
# 		select[(sName = 'Irene') and (enrollment < 20000)]
# 		(Student join Apply join College)))
create temporary table T7a as
	select distinct cName as A1 from
		Student natural join Apply natural join College
		where ((sName = 'Irene') and (enrollment < 20000));

# T6a join T7a
select *
	from T6a natural join T7a;

# drop

drop table Student;
drop table Apply;
drop table College;

exit

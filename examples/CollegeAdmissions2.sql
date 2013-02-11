use downing_test;

# drop

drop table if exists college;
drop table if exists student;
drop table if exists apply;

# create

create table college (
	cName      text,
	state      char(2),
	enrollment int);

create table student (
	sId    int,
	sName  text,
	GPA    float,
	sizeHS int);

create table apply (
	sId      int,
	cName    text,
	major    text,
	decision boolean);

# insert

insert into college values ("Harvard",   "MA",  6700);
insert into college values ("MIT",       "MA",  4500);
insert into college values ("NYU",       "NY", 10000);
insert into college values ("Princeton", "NJ",  5100);
insert into college values ("Stanford",  "CA",  5300);
insert into college values ("UT",        "TX", 52300);
insert into college values ("John Galt", "TX",     0);

insert into student values (1, "Anna Karenina", "3.8", 3500);
insert into student values (2, "Greta Garbo",   "3.5",  900);
insert into student values (3, "John Galt",     "4.0",  500);
insert into student values (4, "John Nash",     "3.9", 2500);

insert into apply values (2, "Harvard",   "literature", true);
insert into apply values (2, "Stanford",  "cs",         false);
insert into apply values (2, "NYU",       "film",       true);
insert into apply values (3, "MIT",       "cs",         true);
insert into apply values (3, "UT",        "cs",         true);
insert into apply values (4, "Princeton", "math",       true);
insert into apply values (4, "UT",        "cs",         false);

# set union

# list of college names and student names
(select cName as csName from college)
union
(select sName as csName from student);

# using temporary tables

create temporary table T1 as select cName as csName from college;
create temporary table T2 as select sName as csName from student;
(select * from T1) union (select * from T2);

# set difference

# ids of students who didn't apply anywhere
# (select sId from student) except (select sId from apply);
# MySQL doesn't support 'except'

select distinct sId from student
	where not exists
	(select sId from apply where (student.sId = apply.sId));

# ids and names of students who didn't apply anywhere

create temporary table T3 as
	select distinct sId from student
	where not exists
	(select sId from apply where (student.sId = apply.sId));
select sId, sName from
	T3 natural join student;

# set intersection

# names that are both a college name and a student name
# (select cName from college) intersect (select sName from student);
# MySQL doesn't support 'intersect'

select distinct cName as xName from college
	where exists
	(select sName from student where (college.cName = student.sName));

create temporary table T5 as
	select distinct cName as xName from college;
create temporary table T6 as
	select distinct sName as xName from student;
select xName from
	T5 natural join T6;

# pairs of colleges in the same state

select distinct A1.cName, A2.cName from
	college as A1 cross join college as A2
	where A1.cName != A2.cName and A1.state = A2.state;

select distinct A1.cName, A2.cName from
	college as A1 cross join college as A2
	where A1.cName < A2.cName and A1.state = A2.state;

create temporary table T7 as
	select cName as cName1, state, enrollment as enrollment1 from college;
create temporary table T8 as
	select cName as cName2, state, enrollment as enrollment2 from college;
select cName1, cName2 from
	T7 natural join T8
	where cName1 < cName2;

# gpas of students applying to cs in ca

select GPA from student
	natural join college
	natural join apply
	where state = "CA" and major = "CS";

# drop

drop table college;
drop table student;
drop table apply;

exit

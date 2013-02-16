use downing_test;

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

# ID and name of students who did not apply anywhere

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

exit

use downing_test;

# ---------
# set union
# ---------

# names of students and colleges

# project[cName](Student) union project[sName](College)
(select cName from College)
union
(select sName from Student);

(select cName as A1 from College)
union
(select sName as A1 from Student);

# --------------
# set difference
# --------------

# ID and name of students who did not apply anywhere

# project[sID](Student) diff project[sID](Apply)
select sID, sName
	from Student
	where not exists
		(select *
			from Apply
			where Student.sID = Apply.sID);

# ----------------
# set intersection
# ----------------

# names that are both a student name and a college name

# project[sName](Student) intersect project[cName](College)
select cName as csName
	from College
	where exists
	    (select *
	    	from Student
	    	where College.cName = Student.sName);

# ----------
# using join
# ----------

# R1 := rename[A1](project[sName](Student))
create temporary table R1 as
	select sName as csName from Student;

# S1 := rename[A1](project[cName](College))
create temporary table S1 as
	select cName as csName from College;

# R1 join S1
select * from
	R1 natural join S1;

# pairs of names of colleges in the same state

# R2 := rename[cName1, state, enrollment1](College);
create temporary table R2 as
	select cName as cName1, state, enrollment as enrollment1 from College;

# S5 := rename[cName2, state, enrollment2](College);
create temporary table S5 as
	select cName as cName2, state, enrollment as enrollment2 from College;

# project[cName1, cName2](select[cName1 != cName2](R2 join S5))
select cName1, cName2 from
	R2 natural join S5
	where cName1 != cName2;

# project[cName1, cName2](select[cName1 < cName2](R2 join S5))
select cName1, cName2 from
	R2 natural join S5
	where cName1 < cName2;

# GPAs of students applying to cs in ca

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

use downing_test;

# ---------
# set union
# ---------

# names of students and colleges

# project[cName]
#     (Student)
# union
# project[sName]
#     (College)
(select cName from College)
union
(select sName from Student)
order by cName;

(select cName as name from College)
union
(select sName as name from Student)
order by name;

# --------------
# set difference
# --------------

# ID of students who did not apply anywhere

# project[sID]
#     (Student)
# diff
# project[sID]
#     (Apply)
select sID
    from Student
    where not exists
        (select *
            from Apply
            where Student.sID = Apply.sID);

# ----------------
# set intersection
# ----------------

# names that are both a student name and a college name

# project[sName]
#     (Student)
# intersect
# project[cName]
#     (College)
select cName as name
    from College
    where exists
        (select *
            from Student
            where cName = sName);

# using join

# R1 := rename[A1](project[sName](Student))
create temporary table R1 as
    select sName as name from Student;

# S1 := rename[A1](project[cName](College))
create temporary table S1 as
    select cName as name from College;

# R1 join S1
select * from
    R1 natural join S1;

# ------
# rename
# ------

# pairs of names of colleges in the same state

# R2 :=
#     rename[cName1, state, enrollment1]
#         (College);
create temporary table R2 as
    select cName as cName1, state, enrollment as enrollment1
    from College;

# S2 :=
#     rename[cName2, state, enrollment2]
#         (College);
create temporary table S2 as
    select cName as cName2, state, enrollment as enrollment2
    from College;

# this doesn't work
# because it has duplicates

# project[cName1, cName2] (
#     select[cName1 != cName2]
#         (R2 join S2))
select cName1, cName2 from
    R2 natural join S2
    where cName1 != cName2;

# this does work

# project[cName1, cName2](select[cName1 < cName2](R2 join S2))
select cName1, cName2 from
    R2 natural join S2
    where cName1 < cName2;

# colleges with enrollments < 20000 that Amy OR Irene applied to

# select[((sName = 'Amy') or (sName = 'Irene')) and (enrollment < 20000)]
#     (Student join Apply join College)
select * from
    Student natural join Apply natural join College
    where ((sName = 'Amy') or (sName = 'Irene')) and (enrollment < 20000)
    order by cName;

# project[cName](
#     select[((sName = 'Amy') or (sName = 'Irene')) and (enrollment < 20000)]
#         (Student join Apply join College))
select distinct cName from
    Student natural join Apply natural join College
    where (((sName = 'Amy') or (sName = 'Irene')) and (enrollment < 20000))
    order by cName;

# colleges with enrollments < 20000 that Amy AND Irene applied to

# project[cName](
#   select[(sName = 'Amy') and (enrollment < 20000)]
#   (Student join Apply join College))
# intersect
# project[cName](
#   select[(sName = 'Irene') and (enrollment < 20000)]
#   (Student join Apply join College))

# R3 :=
#   project[cName](
#       select[(sName = 'Amy') and (enrollment < 20000)]
#       (Student join Apply join College)))
create temporary table R3 as
    select distinct cName from
        Student natural join Apply natural join College
        where ((sName = 'Amy') and (enrollment < 20000));

# S3 :=
#   project[cName](
#       select[(sName = 'Irene') and (enrollment < 20000)]
#       (Student join Apply join College)))
create temporary table S3 as
    select distinct cName from
        Student natural join Apply natural join College
        where ((sName = 'Irene') and (enrollment < 20000));

# R3 join S3
select *
    from R3 natural join S3;

exit

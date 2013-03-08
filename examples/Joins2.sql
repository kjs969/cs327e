use downing_test;

/* -----------------------------------------------------------------------
name and major of students
*/

select distinct sName, major
    from Student, Apply
    where (Student.sID = Apply.sID)
    order by sName;

select distinct sName, major
    from Student join Apply
    where (Student.sID = Apply.sID)
    order by sName;

select distinct sName, major
    from Student inner join Apply
    on (Student.sID = Apply.sID)
    order by sName;

select distinct sName, major
    from Student natural join Apply
    order by sName;

/* -----------------------------------------------------------------------
name and GPA of students with high school size less than 1000 and who
applied to Stanford in CS
*/

select *
    from Student natural join Apply
    where (sizeHS < 1000) and (major = 'CS') and (cName = 'Stanford');

select sName, GPA
    from Student natural join Apply
    where (sizeHS < 1000) and (major = 'CS') and (cName = 'Stanford');

select *
    from Student inner join Apply
    on
        (Student.sID = Apply.sID)   and
        (sizeHS      < 1000)        and
        (major       = 'CS')        and
        (cName       = 'Stanford');

select sName, GPA
    from Student inner join Apply
    on
        (Student.sID = Apply.sID)   and
        (sizeHS      < 1000)        and
        (major       = 'CS')        and
        (cName       = 'Stanford');

exit

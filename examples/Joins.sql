use downing_test;

/* -----------------------------------------------------------------------
Student cross Apply
*/

select *
    from Student cross join Apply;

# select *
#     from Student, Apply;

/* -----------------------------------------------------------------------
Student join[Student.sID = Apply.sID] Apply
Student join                          Apply
*/

# select *
#     from Student, Apply
#     where (Student.sID = Apply.sID);

# select *
#     from Student inner join Apply
#     on (Student.sID = Apply.sID);

# select *
#     from Student join Apply
#     on (Student.sID = Apply.sID);

# select *
#     from Student inner join Apply
#     using (sID);

# select *
#     from Student join Apply
#     using (sID);

select *
    from Student natural join Apply;

/* -----------------------------------------------------------------------
name and GPA of students
   with high school size > 1000,
   with major            = CS,
   with decision         = false

project[sName, GPA]
    (select[(sizeHS > 1000)     and
            (major = 'CS')      and
            (decision = false)]
        (Student join Apply))
*/

select *
    from Student natural join Apply
    where (sizeHS > 1000) and (major = 'CS') and (decision = false);

select sName, GPA
    from Student natural join Apply
    where (sizeHS > 1000) and (major = 'CS') and (decision = false);

/* -----------------------------------------------------------------------
name and GPA of students with
   with high school size > 500,
   with major            = CS,
   with decision         = false,
   with enrollment       > 20000

project[sName, GPA]
    (select[(sizeHS > 500)       and
           (major = 'CS')        and
           (decision = false)    and
           (enrollment > 20000)]
        (Student join Apply join College))
*/

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

exit

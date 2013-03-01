use downing_test;

/* -----------------------------------------------------------------------
all students
*/

select *
    from Student
    order by GPA;

/* -----------------------------------------------------------------------
students whose GPA is > 3.5
*/

select *
    from Student
    where GPA > 3.5
    order by GPA;

select sID, sName, GPA
    from Student
    where GPA > 3.5
    order by GPA;

/* -----------------------------------------------------------------------
students whose GPA is <= 3.5
*/

select sID, sName, GPA
    from Student
    where GPA <= 3.5
    order by GPA;

/* -----------------------------------------------------------------------
students whose (GPA is <= 3.5) or (GPA > 3.5)
*/

select sID, sName, GPA
    from Student
    where (GPA <= 3.5) or (GPA > 3.5)
    order by GPA;

/* -----------------------------------------------------------------------
students whose (GPA is <= 3.5) or (GPA > 3.5) or (GPA is null)
all students
*/

select sID, sName, GPA
    from Student
    where (GPA <= 3.5) or (GPA > 3.5) or GPA is null
    order by GPA;

/* -----------------------------------------------------------------------
students whose (GPA > 3.4) or (high school size < 1600)
*/

select *
    from Student
    where (GPA > 3.5) or (sizeHS < 1600);

/* -----------------------------------------------------------------------
students whose (GPA > 3.4) or (high school size < 1600) or
(high school size >= 1600)
all students
*/

select *
    from Student
    where (GPA > 3.5) or (sizeHS < 1600) or (sizeHS >= 1600);

/* -----------------------------------------------------------------------
number of students whose GPA is not null
*/

select count(*)
    from Student
    where GPA is not null;

/* -----------------------------------------------------------------------
number of students whose non-null GPA is distinct
*/

select count(distinct GPA)
    from Student
    where GPA is not null;

/* -----------------------------------------------------------------------
number of students whose GPA is distinct
*/

select count(distinct GPA)
    from Student;

/* -----------------------------------------------------------------------
students whose GPA is distinct
*/

select distinct GPA
    from Student;

exit

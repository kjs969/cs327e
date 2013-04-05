/*
CS327e: Quiz #27 (5 pts)
*/

create table Student (sID   int,  sName text,    GPA        float, sizeHS   int);
create table Apply   (sID   int,  cName text,    major      text,  decision boolean);
create table College (cName text, state char(2), enrollment int);

/* -----------------------------------------------------------------------
1. Write a query to obtain the average GPA of students applying to CS.
   (4 pts)
*/

select avg(GPA)
    from Student
    where sID in (
        select sID
            from Apply
            where major = 'CS');

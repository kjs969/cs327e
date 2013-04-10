/*
CS327e: Quiz #28 (5 pts)
*/

create table Student (sID   int,  sName text,    GPA        float, sizeHS   int);
create table Apply   (sID   int,  cName text,    major      text,  decision boolean);
create table College (cName text, state char(2), enrollment int);

/* -----------------------------------------------------------------------
1. Write a query to obtain number of students who applied to each college.
   (4 pts)
*/

select cName, count(distinct sID)
    from Apply
    group by cName;

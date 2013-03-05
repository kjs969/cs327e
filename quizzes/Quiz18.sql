/*
CS327e: Quiz #18 (5 pts)
*/

create table Student (sID   int,  sName text,    GPA        float, sizeHS   int);
create table Apply   (sID   int,  cName text,    major      text,  decision boolean);
create table College (cName text, state char(2), enrollment int);

/* -----------------------------------------------------------------------
1. Write a query to obtain the names of the students and the names of the
   colleges and name the attribute, "name".
   (4 pts)
*/

select sName as name from Student
union
select cName as name from College
order by name;

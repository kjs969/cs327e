/*
CS327e: Quiz #14 (5 pts)
*/

create table Student (sID   int,  sName text,    GPA        float, sizeHS   int);
create table Apply   (sID   int,  cName text,    major      text,  decision boolean);
create table College (cName text, state char(2), enrollment int);

/* -----------------------------------------------------------------------
1. Use a subquery to get the ID and name of all the students that were
   rejected, ordered by name.
   (4 pts)
*/

select sID, sName
    from Student
    where sID in (
        select sID
            from Apply
            where decision = false)
    order by sName;

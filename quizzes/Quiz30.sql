/*
CS327e: Quiz #30 (5 pts)
*/

create table Student (sID   int,  sName text,    GPA        float, sizeHS   int);
create table Apply   (sID   int,  cName text,    major      text,  decision boolean);
create table College (cName text, state char(2), enrollment int);

/* -----------------------------------------------------------------------
1. Write a query to have students who applied nowhere to apply to
   Carnegie Melon in CS.
   (4 pts)
*/

insert into Apply
    select sID, 'Carnegie Mellon', 'CS', null
        from Student
        where sID not in
            (select sID
                from Apply);

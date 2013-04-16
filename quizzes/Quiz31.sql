/*
CS327e: Quiz #31 (5 pts)
*/

create table Student (sID   int,  sName text,    GPA        float, sizeHS   int);
create table Apply   (sID   int,  cName text,    major      text,  decision boolean);
create table College (cName text, state char(2), enrollment int);

/* -----------------------------------------------------------------------
1. Write a query to delete colleges that don't have any CS applications.
   (4 pts)
*/

delete
    from College
    where cName not in
        (select cName
            from Apply
            where major = 'CS');

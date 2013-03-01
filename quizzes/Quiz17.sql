/*
CS327e: Quiz #17 (5 pts)
*/

create table Student (sID   int,  sName text,    GPA        float, sizeHS   int);
create table Apply   (sID   int,  cName text,    major      text,  decision boolean);
create table College (cName text, state char(2), enrollment int);

/* -----------------------------------------------------------------------
1. Use a subquery to get the ID, name, and GPA of the students with the
   highest GPA, ordered by ID.
   (4 pts)
*/

select sID, sName, GPA
    from Student as R
    where not exists
        (select *
            from Student as S
            where R.GPA < S.GPA)
    order by sID;

# or

select sID, sName, GPA
    from Student
    where GPA >= all
        (select GPA
            from Student)
    order by sID;

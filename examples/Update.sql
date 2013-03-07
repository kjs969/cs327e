use downing_test;

/* -----------------------------------------------------------------------
applications of students who applied to Carnegie Melon with a GPA < 3.6
*/

select *
    from Apply
    where
        (cName = 'Carnegie Mellon')
        and
        sID in
            (select sID
                from Student
                where GPA < 3.6);

/* -----------------------------------------------------------------------
change those applications from CS to economics
*/

select *
    from Apply
    order by sID;

update Apply
    set decision = true, major = 'economics'
    where
        (cName = 'Carnegie Mellon')
        and
        sID in
            (select sID
                from Student
                where GPA < 3.6);

select *
    from Apply
    order by sID;

/* -----------------------------------------------------------------------
applications of students with the highest GPA who applied to EE
*/

select *
    from Apply
    where
        (major = 'EE')
        and
        sID in
            (select sID
                from Student
                where GPA >= all
                    (select GPA
                        from Student
                        where sID in
                            (select sID
                                from Apply
                                where major = 'EE')));

/* -----------------------------------------------------------------------
change those applications from EE to CS
*/

select *
    from Apply
    order by sID;

create temporary table T as
    select major
        from Apply
        where
            (major = 'EE')
            and
            sID in
                (select sID
                    from Student
                    where GPA >= all
                        (select GPA
                            from Student
                            where sID in
                                (select sID
                                    from Apply
                                    where major = 'EE')));
update Apply
    set major = 'CSE'
    where major in
        (select *
            from T);

select *
    from Apply
    order by sID;

/* -----------------------------------------------------------------------
change every student to have the highest GPA and smalles school size
*/

select *
    from Student
    order by sID;

create temporary table R as
    select max(GPA)
        from Student;
create temporary table S as
    select min(sizeHS)
        from Student;
update Student
    set
        GPA =
            (select *
                from R),
        sizeHS =
            (select *
                from S);

select *
    from Student
    order by sID;

/* -----------------------------------------------------------------------
accept all students
*/

select *
    from Apply
    order by sID;

update Apply
    set decision = true;

select *
    from Apply
    order by sID;

exit

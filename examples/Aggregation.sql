use downing_test;

/* -----------------------------------------------------------------------
average GPA of students
*/

select *
    from Student
    order by GPA;

select avg(GPA)
    from Student;

/* -----------------------------------------------------------------------
lowest GPA of students applying to CS
*/

select *
    from Student natural join Apply
    where major = 'CS'
    order by GPA;

select min(GPA)
    from Student natural join Apply
    where major = 'CS';

/* -----------------------------------------------------------------------
average GPA of students applying to CS
*/

# this is not right
# because of duplicates

select *
    from Student natural join Apply
    where major = 'CS'
    order by GPA;

select avg(GPA)
    from Student natural join Apply
    where major = 'CS';

# this is right

select *
    from Student
    where sID in
        (select sID
            from Apply
            where major = 'CS')
    order by GPA;

select avg(GPA)
    from Student
    where sID in (
        select sID
            from Apply
            where major = 'CS');

/* -----------------------------------------------------------------------
number of colleges with enrollment > 15000
*/

select *
    from College
    where enrollment > 15000
    order by enrollment;

select count(*)
    from College
    where enrollment > 15000;

/* -----------------------------------------------------------------------
number of students who applied to Cornell
*/

# this is not right
# because of duplicates

select *
    from Apply
    where cName = "Cornell"
    order by sID;

select count(*)
    from Apply
    where cName = "Cornell"
    order by sID;

# this is right

select distinct sID
    from Apply
    where cName = "Cornell"
    order by sID;

select count(distinct sID)
    from Apply
    where cName = "Cornell"
    order by sID;

/* -----------------------------------------------------------------------
students, such that the number of other students with the same GPA
equals the number of other students with the same high school size
*/

select *
    from Student as R
    where
        (select count(*)
            from Student as S
            where (R.sID != S.sID) and (R.GPA = S.GPA))
        =
        (select count(*)
            from Student as S
            where (R.sID != S.sID) and (R.sizeHS = S.sizeHS))
    order by sID;

/* -----------------------------------------------------------------------
amount by which the average GPA of students applying to CS
exceeds the average GPA of students not applying to CS
*/

select *
    from
        (select avg(GPA) as x
            from Student
            where sID in
                (select sID
                    from Apply
                        where major = 'CS')) as R,
        (select avg(GPA) as y
            from Student
            where sID not in
                (select sID
                    from Apply
                        where major = 'CS')) as S;

select R.x - S.y
    from
        (select avg(GPA) as x
            from Student
            where sID in
                (select sID
                    from Apply
                        where major = 'CS')) as R,
        (select avg(GPA) as y
            from Student
            where sID not in
                (select sID
                    from Apply
                        where major = 'CS')) as S;

# using subquery in select

select
    (select avg(GPA) as x
        from Student
        where sID in
            (select sID
                from Apply
                    where major = 'CS'))
    -
    (select avg(GPA) as y
        from Student
        where sID not in
            (select sID
                from Apply
                    where major = 'CS')) as S
    from Student;

select distinct
    (select avg(GPA) as x
        from Student
        where sID in
            (select sID
                from Apply
                    where major = 'CS'))
    -
    (select avg(GPA) as y
        from Student
        where sID not in
            (select sID
                from Apply
                    where major = 'CS')) as S
    from Student;

/* -----------------------------------------------------------------------
number of applicants to each college
*/

select *
    from Apply
    order by cName;

select count(*)
    from Apply;

select cName, count(*)
    from Apply
    group by cName;

/* -----------------------------------------------------------------------
college enrollment by state
*/

select *
    from College
    order by state;

select sum(enrollment)
    from College;

select state, sum(enrollment)
    from College
    group by state;

/* -----------------------------------------------------------------------
min and max GPA of applicants to each college and major
*/

select cName, major, GPA
    from Student natural join Apply
    order by cName, major;

select cName, major, min(GPA), max(GPA)
    from Student natural join Apply
    group by cName, major;

/* -----------------------------------------------------------------------
spread between min and max GPA of applicants to each college and major
*/

select y - x
    from
        (select cName, major, min(GPA) as x, max(GPA) as y
            from Student natural join Apply
            group by cName, major) as T;

/* -----------------------------------------------------------------------
max spread between min and max GPA of applicants to each college and major
*/

select max(y - x)
    from
        (select cName, major, min(GPA) as x, max(GPA) as y
            from Student natural join Apply
            group by cName, major) as T;

/* -----------------------------------------------------------------------
number of colleges applied to by each student
*/

select *
    from Student natural join Apply
    order by Student.sID, cName;

select Student.sID, count(distinct cName)
    from Student natural join Apply
    group by Student.sID;

exit

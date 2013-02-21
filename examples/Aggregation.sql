use downing_test;

# ---
# avg
# ---

# average GPA of students

select *
    from Student
    order by GPA desc;

select avg(GPA)
    from Student;

# ---
# min
# ---

# lowest GPA of students applying to CS

select *
    from Student natural join Apply
    where major = 'CS'
    order by GPA desc;

select min(GPA)
    from Student natural join Apply
    where major = 'CS';

# ---
# avg
# ---

# average GPA of students applying to CS

# this isn't right
# because of duplicates

select *
    from Student natural join Apply
    where major = 'CS'
    order by GPA desc;

select avg(GPA)
    from Student natural join Apply
    where major = 'CS';

# this is right

select *
    from Student
    where sID in (
        select sID
            from Apply
            where major = 'CS')
    order by GPA desc;

select avg(GPA)
    from Student
    where sID in (
        select sID
            from Apply
            where major = 'CS');

# -----
# count
# -----

# number of colleges with enrollment > 15000

select *
    from College
    where enrollment > 15000
    order by enrollment desc;

select count(*)
    from College
    where enrollment > 15000;

# number of students who applied to Cornell

# this isn't right
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

# students, such that the number of other students with the same GPA
# equals the number of other students with the same high school size

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

exit

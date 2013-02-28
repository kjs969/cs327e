use downing_test;

# ------------------------------------------------------------------------
# ID, name, and GPA of students who applied in CS

# project[sID, sName, GPA]
#     (select[major = 'CS']
#         (Student join Apply))

select *
    from Student natural join Apply
    where major = 'CS'
    order by sID;

select sID, sName, GPA
    from Student natural join Apply
    where major = 'CS'
    order by sID;

select distinct sID, sName, GPA
    from Student natural join Apply
    where major = 'CS'
    order by sID;

# using subquery, with in

select sID, sName, GPA
    from Student
    where sID in (
        select sID
            from Apply
            where major = 'CS')
    order by sID;

# ------------------------------------------------------------------------
# GPA of students who applied in CS

# project[GPA]
#     (Student
#      diff
#      select[major = 'CS']
#          (Student))

# this is not right
# because of duplicates

select GPA
    from Student natural join Apply
    where major = 'CS'
    order by GPA desc;

# this is not right either
# because it does not remove duplicates in the right way

select distinct GPA
    from Student natural join Apply
    where major = 'CS'
    order by GPA desc;

# this is right
# using subquery, with in

select GPA
    from Student
    where sID in (
        select sID
            from Apply
            where major = 'CS')
    order by GPA desc;

# this is also right, but cumbersome

# T :=
#     project[sID, GPA]
#         (select[major = 'CS']
#             (Student join Apply)))
# project[GPA]
#     (T)

# using derived tables

select GPA
    from
        (select distinct sID, GPA
            from Student natural join Apply
            where major = 'CS') as T
    order by GPA desc;

# using temporary tables

create temporary table T as
    select distinct sID, GPA
        from Student natural join Apply
        where major = 'CS';
select GPA
    from T
    order by GPA desc;

# ------------------------------------------------------------------------
# ID of students who have applied to major in CS but not in EE

# project[sID]
#     (select[major  = 'CS']
#         (Student))
# diff
# project[sID]
#     (select[major != 'EE']
#         (Student))

# this is not right
# because students may be majoring CS in more than one place

select distinct R.sID
    from Apply as R inner join Apply as S
    where R.sID    = S.sID and
          R.major  = 'CS'  and
          S.major != 'EE';

# this is right
# using subquery, with in and not in

select sID
    from Student
    where
        sID in
            (select sID
                from Apply
                where major = 'CS')
        and
        sID not in
            (select sID
                from Apply
                where major = 'EE');

# ------------------------------------------------------------------------
# colleges, such that there's another college in the same state

# using as
# using subquery, with exists

# this is not right
# because a college is in the same state as itself

select cName, state
    from College as R
    where exists
        (select *
            from College as S
            where R.state = S.state);

# this is right

select cName, state
    from College as R
    where exists
        (select *
            from College as S
            where (R.state = S.state) and (R.cName != S.cName));

# ------------------------------------------------------------------------
# college with highest enrollment

# using subquery, with not exists

select cName
    from College as R
    where not exists
        (select *
            from College as S
            where R.enrollment < S.enrollment);

# ------------------------------------------------------------------------
# student with highest GPA

select sID, sName, GPA
    from Student as R
    where not exists
        (select *
            from Student as S
            where R.GPA < S.GPA)
    order by sID;

# using subquery, with all

select sID, sName, GPA
    from Student
    where GPA >= all
        (select GPA
            from Student)
    order by sID;

exit

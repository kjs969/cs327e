use downing_test;

# ----------
# subqueries
# ----------

# ID, name, and GPA of students who applied in CS

# project[sID, sName, GPA] (
#     select[major = 'CS']
#         (Student join Apply))

select sID, sName, GPA
    from Student natural join Apply
    where major = 'CS';

select distinct sID, sName, GPA
    from Student natural join Apply
    where major = 'CS';

# using subquery instead
# in for membership

select sID, sName, GPA
    from Student
    where sID in (
        select sID
            from Apply
            where major = 'CS');

# GPA of students who applied in CS

# using order by

# this isn't right
# because of duplicates

# project[GPA] (
#     select[major = 'CS']
#         (Student join Apply))

select GPA
    from Student natural join Apply
    where major = 'CS'
    order by GPA desc;

# this isn't either
# because it doesn't remove duplicates in the right way

select distinct GPA
    from Student natural join Apply
    where major = 'CS'
    order by GPA desc;

# this is right

# project[GPA] (
#     Student
#     diff
#     select[major = 'CS']
#         (Student))
select GPA
    from Student
    where sID in (
        select sID
            from Apply
            where major = 'CS')
    order by GPA desc;

# using temporary tables
# fixed, but cumbersome without subquery

# T :=
#     project[sID, GPA] (
#         select[major = 'CS]
#             (Student join Apply)))
# project[GPA]
#     (T)
create temporary table T as
    select distinct sID, GPA
        from Student natural join Apply
        where major = 'CS';
select GPA
    from T
    order by GPA desc;

# ID of students who have applied to major in CS but not in EE

# this isn't right
# because students may be majoring CS in more than one place

# project[sID] (
#     select[(major1 = 'CS') and (major2 != 'EE')] (
#          rename[sID, cName1, major1, decision1] Apply
#          join
#          rename[sID, cName2, major2, decision2] Apply))
select distinct R.sID
    from Apply as R inner join Apply as S
    where R.sID    = S.sID and
          R.major  = 'CS'  and
          S.major != 'EE';

# this is right

# project[sID] (
#     select[major  = 'CS']
#         (Student))
# diff
# project[sID] (
#     select[major != 'EE']
#         (Student))
select sID
    from Student
    where
        sID in (
            select sID
                from Apply
                where major = 'CS')
        and
        sID not in (
            select sID
                from Apply
                where major = 'EE');

# colleges, such that there's another college in the same state

# using as for renaming
# using exists for existence

# this isn't right
# because a college is in the same state as itself

select cName, state
    from College as R
    where exists (
        select *
            from College as S
            where R.state = S.state);

# this is right

select cName, state
    from College as R
    where exists (
        select *
            from College as S
            where (R.state = S.state) and (R.cName != S.cName));

# college with highest enrollment

# using not exists for nonexistence

select cName
    from College as R
    where not exists (
        select *
            from College as S
            where R.enrollment < S.enrollment);

# student with highest GPA

select sID, sName, GPA
    from Student as R
    where not exists (
        select *
            from Student as S
            where R.GPA < S.GPA);

# using all for comparison

select sID, sName, GPA
    from Student
    where GPA >= all (
        select GPA
            from Student);

exit

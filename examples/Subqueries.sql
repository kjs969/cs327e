use downing_test;

# ----------
# subqueries
# ----------

# ID, name, and GPA of students who applied in CS

# project[sID, sName, GPA]
#   select[major = 'CS']
#       Student join Apply

select sID, sName, GPA
    from Student natural join Apply
    where major = 'CS';

select distinct sID, sName, GPA
    from Student natural join Apply
    where major = 'CS';

# ----------------------
# using subquery instead
# in for membership
# ----------------------

select sID, sName, GPA
    from Student
    where sID in (
        select sID
            from Apply
            where major = 'CS');

# --------
# order by
# --------

# GPA of students who applied in CS

# project[GPA]
#   select[major = 'CS']
#       Student join Apply

# this doesn't work

select GPA
    from Student natural join Apply
    where major = 'CS'
    order by GPA desc;

# this doesn't work either

select distinct GPA
    from Student natural join Apply
    where major = 'CS'
    order by GPA desc;

# this does work

select GPA
    from Student
    where sID in
        (select sID
            from Apply
            where major = 'CS')
    order by GPA desc;

# ----------------
# temporary tables
# ----------------

# project[GPA]
#   project[sID, sName, GPA]
#       select[major = 'CS']
#           Student join Apply

# fixed, but cumbersome without subquery

create temporary table T1a as
    select distinct sID, sName, GPA
        from Student natural join Apply
        where major = 'CS';
select GPA
    from T1a
    order by GPA desc;

# students who have applied to major in CS but not in EE

select sID, sName
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

# colleges, such that there's another college in the same state

# --------------------
# as for renaming
# exists for existence
# --------------------

select cName, state
    from College as R
    where exists
        (select *
            from College as S
            where R.state = S.state);

select cName, state
    from College as R
    where exists
        (select *
            from College as S
            where (R.state = S.state) and (R.cName != S.cName));

# college with highest enrollment

select cName
    from College as R
    where not exists
        (select *
            from College as S
            where R.enrollment < S.enrollment);

# student with highest GPA

select sID, sName, GPA
    from Student as R
    where not exists
        (select *
            from Student as S
            where R.GPA < S.GPA);

# ------------------
# all for comparison
# ------------------

select sID, sName, GPA
    from Student
    where GPA >= all
        (select GPA
            from Student);

exit

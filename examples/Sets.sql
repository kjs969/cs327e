use downing_test;

/* -----------------------------------------------------------------------
set union
names of students OR colleges

project[sName]
    (Student)
union
project[cName]
    (College)
*/

# this is not right
# because the attribute name is misleading

select sName from Student
union
select cName from College
order by sName;

# this is right

select sName as name from Student
union
select cName as name from College
order by name;

/* -----------------------------------------------------------------------
set intersection
names of students AND colleges

project[sName]
    (Student)
intersect
project[cName]
    (College)
*/

# mysql does not support intersect

# using join

select *
    from
        (select sName as name from Student) as R
        natural join
        (select cName as name from College) as S;

# using a subquery, with in

select sName as name
    from Student
    where sName in
        (select cName
            from College);

# using a subquery, with exists

select sName as name
    from Student
    where exists
        (select *
            from College
            where sName = cName);

/* -----------------------------------------------------------------------
set difference
ID of students who did not apply anywhere

project[sID]
    (Student)
diff
project[sID]
    (Apply)
*/

# mysql does not support except

# using a subquery, with not in

select sID
    from Student
    where sID not in
        (select sID
            from Apply)
    order by sID;

# using a subquery, with not exists

select sID
    from Student
    where not exists
        (select *
            from Apply
            where Student.sID = Apply.sID)
    order by sID;

/* -----------------------------------------------------------------------
pairs of names of colleges in the same state

project[cName1, cName2]
    (select[cName1 != cName2]
        rename[cName1, state, enrollment1]
            (College);
        join
        rename[cName2, state, enrollment2]
            (College);
*/

# this is not right
# because of duplicates

select cName1, cName2
    from
        (select cName as cName1, state, enrollment as enrollment1
            from College) as R
        natural join
        (select cName as cName2, state, enrollment as enrollment2
            from College) as S
    where cName1 != cName2;

# this is right

select cName1, cName2
    from
        (select cName as cName1, state, enrollment as enrollment1
            from College) as R
        natural join
        (select cName as cName2, state, enrollment as enrollment2
            from College) as S
    where cName1 < cName2;

/* -----------------------------------------------------------------------
set union
colleges with (enrollments < 20000) AND (Amy OR Irene) applied to

project[cName](
    select[(sName = 'Amy') and (enrollment < 20000)]
        (Student join Apply join College))
union
project[cName](
    select[(sName = 'Irene') and (enrollment < 20000)]
        (Student join Apply join College))
*/

select *
    from Student natural join Apply natural join College
    where (sName = 'Amy') and (enrollment < 20000)
union
select *
    from Student natural join Apply natural join College
    where (sName = 'Irene') and (enrollment < 20000)
order by cName;

select cName
    from Student natural join Apply natural join College
    where (sName = 'Amy') and (enrollment < 20000)
union
select cName
    from Student natural join Apply natural join College
    where (sName = 'Irene') and (enrollment < 20000)
order by cName;

# just using join

select *
    from Student natural join Apply natural join College
    where ((sName = 'Amy') or (sName = 'Irene')) and (enrollment < 20000)
    order by cName;

select distinct cName
    from Student natural join Apply natural join College
    where ((sName = 'Amy') or (sName = 'Irene')) and (enrollment < 20000)
    order by cName;

/* -----------------------------------------------------------------------
set intersection
colleges with (enrollments < 20000) AND (Amy AND Irene) applied to

project[cName](
    select[(sName = 'Amy') and (enrollment < 20000)]
        (Student join Apply join College))
intersect
project[cName](
    select[(sName = 'Irene') and (enrollment < 20000)]
        (Student join Apply join College))
*/

# using join

select *
    from
        (select distinct cName from
            Student natural join Apply natural join College
            where (sName = 'Amy') and (enrollment < 20000)) as R
        natural join
        (select distinct cName from
            Student natural join Apply natural join College
            where (sName = 'Irene') and (enrollment < 20000)) as S;

# using a subquery, with in

select *
    from
        (select distinct cName from
            Student natural join Apply natural join College
            where (sName = 'Amy') and (enrollment < 20000)) as R
    where cName in
        (select cName
            from Student natural join Apply natural join College
            where (sName = 'Irene') and (enrollment < 20000));

# using a subquery, with exists

select *
    from
        (select distinct cName from
            Student natural join Apply natural join College
            where (sName = 'Amy') and (enrollment < 20000)) as R
    where exists
        (select *
            from Student natural join Apply natural join College
            where (sName = 'Irene') and (enrollment < 20000) and (R.cName = cName));

exit

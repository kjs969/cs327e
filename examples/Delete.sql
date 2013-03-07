use downing_test;

/* -----------------------------------------------------------------------
students who applied to two majors
*/

select sID, count(distinct major)
    from Apply
    group by sID
    having count(distinct major) > 2;

/* -----------------------------------------------------------------------
delete those students from Student
*/

select count(*)
    from Student
    order by sID;

select *
    from Student
    order by sID;

delete
    from Student
    where sID in
        (select sID
            from Apply
            group by sID
            having count(distinct major) > 2);

select count(*)
    from Student
    order by sID;

select *
    from Student
    order by sID;

/* -----------------------------------------------------------------------
delete those students from Apply
*/

# this does not work in MySQL
# can not delete from a relation that is in a subquery

# delete
#     from Apply
#     where sID in
#         (select sID
#             from Apply
#             group by sID
#             having count(distinct major) > 2);

# create temporary table first

create temporary table T as
    select sID
        from Apply
        group by sID
        having count(distinct major) > 2;
select count(*)
    from T;
select *
    from T;
select count(*)
    from Apply
    where sID in
        (select *
            from T);
select *
    from Apply
    where sID in
        (select *
            from T);

select count(*)
    from Apply
    order by sID;

select *
    from Apply
    order by sID;

# this does work

delete
    from Apply
    where sID in
        (select *
            from T);

select count(*)
    from Apply
    order by sID;

select *
    from Apply
    order by sID;

/* -----------------------------------------------------------------------
colleges without CS applications
*/

select count(*)
    from College
    where cName not in
        (select cName
            from Apply
            where major = 'CS');

select *
    from College
    where cName not in
        (select cName
            from Apply
            where major = 'CS');

/* -----------------------------------------------------------------------
delete those colleges from College
*/

select count(*)
    from College
    order by cName;

select *
    from College
    order by cName;

delete
    from College
    where cName not in
        (select cName
            from Apply
            where major = 'CS');

select count(*)
    from College
    order by cName;

select *
    from College
    order by cName;

exit

use downing_test;

/* -----------------------------------------------------------------------
students who did not apply anywhere
*/

select count(*)
    from Student
    where sID not in
        (select sID
            from Apply)
    order by sID;

select *
    from Student
    where sID not in
        (select sID
            from Apply)
    order by sID;

/* -----------------------------------------------------------------------
have those students apply to Carnegie Mellon in CS
*/

select count(*)
    from Apply
    order by sID;

select *
    from Apply
    order by sID;

insert into Apply
    select sID, 'Carnegie Mellon', 'CS', null
        from Student
        where sID not in
            (select sID
                from Apply);

select count(*)
    from Apply
    order by sID;

select *
    from Apply
    order by sID;

/* -----------------------------------------------------------------------
students who applied to EE and were rejected
*/

select count(*)
    from Student
    where sID in
        (select sID
            from Apply
            where (major = 'EE') and (decision = false))
    order by sID;

select *
    from Student
    where sID in
        (select sID
            from Apply
            where (major = 'EE') and (decision = false))
    order by sID;

/* -----------------------------------------------------------------------
have those students apply to Carnegie Mellon in EE and be accepted
*/

select count(*)
    from Apply
    order by sID;

select *
    from Apply
    order by sID;

insert into Apply
    select sID, 'Carnegie Mellon', 'EE', true
        from Student
        where sID in
            (select sID
                from Apply
                where (major = 'EE') and (decision = false));

select count(*)
    from Apply
    order by sID;

select *
    from Apply
    order by sID;

exit

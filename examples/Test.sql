use downing_test;

select count(*)
    from Student cross join Apply;

select count(*)
    from Student, Apply;

select count(*)
    from Student inner join Apply;

select count(*)
    from Student natural join Apply;

select count(*)
    from Student cross join College;

select count(*)
    from Student, College;

select count(*)
    from Student inner join College;

select count(*)
    from Student natural join College;

exit

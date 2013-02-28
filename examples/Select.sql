use downing_test;

# ------------------------------------------------------------------------
# students with GPA > 3.7

# select[GPA > 3.7]
#    (Student)

select *
    from Student where (GPA > 3.7);

# ------------------------------------------------------------------------
# students with GPA > 3.7 with high school size < 1000

# select[(GPA > 3.7) and (sizeHS < 1000)]
#    (Student)

select *
    from Student
    where (GPA > 3.7) and (sizeHS < 1000);

# ------------------------------------------------------------------------
# applications to Stanford with major = CS

# select[(cName = 'Stanford') and (major = 'CS']
#    (Apply)

select *
    from Apply
    where (cName = 'Stanford') and (major = 'CS');

# ------------------------------------------------------------------------
# student ID and decision of applications

# project[sID, decision]
#    (Apply)

select sID, decision
    from Apply;

# ------------------------------------------------------------------------
# ID and name of students with GPA > 3.7

# project[sID, sName]
#    (select[GPA > 3.7]
#        (Student))

select sID, sName
    from Student
    where (GPA > 3.7);

# ------------------------------------------------------------------------
# major and decision of applications

# project[major, decision]
#    (Apply)

select major, decision
    from Apply;

select distinct major, decision
    from Apply;

exit

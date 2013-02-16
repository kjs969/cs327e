use downing_test;

# ----------
# subqueries
# ----------

# students who applied in CS

# select[major = 'CS'](Student join Apply)

select distinct sID, sName, GPA, sizeHS
	from Student natural join Apply
	where (major = 'CS');

select *
	from Student
	where sID in
		(select sID
			from Apply
			where (major = 'CS'));

exit

/*
CS327e: Quiz #13 (5 pts)
*/

/* -----------------------------------------------------------------------
1. Describe what the following query returns.
   (2 pts)

sID cName		major	decision	sID cName		major	decision
123 Stanford	CS		1			123 Stanford	EE		0
123 Berkeley	CS		1			123 Stanford	EE		0
123 Stanford	CS		1			123 Cornell		EE		1
123 Berkeley	CS		1			123 Cornell		EE		1
345 Cornell		CS		1			345 Cornell		EE		0
*/

select distinct *
	from Apply as R, Apply as S
	where R.sID	  = S.sID and
		  R.major = 'CS'  and
		  S.major = 'EE';

/* -----------------------------------------------------------------------
2. Describe what the following query returns.
   (2 pts)

sID cName		major	decision	sID cName		major			decision
123 Stanford	CS		1			123 Stanford	CS				1
123 Berkeley	CS		1			123 Stanford	CS				1
123 Stanford	CS		1			123 Berkeley	CS				1
123 Berkeley	CS		1			123 Berkeley	CS				1
345 Cornell		CS		1			345 MIT			bioengineering	1
345 Cornell		CS		1			345 Cornell		bioengineering	0
345 Cornell		CS		1			345 Cornell		CS				1
987 Stanford	CS		1			987 Stanford	CS				1
987 Berkeley	CS		1			987 Stanford	CS				1
987 Stanford	CS		1			987 Berkeley	CS				1
987 Berkeley	CS		1			987 Berkeley	CS				1
876 Stanford	CS		0			876 Stanford	CS				0
876 Stanford	CS		0			876 MIT			biology			1
876 Stanford	CS		0			876 MIT			marine biology	0
543 MIT			CS		0			543 MIT			CS				0
*/

select distinct *
	from Apply as R, Apply as S
	where R.sID	   = S.sID and
		  R.major  = 'CS'  and
		  S.major != 'EE';

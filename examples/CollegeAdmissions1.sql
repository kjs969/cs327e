use downing_test;

# drop

drop table if exists college;
drop table if exists student;
drop table if exists apply;

# create

create table college (
    cName      text,
    state      char(2),
    enrollment int);

create table student (
    sId    int,
    sName  text,
    GPA    float,
    sizeHS int);

create table apply (
    sId      int,
    cName    text,
    major    text,
    decision boolean);

# insert

insert into college values ("Harvard",   "MA", " 6700");
insert into college values ("MIT",       "MA", " 4500");
insert into college values ("NYU",       "NY", "10000");
insert into college values ("Princeton", "NJ", " 5100");
insert into college values ("Stanford",  "CA", " 5300");
insert into college values ("UT",        "TX", "52300");

insert into student values ("1", "Anna Karenina", "3.8", "3500");
insert into student values ("2", "Greta Garbo",   "3.5", " 900");
insert into student values ("3", "John Galt",     "4.0",  "500");
insert into student values ("4", "John Nash",     "3.9", "2500");

insert into apply values ("1", "Harvard",   "cs",         false);
insert into apply values ("1", "Stanford",  "literature", true);
insert into apply values ("2", "NYU",       "film",       true);
insert into apply values ("3", "MIT",       "cs",         true);
insert into apply values ("3", "UT",        "cs",         true);
insert into apply values ("4", "Princeton", "math",       true);
insert into apply values ("4", "UT",        "cs",         false);

# select

select * from college;
select * from student;
select * from apply;

# select

select * from student where (GPA > 3.7);
select * from student where (GPA > 3.7)    and (sizeHS < 1000);
select * from apply   where (cName = 'UT') and (major = 'cs');

# project

select sID, decision from apply;

# select and project

select sID, sName from student where (GPA > 3.7);

# select distinct

select          major, decision from apply;
select distinct major, decision from apply;

# cross join

select * from student cross join apply;

# inner join

select * from student inner join apply on (student.sId = apply.sId);

# natural join

select * from student natural join apply;

# names and GPAs of students with
#   high school size > 1000,
#   who applied to CS,
#   and were rejected

select sName, GPA from student inner join apply on (student.sId = apply.sId)
       where (sizeHS > 1000) and (major = 'cs') and (decision = false);

select sName, GPA from student natural join apply
       where (sizeHS > 1000) and (major = 'cs') and (decision = false);

# names and GPAs of students with
#   high school size > 1000,
#   who applied to CS,
#   at a college with enrollment > 20000,
#   and were rejected

select sName, GPA from student
       inner join apply   on (student.sId   = apply.sId)
       inner join college on (college.cName = apply.cName)
       where (sizeHS   > 1000)  and (major = 'cs')       and
             (decision = false) and (enrollment > 20000);

select sName, GPA from student
       natural join apply
       natural join college
       where (sizeHS   > 1000)  and (major = 'cs')       and
             (decision = false) and (enrollment > 20000);

# drop

drop table college;
drop table student;
drop table apply;

exit

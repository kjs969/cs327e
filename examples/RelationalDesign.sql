use downing_test;

/* -----------------------------------------------------------------------
Redundancy
Update Anomaly: change cornet to trumpet
Deletion Anomaly: delete surfing
*/

drop table if exists Apply;

create table Apply (
    SSN    int,
    sName  text,
    cName  text,
    HS     text,
    HScity text,
    hobby  text);

insert into Apply values (123, 'Ann', 'Stanford', 'PAHS', 'Palo Alto', 'tennis');
insert into Apply values (123, 'Ann', 'Berkeley', 'PAHS', 'Palo Alto', 'tennis');
insert into Apply values (123, 'Ann', 'MIT',      'PAHS', 'Palo Alto', 'tennis');
insert into Apply values (123, 'Ann', 'Stanford', 'GHS',  'Palo Alto', 'tennis');
insert into Apply values (123, 'Ann', 'Berkeley', 'GHS',  'Palo Alto', 'tennis');
insert into Apply values (123, 'Ann', 'MIT',      'GHS',  'Palo Alto', 'tennis');
insert into Apply values (123, 'Ann', 'Stanford', 'PAHS', 'Palo Alto', 'trumpet');
insert into Apply values (123, 'Ann', 'Berkeley', 'PAHS', 'Palo Alto', 'trumpet');
insert into Apply values (123, 'Ann', 'MIT',      'PAHS', 'Palo Alto', 'trumpet');
insert into Apply values (123, 'Ann', 'Stanford', 'GHS',  'Palo Alto', 'trumpet');
insert into Apply values (123, 'Ann', 'Berkeley', 'GHS',  'Palo Alto', 'trumpet');
insert into Apply values (123, 'Ann', 'MIT',      'GHS',  'Palo Alto', 'trumpet');
insert into Apply values (456, 'Bob', 'MIT',      'GHS',  'Palo Alto', 'surfing');

drop table if exists Apply;

/* -----------------------------------------------------------------------
Better
*/

drop table if exists Student;
drop table if exists Apply;
drop table if exists HighSchool;

create table Student (
    SSN    int,
    sName  text);

create table Apply (
    SSN    int,
    cName  text,
    hobby  text);

create table HighSchool (
    SSN    int,
    HS     text,
    HScity text);

insert into Student values (123, 'Ann');
insert into Student values (456, 'Bob');

insert into Apply values (123, 'Berkeley', 'tennis');
insert into Apply values (123, 'MIT',      'tennis');
insert into Apply values (123, 'Stanford', 'tennis');
insert into Apply values (123, 'Berkeley', 'tennis');
insert into Apply values (123, 'MIT',      'tennis');
insert into Apply values (123, 'Stanford', 'trumpet');
insert into Apply values (123, 'Berkeley', 'trumpet');
insert into Apply values (123, 'MIT',      'trumpet');
insert into Apply values (123, 'Stanford', 'trumpet');
insert into Apply values (123, 'Berkeley', 'trumpet');
insert into Apply values (123, 'MIT',      'trumpet');
insert into Apply values (456, 'MIT',      'surfing');

insert into HighSchool values (123, 'PAHS', 'Palo Alto');
insert into HighSchool values (123, 'GHS',  'Palo Alto');
insert into HighSchool values (456, 'GHS',  'Palo Alto');

drop table if exists Student;
drop table if exists Apply;
drop table if exists HighSchool;

/* -----------------------------------------------------------------------
1st Normal Form
Each column must be atomic.
*/

drop table if exists Apply;

create table Apply (
    SSN    int,
    sName  text,
    cNames text);

insert into Apply values (123, 'Ann', 'Berkeley, MIT, Stanford');
insert into Apply values (456, 'Bob', 'MIT');

drop table if exists Apply;

/* -----------------------------------------------------------------------
1st Normal Form
No repeating columns with associated data.
*/

drop table if exists Apply;

create table Apply (
    SSN    int,
    sName  text,
    cName1 text,
    cName2 text,
    cName3 test);

insert into Apply values (123, 'Ann', 'Berkeley', 'MIT', 'Stanford');
insert into Apply values (456, 'Bob', 'MIT',      null,   null);

drop table if exists Apply;

/* -----------------------------------------------------------------------
2nd Normal Form
Every non-key column is independent of every other non-key column.
*/

drop table if exists Apply;

create table Apply (
    SSN    int,
    sName  text,
    cName  text,
    cState char(2));

insert into Apply values (123, 'Ann', 'Berkeley', 'CA');
insert into Apply values (123, 'Ann', 'MIT',      'MA');
insert into Apply values (123, 'Ann', 'Stanford', 'CA');
insert into Apply values (456, 'Bob', 'MIT',      'MA');

drop table if exists Apply;

/* -----------------------------------------------------------------------
2nd Normal Form
Every non-key column is independent of every other non-key column.
*/

drop table if exists Apply;
drop table if exists College;

create table Apply (
    SSN    int,
    sName  text,
    cName  text);

create table College (
    cName  text,
    cState char(2));

insert into Apply values (123, 'Ann', 'Berkeley');
insert into Apply values (123, 'Ann', 'MIT');
insert into Apply values (123, 'Ann', 'Stanford');
insert into Apply values (456, 'Bob', 'MIT');

insert into College values ('Berkeley', 'CA');
insert into College values ('MIT',      'MA');

drop table if exists Apply;
drop table if exists College;

/* -----------------------------------------------------------------------
3rd Normal Form
Boyce-Codd Normal Form: BCNF
Functional Dependencies
SSN -> sName
*/

drop table if exists Apply;

create table Apply (
    SSN   int,
    sName text,
    cName text);

insert into Apply values (123, 'Ann', 'Berkeley');
insert into Apply values (123, 'Ann', 'MIT');
insert into Apply values (123, 'Ann', 'Stanford');
insert into Apply values (456, 'Bob', 'MIT');

drop table if exists Apply;

/* -----------------------------------------------------------------------
3rd Normal Form
BCNF
No Functional Dependencies
*/

drop table if exists Student;
drop table if exists Apply;

create table Student (
    SSN   int,
    sName text);

create table Apply (
    SSN   int,
    cName text);

insert into Student values (123, 'Ann');
insert into Student values (456, 'Bob');

insert into Apply values (123, 'Berkeley');
insert into Apply values (123, 'MIT');
insert into Apply values (123, 'Stanford');
insert into Apply values (456, 'MIT');

drop table if exists Student;
drop table if exists Apply;

/* -----------------------------------------------------------------------
4th Normal Form
No Functional Dependencies
SSN -/> cName
SSN -/> HS

Multivalued Dependencies
Redundancy
Multiplicative Effect: C colleges, H high schools results in C*H tuples
SSN ->> cName
SSN ->> HS
*/

drop table if exists Apply;

create table Apply (
    SSN   int,
    cName text,
    HS    text);

insert into Apply values (123, 'Berkeley', 'PAHS');
insert into Apply values (123, 'MIT',      'PAHS');
insert into Apply values (123, 'Stanford', 'PAHS');
insert into Apply values (123, 'Berkeley', 'GHS');
insert into Apply values (123, 'MIT',      'GHS');
insert into Apply values (123, 'Stanford', 'GHS');
insert into Apply values (456, 'MIT',      'GHS');

drop table if exists Apply;

/* -----------------------------------------------------------------------
4th Normal Form
No Functional Dependencies
No Multivalued Dependencies
C+H, not C*H tuples
*/

drop table if exists Apply;
drop table if exists HighSchool;

create table Apply (
    SSN   int,
    cName text);

create table HighSchool (
    SSN   int,
    HS    text);

insert into Apply values (123, 'Berkeley');
insert into Apply values (123, 'MIT');
insert into Apply values (123, 'Stanford');
insert into Apply values (456, 'MIT');

insert into HighSchool values (123, 'PAHS');
insert into HighSchool values (123, 'GHS');
insert into HighSchool values (456, 'GHS');

drop table if exists Apply;
drop table if exists HighSchool;

exit

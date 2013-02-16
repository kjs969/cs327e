/*
CS327e: Quiz #13 (5 pts)
*/

/* -----------------------------------------------------------------------
1. Describe what the following query returns.
   (2 pts)
*/

select distinct *
    from Apply as R, Apply as S
    where R.sID   = S.sID and
          R.major = 'CS'  and
          S.major = 'EE';

/* -----------------------------------------------------------------------
2. Describe what the following query returns.
   (2 pts)
*/

select distinct *
    from Apply as R, Apply as S
    where R.sID    = S.sID and
          R.major  = 'CS'  and
          S.major != 'EE';

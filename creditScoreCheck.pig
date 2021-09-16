-- run this in pig local mode and files to be present in local
-- to run in MR mode use path '/user/cloudera/...'
-- run this file in local,  command is    
-- pig -x local creditScoreCheck.pig

cust_us = LOAD '/home/cloudera/cust_us' using PigStorage(',') AS (name:chararray,city:chararray,score:int);

cust_ind = LOAD '/home/cloudera/cust_ind' using PigStorage(',') AS (name:chararray,city:chararray,score:int);

total_cust = UNION cust_ind, cust_us;

SPLIT total_cust INTO good_cust IF score > 5,bad_cust IF score <=5;

cust_sort = ORDER good_cust BY score DESC;

DUMP cust_sort;

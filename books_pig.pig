-- run this is MR mode but books_pig file should be in local
-- and books file should be in hdfs

books = load '/user/cloudera/pig_all/books' using PigStorage('\t') as (name:chararray, user:chararray);
-- books = load '/home/cloudera/ms_pig/books' using PigStorage('\t') as (name:chararray, user:chararray);
books_grp = group books by name;
books_cnt = foreach books_grp generate group, COUNT(books) as cnt;
books_sort = order books_cnt by cnt desc;
-- store books_sort into '/user/cloudera/ms_pig/books_count';
dump books_sort;

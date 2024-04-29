CREATE EXTENSION postgis;

\set ON_ERROR_STOP on

BEGIN;

SET max_parallel_maintenance_workers TO 80;
SET maintenance_work_mem TO '16 GB';

--CREATE EXTENSION btree_gin;

CREATE INDEX
ON tweets USING gin(to_tsvector('english',text));
--ON tweets USING gin((to_tsvector('english',text)),lang);

CREATE INDEX
ON tweet_tags(tag); 

CREATE INDEX
ON tweets(id_tweets);

CREATE INDEX
ON tweet_tags(id_tweets, tag); 

CREATE INDEX
ON tweet_tags(tag, id_tweets);

CREATE INDEX
ON tweets(lang);

COMMIT;

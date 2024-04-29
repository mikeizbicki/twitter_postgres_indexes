--CREATE EXTENSION postgis;

\set ON_ERROR_STOP on

BEGIN;
SET max_parallel_maintenance_workers TO 80;
SET maintenance_work_mem TO '16 GB';

--CREATE INDEX
--ON tweets_jsonb USING gin(data);

CREATE INDEX idx_gin_entities_hashtags ON tweets_jsonb USING gin ((data -> 'entities' -> 'hashtags') jsonb_path_ops);

COMMIT;

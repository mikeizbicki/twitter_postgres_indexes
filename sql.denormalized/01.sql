SELECT COUNT(*)
FROM tweets_jsonb
WHERE 
    (data -> 'entities' -> 'hashtags' @> '[{"text":"coronavirus"}]'::jsonb)
    OR 
    (data -> 'entities' -> 'symbols' @> '[{"text":"coronavirus"}]'::jsonb)
    OR
    (data -> 'extended_tweet'-> 'entities'  -> 'hashtags' @> '[{"text":"coronavirus"}]'::jsonb)
    OR
    (data -> 'extended_tweet'-> 'entities'  -> 'symbols' @> '[{"text":"coronavirus"}]'::jsonb);




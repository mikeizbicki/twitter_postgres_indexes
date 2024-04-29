WITH RelevantTweets AS (
    SELECT
        data
    FROM
        tweets_jsonb
    WHERE
        (data -> 'entities' -> 'hashtags' @> '[{"text":"coronavirus"}]'::jsonb)
        OR (data -> 'entities' -> 'symbols' @> '[{"text":"coronavirus"}]'::jsonb)
        OR (data -> 'extended_tweet'-> 'entities'  -> 'hashtags' @> '[{"text":"coronavirus"}]'::jsonb)
        OR (data -> 'extended_tweet'-> 'entities'  -> 'symbols' @> '[{"text":"coronavirus"}]'::jsonb)
),
HashtagExtraction AS (
    SELECT
        jsonb_array_elements_text(e.hashtags -> 'text') AS hashtag
    FROM
        RelevantTweets,
        jsonb_array_elements(data -> 'entities' -> 'hashtags') AS e(hashtags)
    UNION
    SELECT
        jsonb_array_elements_text(e.hashtags -> 'text') AS hashtag
    FROM
        RelevantTweets,
        jsonb_array_elements(data -> 'extended_tweet' -> 'entities' -> 'hashtags') AS e(hashtags)
)
SELECT
    hashtag AS tag,
    COUNT(*) AS count
FROM
    HashtagExtraction
WHERE
    hashtag <> 'coronavirus' -- Exclude the main hashtag from the results
GROUP BY
    hashtag
ORDER BY
    count DESC,
    hashtag
LIMIT 1000;

/*
 * Count the number of tweets that use #coronavirus
 */

/*
-- No way to speed up this query because of jsonb_array_elements (set returning function)
SELECT count(*)
FROM (
    SELECT DISTINCT ctid, hashtag
    FROM (
        SELECT
            ctid,
            jsonb_array_elements(data->'entities'->'hashtags')->>'text' as hashtag
        FROM tweets_jsonb
        UNION ALL
        SELECT
            ctid,
            jsonb_array_elements(data->'extended_tweet'->'entities'->'hashtags')->>'text' as hashtag
        FROM tweets_jsonb
    )t
    WHERE
        hashtag = 'coronavirus'
)t;

SELECT count(*)
FROM tweets_jsonb
WHERE data->'entities'->'hashtags'@@'$[*].text == "coronavirus"'
   OR data->'extended_tweet'->'entities'->'hashtags'@@'$[*].text == "coronavirus"';

-- thing you are searching @@ query searching for
-- tsvector @@ tsquery
-- jsonb @@ jsonbpath = jsonb selector

-- previously saw creating an expression index with a btree on a jsonb type to index user.screen_name
-- because that did not use any arrays in the json
--
-- must use the @@ syntax for entries in jsonb with arrays => GIN index ; cannot use a btree index
*/

SELECT count(*)
FROM tweets_jsonb
WHERE data@@'$.entities.hashtags[*].text == "coronavirus"'
   OR data@@'$.extended_tweet.entities.hashtags[*].text == "coronavirus"';

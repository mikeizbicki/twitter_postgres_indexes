CREATE INDEX tweets_idx ON tweets(id_tweets);
CREATE INDEX tweets_idx_gin ON tweets USING gin((to_tsvector('english',text))) WHERE lang='en';
CREATE INDEX tweet_tags_idx ON tweet_tags(id_tweets);
CREATE INDEX tweet_tags_idx2 ON tweet_tags(tag);

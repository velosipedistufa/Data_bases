EXPLAIN ANALYZE
SELECT count(*) FROM connections
WHERE connections.plan_indebtedness > 100

CREATE INDEX plan_indebtedness ON connections(plan_indebtedness)
WHERE connections.plan_indebtedness > 100
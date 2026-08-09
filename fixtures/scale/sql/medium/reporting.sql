-- Views behind the usage dashboard.
CREATE VIEW active_sessions AS
SELECT s.id, s.started_at, u.handle
FROM sessions s
JOIN users u ON u.id = s.user_id
WHERE s.ended_at IS NULL;

CREATE VIEW popular_functions AS
SELECT f.name, COUNT(fc.id) AS call_count
FROM functions f
JOIN function_calls fc ON fc.function_id = f.id
GROUP BY f.name;

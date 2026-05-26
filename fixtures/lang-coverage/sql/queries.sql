-- DML queries: SELECT, INSERT, UPDATE, DELETE
-- Note: DML does NOT produce graph nodes (DDL-only extractor)

SELECT u.name, p.title
FROM users u
JOIN posts p ON p.user_id = u.id
WHERE u.email IS NOT NULL;

INSERT INTO posts (user_id, title, body)
VALUES (1, 'Hello World', 'First post content');

UPDATE users
SET name = 'Alice Updated'
WHERE id = 1;

DELETE FROM comments
WHERE post_id = 99;

-- Schema definitions: tables, views, indexes, and foreign key references.
-- Demonstrates: CREATE TABLE with REFERENCES, CREATE VIEW, CREATE INDEX.

CREATE TABLE users (
    id    INTEGER PRIMARY KEY,
    name  TEXT    NOT NULL,
    email TEXT    UNIQUE
);

CREATE TABLE posts (
    id      INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    title   TEXT    NOT NULL,
    body    TEXT
);

CREATE TABLE comments (
    id      INTEGER PRIMARY KEY,
    post_id INTEGER NOT NULL REFERENCES posts(id),
    user_id INTEGER NOT NULL REFERENCES users(id),
    body    TEXT
);

CREATE INDEX idx_posts_user_id ON posts(user_id);

CREATE INDEX idx_comments_post_id ON comments(post_id);

CREATE VIEW active_users AS
    SELECT id, name, email
    FROM users
    WHERE email IS NOT NULL;

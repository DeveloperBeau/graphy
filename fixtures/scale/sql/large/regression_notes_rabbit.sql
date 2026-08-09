-- Free-text investigation notes for Rabbit regressions.
CREATE TABLE regression_notes_rabbit (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_rabbit_regression_idx ON regression_notes_rabbit (regression_id);

CREATE INDEX regression_notes_rabbit_regression_id_idx ON regression_notes_rabbit (regression_id);

CREATE INDEX regression_notes_rabbit_author_idx ON regression_notes_rabbit (author);

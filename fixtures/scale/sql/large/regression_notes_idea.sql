-- Free-text investigation notes for IDEA regressions.
CREATE TABLE regression_notes_idea (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    author TEXT NOT NULL DEFAULT 'maintainer',
    body TEXT NOT NULL
);

CREATE INDEX regression_notes_idea_regression_idx ON regression_notes_idea (regression_id);

CREATE INDEX regression_notes_idea_regression_id_idx ON regression_notes_idea (regression_id);

CREATE INDEX regression_notes_idea_author_idx ON regression_notes_idea (author);

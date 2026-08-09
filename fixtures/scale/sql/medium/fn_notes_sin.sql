-- Per-function notes table for sin, category trig.
CREATE TABLE fn_notes_sin (
    id BIGSERIAL PRIMARY KEY,
    function_id BIGINT NOT NULL REFERENCES functions (id),
    note TEXT NOT NULL,
    author TEXT NOT NULL DEFAULT 'maintainer',
    added_on DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE INDEX fn_notes_sin_function_idx ON fn_notes_sin (function_id);

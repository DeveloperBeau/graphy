-- Per-function notes table for ln, category analytic.
CREATE TABLE fn_notes_ln (
    id BIGSERIAL PRIMARY KEY,
    function_id BIGINT NOT NULL REFERENCES functions (id),
    note TEXT NOT NULL,
    author TEXT NOT NULL DEFAULT 'maintainer',
    added_on DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE INDEX fn_notes_ln_function_idx ON fn_notes_ln (function_id);

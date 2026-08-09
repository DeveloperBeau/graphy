-- Per-function notes table for exp, category analytic.
CREATE TABLE fn_notes_exp (
    id BIGSERIAL PRIMARY KEY,
    function_id BIGINT NOT NULL REFERENCES functions (id),
    note TEXT NOT NULL,
    author TEXT NOT NULL DEFAULT 'maintainer',
    added_on DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE INDEX fn_notes_exp_function_idx ON fn_notes_exp (function_id);

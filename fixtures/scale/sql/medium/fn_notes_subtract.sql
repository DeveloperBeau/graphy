-- Per-function notes table for subtract, category arithmetic.
CREATE TABLE fn_notes_subtract (
    id BIGSERIAL PRIMARY KEY,
    function_id BIGINT NOT NULL REFERENCES functions (id),
    note TEXT NOT NULL,
    author TEXT NOT NULL DEFAULT 'maintainer',
    added_on DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE INDEX fn_notes_subtract_function_idx ON fn_notes_subtract (function_id);

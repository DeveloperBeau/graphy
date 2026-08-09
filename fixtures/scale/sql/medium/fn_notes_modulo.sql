-- Per-function notes table for modulo, category rounding.
CREATE TABLE fn_notes_modulo (
    id BIGSERIAL PRIMARY KEY,
    function_id BIGINT NOT NULL REFERENCES functions (id),
    note TEXT NOT NULL,
    author TEXT NOT NULL DEFAULT 'maintainer',
    added_on DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE INDEX fn_notes_modulo_function_idx ON fn_notes_modulo (function_id);

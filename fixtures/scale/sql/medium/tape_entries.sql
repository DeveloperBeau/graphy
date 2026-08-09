-- The persistent history tape: one row per evaluated expression.
CREATE TABLE tape_entries (
    id BIGSERIAL PRIMARY KEY,
    expression_id BIGINT NOT NULL REFERENCES expressions (id),
    result NUMERIC NOT NULL,
    display_precision SMALLINT NOT NULL,
    entry_no INTEGER NOT NULL
);

CREATE INDEX tape_entries_entry_no_idx ON tape_entries (entry_no);

CREATE INDEX tape_entries_expression_id_idx ON tape_entries (expression_id);

CREATE INDEX tape_entries_result_idx ON tape_entries (result);

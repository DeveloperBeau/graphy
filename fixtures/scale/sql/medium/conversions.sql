-- Unit conversion calls, distinct from ordinary function calls.
CREATE TABLE conversions (
    id BIGSERIAL PRIMARY KEY,
    expression_id BIGINT NOT NULL REFERENCES expressions (id),
    from_unit_id BIGINT NOT NULL REFERENCES units (id),
    to_unit_id BIGINT NOT NULL REFERENCES units (id)
);

CREATE INDEX conversions_expression_id_idx ON conversions (expression_id);

CREATE INDEX conversions_from_unit_id_idx ON conversions (from_unit_id);

CREATE INDEX conversions_to_unit_id_idx ON conversions (to_unit_id);

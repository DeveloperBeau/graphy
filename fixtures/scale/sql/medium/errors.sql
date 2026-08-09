-- Parse and evaluation errors raised while typing.
CREATE TABLE errors (
    id BIGSERIAL PRIMARY KEY,
    expression_id BIGINT NOT NULL REFERENCES expressions (id),
    kind TEXT NOT NULL,
    message TEXT NOT NULL
);

CREATE INDEX errors_kind_idx ON errors (kind);

CREATE INDEX errors_expression_id_idx ON errors (expression_id);

CREATE INDEX errors_kind_idx ON errors (kind);

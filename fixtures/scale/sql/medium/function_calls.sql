-- Which built-in functions appeared in an expression.
CREATE TABLE function_calls (
    id BIGSERIAL PRIMARY KEY,
    expression_id BIGINT NOT NULL REFERENCES expressions (id),
    function_id BIGINT NOT NULL REFERENCES functions (id),
    arg_count SMALLINT NOT NULL DEFAULT 1
);

CREATE INDEX function_calls_expression_id_idx ON function_calls (expression_id);

CREATE INDEX function_calls_function_id_idx ON function_calls (function_id);

CREATE INDEX function_calls_arg_count_idx ON function_calls (arg_count);

-- The twenty-four built-in functions on the function row.
CREATE TABLE functions (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    category TEXT NOT NULL,
    min_args SMALLINT NOT NULL DEFAULT 1,
    max_args SMALLINT NOT NULL DEFAULT 1
);

CREATE INDEX functions_category_idx ON functions (category);

CREATE INDEX functions_name_idx ON functions (name);

CREATE INDEX functions_category_idx ON functions (category);

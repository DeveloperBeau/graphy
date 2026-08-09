-- Predefined constants such as pi, e and phi.
CREATE TABLE constants (
    id BIGSERIAL PRIMARY KEY,
    symbol TEXT NOT NULL UNIQUE,
    value NUMERIC NOT NULL,
    description TEXT
);

CREATE INDEX constants_symbol_idx ON constants (symbol);

CREATE INDEX constants_value_idx ON constants (value);

CREATE INDEX constants_description_idx ON constants (description);

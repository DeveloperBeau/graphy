-- Individual units within a conversion category.
CREATE TABLE units (
    id BIGSERIAL PRIMARY KEY,
    category_id BIGINT NOT NULL REFERENCES unit_categories (id),
    symbol TEXT NOT NULL,
    to_base_factor NUMERIC NOT NULL DEFAULT 1
);

CREATE INDEX units_category_idx ON units (category_id);

CREATE INDEX units_category_id_idx ON units (category_id);

CREATE INDEX units_symbol_idx ON units (symbol);

-- Length, mass, temperature and the other conversion families.
CREATE TABLE unit_categories (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    base_unit_symbol TEXT NOT NULL,
    display_order SMALLINT NOT NULL DEFAULT 0
);

CREATE INDEX unit_categories_name_idx ON unit_categories (name);

CREATE INDEX unit_categories_base_unit_symbol_idx ON unit_categories (base_unit_symbol);

CREATE INDEX unit_categories_display_order_idx ON unit_categories (display_order);

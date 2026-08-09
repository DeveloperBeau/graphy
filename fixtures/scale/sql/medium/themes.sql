-- The twelve bundled colour themes.
CREATE TABLE themes (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    is_dark BOOLEAN NOT NULL DEFAULT TRUE,
    accent_hex CHAR(7) NOT NULL
);

CREATE INDEX themes_is_dark_idx ON themes (is_dark);

CREATE INDEX themes_name_idx ON themes (name);

CREATE INDEX themes_is_dark_idx ON themes (is_dark);

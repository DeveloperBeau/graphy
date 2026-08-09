-- The six built-in formatting presets plus any custom ones.
CREATE TABLE presets (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    width INTEGER NOT NULL DEFAULT 80,
    wrap BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE INDEX presets_name_idx ON presets (name);

CREATE INDEX presets_name_idx ON presets (name);

CREATE INDEX presets_width_idx ON presets (width);

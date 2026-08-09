-- Persisted per-user settings, one row each.
CREATE TABLE settings (
    user_id BIGINT PRIMARY KEY REFERENCES users (id),
    precision SMALLINT NOT NULL DEFAULT 12,
    rounding_mode TEXT NOT NULL DEFAULT 'half-even',
    angle_mode TEXT NOT NULL DEFAULT 'radians',
    theme_name TEXT NOT NULL DEFAULT 'dark'
);

CREATE INDEX settings_user_id_idx ON settings (user_id);

CREATE INDEX settings_precision_idx ON settings (precision);

CREATE INDEX settings_rounding_mode_idx ON settings (rounding_mode);

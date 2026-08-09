-- Registry of the sixty cipher families the harness measures.
CREATE TABLE cipher_families (
    id BIGSERIAL PRIMARY KEY,
    slug TEXT NOT NULL UNIQUE,
    display_name TEXT NOT NULL,
    kind TEXT NOT NULL,
    group_name TEXT NOT NULL
);

CREATE INDEX cipher_families_kind_idx ON cipher_families (kind);

CREATE INDEX cipher_families_slug_idx ON cipher_families (slug);

CREATE INDEX cipher_families_display_name_idx ON cipher_families (display_name);

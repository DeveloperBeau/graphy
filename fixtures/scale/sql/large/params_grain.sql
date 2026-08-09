-- Reference parameter set the harness registers for Grain.
CREATE TABLE params_grain (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_grain_cipher_idx ON params_grain (cipher_family_id);

CREATE INDEX params_grain_cipher_family_id_idx ON params_grain (cipher_family_id);

CREATE INDEX params_grain_key_bits_idx ON params_grain (key_bits);

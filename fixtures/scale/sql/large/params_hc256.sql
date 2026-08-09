-- Reference parameter set the harness registers for HC-256.
CREATE TABLE params_hc256 (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_hc256_cipher_idx ON params_hc256 (cipher_family_id);

CREATE INDEX params_hc256_cipher_family_id_idx ON params_hc256 (cipher_family_id);

CREATE INDEX params_hc256_key_bits_idx ON params_hc256 (key_bits);

-- Reference parameter set the harness registers for CAST-256.
CREATE TABLE params_cast256 (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_cast256_cipher_idx ON params_cast256 (cipher_family_id);

CREATE INDEX params_cast256_cipher_family_id_idx ON params_cast256 (cipher_family_id);

CREATE INDEX params_cast256_key_bits_idx ON params_cast256 (key_bits);

-- Reference parameter set the harness registers for SHACAL-2.
CREATE TABLE params_shacal2 (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_shacal2_cipher_idx ON params_shacal2 (cipher_family_id);

CREATE INDEX params_shacal2_cipher_family_id_idx ON params_shacal2 (cipher_family_id);

CREATE INDEX params_shacal2_key_bits_idx ON params_shacal2 (key_bits);

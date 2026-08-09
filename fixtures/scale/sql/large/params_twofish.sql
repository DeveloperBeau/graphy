-- Reference parameter set the harness registers for Twofish.
CREATE TABLE params_twofish (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_twofish_cipher_idx ON params_twofish (cipher_family_id);

CREATE INDEX params_twofish_cipher_family_id_idx ON params_twofish (cipher_family_id);

CREATE INDEX params_twofish_key_bits_idx ON params_twofish (key_bits);

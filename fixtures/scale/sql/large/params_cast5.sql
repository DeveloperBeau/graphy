-- Reference parameter set the harness registers for CAST5.
CREATE TABLE params_cast5 (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_cast5_cipher_idx ON params_cast5 (cipher_family_id);

CREATE INDEX params_cast5_cipher_family_id_idx ON params_cast5 (cipher_family_id);

CREATE INDEX params_cast5_key_bits_idx ON params_cast5 (key_bits);

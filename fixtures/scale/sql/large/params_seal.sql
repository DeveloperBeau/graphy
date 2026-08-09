-- Reference parameter set the harness registers for SEAL.
CREATE TABLE params_seal (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_seal_cipher_idx ON params_seal (cipher_family_id);

CREATE INDEX params_seal_cipher_family_id_idx ON params_seal (cipher_family_id);

CREATE INDEX params_seal_key_bits_idx ON params_seal (key_bits);

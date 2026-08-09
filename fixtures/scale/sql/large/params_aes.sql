-- Reference parameter set the harness registers for AES.
CREATE TABLE params_aes (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_aes_cipher_idx ON params_aes (cipher_family_id);

CREATE INDEX params_aes_cipher_family_id_idx ON params_aes (cipher_family_id);

CREATE INDEX params_aes_key_bits_idx ON params_aes (key_bits);

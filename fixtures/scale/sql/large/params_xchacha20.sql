-- Reference parameter set the harness registers for XChaCha20.
CREATE TABLE params_xchacha20 (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_xchacha20_cipher_idx ON params_xchacha20 (cipher_family_id);

CREATE INDEX params_xchacha20_cipher_family_id_idx ON params_xchacha20 (cipher_family_id);

CREATE INDEX params_xchacha20_key_bits_idx ON params_xchacha20 (key_bits);

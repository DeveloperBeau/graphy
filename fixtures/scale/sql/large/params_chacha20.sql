-- Reference parameter set the harness registers for ChaCha20.
CREATE TABLE params_chacha20 (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_chacha20_cipher_idx ON params_chacha20 (cipher_family_id);

CREATE INDEX params_chacha20_cipher_family_id_idx ON params_chacha20 (cipher_family_id);

CREATE INDEX params_chacha20_key_bits_idx ON params_chacha20 (key_bits);

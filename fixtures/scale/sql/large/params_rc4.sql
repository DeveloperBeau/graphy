-- Reference parameter set the harness registers for RC4.
CREATE TABLE params_rc4 (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_rc4_cipher_idx ON params_rc4 (cipher_family_id);

CREATE INDEX params_rc4_cipher_family_id_idx ON params_rc4 (cipher_family_id);

CREATE INDEX params_rc4_key_bits_idx ON params_rc4 (key_bits);

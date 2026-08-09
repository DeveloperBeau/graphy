-- Reference parameter set the harness registers for RC5.
CREATE TABLE params_rc5 (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_rc5_cipher_idx ON params_rc5 (cipher_family_id);

CREATE INDEX params_rc5_cipher_family_id_idx ON params_rc5 (cipher_family_id);

CREATE INDEX params_rc5_key_bits_idx ON params_rc5 (key_bits);

-- Reference parameter set the harness registers for RC2.
CREATE TABLE params_rc2 (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_rc2_cipher_idx ON params_rc2 (cipher_family_id);

CREATE INDEX params_rc2_cipher_family_id_idx ON params_rc2 (cipher_family_id);

CREATE INDEX params_rc2_key_bits_idx ON params_rc2 (key_bits);

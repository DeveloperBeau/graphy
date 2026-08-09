-- Reference parameter set the harness registers for RC6.
CREATE TABLE params_rc6 (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_rc6_cipher_idx ON params_rc6 (cipher_family_id);

CREATE INDEX params_rc6_cipher_family_id_idx ON params_rc6 (cipher_family_id);

CREATE INDEX params_rc6_key_bits_idx ON params_rc6 (key_bits);

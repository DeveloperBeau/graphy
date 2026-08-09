-- Reference parameter set the harness registers for HC-128.
CREATE TABLE params_hc128 (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_hc128_cipher_idx ON params_hc128 (cipher_family_id);

CREATE INDEX params_hc128_cipher_family_id_idx ON params_hc128 (cipher_family_id);

CREATE INDEX params_hc128_key_bits_idx ON params_hc128 (key_bits);

-- Reference parameter set the harness registers for Speck.
CREATE TABLE params_speck (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_speck_cipher_idx ON params_speck (cipher_family_id);

CREATE INDEX params_speck_cipher_family_id_idx ON params_speck (cipher_family_id);

CREATE INDEX params_speck_key_bits_idx ON params_speck (key_bits);

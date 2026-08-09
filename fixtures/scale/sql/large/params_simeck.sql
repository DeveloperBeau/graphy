-- Reference parameter set the harness registers for Simeck.
CREATE TABLE params_simeck (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_simeck_cipher_idx ON params_simeck (cipher_family_id);

CREATE INDEX params_simeck_cipher_family_id_idx ON params_simeck (cipher_family_id);

CREATE INDEX params_simeck_key_bits_idx ON params_simeck (key_bits);

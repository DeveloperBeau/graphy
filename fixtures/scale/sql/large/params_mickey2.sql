-- Reference parameter set the harness registers for MICKEY.
CREATE TABLE params_mickey2 (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_mickey2_cipher_idx ON params_mickey2 (cipher_family_id);

CREATE INDEX params_mickey2_cipher_family_id_idx ON params_mickey2 (cipher_family_id);

CREATE INDEX params_mickey2_key_bits_idx ON params_mickey2 (key_bits);

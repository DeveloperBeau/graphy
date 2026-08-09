-- Reference parameter set the harness registers for SEED.
CREATE TABLE params_seed (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_seed_cipher_idx ON params_seed (cipher_family_id);

CREATE INDEX params_seed_cipher_family_id_idx ON params_seed (cipher_family_id);

CREATE INDEX params_seed_key_bits_idx ON params_seed (key_bits);

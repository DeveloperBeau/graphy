-- Reference parameter set the harness registers for ISAAC.
CREATE TABLE params_isaac (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_isaac_cipher_idx ON params_isaac (cipher_family_id);

CREATE INDEX params_isaac_cipher_family_id_idx ON params_isaac (cipher_family_id);

CREATE INDEX params_isaac_key_bits_idx ON params_isaac (key_bits);

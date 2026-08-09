-- Reference parameter set the harness registers for Serpent.
CREATE TABLE params_serpent (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_serpent_cipher_idx ON params_serpent (cipher_family_id);

CREATE INDEX params_serpent_cipher_family_id_idx ON params_serpent (cipher_family_id);

CREATE INDEX params_serpent_key_bits_idx ON params_serpent (key_bits);

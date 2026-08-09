-- Reference parameter set the harness registers for FEAL.
CREATE TABLE params_feal (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_feal_cipher_idx ON params_feal (cipher_family_id);

CREATE INDEX params_feal_cipher_family_id_idx ON params_feal (cipher_family_id);

CREATE INDEX params_feal_key_bits_idx ON params_feal (key_bits);

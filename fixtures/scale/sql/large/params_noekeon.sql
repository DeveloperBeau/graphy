-- Reference parameter set the harness registers for NOEKEON.
CREATE TABLE params_noekeon (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_noekeon_cipher_idx ON params_noekeon (cipher_family_id);

CREATE INDEX params_noekeon_cipher_family_id_idx ON params_noekeon (cipher_family_id);

CREATE INDEX params_noekeon_key_bits_idx ON params_noekeon (key_bits);

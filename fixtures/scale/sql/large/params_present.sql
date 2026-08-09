-- Reference parameter set the harness registers for PRESENT.
CREATE TABLE params_present (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_present_cipher_idx ON params_present (cipher_family_id);

CREATE INDEX params_present_cipher_family_id_idx ON params_present (cipher_family_id);

CREATE INDEX params_present_key_bits_idx ON params_present (key_bits);

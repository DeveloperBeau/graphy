-- Reference parameter set the harness registers for SHARK.
CREATE TABLE params_shark (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_shark_cipher_idx ON params_shark (cipher_family_id);

CREATE INDEX params_shark_cipher_family_id_idx ON params_shark (cipher_family_id);

CREATE INDEX params_shark_key_bits_idx ON params_shark (key_bits);

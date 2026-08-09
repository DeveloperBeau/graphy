-- Reference parameter set the harness registers for Simon.
CREATE TABLE params_simon (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_simon_cipher_idx ON params_simon (cipher_family_id);

CREATE INDEX params_simon_cipher_family_id_idx ON params_simon (cipher_family_id);

CREATE INDEX params_simon_key_bits_idx ON params_simon (key_bits);

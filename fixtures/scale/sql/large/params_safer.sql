-- Reference parameter set the harness registers for SAFER.
CREATE TABLE params_safer (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_safer_cipher_idx ON params_safer (cipher_family_id);

CREATE INDEX params_safer_cipher_family_id_idx ON params_safer (cipher_family_id);

CREATE INDEX params_safer_key_bits_idx ON params_safer (key_bits);

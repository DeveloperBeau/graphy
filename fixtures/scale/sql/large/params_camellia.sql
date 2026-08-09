-- Reference parameter set the harness registers for Camellia.
CREATE TABLE params_camellia (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_camellia_cipher_idx ON params_camellia (cipher_family_id);

CREATE INDEX params_camellia_cipher_family_id_idx ON params_camellia (cipher_family_id);

CREATE INDEX params_camellia_key_bits_idx ON params_camellia (key_bits);

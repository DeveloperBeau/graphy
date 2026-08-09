-- Reference parameter set the harness registers for BaseKing.
CREATE TABLE params_baseking (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_baseking_cipher_idx ON params_baseking (cipher_family_id);

CREATE INDEX params_baseking_cipher_family_id_idx ON params_baseking (cipher_family_id);

CREATE INDEX params_baseking_key_bits_idx ON params_baseking (key_bits);

-- Reference parameter set the harness registers for CLEFIA.
CREATE TABLE params_clefia (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_clefia_cipher_idx ON params_clefia (cipher_family_id);

CREATE INDEX params_clefia_cipher_family_id_idx ON params_clefia (cipher_family_id);

CREATE INDEX params_clefia_key_bits_idx ON params_clefia (key_bits);

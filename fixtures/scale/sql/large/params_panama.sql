-- Reference parameter set the harness registers for Panama.
CREATE TABLE params_panama (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_panama_cipher_idx ON params_panama (cipher_family_id);

CREATE INDEX params_panama_cipher_family_id_idx ON params_panama (cipher_family_id);

CREATE INDEX params_panama_key_bits_idx ON params_panama (key_bits);

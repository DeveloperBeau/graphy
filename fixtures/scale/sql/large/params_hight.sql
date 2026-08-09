-- Reference parameter set the harness registers for HIGHT.
CREATE TABLE params_hight (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_hight_cipher_idx ON params_hight (cipher_family_id);

CREATE INDEX params_hight_cipher_family_id_idx ON params_hight (cipher_family_id);

CREATE INDEX params_hight_key_bits_idx ON params_hight (key_bits);

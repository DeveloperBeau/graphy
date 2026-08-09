-- Reference parameter set the harness registers for XTEA.
CREATE TABLE params_xtea (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_xtea_cipher_idx ON params_xtea (cipher_family_id);

CREATE INDEX params_xtea_cipher_family_id_idx ON params_xtea (cipher_family_id);

CREATE INDEX params_xtea_key_bits_idx ON params_xtea (key_bits);

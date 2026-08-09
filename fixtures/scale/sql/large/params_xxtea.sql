-- Reference parameter set the harness registers for XXTEA.
CREATE TABLE params_xxtea (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_xxtea_cipher_idx ON params_xxtea (cipher_family_id);

CREATE INDEX params_xxtea_cipher_family_id_idx ON params_xxtea (cipher_family_id);

CREATE INDEX params_xxtea_key_bits_idx ON params_xxtea (key_bits);

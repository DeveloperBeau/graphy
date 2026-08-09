-- Reference parameter set the harness registers for Blowfish.
CREATE TABLE params_blowfish (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_blowfish_cipher_idx ON params_blowfish (cipher_family_id);

CREATE INDEX params_blowfish_cipher_family_id_idx ON params_blowfish (cipher_family_id);

CREATE INDEX params_blowfish_key_bits_idx ON params_blowfish (key_bits);

-- Reference parameter set the harness registers for KASUMI.
CREATE TABLE params_kasumi (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_kasumi_cipher_idx ON params_kasumi (cipher_family_id);

CREATE INDEX params_kasumi_cipher_family_id_idx ON params_kasumi (cipher_family_id);

CREATE INDEX params_kasumi_key_bits_idx ON params_kasumi (key_bits);

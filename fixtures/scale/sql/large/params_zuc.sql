-- Reference parameter set the harness registers for ZUC.
CREATE TABLE params_zuc (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_zuc_cipher_idx ON params_zuc (cipher_family_id);

CREATE INDEX params_zuc_cipher_family_id_idx ON params_zuc (cipher_family_id);

CREATE INDEX params_zuc_key_bits_idx ON params_zuc (key_bits);

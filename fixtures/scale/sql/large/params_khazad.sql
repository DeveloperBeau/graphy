-- Reference parameter set the harness registers for KHAZAD.
CREATE TABLE params_khazad (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_khazad_cipher_idx ON params_khazad (cipher_family_id);

CREATE INDEX params_khazad_cipher_family_id_idx ON params_khazad (cipher_family_id);

CREATE INDEX params_khazad_key_bits_idx ON params_khazad (key_bits);

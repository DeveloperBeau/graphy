-- Reference parameter set the harness registers for Sosemanuk.
CREATE TABLE params_sosemanuk (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_sosemanuk_cipher_idx ON params_sosemanuk (cipher_family_id);

CREATE INDEX params_sosemanuk_cipher_family_id_idx ON params_sosemanuk (cipher_family_id);

CREATE INDEX params_sosemanuk_key_bits_idx ON params_sosemanuk (key_bits);

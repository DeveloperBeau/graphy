-- Reference parameter set the harness registers for MARS.
CREATE TABLE params_mars (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_mars_cipher_idx ON params_mars (cipher_family_id);

CREATE INDEX params_mars_cipher_family_id_idx ON params_mars (cipher_family_id);

CREATE INDEX params_mars_key_bits_idx ON params_mars (key_bits);

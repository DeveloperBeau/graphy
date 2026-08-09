-- Reference parameter set the harness registers for SNOW 3G.
CREATE TABLE params_snow3g (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_snow3g_cipher_idx ON params_snow3g (cipher_family_id);

CREATE INDEX params_snow3g_cipher_family_id_idx ON params_snow3g (cipher_family_id);

CREATE INDEX params_snow3g_key_bits_idx ON params_snow3g (key_bits);

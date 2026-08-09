-- Reference parameter set the harness registers for Trivium.
CREATE TABLE params_trivium (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_trivium_cipher_idx ON params_trivium (cipher_family_id);

CREATE INDEX params_trivium_cipher_family_id_idx ON params_trivium (cipher_family_id);

CREATE INDEX params_trivium_key_bits_idx ON params_trivium (key_bits);

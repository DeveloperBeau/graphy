-- Reference parameter set the harness registers for Lucifer.
CREATE TABLE params_lucifer (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_lucifer_cipher_idx ON params_lucifer (cipher_family_id);

CREATE INDEX params_lucifer_cipher_family_id_idx ON params_lucifer (cipher_family_id);

CREATE INDEX params_lucifer_key_bits_idx ON params_lucifer (key_bits);

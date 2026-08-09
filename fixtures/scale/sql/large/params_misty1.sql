-- Reference parameter set the harness registers for MISTY1.
CREATE TABLE params_misty1 (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_misty1_cipher_idx ON params_misty1 (cipher_family_id);

CREATE INDEX params_misty1_cipher_family_id_idx ON params_misty1 (cipher_family_id);

CREATE INDEX params_misty1_key_bits_idx ON params_misty1 (key_bits);

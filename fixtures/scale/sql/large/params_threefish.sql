-- Reference parameter set the harness registers for Threefish.
CREATE TABLE params_threefish (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_threefish_cipher_idx ON params_threefish (cipher_family_id);

CREATE INDEX params_threefish_cipher_family_id_idx ON params_threefish (cipher_family_id);

CREATE INDEX params_threefish_key_bits_idx ON params_threefish (key_bits);

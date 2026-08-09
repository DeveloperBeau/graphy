-- Reference parameter set the harness registers for TEA.
CREATE TABLE params_tea (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_tea_cipher_idx ON params_tea (cipher_family_id);

CREATE INDEX params_tea_cipher_family_id_idx ON params_tea (cipher_family_id);

CREATE INDEX params_tea_key_bits_idx ON params_tea (key_bits);

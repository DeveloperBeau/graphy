-- Reference parameter set the harness registers for LEA.
CREATE TABLE params_lea (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_lea_cipher_idx ON params_lea (cipher_family_id);

CREATE INDEX params_lea_cipher_family_id_idx ON params_lea (cipher_family_id);

CREATE INDEX params_lea_key_bits_idx ON params_lea (key_bits);

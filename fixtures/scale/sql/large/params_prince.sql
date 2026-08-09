-- Reference parameter set the harness registers for PRINCE.
CREATE TABLE params_prince (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_prince_cipher_idx ON params_prince (cipher_family_id);

CREATE INDEX params_prince_cipher_family_id_idx ON params_prince (cipher_family_id);

CREATE INDEX params_prince_key_bits_idx ON params_prince (key_bits);

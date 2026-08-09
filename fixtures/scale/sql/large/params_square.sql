-- Reference parameter set the harness registers for Square.
CREATE TABLE params_square (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_square_cipher_idx ON params_square (cipher_family_id);

CREATE INDEX params_square_cipher_family_id_idx ON params_square (cipher_family_id);

CREATE INDEX params_square_key_bits_idx ON params_square (key_bits);

-- Reference parameter set the harness registers for KLEIN.
CREATE TABLE params_klein (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_klein_cipher_idx ON params_klein (cipher_family_id);

CREATE INDEX params_klein_cipher_family_id_idx ON params_klein (cipher_family_id);

CREATE INDEX params_klein_key_bits_idx ON params_klein (key_bits);

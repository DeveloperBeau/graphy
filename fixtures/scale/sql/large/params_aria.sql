-- Reference parameter set the harness registers for ARIA.
CREATE TABLE params_aria (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_aria_cipher_idx ON params_aria (cipher_family_id);

CREATE INDEX params_aria_cipher_family_id_idx ON params_aria (cipher_family_id);

CREATE INDEX params_aria_key_bits_idx ON params_aria (key_bits);

-- Reference parameter set the harness registers for 3-Way.
CREATE TABLE params_threeway (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_threeway_cipher_idx ON params_threeway (cipher_family_id);

CREATE INDEX params_threeway_cipher_family_id_idx ON params_threeway (cipher_family_id);

CREATE INDEX params_threeway_key_bits_idx ON params_threeway (key_bits);

-- Reference parameter set the harness registers for Anubis.
CREATE TABLE params_anubis (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_anubis_cipher_idx ON params_anubis (cipher_family_id);

CREATE INDEX params_anubis_cipher_family_id_idx ON params_anubis (cipher_family_id);

CREATE INDEX params_anubis_key_bits_idx ON params_anubis (key_bits);

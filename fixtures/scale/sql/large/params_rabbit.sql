-- Reference parameter set the harness registers for Rabbit.
CREATE TABLE params_rabbit (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_rabbit_cipher_idx ON params_rabbit (cipher_family_id);

CREATE INDEX params_rabbit_cipher_family_id_idx ON params_rabbit (cipher_family_id);

CREATE INDEX params_rabbit_key_bits_idx ON params_rabbit (key_bits);

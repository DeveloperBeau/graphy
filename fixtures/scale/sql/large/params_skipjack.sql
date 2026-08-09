-- Reference parameter set the harness registers for Skipjack.
CREATE TABLE params_skipjack (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_skipjack_cipher_idx ON params_skipjack (cipher_family_id);

CREATE INDEX params_skipjack_cipher_family_id_idx ON params_skipjack (cipher_family_id);

CREATE INDEX params_skipjack_key_bits_idx ON params_skipjack (key_bits);

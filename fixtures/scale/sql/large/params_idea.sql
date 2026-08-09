-- Reference parameter set the harness registers for IDEA.
CREATE TABLE params_idea (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_idea_cipher_idx ON params_idea (cipher_family_id);

CREATE INDEX params_idea_cipher_family_id_idx ON params_idea (cipher_family_id);

CREATE INDEX params_idea_key_bits_idx ON params_idea (key_bits);

-- Reference parameter set the harness registers for Kuznyechik.
CREATE TABLE params_kuznyechik (
    id BIGSERIAL PRIMARY KEY,
    cipher_family_id BIGINT NOT NULL REFERENCES cipher_families (id),
    key_bits SMALLINT NOT NULL,
    block_bits SMALLINT,
    rounds SMALLINT
);

CREATE INDEX params_kuznyechik_cipher_idx ON params_kuznyechik (cipher_family_id);

CREATE INDEX params_kuznyechik_cipher_family_id_idx ON params_kuznyechik (cipher_family_id);

CREATE INDEX params_kuznyechik_key_bits_idx ON params_kuznyechik (key_bits);

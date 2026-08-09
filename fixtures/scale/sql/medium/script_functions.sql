-- User-defined functions declared inside a saved script.
CREATE TABLE script_functions (
    id BIGSERIAL PRIMARY KEY,
    script_id BIGINT NOT NULL REFERENCES scripts (id),
    name TEXT NOT NULL,
    arity SMALLINT NOT NULL DEFAULT 1
);

CREATE INDEX script_functions_script_id_idx ON script_functions (script_id);

CREATE INDEX script_functions_name_idx ON script_functions (name);

CREATE INDEX script_functions_arity_idx ON script_functions (arity);

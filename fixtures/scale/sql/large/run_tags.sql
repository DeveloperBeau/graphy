-- Many-to-many link between runs and tags.
CREATE TABLE run_tags (
    run_id BIGINT NOT NULL REFERENCES runs (id),
    tag_id BIGINT NOT NULL REFERENCES tags (id),
    PRIMARY KEY (run_id, tag_id)
);

CREATE INDEX run_tags_run_id_idx ON run_tags (run_id);

CREATE INDEX run_tags_tag_id_idx ON run_tags (tag_id);

-- Aggregated match counts per rule per job, for tuning presets.
CREATE TABLE rule_hits (
    id BIGSERIAL PRIMARY KEY,
    colour_rule_id BIGINT NOT NULL REFERENCES colour_rules (id),
    job_id BIGINT NOT NULL REFERENCES jobs (id),
    hit_count INTEGER NOT NULL DEFAULT 0
);

CREATE INDEX rule_hits_rule_idx ON rule_hits (colour_rule_id);

CREATE INDEX rule_hits_colour_rule_id_idx ON rule_hits (colour_rule_id);

CREATE INDEX rule_hits_job_id_idx ON rule_hits (job_id);

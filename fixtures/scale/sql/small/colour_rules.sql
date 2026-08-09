-- Named pattern-to-colour rules attached to a preset.
CREATE TABLE colour_rules (
    id BIGSERIAL PRIMARY KEY,
    preset_id BIGINT NOT NULL REFERENCES presets (id),
    pattern TEXT NOT NULL,
    colour_name TEXT NOT NULL,
    rule_order SMALLINT NOT NULL DEFAULT 0
);

CREATE INDEX colour_rules_preset_idx ON colour_rules (preset_id, rule_order);

CREATE INDEX colour_rules_preset_id_idx ON colour_rules (preset_id);

CREATE INDEX colour_rules_pattern_idx ON colour_rules (pattern);

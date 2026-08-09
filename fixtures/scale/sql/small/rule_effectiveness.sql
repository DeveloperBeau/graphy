-- How often each colour rule actually fires.
CREATE VIEW rule_effectiveness AS
SELECT r.pattern, r.colour_name, SUM(h.hit_count) AS total_hits
FROM colour_rules r
JOIN rule_hits h ON h.colour_rule_id = r.id
GROUP BY r.pattern, r.colour_name;

CREATE INDEX colour_rules_colour_idx ON colour_rules (colour_name);

CREATE INDEX job_errors_job_idx ON job_errors (job_id);

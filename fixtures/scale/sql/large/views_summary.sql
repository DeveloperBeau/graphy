-- Dashboard rollups.
CREATE VIEW latest_stable_summaries AS
SELECT rs.id, rs.median_throughput, cf.display_name
FROM run_summaries rs
JOIN cipher_families cf ON cf.id = rs.cipher_family_id
WHERE rs.stable = TRUE;

CREATE VIEW open_regressions AS
SELECT r.id, r.metric, r.delta_percent, cf.display_name
FROM regressions r
JOIN cipher_families cf ON cf.id = r.cipher_family_id;

-- Fleet health rollups.
CREATE VIEW machine_run_counts AS
SELECT m.name, COUNT(r.id) AS run_count
FROM machines m
JOIN runs r ON r.machine_id = m.id
GROUP BY m.name;

CREATE VIEW unstable_pairs AS
SELECT rs.cipher_family_id, rs.run_id
FROM run_summaries rs
WHERE rs.stable = FALSE;

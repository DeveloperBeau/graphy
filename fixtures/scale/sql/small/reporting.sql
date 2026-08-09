-- Dashboards behind the daemon status page.
CREATE VIEW running_jobs AS
SELECT j.id, j.started_at, q.name AS queue_name
FROM jobs j
JOIN queues q ON q.id = j.queue_id
WHERE j.finished_at IS NULL;

CREATE VIEW failing_jobs AS
SELECT j.id, e.message, e.exit_code
FROM jobs j
JOIN job_errors e ON e.job_id = j.id;

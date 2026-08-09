-- Calibration workload results per machine.
CREATE TABLE calibrations (
    id BIGSERIAL PRIMARY KEY,
    machine_id BIGINT NOT NULL REFERENCES machines (id),
    performed_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    baseline_score NUMERIC NOT NULL
);

CREATE INDEX calibrations_machine_id_idx ON calibrations (machine_id);

CREATE INDEX calibrations_performed_at_idx ON calibrations (performed_at);

CREATE INDEX calibrations_baseline_score_idx ON calibrations (baseline_score);

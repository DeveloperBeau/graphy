-- Maintainer sign-off on a flagged regression.
CREATE TABLE reviews (
    id BIGSERIAL PRIMARY KEY,
    regression_id BIGINT NOT NULL REFERENCES regressions (id),
    maintainer_id BIGINT NOT NULL REFERENCES maintainers (id),
    reviewed_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    verdict TEXT NOT NULL DEFAULT 'pending'
);

CREATE INDEX reviews_regression_id_idx ON reviews (regression_id);

CREATE INDEX reviews_maintainer_id_idx ON reviews (maintainer_id);

CREATE INDEX reviews_reviewed_at_idx ON reviews (reviewed_at);

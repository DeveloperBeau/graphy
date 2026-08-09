-- In-app feedback form submissions.
CREATE TABLE feedback (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users (id),
    submitted_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    message TEXT NOT NULL,
    category TEXT NOT NULL DEFAULT 'general'
);

CREATE INDEX feedback_user_id_idx ON feedback (user_id);

CREATE INDEX feedback_submitted_at_idx ON feedback (submitted_at);

CREATE INDEX feedback_message_idx ON feedback (message);

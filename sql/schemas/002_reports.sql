-- +goose Up
CREATE TABLE event_reports (
    event_id BIGINT NOT NULL,
    attendance_count int NOT NULL,
    mean_reviews float NOT NULL,

    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

ALTER TABLE event_reports ADD CONSTRAINT event_analytics_id_fkey FOREIGN KEY (event_id) REFERENCES events(id);

-- +goose Down
DROP TABLE event_reports;

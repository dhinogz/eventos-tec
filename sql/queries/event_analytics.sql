-- name: QueryAttendace :one
SELECT 
    COUNT(*) AS attendance_count
FROM event_registers
WHERE event_id = $1 AND did_attend = TRUE;

-- name: QueryMeanReviews :one
SELECT 
    AVG(rating) AS mean_reviews
FROM reviews
WHERE event_id = $1;

-- name: InsertEventAnalytics :exec
INSERT INTO event_reports (event_id, attendance_count, mean_reviews, created_at, active)
VALUES ($1, $2, $3, NOW(), TRUE);

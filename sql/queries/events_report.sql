-- name: GetEventsReport :many
SELECT e.id, e.title, e.description, e.date, e.venue, e.is_online, e.meeting_link, e.capacity, o.name as organization_name, er.attendance_count as event_attendance, er.mean_reviews as event_rating
FROM events e
JOIN organization o ON o.id = e.organization_id
JOIN event_reports er ON er.event_id = e.id;
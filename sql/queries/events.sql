-- name: GetAllEvents :many
SELECT e.id, e.title, e.date, e.venue, e.is_online, e.meeting_link, e.capacity, o.name as organization_name
FROM events e
JOIN organization o ON o.id = e.organization_id;

-- name: GetEventDetails :one
SELECT e.id, e.title, e.description, e.venue, e.is_online, e.capacity, o.name as organization_name
FROM events e
JOIN organization o ON o.id = e.organization_id
WHERE e.id = $1 AND e.active = true;

-- name: InsertEvent :exec
INSERT INTO events (
    organization_id,
    title,
    description,
    capacity,
    date,
    duration,
    venue,
    is_online,
    meeting_link
) VALUES (
    $1,  -- organization_id
    $2,  -- title
    $3,  -- description
    $4,  -- capacity
    $5,  -- date
    $6,  -- duration
    $7,  -- venue
    $8,  -- is_online
    $9   -- meeting_link
);

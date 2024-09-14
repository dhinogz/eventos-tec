-- name: CreateUser :one
INSERT INTO users (email, hashed_password)
VALUES ($1, $2)
RETURNING *;

-- name: GetUser :one
SELECT u.id, u.email, u.hashed_password
FROM sessions s
JOIN users u ON u.user_id = s.user_id
WHERE s.token_hash = $1;

-- name: GetAllUsers :many
SELECT u.id, u.email, u.hashed_password
FROM users u;

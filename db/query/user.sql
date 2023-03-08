-- name: CreateUser :one
INSERT INTO users (
  username,
  hashed_password,
  full_name,
  email
) VALUES (
  $1, $2, $3, $4
) RETURNING *;

-- name: GetUser :one
SELECT * FROM users
WHERE username = $1 LIMIT 1;

-- name: UpdateUser :one
UPDATE users
SET
  hashed_password = COALESCE(sqlc.arg(hashed_password), hashed_password),
  password_changed_at = COALESCE(sqlc.arg(password_changed_at), password_changed_at),
  full_name = COALESCE(sqlc.arg(full_name), full_name),
  email = COALESCE(sqlc.arg(email), email)
WHERE
  username = sqlc.arg(username)
RETURNING *;

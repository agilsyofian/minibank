DB_URL=postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable

createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_bank

new_migration:
	migrate create -ext sql -dir db/migrations -seq $(name)

migrateup:
	migrate -path db/migrations -database "$(DB_URL)" -verbose up

migratedown:
	migrate -path db/migrations -database "$(DB_URL)" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover -short ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/agilsyofian/minibank/db/sqlc Store

.PHONY: createdb new_migration migrateup migratedown sqlc server

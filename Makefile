postgres:
	docker run --name postgres-go -p 1234:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine

createdb:
	docker exec -it postgres-go createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres-go dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:1234/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:1234/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc
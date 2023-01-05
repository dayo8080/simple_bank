postgres:
	docker run --name bank-postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15-alpine

createdb:
	docker exec -it bank-postgres createdb simple_bank

dropdb:
	docker exec -it bank-postgres dropdb simple_bank
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc
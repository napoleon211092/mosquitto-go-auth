all:
	go build -buildmode=c-archive go-auth.go
	go build -buildmode=c-shared -o go-auth.so
	go build pw-gen/pw.go

dev-requirements:
	go get -u github.com/golang/dep/cmd/dep
	go get -u github.com/smartystreets/goconvey

test:
	go test ./backends ./cache ./hashing -v -bench=none -count=1

test-backends:
	go test ./backends -v -failfast -bench=none -count=1

test-cache:
	go test ./cache -v -failfast -bench=none -count=1

test-hashing:
	go test ./hashing -v -failfast -bench=none -count=1

benchmark:
	go test ./backends -v -bench=. -run=^a

service:
	@echo "Generating gRPC code from .proto files"
	@go generate grpc/grpc.go
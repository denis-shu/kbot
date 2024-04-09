APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=denisshum
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=amd64
MIMAGE_TAG=myapp:latest

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/denis-shu/kbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push: 
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	docker rmi $(MIMAGE_TAG) || true

linux:
	CGO_ENABLED=0 GOOS=${linux} GOARCH=${amd64} go build -v -o kbot -ldflags "-X="github.com/denis-shu/kbot/cmd.appVersion=${VERSION}

arm:
	CGO_ENABLED=0 GOOS=${linux} GOARCH=${arm} go build -v -o kbot -ldflags "-X="github.com/denis-shu/kbot/cmd.appVersion=${VERSION}

macos:
	CGO_ENABLED=0 GOOS=${darwin} GOARCH=${amd64} go build -v -o kbot -ldflags "-X="github.com/denis-shu/kbot/cmd.appVersion=${VERSION}

windows:
	CGO_ENABLED=0 GOOS=${windows} GOARCH=${amd64} go build -v -o kbot -ldflags "-X="github.com/denis-shu/kbot/cmd.appVersion=${VERSION}

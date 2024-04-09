format:
	gofmt -s -w ./

build:
	go build  -v -o kbot -ldflags "-X=github.com/denis-shu/kbot/cmd.appVersion=${VERSION}"
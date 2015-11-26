# Variables to be used within the Makefile
GO_SOURCE := $(shell find . -name '*.go')
GO_PATH := $(shell pwd)/.gobuild
USERNAME := luebken
GO_PROJECT_PATH := $(GO_PATH)/src/github.com/$(USERNAME)

.PHONY=all deps httplog

# The default target when you issue 'make'
all: deps httplog

deps: .gobuild
.gobuild:
	mkdir -p $(GO_PROJECT_PATH)
	cd $(GO_PROJECT_PATH) && ln -s ../../../.. httplog

	# Fetch public packages
	GOPATH=$(GO_PATH) go get -d github.com/$(USERNAME)/httplog

# Compiling the Golang binary for Linux from main.go and libraries.
# We actually use another Docker container for this to ensure
# this works even on non-Linux systems.
httplog: $(GO_SOURCE)
	echo Building for linux/amd64
	docker run \
		--rm \
		-it \
		-v $(shell pwd):/usr/code \
		-e GOPATH=/usr/code/.gobuild \
		-e GOOS=linux \
		-e GOARCH=amd64 \
		-w /usr/code \
		golang:1.5.1 \
		go build -a -o httplog

clean:
	rm httplog
	rm -rf $(GO_PATH)
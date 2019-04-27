IMAGE = andydude64/pause
IMAGE_TAG = $(shell cat VERSION)

.PHONY: all
all: build

.PHONY: build
build: $(FILES)
	docker build -t $(IMAGE):$(IMAGE_TAG) .

.PHONY: push
push:
	docker push $(IMAGE):$(IMAGE_TAG)

.PHONY: run
run:
	docker run -it $(IMAGE):$(IMAGE_TAG)

.PHONY: clean
clean:

IMAGE = andydude64/pause
IMAGE_TAG = $(shell cat VERSION)

FILES = \
  pause-tiny

EXTRA_FILES = \
  pause-tiny.o

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
	docker run -it --init $(IMAGE):$(IMAGE_TAG)

.PHONY: clean
clean:
	rm -f $(EXTRA_FILES)
	rm -f $(FILES)

pause-tiny:
	as -o pause-tiny.o pause-tiny.s
	dd if=pause-tiny.o of=pause-tiny bs=16 skip=4 count=7
	chmod a+x pause-tiny

# Alternatively,
.PHONY: pause-tiny-hex
pause-tiny-hex:
	xxd -r pause-tiny.hex pause-tiny
	chmod a+x pause-tiny

.PHONY: all
all: nsenter1-small nsenter1-tiny

.PHONY: clean
clean:
	rm -f *.o
	rm nsenter1-small

nsenter1-small:
	gcc -static -nostdlib -o nsenter1-small nsenter1-small.c

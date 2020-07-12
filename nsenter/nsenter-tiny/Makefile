.PHONY: all
all: nsenter1-small nsenter1-tiny

.PHONY: clean
clean:
	rm -f *.o
	rm nsenter1-tiny

nsenter1-tiny:
	as -o nsenter1-tiny.o nsenter1-tiny.s
	dd if=nsenter1-tiny.o of=nsenter1-tiny bs=16 skip=4 count=23
	chmod a+x nsenter1-tiny

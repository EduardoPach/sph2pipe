build:
	gcc -o sph2pipe *.c -lm -Wno-pointer-sign

clean:
	rm -f sph2pipe

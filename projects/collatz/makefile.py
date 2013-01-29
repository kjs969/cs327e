run:
	RunCollatz.py < RunCollatz.in

diff:
	RunCollatz.py < RunCollatz.in > RunCollatz.tmp
	diff RunCollatz.out RunCollatz.tmp
	rm RunCollatz.tmp

test:
	TestCollatz.py

zip:
	zip -r Collatz.zip EADME.txt makefile Collatz.html Collatz.log Collatz.py \
	RunCollatz.in RunCollatz.out RunCollatz.py SphereCollatz.py \
	TestCollatz.py TestCollatz.out

clean:
	rm -f *.pyc
	rm -f *.tmp

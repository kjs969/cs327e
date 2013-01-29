run:
	RunCollatz.py < RunCollatz.in

diff:
	RunCollatz.py < RunCollatz.in > RunCollatz.tmp
	diff RunCollatz.out RunCollatz.tmp
	rm RunCollatz.tmp

test:
	TestCollatz.py

turnin-list:
	turnin --list hychyc07 cs372epj1

turnin-submit:
	turnin --submit hychyc07 cs372epj1 Collatz.zip

turnin-verify:
	turnin --verify hychyc07 cs372epj1

zip:
	zip -r Collatz.zip README.txt makefile Collatz.html Collatz.log Collatz.py \
	RunCollatz.in RunCollatz.out RunCollatz.py SphereCollatz.py \
	TestCollatz.py TestCollatz.out

clean:
	rm -f *.pyc
	rm -f *.tmp

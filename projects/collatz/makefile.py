run:
	RunCollatz.py < RunCollatz.in

diff:
	RunCollatz.py < RunCollatz.in > RunCollatz.tmp
	diff RunCollatz.out RunCollatz.tmp
	rm RunCollatz.tmp

test:
	TestCollatz.py

clean:
	rm -f *.pyc
	rm -f *.tmp

RunCollatz.class: RunCollatz.java Collatz.java
	javac -Xlint RunCollatz.java

run: RunCollatz.class
	java -ea RunCollatz < RunCollatz.in

diff: RunCollatz.class
	java -ea RunCollatz < RunCollatz.in > RunCollatz.tmp
	diff RunCollatz.out RunCollatz.tmp
	rm RunCollatz.tmp

TestCollatz.class: TestCollatz.java Collatz.java
	javac -Xlint TestCollatz.java

test: TestCollatz.class
	java -ea TestCollatz

clean:
	rm -f *.class
	rm -f *.tmp

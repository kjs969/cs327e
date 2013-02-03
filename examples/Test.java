// --------------
// Arguments.java
// --------------

import java.util.Arrays;

class A extends Exception {}
class B extends A {}

class C {
    void f () throws B {}}

class D {
    void f () throws A {}}

final class Test {

    public static void main (String[] args) throws A {
        System.out.println("Arguments.java");

        C x = new C();
        x.f();

        System.out.println("Done.");}}

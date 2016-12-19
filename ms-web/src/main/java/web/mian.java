package web;

/**
 * Created by sjzc66 on 2016/12/8.
 */
public class mian {

}

class A {
    public A() {
        System.out.println("1 ");
    }

    {
        System.out.println("2 ");
    }

    static {
        System.out.println("3 ");
    }
}

class B extends A {
    public B() {
        System.out.println("4 ");
    }

    {
        System.out.println("5 ");
    }

    static {
        System.out.println("6 ");
    }

    public static void main(String[] args) {
        new B();
    }
}

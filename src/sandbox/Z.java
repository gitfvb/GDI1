package sandbox;

public class Z extends Y {

	static int b = 3;
	
	int get() {
		return b + a;
	}
	
	static int get (X x) {
		return x.a;
	}
	
	static void set (int i) {
		a = 3 * i;
	}
	
	static void set (X x, int i) {
		a = i;
	}
	
	static void test() {
		Z z = new Z();
		
		System.out.println(Y.a); // 7
		System.out.println(get(z)); // 4
		
		Z.set('c' - 'a' - 1); // c = 99; a = 97 -> 1
		System.out.println(get(z)); // 4
		System.out.println(z.get()); // 6
		
		Y y = z;
		Y.set(2);
		System.out.println(z.get() + 1); // 6
		Z.set(y, 0);
		System.out.println(y.get() + 4); // 7 
	}
	
	public static void main(String[] args) {
		Z.test();
	}

}

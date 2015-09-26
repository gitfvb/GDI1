package sandbox;

public class Y extends X {

	static int a = 7;
	
	int get() {
		return a;
	}
	
	static void set (int x) {
		a = x;
	}
	
	static void set (char c) {
		a = 2 * c;
	}
	
}

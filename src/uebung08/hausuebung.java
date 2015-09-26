package uebung08;
public class hausuebung {

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		// Variablen
		int x = 2;
		int number = 10;
		int count = 1;

		// Prozess mit einer while-Schleife
		count = 1;
		while (Math.pow(x, count) <= number) {
			count++;
		}
		System.out.println("while-Schleife: " + count);

		// Prozess mit einer for-Schleife
		count = 1;
		for (int i = 1; Math.pow(x, i) <= number; i++) {
			count++;
		}
		System.out.println("for-Schleife: " + count);

		// Prozess mit einer do while-Schleife
		count = 1;
		do {
			count++;
		} while (Math.pow(x, count) <= number);
		System.out.println("do-while-Schleife: " + count);

	}

}

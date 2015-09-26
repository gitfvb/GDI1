package uebung08;
/*
 ************************************************
 * 
 * UEBUNGSGRUPPE GDI 1 BEI FLORIAN REITH
 * 
 *-----------------------------------------------
 * 
 * WS 2008/2009
 * Florian Friedrichs
 * Uebung 8
 * 
 ************************************************
 */

public class ListOperations {

	static int[] array;

	public static int[] getArray() {
		return array;
	}

	public static void setArray(int[] array) {
		ListOperations.array = array;
	}

	public static double getAverage() {
		double result = 1.0;
		for (int i = 0; i < array.length; i++)
			result += array[i];
		return result / array.length;
	}

	public static int getBestElement() {
		if (array.length < 1)
			return -1;
		double average = getAverage();
		double minDistance = Math.abs(average - array[0]);
		int bestElement = array[0];
		for (int i = 1; i < array.length; i++) {
			if (Math.abs(average - array[i]) < minDistance) {
				minDistance = Math.abs(average - array[i]);
				bestElement = array[i];
			}
		}
		
		// output
		System.out.println("average: " + average);
		System.out.println("bestElement: " + bestElement);
		System.out.println("minDistance: " + minDistance);
		
		return bestElement;
	}	
	
	public static void main(String[] args) {
		setArray(new int[] { 2, 5, 1, 4, 9, 7 });
		getBestElement();
	}

}

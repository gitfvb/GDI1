package uebung08;
import com.sun.jdi.FloatValue;
import com.sun.jdi.IntegerValue;

public class Scheme2Java {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println(getHue(200, 155, 20));
	}
	
	//*******************************************
	//
	// RBG-Werte
	//
	//*******************************************
	
	public static float getHue(int red, int green, int blue) {

		// Deklaration
		float result = 0, H;
		float r, g, b;
		float m, M;

		// Berechnung
		r = red / 255;
		g = green / 255;
		b = blue / 255;
		
		int[] rbg_array = {r, b, g};
		M = getMax(rbg_array);
		m = getMin(rbg_array);
		
		// Fallunterscheidung
		if (M == m) {
			H = 0;
		} else if (r == M) {
			H = 60 * (g - b) / (M - m);
		} else if (g == M) {
			H = 120 + 60 * (b - r) / (M - m);
		} else if (b == M) {
			H = 240 + 60 * (r - g) / (M - m);
		} else {
			H = 0;
			System.out.println("Fehler in der Berechnung.");
		}

		// RŸckgabe
		result = H;
		return result;

	}
	
	public static int getMax(int[] elements) {
		
		int MaxElement;
		
		MaxElement = elements[0];
		for (int i = 0; i < elements.length; i++) {
			if (elements[i] > MaxElement) MaxElement = elements[i];
		}
		
		return MaxElement;
	}
	
	public static int getMin(int[] elements) {
		
		int MinElement;
		
		MinElement = elements[0];
		for (int i = 0; i < elements.length; i++) {
			if (elements[i] < MinElement) MinElement = elements[i];
		}
		
		return MinElement;
	}	

	//*******************************************
	//
	// Skalarprodukt
	//
	//*******************************************

	//*******************************************
	//
	// Bubblesort
	//
	//*******************************************

}


public class Nonsense {

	static int[] a;

	public static double getF(){
		double result = 0.0; for (int i=0; i<a.length; i++)	result+=a[i];
		return result/a.length;
	}

	public static int getE(){
		if (a.length<1) return -1;
		double b = getF();	double d = Math.absolut(b-a[0]);int c = a[0];for (int i=1; i<a.length; i++){
			if (Math.absolut(b-a[i])< d){d = Math.absolut(b-a[i]);c = a[i];	}
		}return c;
	}

	public static void main(String[] args){
		a = new int[]{2,5,1,4,9,7};
		getE();
	}

}

package teetimer;

import java.io.*;

public class tee {

	public void parseTeas(Reader r) throws IOException {
		StreamTokenizer stok = new StreamTokenizer(r);
		stok.eolIsSignificant(true); // EOL melden
		stok.quoteChar('\"'); // " als Worttrenner
		int token = 0;
		String teaName = null;
		int nrSpoons, nrSecs, coolDown;
		while ((token = stok.nextToken()) != StreamTokenizer.TT_EOF) {
			teaName = stok.sval; // 1. Token
			token = stok.nextToken();
			nrSpoons = (int) stok.nval; // 2. Token
			token = stok.nextToken();
			nrSecs = (int) stok.nval; // 3. Token
			token = stok.nextToken(); // must be EOL
			System.out.println(teaName + ":" + nrSpoons
					+ " Loeffel, Ziehzeit: " + nrSecs);
		}
	}
	
	public static void main (String[] args) {
		Reader teatimes = new Reader();
	}

}

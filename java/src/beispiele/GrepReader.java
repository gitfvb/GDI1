import java.io.BufferedReader;
import java.io.FilterReader;
import java.io.IOException;

class GrepReader extends FilterReader {

	String substring;
	BufferedReader in;

	GrepReader(BufferedReader reader, String pattern) {
		super(reader);
		in = reader;
		substring = pattern;
	}
	// return the next line containing the search pattern
	String readLine() throws IOException {
		String line;
		while (((line = in.readLine()) != null) && 
				(line.indexOf(substring) == -1)) ;

		return line;
	}
}

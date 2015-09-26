import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
public class Grep {
	public static void main(String[] args) {
		if ((args.length == 0) || (args.length > 2)) {
			System.out.println("Usage: java Grep <substring> [<filename>]");
			System.exit(0);
		}
		try {
			Reader d;
			if (args.length == 2) 
				d = new FileReader(args[1]);
			else 
				d = new InputStreamReader(System.in);
			GrepReader g = new GrepReader(new BufferedReader(d), args[0]);
			String line;
			while ((line = g.readLine()) != null) System.out.println(line);
			g.close();
		} 
		catch (IOException e) { System.err.println(e); }
	}
}

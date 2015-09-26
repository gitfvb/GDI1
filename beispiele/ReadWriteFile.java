import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class ReadWriteFile {
  // constructor etc.
	public static void main(String[] args) {
		ReadWriteFile rwf = new ReadWriteFile();
		try {
		rwf.writeAToZ("ascii.txt");
		rwf.readFrom("ascii.txt");
		} catch(IOException e) {
			System.err.println(e.getMessage());
		}
	}

  public void readFrom(String fileName) throws IOException {
	 FileReader in = new FileReader(fileName);
	 int b;
    while ((b = in.read()) != -1) System.out.print((char)b); 
    in.close();
  }

  public void writeAToZ(String filename) throws IOException {
    FileWriter out = new FileWriter(filename);
    for (char c = 'a'; c <= 'z'; c++) out.write(c);
    out.close();
  } 
  // main() etc.
}

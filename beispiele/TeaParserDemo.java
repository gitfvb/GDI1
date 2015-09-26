import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.io.StreamTokenizer;

import java.util.Vector;

public class TeaParserDemo {
  // the list of parsed teas
  private Vector<Tea> teas = null;
  
  /**
   * creates a new TeaParserDemo by parsing from the filename
   *
   * @param filename the name of the file to be parsed
   * @throws IOException if the parsing fails
   */
  public TeaParserDemo(String filename) throws IOException {
	Reader reader = null;
    if (filename != null) {
      reader = new BufferedReader(new FileReader(filename));
      parseTeas(reader);
    }
  }
   
  /** 
   * prints the list of teas
   */
  public void dumpTeas() {
    if (teas == null || teas.size() == 0)
      System.out.println("No teas parsed in.");
    else
      for (Tea t : teas)
        System.out.println(t.toString());
  }  
  
  /**
   * parses teas from a Reader and populates the teas vector.
   *
   * @param r the Reader to parse from
   * @throws IOException if the parsing fails
   */
  public void parseTeas(Reader r) throws IOException {
    // ensure the Vector<Tea> exists!
    if (teas == null)
      teas = new Vector<Tea>(50);
    StreamTokenizer stok = new StreamTokenizer(r);
    stok.eolIsSignificant(true); // detect EOL
    stok.quoteChar('\"'); // use " as word separator
  
    int token = 0;
    String teaName = null;
    int nrSpoons, nrSecs;

    while ((token = stok.nextToken()) != StreamTokenizer.TT_EOF) {
	   teaName = stok.sval; // 1. Token
	   token = stok.nextToken();
	   nrSecs = (int)stok.nval; // 2. Token
	   token = stok.nextToken();
	   nrSpoons = (int)stok.nval; // 3. Token
	   token = stok.nextToken(); // must be EOL
       teas.addElement(new Tea(teaName, nrSpoons, nrSecs));
    }
  }
  
  /**
   * Runs the tea parser demo
   * 
   * @param args will be ignored
   */
  public static void main(String[] args) {
    TeaParserDemo demo = null;
    try {
      demo = new TeaParserDemo("tealist.txt");
      demo.dumpTeas();
    }
    catch (IOException e) {
      System.err.println("There was a problem parsing the tea list.");
    }
  }
}
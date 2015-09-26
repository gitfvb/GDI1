import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream; 
import java.io.FileOutputStream; 
import java.io.IOException;

public class DataStreamExample { 
  String fileName = "demo.txt";
  // some methods
  public void writeData() throws IOException {
    FileOutputStream fos = new FileOutputStream(fileName);
    DataOutputStream out = new DataOutputStream(fos);
    out.writeInt(9);
    out.writeDouble(Math.PI);
    out.writeBoolean(true);
    out.close();
  }
  // other methods
  public void readData() throws IOException {
    FileInputStream fis = new FileInputStream(fileName);
    DataInputStream in = new DataInputStream(fis);
    int i = in.readInt();
    double d = in.readDouble();
    boolean b = in.readBoolean();
    in.close();
    System.out.println("Read "+ i + ", " + d + ", and " + b+ ".");
  } 
  public static void main(String[] args) {
	  DataStreamExample dse = new DataStreamExample();
	 try {
		 dse.writeData();
		 dse.readData();
	 } catch(IOException e) {
		 System.err.println(e.getMessage());
	 }
  }
}

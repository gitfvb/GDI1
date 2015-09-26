import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class StrangeTest {
  @Test
  public void testStrange() {
    // create Strange instance
    Strange strange = new Strange();
    // check value
    assertEquals(5, strange.getAvg(new int[] { 1, 3, 5, 7, 9 }));
  }
}

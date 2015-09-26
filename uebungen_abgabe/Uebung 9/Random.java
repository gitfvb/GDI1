/**
 * Random class for GdI / ICS exercise sheet 9.
 * 
 * @author Oren Avni / Guido Roessling
 * @version 1.0
 */
public class Random {

  /**
   * 
   * 
   * @param m
   * @param s
   * @return
   */
  public int[] doSomething(int m, int s) {
    int i = 0;
    int[] arr = new int[s];

    while (i < arr.length) {
      arr[i] = (int) (m * (Math.random())) + 1;
      i++;
    }

    return arr;
  }
}
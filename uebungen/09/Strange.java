public class Strange {
  public int getAvg(int[] array) {
    int temp = 0;

    for (int i = 0; i <= array.length; i++) {
      temp += array[i];
    }

    return (temp / array.length);
  }
}

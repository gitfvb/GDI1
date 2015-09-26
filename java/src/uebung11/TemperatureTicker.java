package uebung11;
/**
 * The temperature ticker provides data for the temperature sensors
 * 
 * @author Daniel Schreiber
 */
public class TemperatureTicker {
  /**
   * Start the ticker service
   * 
   * @param c a temperature client, that wants to get notified if new temperatures arrive
   */
  public static void initSensor(final TemperatureClient client) {
    new Thread() {
      public void run() {
        java.util.Random r = new java.util.Random();
        String[] locations = new String[]{"A124","A126","C110","C120"};
        while (true) {
          try {
            Thread.sleep(1000);
            if (client != null) {
              client.newTemperature(
                  System.currentTimeMillis(), 
                  locations[r.nextInt(locations.length)],
                  r.nextDouble() * 30);
            }
          } catch (InterruptedException e) {
            e.printStackTrace();
          }
        }
      }
    }.start();
  }
  
}

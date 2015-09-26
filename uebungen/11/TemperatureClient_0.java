/**
 * This interface must be implemented by all clients interested in receiving
 * temperature data 
 *
 * @author Daniel Schreiber
 */
public interface TemperatureClient {
  void newTemperature(long timestamp, String location, double temperature);
}

import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

public class InteractiveChart extends BarChart
            implements TemperatureTicker.TemperatureClient, InteractiveChartTestInterface {
	
	/*
	 * Stores a list with up to 30 Measurements for each location.
	 * This list is used to compute the average temperature for this location.
	 */
	private HashMap tempHistoryPerLocation = new HashMap();

	/*
	 * Alphabetically sorted list of all locations. This variable is needed,
	 * as the keys in the tempHistoryPerLocation map are not ordered. Whenever
	 * a Measurement from a new location is received this list needs to be re-sorted.  
	 */
	private LinkedList allLocations = new LinkedList();
	
	/*
	 * Stored for testing purposes
	 */
	private Map lastDiagramData;

	/**
	 * Record for storing measurements from temperature sensors
	 */
	class Measurement {
		Measurement(long t, String l, double temp) {
			time = t;
			location = l;
			temperature = temp;
		}
		public long time;
		public String location;
		public double temperature;
	}

	/**
	 * @return the locations used for the last displayed diagram
	 */
	public LinkedList getLastDiagramLocations() {
		return allLocations;
	}

	/**
	 * @return the data used for the last displayed diagram
	 */
	public Map getLastDiagramData() {
		return lastDiagramData;
	}

	/**
	 * Open a new window and start the TemperatureTicker.
	 * Do not change this method!
	 * @param args command line parameters are not used in this exercise
	 */
	public static void main(String[] args) {
		InteractiveChart chart = new InteractiveChart();
		chart.start();
		
		//start the temperature ticker
		TemperatureTicker.initSensor(chart);
	}

	/**
	 * Called whenever a new temperature is measured by a sensor.
	 * @param timestamp The time when the measurement was taken, given in microseconds since 1.1.1970
	 * @param location The location where the measurement was taken
	 * @param temperature The measured temperature
	 */
	public void newTemperature(long timestamp, String location, double temperature) {
		// TODO implement
		println(location + ": " + temperature);
		
		allLocations = null;
		lastDiagramData = null;
		
		//displayDiagram ...
	}
}

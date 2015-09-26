package uebung11;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Interface for testing InteractivChart implementations.
 * The methods must return the last parameters used for generating a diagram.
 *  
 * @author Daniel Schreiber
 */
public interface InteractiveChartTestInterface extends TemperatureClient {
	public LinkedList getLastDiagramLocations();
	public Map getLastDiagramData();
}

package uebung11;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.Test;

public class TestInteractiveChart {

	InteractiveChartTestInterface chart;
	
	@Before
	public void setUp() throws Exception {
		chart = new InteractiveChart();
	}

	@Test
	public void displayAnyBarChart() {
		chart.newTemperature(1, "a location", 20);
		assertTrue("data is not null",chart.getLastDiagramData() != null);
		assertTrue("categories is not null",chart.getLastDiagramLocations() != null);
	}

	@Test
	public void displayAllLocations() {
		chart.newTemperature(System.currentTimeMillis(), "a", 20);
		chart.newTemperature(System.currentTimeMillis(), "b", 20);
		assertTrue("data is not null",chart.getLastDiagramData() != null);
		assertTrue("categories is not null",chart.getLastDiagramLocations() != null);
		assertTrue("categories contains a",chart.getLastDiagramLocations().contains("a"));
		assertTrue("categories contains b",chart.getLastDiagramLocations().contains("b"));
		assertEquals("two locations measured", 2, chart.getLastDiagramLocations().size() );
	}


	@Test
	public void locationSorted() {
		chart.newTemperature(System.currentTimeMillis(), "b", 20);
		chart.newTemperature(System.currentTimeMillis(), "a", 20);
		assertTrue("data is not null",chart.getLastDiagramData() != null);
		assertTrue("categories is not null",chart.getLastDiagramLocations() != null);
		assertTrue("categories first element a",chart.getLastDiagramLocations().get(0).toString().equals("a"));
		assertTrue("categories second element b",chart.getLastDiagramLocations().get(1).toString().equals("b"));
		assertEquals("two locations measured", 2, chart.getLastDiagramLocations().size() );
	}


	@Test
	public void displayLatestTemperatureAtLocation() {
		chart.newTemperature(System.currentTimeMillis(), "a", 20.0);
		chart.newTemperature(System.currentTimeMillis(), "b", 21.0);
		assertTrue("data is not null",chart.getLastDiagramData() != null);
		Double tempA = (Double) chart.getLastDiagramData().get("a");
		Double tempB = (Double) chart.getLastDiagramData().get("b");
		assertEquals("last temperature at a", 20.0,tempA );
		assertEquals("last temperature at b", 21.0, tempB );
	}

	@Test
	public void displayAverageTemperatureAtLocation() {
		chart.newTemperature(System.currentTimeMillis(), "a", 20.0);
		chart.newTemperature(System.currentTimeMillis(), "b", 30.0);
		chart.newTemperature(System.currentTimeMillis(), "a", 10.0);
		chart.newTemperature(System.currentTimeMillis(), "b", 10.0);
		assertTrue("data is not null",chart.getLastDiagramData() != null);
		Double tempA = (Double) chart.getLastDiagramData().get("a");
		Double tempB = (Double) chart.getLastDiagramData().get("b");
		assertEquals("average temperature at a", 15.0,tempA );
		assertEquals("average temperature at b", 20.0, tempB );
	}
	
	@Test
	public void displayAverageOfLastThirtyAtLocation() {
		for (int i = 0; i < 30; i++)
			chart.newTemperature(System.currentTimeMillis(), "a", 1.0);
		chart.newTemperature(System.currentTimeMillis(), "a", 31.0);
		assertTrue("data is not null",chart.getLastDiagramData() != null);
		Double tempA = (Double) chart.getLastDiagramData().get("a");
		assertEquals("average temperature at a", 2.0,tempA );
	}
	
}

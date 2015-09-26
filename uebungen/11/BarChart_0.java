
import java.awt.Color;
import java.util.HashMap;
import java.util.Map;

import acm.graphics.GLabel;
import acm.graphics.GRect;
import acm.program.GraphicsProgram;

public class BarChart extends GraphicsProgram {
	private static final long serialVersionUID = 1L;
	private static int WIDTH = 600;
	private static int HEIGHT = 400;
	private static int GAP = 20;

	
	/**
	 * Display a bar chart of data. The parameter ymax specifies the scaling of the yaxis.
	 * 
	 * @param data the data to display
	 * @param ymax the maximum of the y-axis
	 */
	public void displayDiagram(Map data, double ymax) {	
		//clean canvas
		removeAll();
		// compute bar width
		int barWidth = (WIDTH - GAP * (data.size() - 1)) / data.size();
		// compute bar unit height
		double barUnitHeight = HEIGHT / ymax;
		// x of lower left corner of next bar
		int x = 0;
		
		// draw a rectangle with label for every entry
		for (Object o: data.entrySet()) {
			Map.Entry e = (Map.Entry) o;
			// bar height corresponds to value of the entry
			Double v = (Double) e.getValue();
			GRect bar = new GRect(barWidth, barUnitHeight * v);
			add(bar, x, HEIGHT + 1 - barUnitHeight * v);
			// label text is the key of the entry
			GLabel lbl = new GLabel((String) e.getKey());
			//center label in bar
			add(lbl, x + (barWidth - lbl.getWidth()) / 2, HEIGHT);
			x = x + barWidth + GAP;
		}
	}
	
	/**
	 * Opens a window with an example bar chart.
	 * You do not need to change this method!
	 * @param args command line arguments are not used in this exercise 
	 */
	public static void main(String[] args) {
		BarChart b = new BarChart();
		b.start();

		Map data = new HashMap();
		data.put("0 - 4", 3.0);
		data.put("5 - 9", 7.0);
		data.put("10 - 14", 1.0);
		
		b.displayDiagram(data,10);
	}
}

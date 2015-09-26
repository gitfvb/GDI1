package sandbox;
//package acm.graphics;

import acm.graphics.*;

public class GStringArrayCompound extends GCompound {
	public GStringArrayCompound(String[] values, double x, double y) {
		setLocation(x, y); // set the object's location
		// create Strings and boxes
		double x0 = x; // initial x position
		for (String value : values)
			// iterate over all input values
			x0 = makeEntry(value, x0, y); // create object at (x0, y)
		markAsComplete();
		markAsComplete();
	}

	private double makeEntry(String value, double x, double y) {
		GLabel text = new GLabel(value, x + 5, y + 15); // some offset
		GRect arrayCell = new GRect(x, y, text.getWidth() + 10, 20);
		add(arrayCell); // add the element to the canvas -> visible
		add(text); // add the element to the canvas -> visible
		return x + arrayCell.getWidth();
	}
}
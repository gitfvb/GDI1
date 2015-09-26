package uebung12;

import acm.program.DialogProgram;

public class GeoDialog extends DialogProgram{
	
	/**
	 * Loads a map and interacts with the user
	 */
	public void run()  {
		//Attention: This is columnwise 
		char arr[][] = { { '#', '~', '#' }, { '0', '#', '0' }, { '0', '0', '0' },
				{ '0', '#', '0' }, { '#', '0', '#' } };
		
		//initiate new GeoSimulation object with the given area
		//catch correct exceptions
		
		//ask the user for x- and y-coordinates simulate a crevasse and display resulting area

		

	}
	
	 /**
	   * Main method. This is automatically called by the environment when your
	   * program starts.
	   * 
	   * @param args
	   */
	  public static void main(String[] args) {
	    new GeoDialog().start();
	  }


}

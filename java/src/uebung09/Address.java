package uebung09;

/*
 ************************************************
 * 
 * UEBUNGSGRUPPE GDI 1 BEI FLORIAN REITH
 * 
 *-----------------------------------------------
 * 
 * WS 2008/2009
 * Florian Friedrichs
 * Uebung 9
 * 
 ************************************************
 */

/**
 * Address saves an address. It exists a possibility to return all attributes as one string.
 * 
 * @author Florian Friedrichs - ff1010
 * 
 */
public class Address {

	// Attributes
	private String myStreet;
	private String myNumber;
	private String myZipCode;
	private String myCity;

	/**
	 * Constructor for a new address
	 * 
	 * @param myStreet street
	 * @param myNumber street number
	 * @param myZipCode zip-code
	 * @param myCity city
	 * 
	 */
	public Address(String myStreet, String myNumber, String myZipCode,
			String myCity) {
		this.myStreet = myStreet;
		this.myNumber = myNumber;
		this.myZipCode = myZipCode;
		this.myCity = myCity;
	}

	/**
	 * Overwriting the method toString()
	 * 
	 * @return a String with the whole address like this template: {myStreet myNumber, myZipCode myCity}<br>
	 * 		   Example: {Hochschulstr . 10, 64289 Darmstadt}
	 * 			
	 */
	public String toString() {
		StringBuffer myBuffer = new StringBuffer(256); // create new buffer
		myBuffer.append("{").append(myStreet).append(" ").append(myNumber)
				.append(", ").append(myZipCode).append(" ").append(myCity)
				.append("}"); // append yet more things
		// done, return the String
		return myBuffer.toString();

	}

	/**
	 * @return the myStreet
	 */
	public String getMyStreet() {
		return myStreet;
	}

	/**
	 * @param myStreet the myStreet to set
	 */
	public void setMyStreet(String myStreet) {
		this.myStreet = myStreet;
	}

	/**
	 * @return the myNumber
	 */
	public String getMyNumber() {
		return myNumber;
	}

	/**
	 * @param myNumber the myNumber to set
	 */
	public void setMyNumber(String myNumber) {
		this.myNumber = myNumber;
	}

	/**
	 * @return the myZipCode
	 */
	public String getMyZipCode() {
		return myZipCode;
	}

	/**
	 * @param myZipCode the myZipCode to set
	 */
	public void setMyZipCode(String myZipCode) {
		this.myZipCode = myZipCode;
	}

	/**
	 * @return the myCity
	 */
	public String getMyCity() {
		return myCity;
	}

	/**
	 * @param myCity the myCity to set
	 */
	public void setMyCity(String myCity) {
		this.myCity = myCity;
	}
	
	
	
}

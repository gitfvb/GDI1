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
 * Stores the phone-number with area-code and number. It is possible to return all attributes in one string.
 * 
 * @author Florian Friedrichs - ff1010
 *
 */
public class PhoneNumber {

	// Attributes
	private String myAreaCode;
	private String myNumber;

	/**
	 * Constructor for a phone-number.
	 * 
	 * @param myAreaCode area-code for the number
	 * @param myNumber number without the area-code
	 */
	public PhoneNumber(String myAreaCode, String myNumber) {
		this.myAreaCode = myAreaCode;
		this.myNumber = myNumber;
	}

	/**
	 * Overwriting the method toString()
	 * 
	 * @return string build of area-code an number like this template:<br>
	 * 		   areacode-number<br>
	 * 		   Example: 06151-160 
	 */
	public String toString() {
		StringBuffer myBuffer = new StringBuffer(256);
		myBuffer.append(myAreaCode).append("-").append(myNumber);
		// done, return the string
		return myBuffer.toString();
	}

	/**
	 * @return the myAreaCode
	 */
	public String getMyAreaCode() {
		return myAreaCode;
	}

	/**
	 * @param myAreaCode the myAreaCode to set
	 */
	public void setMyAreaCode(String myAreaCode) {
		this.myAreaCode = myAreaCode;
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


}

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
 * Class to store an complete entry with names, phone-number, address and a job
 * 
 * @author Florian Friedrichs - ff1010
 *
 */
public class Entry {

	// Attributes
	private String myGivenName;
	private String myFamilyName;
	private PhoneNumber myPhoneNumber;
	private Address myAddress;
	private String myJob;

	/**
	 * Constructor to fill a attributes of this class
	 * 
	 * @param myGivenName first name
	 * @param myFamilyName last name
	 * @param myPhoneNumber phone-number
	 * @param myAddress adress
	 * @param myJob job
	 */
	public Entry(String myGivenName, String myFamilyName,
			PhoneNumber myPhoneNumber, Address myAddress, String myJob) {
		this.myGivenName = myGivenName;
		this.myFamilyName = myFamilyName;
		this.myPhoneNumber = myPhoneNumber;
		this.myAddress = myAddress;
		this.myJob = myJob;
	}
	
	/**
	 * Overwriting the method toString()
	 * 
	 * @return string build of all attributes like this template, separated by tabs:<br>
	 * 			first-name last-name phonenumber address Job<br>
	 * 			example: Markus Meier	06151-164589	{Hochschulstr. 10, 64289 Darmstadt}	Student
	 * 
	 */
	public String toString() {
		StringBuffer myBuffer = new StringBuffer(256);
		myBuffer.append(myGivenName).append("\t").append(myFamilyName).append(
				"\t").append(myPhoneNumber.toString()).append("\t").append(myAddress.toString())
				.append("\t").append(myJob);
		// done, return the string
		return myBuffer.toString();
	}

	/**
	 * @return the myGivenName
	 */
	public String getMyGivenName() {
		return myGivenName;
	}

	/**
	 * @param myGivenName the myGivenName to set
	 */
	public void setMyGivenName(String myGivenName) {
		this.myGivenName = myGivenName;
	}

	/**
	 * @return the myFamilyName
	 */
	public String getMyFamilyName() {
		return myFamilyName;
	}

	/**
	 * @param myFamilyName the myFamilyName to set
	 */
	public void setMyFamilyName(String myFamilyName) {
		this.myFamilyName = myFamilyName;
	}

	/**
	 * @return the myPhoneNumber
	 */
	public PhoneNumber getMyPhoneNumber() {
		return myPhoneNumber;
	}

	/**
	 * @param myPhoneNumber the myPhoneNumber to set
	 */
	public void setMyPhoneNumber(PhoneNumber myPhoneNumber) {
		this.myPhoneNumber = myPhoneNumber;
	}

	/**
	 * @return the myAddress
	 */
	public Address getMyAddress() {
		return myAddress;
	}

	/**
	 * @param myAddress the myAddress to set
	 */
	public void setMyAddress(Address myAddress) {
		this.myAddress = myAddress;
	}

	/**
	 * @return the myJob
	 */
	public String getMyJob() {
		return myJob;
	}

	/**
	 * @param myJob the myJob to set
	 */
	public void setMyJob(String myJob) {
		this.myJob = myJob;
	}
	
}

package uebung10;

import database.Database;
import database.Entry;

public class ImprovedDatabase extends Database implements AdditionalOperations,
		ImprovedAccess {

	/*
	 * AdditionalOperations
	 */

	public int union(ImprovedDatabase data) {
		int i;
		for (i = 0; i < data.getSize(); i++) {
			this.addEntry(data.getEntry(i));
		}
		return this.getSize();
	}
	
	public int complement(ImprovedDatabase data) {
		return this.buildOperation(data, true);
	}

	public int intersection(ImprovedDatabase data) {
		return this.buildOperation(data, false);
	}
	
	
	/**
	 * 
	 * Helping method for complement and intersection, because both function are very similar
	 * 
	 * @param data 
	 * 		the given database
	 * @param shouldEntryExist
	 * 		boolean to decide, how this method works (possible: intersectioin, complement)
	 * @return size of Entry-array in database
	 */
	private int buildOperation(ImprovedDatabase data, boolean shouldEntryExist) {
		int i;
		int length = this.getSize();
		Entry currentEntry;

		for (i = length - 1; i >= 0; i--) {
			currentEntry = this.getEntry(i);
			if (data.entryExists(currentEntry) == shouldEntryExist) {
				if (this.deleteEntry(currentEntry) == false) {
					System.out.println("Error: Could not run method");
				}
			}
		}

		return this.getSize();
	}


	/*
	 * ImprovedAccess
	 */

	public Entry[] selectXFrom(Column col, String str) {
		
		// Declaration
		int j = 0;
		Entry[] tempEntries = new Entry[this.getSize()]; // first temporary array
		
		// Fill temporary array with compared entries
		for (int i = 0; i < this.getSize(); i++) {
			if (getContentFor(col, i).toLowerCase().contains(str.toLowerCase()) == true) {
				tempEntries[j++] = this.getEntry(i); // fill array
			}
		}
		
		// Copy temporary array in a new array with right size
		Entry[] result = new Entry[j]; // second array with final size
		System.arraycopy(tempEntries, 0, result, 0, j); // copy the first temporary array in second
		
		return result;
		
	}
	

	public void sort(Column col) {
		for (int i = this.getSize(); i > 0; i--) {
			for (int j = 1; j < i; j++) {
				if (this.getContentFor(col, j - 1).compareToIgnoreCase(this.getContentFor(col, j)) > 0) {
					this.swap(j, j - 1); // change the values
				}
			}
		}
	}
	
	

	/**
	 * 
	 * Get a String of a specified Column
	 * 
	 * @param col
	 *            Column, which is meant to be read
	 * @param index
	 *            Number in index
	 * @return
	 * 			the string wished to be returned. The address contains a column and an index
	 */
	public String getContentFor(Column col, int index) {
		
		String result;
		Entry entry = this.getEntry(index);
		
		switch ( col ) {

			case ADDRESS_CITY: 			result = entry.getAddress().getCity(); 			break;
			case ADDRESS_HOUSE_NUMBER: 	result = entry.getAddress().getHouseNumber(); 	break;
			case ADDRESS_STREET_NAME: 	result = entry.getAddress().getStreetName();  	break;
			case ADDRESS_ZIP_CODE: 		result = entry.getAddress().getZipCode();  		break;
			case FAMILY_NAME: 			result = entry.getFamilyName(); 				break;
			case GIVEN_NAME:  			result = entry.getGivenName(); 					break;
			case JOB:					result = entry.getJob();						break;
			case PHONE_AREA_CODE:  		result = entry.getPhoneNumber().getAreaCode();	break;
			case PHONE_NUMBER:  		result = entry.getPhoneNumber().getNumber();	break;
			default: 					result = ""; 									break;

		}

		return result;
	}
	
	

}

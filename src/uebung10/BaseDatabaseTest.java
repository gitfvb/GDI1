package uebung10;

/**
 *
 * JUnit Testcases for the Matrix class
 *
 * @author   Oren Avni, (Tutor for GDI 1 / ICS 1 @ Winterterm: 2008-2009 {TU-Darmstadt}
 * @author Guido Roessling
 * @category Basic Linear Algebra Operations
 * @version  1.0
 */
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import uebung10.*;

import database.Address;
import database.Entry;
import database.PhoneNumber;

public class BaseDatabaseTest {
	ImprovedDatabase dbase1;
	ImprovedDatabase dbase2;

	// e1, e2,..., e6 = statische Eintr‰ge (Diese existieren also bevor jeder
	// einzelne Test aufgerufen wird.)

	Entry e1 = new Entry("Hans", "Mustermann", 	new PhoneNumber("0180","1234567"), 		new Address("Rossmarkt", "26", "60311", "Frankfurt"),					"Dancer");
	Entry e2 = new Entry("Anna", "Friedlich",  	new PhoneNumber("0163", "9999999"), 	new Address("Zeil", "1","60311", "Frankfurt"), 											"Teacher");
	Entry e3 = new Entry("Otto", "Norbert", 	new PhoneNumber("0190", "6666666"),		new Address("Igelweg", "16", "64293", "Darmstadt"), 						"Programmer");
	Entry e4 = new Entry("Timo", "Ulbrich", 	new PhoneNumber("0170", "8888888"),		new Address("Irgendwostrasse", "9", "80210", "Irgendwo"),	"Physician");
	Entry e5 = new Entry("Data", "Base", 		new PhoneNumber("06031", "2222222"),	new Address("Wallstreet", "7", "99551", "Stuttgart"),				 "Astronaut");
	Entry e6 = new Entry("Karl", "Heinz", 		new PhoneNumber("030", "1111111"),		new Address("Peterstrasse", "442", "04504", "Berlin"), 			"Pilot");
	
	// e7 = dynamischer Eintrag

	Entry e7 = new Entry("Joe", "Presley", new PhoneNumber("0179", "47854754"),
			new Address("Marktplatz", "3", "23548", "Sonstwo"), "Postbote");

	private final String expectedOutput = "Hans\tMustermann\t0180-1234567\t{Rossmarkt 26, 60311 Frankfurt}\tDancer\n"
			+ "Anna\tFriedlich\t0163-9999999\t{Zeil 1, 60311 Frankfurt}\tTeacher\n"
			+ "Otto\tNorbert\t0190-6666666\t{Igelweg 16, 64293 Darmstadt}\tProgrammer\n"
			+ "Timo\tUlbrich\t0170-8888888\t{Irgendwostrasse 9, 80210 Irgendwo}\tPhysician\n"
			+ "Data\tBase\t06031-2222222\t{Wallstreet 7, 99551 Stuttgart}\tAstronaut\n"
			+ "Karl\tHeinz\t030-1111111\t{Peterstrasse 442, 04504 Berlin}\tPilot";

	/**
	 * Set up the database by inserting six values in succession
	 */
	@Before
	public void setup() {
		
		dbase1 = new ImprovedDatabase();
		String msg0 = "Entry was not added to the database.";

		assertTrue(msg0, dbase1.addEntry(e1));
		assertTrue(msg0, dbase1.addEntry(e2));
		assertTrue(msg0, dbase1.addEntry(e3));
		assertTrue(msg0, dbase1.addEntry(e4));
		assertTrue(msg0, dbase1.addEntry(e5));
		assertTrue(msg0, dbase1.addEntry(e6));

		dbase2 = new ImprovedDatabase();
		assertTrue(msg0, dbase2.addEntry(e5));
		assertTrue(msg0, dbase2.addEntry(e7));
		assertTrue(msg0, dbase2.addEntry(e6));

	}

	/**
	 * Tests that the existing values cannot be re-inserted, but a new element
	 * can be inserted
	 */
	@Test
	public void addingDuplicates() {
		String msg0 = "Entry was not added to the database.";
		String msg1 = "Entry already exists in the database.";

		assertFalse(msg1, dbase1.addEntry(e1));
		assertFalse(msg1, dbase1.addEntry(e2));
		assertFalse(msg1, dbase1.addEntry(e3));
		assertFalse(msg1, dbase1.addEntry(e4));
		assertFalse(msg1, dbase1.addEntry(e5));
		assertFalse(msg1, dbase1.addEntry(e6));

		assertTrue(msg0, dbase1.addEntry(e7));
	}

	/**
	 * Checks that the database size is consistent with add / delete
	 */
	@Test
	public void getSize() {
		String msg0 = "The database should have 6 elements.";
		String msg1 = "After adding an element, there should be 7, not 6, elements in the database.";
		String msg2 = "Entry was not added to the database.";
		String msg3 = "Entry could not be deleted from the database.";

		assertEquals(msg0, 6, dbase1.getSize());
		assertTrue(msg2, dbase1.addEntry(e7));

		assertEquals(msg1, 7, dbase1.getSize());

		assertTrue(msg3, dbase1.deleteEntry(e7));
		assertEquals(msg0, 6, dbase1.getSize());
	}

	/**
	 * test that all values can be deleted, but that re-deleting one is not
	 * possible
	 */
	@Test
	public void deleteEntry() {
		String msg0 = "Entry could not be deleted from the database.";

		assertTrue(msg0, dbase1.deleteEntry(e1));
		assertTrue(msg0, dbase1.deleteEntry(e2));
		assertTrue(msg0, dbase1.deleteEntry(e3));
		assertTrue(msg0, dbase1.deleteEntry(e4));
		assertTrue(msg0, dbase1.deleteEntry(e5));
		assertTrue(msg0, dbase1.deleteEntry(e6));
		assertEquals(0, dbase1.getSize());

		assertFalse(msg0, dbase1.deleteEntry(e1));
	}

	/**
	 * Check what happens if the database is dropped
	 */
	@Test
	public void dropDatabase() {
		String msg0 = "Database was not dropped correctly.";

		assertTrue(msg0, dbase1.dropDatabase());
		assertEquals(msg0, "<Database is empty>", dbase1.toString());
	}

	/**
	 * Validate that getPos works correctly
	 */
	@Test
	public void getPos() {
		String msg0 = "Entry is at the wrong position.";
		String msg1 = "Entry could not be deleted from the database.";

		assertEquals(msg0, 0, dbase1.getPos(e1));
		assertEquals(msg0, 1, dbase1.getPos(e2));
		assertEquals(msg0, 2, dbase1.getPos(e3));
		assertEquals(msg0, 3, dbase1.getPos(e4));
		assertEquals(msg0, 4, dbase1.getPos(e5));
		assertEquals(msg0, 5, dbase1.getPos(e6));

		assertTrue(msg0, dbase1.deleteEntry(e1));
		assertEquals(msg0, -1, dbase1.getPos(e1));
		assertEquals(msg0, 0, dbase1.getPos(e2));
		assertEquals(msg0, 1, dbase1.getPos(e3));
		assertEquals(msg0, 2, dbase1.getPos(e4));
		assertEquals(msg0, 3, dbase1.getPos(e5));
		assertEquals(msg0, 4, dbase1.getPos(e6));

		assertTrue(msg1, dbase1.deleteEntry(e2));
		assertEquals(msg0, -1, dbase1.getPos(e2));
		assertEquals(msg0, 0, dbase1.getPos(e3));
		assertEquals(msg0, 1, dbase1.getPos(e4));
		assertEquals(msg0, 2, dbase1.getPos(e5));
		assertEquals(msg0, 3, dbase1.getPos(e6));
	}

	/**
	 * Checks that getEntry works as anticipated
	 */
	/*
	 * @Test public void getEntry() { String msg0 = "Wrong entry was returned.";
	 * String msg1 = "Entry could not be deleted from the database.";
	 * 
	 * assertTrue(msg0, dbase.getEntry(0).equals(e1)); assertTrue(msg0,
	 * dbase.getEntry(1).equals(e2)); assertTrue(msg0,
	 * dbase.getEntry(2).equals(e3)); assertTrue(msg0,
	 * dbase.getEntry(3).equals(e4)); assertTrue(msg0,
	 * dbase.getEntry(4).equals(e5)); assertTrue(msg0,
	 * dbase.getEntry(5).equals(e6));
	 * 
	 * assertTrue(msg1, dbase.deleteEntry(e6)); assertTrue(msg0,
	 * dbase.getEntry(4).equals(e5)); }
	 */

	// @Test
	// public void test_updateEntry() {
	// String msg0 = "Datenbank Eintrag wurde nicht korrekt ge‰ndert.", msg1 =
	// "Datensatz befindet sich nicht in der korrekten Position.";
	//
	// assertTrue(msg0, dbase.updateEntry(0, e7));
	// assertTrue(msg1, dbase.getEntry(0).equals(e7));
	// }

	/**
	 * Test the toString method
	 */
	@Test
	public void testStringRepresentation() {
		assertEquals(expectedOutput, dbase1.toString().trim());
	}

	// Own tests

	/**
	 * Test the union method
	 */
	@Test
	public void unionDatabase() {
		assertEquals("Union fehlerhaft!", 7, dbase1.union(dbase2));
	}

	/**
	 * Test the intersection method
	 */
	@Test
	public void intersectionDatabase() {
		assertEquals("Intersection fehlerhaft!", 2, dbase1.intersection(dbase2));
	}

	/**
	 * Test the complement method
	 */
	@Test
	public void complementDatabase() {
		assertEquals("Complement fehlerhaft!", 4, dbase1.complement(dbase2));
	}
	
	/**
	 * Test to get contents
	 * @return 
	 */
	@Test
	public void getEntryContent() {
		assertEquals("Teacher", dbase1.getContentFor(Column.JOB, 1));
	}
	
	/**
	 * Test the select-Statement 
	 */
	@SuppressWarnings("deprecation")
	@Test
	public void selectRows() {
		
		Entry[] compareRows1 = {e4,e6};
		assertEquals("Objekt fehlerhaft!", compareRows1, dbase1.selectXFrom(Column.ADDRESS_STREET_NAME, "straSSe"));
		
		Entry[] compareRows2 = {e4};
		assertEquals("Objekt fehlerhaft!", compareRows2, dbase1.selectXFrom(Column.GIVEN_NAME, "timo"));
		
		Entry[] compareRows3 = {e1,e2,e3,e4};
		assertEquals("Objekt fehlerhaft!", compareRows3, dbase1.selectXFrom(Column.PHONE_AREA_CODE, "01"));
		
		Entry[] compareRows4 = {};
		assertEquals("Objekt fehlerhaft!", compareRows4, dbase1.selectXFrom(Column.JOB, "zzzz"));
		
	}
	
	/**
	 * Test the sort-method
	 */
	@SuppressWarnings("deprecation")
	@Test
	public void sortEntries() {
		// Assert.assertArrayEquals ist die neue Methode, assertEquals für Objekte ist veraltet
		dbase1.sort(Column.FAMILY_NAME);
		Entry[] compareRows1 = {e5, e2, e6, e1, e3, e4}; // z.B. ulbrich
		//assertEquals("Sortierung fehlerhaft!", compareRows1, dbase1.selectXFrom(Column.FAMILY_NAME, ""));
		Assert.assertArrayEquals(compareRows1, dbase1.selectXFrom(Column.FAMILY_NAME, "")); // Test für die neue Methode
		
		dbase1.sort(Column.GIVEN_NAME);
		Entry[] compareRows2 = {e2, e5, e1, e6, e3, e4}; // z.B. timo
		assertEquals("Sortierung fehlerhaft!", compareRows2, dbase1.selectXFrom(Column.GIVEN_NAME, ""));

		dbase1.sort(Column.ADDRESS_STREET_NAME);
		Entry[] compareRows3 = {e3, e4, e6, e1, e5, e2}; // strasse
		assertEquals("Sortierung fehlerhaft!", compareRows3, dbase1.selectXFrom(Column.ADDRESS_STREET_NAME, ""));
		
	}
	
}

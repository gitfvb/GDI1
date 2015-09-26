/**
 * GDI1, Hausuebung 10
 * 
 * Erweiterte JUnit Klasse
 * Alle Methoden aus den Hausaufgaben
 * der Uebungen 9 und 10 werden getestet
 *
 */

package database;

/**
 *
 * JUnit Testcases for the Matrix class
 *
 * @author Oren Avni, (Tutor for GDI 1 / ICS 1 @ Winterterm: 2008-2009 {TU-Darmstadt}
 * @author Guido Roessling
 * @author Ivelin Ivanov
 * @category Basic Linear Algebra Operations
 * @version  1.2
 */
import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.Test;


public class BaseDatabaseTestExtended {
  ImprovedDatabase dbase1;
  ImprovedDatabase dbase2;

  // e1, ..., e6 = static entries. They exist before any of the tests is run
  // Used to create the first database (dbase1)
  Entry    e1    = new Entry("Hans", "Mustermann", new PhoneNumber("0180",
                    "1234567"), new Address("Rossmarkt", "26", "60311",
                    "Frankfurt"), "Dancer");
  Entry    e2    = new Entry("Anna", "Friedlich", new PhoneNumber("0163",
                    "9999999"), new Address("Zeil", "1", "60311", "Frankfurt"),
                    "Teacher");
  Entry    e3    = new Entry("Otto", "Norbert", new PhoneNumber("0190",
                    "6666666"), new Address("Igelweg", "16", "64293",
                    "Darmstadt"), "Programmer");
  Entry    e4    = new Entry("Timo", "Ulbrich", new PhoneNumber("0170",
                    "8888888"), new Address("Irgendwostrasse", "9", "80210",
                    "Irgendwo"), "Physician");
  Entry    e5    = new Entry("Data", "Base", new PhoneNumber("06031",
		  			"2222222"), new Address("Wallstreet", "7", "99551",
		  			"Stuttgart"), "Astronaut");
  Entry    e6    = new Entry("Karl", "Heinz", new PhoneNumber("030",
		  			"1111111"), new Address("Peterstrasse", "442", "04504",
		  			"Berlin"), "Pilot");
  
  // en1, ..., en5 = static entries. They exist before any of the tests is run
  // Used to create the second database (dbase2)
  Entry    en1    = new Entry("Heinz", "Conrad", new PhoneNumber("0190",
  					"1233367"), new Address("Marktplatz", "16", "60313",
  					"Frankfurt"), "Teacher");
  Entry    en2    = new Entry("Harald", "Schmidt", new PhoneNumber("0150",
					"5633367"), new Address("Hauptstr.", "6", "65929",
					"Frankfurt"), "Salesman");
  Entry    en3    = new Entry("Otto", "Norbert", new PhoneNumber("0190",
  					"6666666"), new Address("Igelweg", "16", "64293",
  					"Darmstadt"), "Programmer");
  Entry    en4    = new Entry("Karla", "Stein", new PhoneNumber("0179",
  					"6543456"), new Address("Luisenplatz", "1", "64293",
  					"Darmstadt"), "Manager");
  Entry    en5    = new Entry("Data", "Base", new PhoneNumber("06031",
		  			"2222222"), new Address( "Wallstreet", "7", "99551",
		  			"Stuttgart"), "Astronaut");

  // e7 = dynamic entry
  Entry    e7    = new Entry("Joe", "Presley", new PhoneNumber("0179",
                     "47854754"), new Address("Marktplatz", "3", "23548",
                     "Sonstwo"), "Postbote");
  // en6 = dynamic entry
  Entry    en6    = new Entry("Joe", "Presley", new PhoneNumber("0179",
  					"47854754"), new Address("Marktplatz", "3", "23548",
  					"Sonstwo"), "Postbote");
  
  private final String expectedOutput1 =
    "Hans\tMustermann\t0180-1234567\t{Rossmarkt 26, 60311 Frankfurt}\tDancer\n"
    +"Anna\tFriedlich\t0163-9999999\t{Zeil 1, 60311 Frankfurt}\tTeacher\n"
    +"Otto\tNorbert\t0190-6666666\t{Igelweg 16, 64293 Darmstadt}\tProgrammer\n"
    +"Timo\tUlbrich\t0170-8888888\t{Irgendwostrasse 9, 80210 Irgendwo}\tPhysician\n"
    +"Data\tBase\t06031-2222222\t{Wallstreet 7, 99551 Stuttgart}\tAstronaut\n"
    +"Karl\tHeinz\t030-1111111\t{Peterstrasse 442, 04504 Berlin}\tPilot";
  
  private final String expectedOutput2 = "Heinz\tConrad\t0190-1233367\t{Marktplatz 16, 60313 Frankfurt}\tTeacher\n"
	+"Harald\tSchmidt\t0150-5633367\t{Hauptstr. 6, 65929 Frankfurt}\tSalesman\n"
	+"Otto\tNorbert\t0190-6666666\t{Igelweg 16, 64293 Darmstadt}\tProgrammer\n"
	+"Karla\tStein\t0179-6543456\t{Luisenplatz 1, 64293 Darmstadt}\tManager\n"
	+"Data\tBase\t06031-2222222\t{Wallstreet 7, 99551 Stuttgart}\tAstronaut";

  /**
   * Set up the database by inserting six values in succession
   */
  @Before
  public void setup() {
    dbase1 = new ImprovedDatabase();
    dbase2 = new ImprovedDatabase();
    String msg0 = "Entry was not added to the database.";

    //dbase1
    assertTrue(msg0, dbase1.addEntry(e1));
    assertTrue(msg0, dbase1.addEntry(e2));
    assertTrue(msg0, dbase1.addEntry(e3));
    assertTrue(msg0, dbase1.addEntry(e4));
    assertTrue(msg0, dbase1.addEntry(e5));
    assertTrue(msg0, dbase1.addEntry(e6));
    
    //dbase2
    assertTrue(msg0, dbase2.addEntry(en1));
    assertTrue(msg0, dbase2.addEntry(en2));
    assertTrue(msg0, dbase2.addEntry(en3));
    assertTrue(msg0, dbase2.addEntry(en4));
    assertTrue(msg0, dbase2.addEntry(en5));
  }

  /**
   * Tests that the existing values cannot be re-inserted,
   * but a new element can be inserted
   */
  @Test
  public void addingDuplicates() {
    String msg0 = "Entry was not added to the database.";
    String msg1 = "Entry already exists in the database.";

    //dbase1
    assertFalse(msg1, dbase1.addEntry(e1));
    assertFalse(msg1, dbase1.addEntry(e2));
    assertFalse(msg1, dbase1.addEntry(e3));
    assertFalse(msg1, dbase1.addEntry(e4));
    assertFalse(msg1, dbase1.addEntry(e5));
    assertFalse(msg1, dbase1.addEntry(e6));
    
    //dbase2
    assertFalse(msg0, dbase2.addEntry(en1));
    assertFalse(msg0, dbase2.addEntry(en2));
    assertFalse(msg0, dbase2.addEntry(en3));
    assertFalse(msg0, dbase2.addEntry(en4));
    assertFalse(msg0, dbase2.addEntry(en5));

    assertTrue(msg0, dbase1.addEntry(e7));
    assertTrue(msg0, dbase2.addEntry(en6));
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
    String msg4 = "After adding an element, there should be 6, not 5, elements in the database.";

    //dbase1
    assertEquals(msg0, 6, dbase1.getSize());
    assertTrue(msg2, dbase1.addEntry(e7));

    assertEquals(msg1, 7, dbase1.getSize());

    assertTrue(msg3, dbase1.deleteEntry(e7));
    assertEquals(msg0, 6, dbase1.getSize());
    
    //dbase2
    assertEquals(msg0, 5, dbase2.getSize());
    assertTrue(msg2, dbase2.addEntry(en6));

    assertEquals(msg4, 6, dbase2.getSize());

    assertTrue(msg3, dbase2.deleteEntry(en6));
    assertEquals(msg0, 5, dbase2.getSize());
  }

  /**
   * test that all values can be deleted, but that re-deleting one is not
   * possible
   */
  @Test
  public void deleteEntry() {
    String msg0 = "Entry could not be deleted from the database.";
    

    //dbase1
    assertTrue(msg0, dbase1.deleteEntry(e1));
    assertTrue(msg0, dbase1.deleteEntry(e2));
    assertTrue(msg0, dbase1.deleteEntry(e3));
    assertTrue(msg0, dbase1.deleteEntry(e4));
    assertTrue(msg0, dbase1.deleteEntry(e5));
    assertTrue(msg0, dbase1.deleteEntry(e6));
    assertEquals(0, dbase1.getSize());

    assertFalse(msg0, dbase1.deleteEntry(e1));
    
    //dbase2
    assertTrue(msg0, dbase2.deleteEntry(en1));
    assertTrue(msg0, dbase2.deleteEntry(en2));
    assertTrue(msg0, dbase2.deleteEntry(en3));
    assertTrue(msg0, dbase2.deleteEntry(en4));
    assertTrue(msg0, dbase2.deleteEntry(en5));
    assertEquals(0, dbase2.getSize());

    assertFalse(msg0, dbase2.deleteEntry(en1));
  }

  /**
   * Check what happens if the database is dropped
   */
  @Test
  public void dropDatabase() {
    String msg0 = "Database was not dropped correctly.";

    //dbase1
    assertTrue(msg0, dbase1.dropDatabase());
    assertEquals(msg0, "<Database is empty>", dbase1.toString());
    
    //dbase2
    assertTrue(msg0, dbase2.dropDatabase());
    assertEquals(msg0, "<Database is empty>", dbase2.toString());
  }

  /**
   * Validate that getPos works correctly
   */
  @Test
  public void getPos() {
    String msg0 = "Entry is at the wrong position.";
    String msg1 = "Entry could not be deleted from the database.";

    //dbase1
    assertEquals(msg0, 0, dbase1.getPos(e1));
    assertEquals(msg0, 1, dbase1.getPos(e2));
    assertEquals(msg0, 2, dbase1.getPos(e3));
    assertEquals(msg0, 3, dbase1.getPos(e4));
    assertEquals(msg0, 4, dbase1.getPos(e5));
    assertEquals(msg0, 5, dbase1.getPos(e6));

    assertTrue(msg1, dbase1.deleteEntry(e1));
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

    //dbase2
    assertEquals(msg0, 0, dbase2.getPos(en1));
    assertEquals(msg0, 1, dbase2.getPos(en2));
    assertEquals(msg0, 2, dbase2.getPos(en3));
    assertEquals(msg0, 3, dbase2.getPos(en4));
    assertEquals(msg0, 4, dbase2.getPos(en5));

    assertTrue(msg1, dbase2.deleteEntry(en1));
    assertEquals(msg0, -1, dbase2.getPos(en1));
    assertEquals(msg0, 0, dbase2.getPos(en2));
    assertEquals(msg0, 1, dbase2.getPos(en3));
    assertEquals(msg0, 2, dbase2.getPos(en4));
    assertEquals(msg0, 3, dbase2.getPos(en5));

    assertTrue(msg1, dbase2.deleteEntry(en2));
    assertEquals(msg0, -1, dbase2.getPos(en2));
    assertEquals(msg0, 0, dbase2.getPos(en3));
    assertEquals(msg0, 1, dbase2.getPos(en4));
    assertEquals(msg0, 2, dbase2.getPos(en5));
  }

  /**
   * Checks that getEntry works as anticipated
   */
  @Test
  public void getEntry() {
    String msg0 = "Wrong entry was returned.";
    String msg1 = "Entry could not be deleted from the database.";

    //dbase1
    assertTrue(msg0, dbase1.getEntry(0).equals(e1));
    assertTrue(msg0, dbase1.getEntry(1).equals(e2));
    assertTrue(msg0, dbase1.getEntry(2).equals(e3));
    assertTrue(msg0, dbase1.getEntry(3).equals(e4));
    assertTrue(msg0, dbase1.getEntry(4).equals(e5));
    assertTrue(msg0, dbase1.getEntry(5).equals(e6));

    assertTrue(msg1, dbase1.deleteEntry(e6));
    assertTrue(msg0, dbase1.getEntry(4).equals(e5));

    //dbase2
    assertTrue(msg0, dbase2.getEntry(0).equals(en1));
    assertTrue(msg0, dbase2.getEntry(1).equals(en2));
    assertTrue(msg0, dbase2.getEntry(2).equals(en3));
    assertTrue(msg0, dbase2.getEntry(3).equals(en4));
    assertTrue(msg0, dbase2.getEntry(4).equals(en5));

    assertTrue(msg1, dbase2.deleteEntry(en5));
    assertTrue(msg0, dbase2.getEntry(3).equals(en4));
  }


  /**
   * Test the toString method
   */
  @Test
  public void testStringRepresentation() {
	//dbase1
    assertEquals(expectedOutput1, dbase1.toString().trim());

    //dbase2
    assertEquals(expectedOutput2, dbase2.toString().trim());
  }
  
/*
 * 
 * Tests for exercise 10 start here!
 * Tests for exercise 10 start here!
 * Tests for exercise 10 start here!
 * 
 */
  
  /**
   * Validate that union works correctly
   */
  @Test
  public void union() {
	  String msg0 = "Error in union(). Positions of entries in "
		  				+ "resulting database are wrong.";
	  String msg1 = "Error in union(). Size of resulting database is wrong.";
	  dbase1.union(dbase2);

	  
	  assertEquals(msg1, 9, dbase1.getSize());
	  assertEquals(msg0, 0, dbase1.getPos(e1));
	  assertEquals(msg0, 1, dbase1.getPos(e2));
	  assertEquals(msg0, 2, dbase1.getPos(e3));
	  assertEquals(msg0, 3, dbase1.getPos(e4));
	  assertEquals(msg0, 4, dbase1.getPos(e5));
	  assertEquals(msg0, 5, dbase1.getPos(e6));
	  assertEquals(msg0, 6, dbase1.getPos(en1));
	  assertEquals(msg0, 7, dbase1.getPos(en2));
	  assertEquals(msg0, 8, dbase1.getPos(en4));
	  
	  //Test what happens if NULL is passed as an argument
	  dbase1.union(null);
	  assertEquals(msg1, 9, dbase1.getSize());
	  
	  //Test what happens if the first database is passed as an argument
	  dbase1.union(dbase1);
	  assertEquals(msg1, 9, dbase1.getSize());
  }
  
  
  /**
   * Validate that intersection works correctly
   */
  @Test
  public void intersection() {
	  String msg0 = "Error in intersection(). Positions of entries in "
		  				+ "resulting database are wrong.";
	  String msg1 = "Error in intersection(). Size of resulting database is wrong.";
	  String msg2 = " According to Guido Roessling, the database is NOT to be changed, "
		  			+ "when NULL is passed as a parameter.";
	  dbase1.intersection(dbase2);
	  
	  assertEquals(msg1, 2, dbase1.getSize());
	  assertEquals(msg0, 0, dbase1.getPos(en3));
	  assertEquals(msg0, 1, dbase1.getPos(en5));

	  //Test what happens if NULL is passed as an argument
	  dbase1.intersection(null);
	  assertEquals(msg1 + msg2, 2, dbase1.getSize());
	  
	  //Test what happens if the first database is passed as an argument
	  dbase1.intersection(dbase1);
	  assertEquals(msg1, 2, dbase1.getSize());
  }
  
  
  /**
   * Validate that complement works correctly
   */
  @Test
  public void complement() {
	  String msg0 = "Error in complement(). Positions of entries in "
		  				+ "resulting database are wrong.";
	  String msg1 = "Error in complement(). Size of resulting database is wrong.";
	  dbase1.complement(dbase2);
	  
	  assertEquals(msg1, 4, dbase1.getSize());
	  assertEquals(msg0, 0, dbase1.getPos(e1));
	  assertEquals(msg0, 1, dbase1.getPos(e2));
	  assertEquals(msg0, 2, dbase1.getPos(e4));
	  assertEquals(msg0, 3, dbase1.getPos(e6));
	  
	  //Test what happens if NULL is passed as an argument
	  dbase1.complement(null);
	  assertEquals(msg1, 4, dbase1.getSize());
	  
	  //Test what happens if the first database is passed as an argument
	  dbase1.complement(dbase1);
	  assertEquals(msg1, 0, dbase1.getSize());
  }
  
  
  /**
   * Validate that selectXFrom works correctly
   */
  @Test
  public void selectXFrom() {
	  String msg0 = "Error in selectXFrom(). Returned array is wrong.";
	  String msg1 = "Error in selectXFrom(). Size of returned array is wrong.";
	  
	  //Test with GIVEN_NAME 	  
	  Entry[] expectedArray1 = { e1, e2 };
	  Entry[] actualArray1 = dbase1.selectXFrom(Column.GIVEN_NAME, "an");
	  assertEquals(msg1, 2, actualArray1.length);
	  assertArrayEquals(msg0, expectedArray1, actualArray1);
	  
	  //Test with FAMILY_NAME 	  
	  Entry[] expectedArray2 = { e2, e4 };
	  Entry[] actualArray2 = dbase1.selectXFrom(Column.FAMILY_NAME, "ICH");
	  assertEquals(msg1, 2, actualArray2.length);
	  assertArrayEquals(msg0, expectedArray2, actualArray2);
	  
	  //Test with PHONE_AREA_CODE 	  
	  Entry[] expectedArray3 = { e1, e2, e3, e4 };
	  Entry[] actualArray3 = dbase1.selectXFrom(Column.PHONE_AREA_CODE, "01");
	  assertEquals(msg1, 4, actualArray3.length);
	  assertArrayEquals(msg0, expectedArray3, actualArray3);

	  //Test with PHONE_NUMBER 	  
	  Entry[] expectedArray4 = { e1, e6 };
	  Entry[] actualArray4 = dbase1.selectXFrom(Column.PHONE_NUMBER, "1");
	  assertEquals(msg1, 2, actualArray4.length);
	  assertArrayEquals(msg0, expectedArray4, actualArray4);
	  
	  //Test with ADDRESS_STREET_NAME 	  
	  Entry[] expectedArray5 = { e4, e6 };
	  Entry[] actualArray5 = dbase1.selectXFrom(Column.ADDRESS_STREET_NAME, "Strasse");
	  assertEquals(msg1, 2, actualArray5.length);
	  assertArrayEquals(msg0, expectedArray5, actualArray5);
	 
	  //Test with ADDRESS_HOUSE_NUMBER 	  
	  Entry[] expectedArray6 = { e4 };
	  Entry[] actualArray6 = dbase1.selectXFrom(Column.ADDRESS_HOUSE_NUMBER, "9");
	  assertEquals(msg1, 1, actualArray6.length);
	  assertArrayEquals(msg0, expectedArray6, actualArray6);
	  
	  //Test with ADDRESS_ZIP_CODE 	  
	  Entry[] expectedArray7 = { e1, e2 };
	  Entry[] actualArray7 = dbase1.selectXFrom(Column.ADDRESS_ZIP_CODE, "031");
	  assertEquals(msg1, 2, actualArray7.length);
	  assertArrayEquals(msg0, expectedArray7, actualArray7);
	  
	  //Test with ADDRESS_CITY 	  
	  Entry[] expectedArray8 = { e1, e2, e3, e5 };
	  Entry[] actualArray8 = dbase1.selectXFrom(Column.ADDRESS_CITY, "t");
	  assertEquals(msg1, 4, actualArray8.length);
	  assertArrayEquals(msg0, expectedArray8, actualArray8);
	  
	  //Test with JOB 	  
	  Entry[] expectedArray9 = { e3, e5 };
	  Entry[] actualArray9 = dbase1.selectXFrom(Column.JOB, "ro");
	  assertEquals(msg1, 2, actualArray9.length);
	  assertArrayEquals(msg0, expectedArray9, actualArray9);
	  
	  //Test with ADDRESS_STREET_NAME and NULL
	  Entry[] actualArray10 = dbase1.selectXFrom(Column.ADDRESS_STREET_NAME, null);
	  assertArrayEquals(msg0, (actualArray10 == null ? null : new Entry[0]), actualArray10);
	  
	  //Test with PHONE_NUMBER and a nonexistant String
	  Entry[] expectedArray11 = new Entry[0];
	  Entry[] actualArray11 = dbase1.selectXFrom(Column.PHONE_NUMBER, "zzzz");
	  assertEquals(msg1, 0, actualArray11.length);
	  assertArrayEquals(msg0, expectedArray11, actualArray11);
	  
	  //Test with a NULL Column and some String
	  Entry[] actualArray12 = dbase1.selectXFrom(null, "zzzz");
	  assertArrayEquals(msg0, (actualArray12 == null ? null : new Entry[0]), actualArray12);
  }
  
  
  /**
   * Validate that sort works correctly
   */
  @Test
  public void sort() {
	  String msg0 = "Error in sort(). Elements of resulting database are wrong.";
	  
	  //Test with GIVEN_NAME 	  
	  dbase1.sort(Column.GIVEN_NAME);
	  assertEquals(msg0, 0, dbase1.getPos(e2));
	  assertEquals(msg0, 1, dbase1.getPos(e5));
	  assertEquals(msg0, 2, dbase1.getPos(e1));
	  assertEquals(msg0, 3, dbase1.getPos(e6));
	  assertEquals(msg0, 4, dbase1.getPos(e3));
	  assertEquals(msg0, 5, dbase1.getPos(e4));

	  //Test with FAMILY_NAME 	  
	  dbase1.sort(Column.FAMILY_NAME);
	  assertEquals(msg0, 0, dbase1.getPos(e5));
	  assertEquals(msg0, 1, dbase1.getPos(e2));
	  assertEquals(msg0, 2, dbase1.getPos(e6));
	  assertEquals(msg0, 3, dbase1.getPos(e1));
	  assertEquals(msg0, 4, dbase1.getPos(e3));
	  assertEquals(msg0, 5, dbase1.getPos(e4));
	  
	  //Test with PHONE_AREA_CODE 	  
	  dbase1.sort(Column.PHONE_AREA_CODE);
	  assertEquals(msg0, 0, dbase1.getPos(e2));
	  assertEquals(msg0, 1, dbase1.getPos(e4));
	  assertEquals(msg0, 2, dbase1.getPos(e1));
	  assertEquals(msg0, 3, dbase1.getPos(e3));
	  assertEquals(msg0, 4, dbase1.getPos(e6));
	  assertEquals(msg0, 5, dbase1.getPos(e5));

	  //Test with PHONE_NUMBER 	  
	  dbase1.sort(Column.PHONE_NUMBER);
	  assertEquals(msg0, 0, dbase1.getPos(e6));
	  assertEquals(msg0, 1, dbase1.getPos(e1));
	  assertEquals(msg0, 2, dbase1.getPos(e5));
	  assertEquals(msg0, 3, dbase1.getPos(e3));
	  assertEquals(msg0, 4, dbase1.getPos(e4));
	  assertEquals(msg0, 5, dbase1.getPos(e2));
	  
	  //Test with ADDRESS_STREET_NAME 	  
	  dbase1.sort(Column.ADDRESS_STREET_NAME);
	  assertEquals(msg0, 0, dbase1.getPos(e3));
	  assertEquals(msg0, 1, dbase1.getPos(e4));
	  assertEquals(msg0, 2, dbase1.getPos(e6));
	  assertEquals(msg0, 3, dbase1.getPos(e1));
	  assertEquals(msg0, 4, dbase1.getPos(e5));
	  assertEquals(msg0, 5, dbase1.getPos(e2));
	 
	  //Test with ADDRESS_HOUSE_NUMBER 	  
	  dbase1.sort(Column.ADDRESS_HOUSE_NUMBER);
	  assertEquals(msg0, 0, dbase1.getPos(e2));
	  assertEquals(msg0, 1, dbase1.getPos(e3));
	  assertEquals(msg0, 2, dbase1.getPos(e1));
	  assertEquals(msg0, 3, dbase1.getPos(e6));
	  assertEquals(msg0, 4, dbase1.getPos(e5));
	  assertEquals(msg0, 5, dbase1.getPos(e4));
	  
	  //Test with ADDRESS_ZIP_CODE 	  
	  dbase1.sort(Column.ADDRESS_ZIP_CODE);
	  assertEquals(msg0, 0, dbase1.getPos(e6));
	  assertEquals(msg0, (dbase1.getPos(e2) == 1 ? 1 : 2), dbase1.getPos(e2));
	  assertEquals(msg0, (dbase1.getPos(e1) == 2 ? 2 : 1), dbase1.getPos(e1));
	  assertEquals(msg0, 3, dbase1.getPos(e3));
	  assertEquals(msg0, 4, dbase1.getPos(e4));
	  assertEquals(msg0, 5, dbase1.getPos(e5));
	  
	  //Test with ADDRESS_CITY 	  
	  dbase1.sort(Column.ADDRESS_CITY);
	  assertEquals(msg0, 0, dbase1.getPos(e6));
	  assertEquals(msg0, 1, dbase1.getPos(e3));
	  assertEquals(msg0, (dbase1.getPos(e2) == 2 ? 2 : 3), dbase1.getPos(e2));
	  assertEquals(msg0, (dbase1.getPos(e1) == 3 ? 3 : 2), dbase1.getPos(e1));
	  assertEquals(msg0, 4, dbase1.getPos(e4));
	  assertEquals(msg0, 5, dbase1.getPos(e5));
	  
	  //Test with JOB 	  
	  dbase1.sort(Column.JOB);
	  assertEquals(msg0, 0, dbase1.getPos(e5));
	  assertEquals(msg0, 1, dbase1.getPos(e1));
	  assertEquals(msg0, 2, dbase1.getPos(e4));
	  assertEquals(msg0, 3, dbase1.getPos(e6));
	  assertEquals(msg0, 4, dbase1.getPos(e3));
	  assertEquals(msg0, 5, dbase1.getPos(e2));
	  
	  //Test with a NULL Column
	  dbase1.sort(null);
	  assertEquals(msg0, 0, dbase1.getPos(e5));
	  assertEquals(msg0, 1, dbase1.getPos(e1));
	  assertEquals(msg0, 2, dbase1.getPos(e4));
	  assertEquals(msg0, 3, dbase1.getPos(e6));
	  assertEquals(msg0, 4, dbase1.getPos(e3));
	  assertEquals(msg0, 5, dbase1.getPos(e2));
  }
 }

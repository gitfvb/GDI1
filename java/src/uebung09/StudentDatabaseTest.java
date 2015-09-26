package uebung09;

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

import org.junit.Before;
import org.junit.Test;

public class StudentDatabaseTest {
  Database dbase;

  // e1, e2,..., e6 = statische Einträge (Diese existieren also bevor jeder
  // einzelne Test aufgerufen wird.)

  Entry    e1    = new Entry("Hans", "Mustermann", new PhoneNumber("0180",
                     "1234567"), new Address("Rossmarkt", "26", "60311",
                     "Frankfurt"), "Dancer");
  Entry    e2    = new Entry("Anna", "Friedlich", new PhoneNumber("0163",
                     "9999999"),
                     new Address("Zeil", "1", "60311", "Frankfurt"),
                     "Teacher");
  Entry    e3    = new Entry("Otto", "Norbert", new PhoneNumber("0190",
                     "6666666"), new Address("Igelweg", "16", "64293",
                     "Darmstadt"), "Programmer");
  Entry    e4    = new Entry("Timo", "Ulbrich", new PhoneNumber("0170",
                     "8888888"), new Address("Irgendwostrasse", "9", "80210",
                     "Irgendwo"), "Physician");
  Entry    e5    = new Entry("Data", "Base",
                     new PhoneNumber("06031", "2222222"), new Address(
                         "Wallstreet", "7", "99551", "Stuttgart"), "Astronaut");
  Entry    e6    = new Entry("Karl", "Heinz",
                     new PhoneNumber("030", "1111111"), new Address(
                         "Peterstrasse", "442", "04504", "Berlin"), "Pilot");

  // e7 = dynamischer Eintrag

  Entry    e7    = new Entry("Joe", "Presley", new PhoneNumber("0179",
                     "47854754"), new Address("Marktplatz", "3", "23548",
                     "Sonstwo"), "Postbote");

  private final String expectedOutput =
    "Hans\tMustermann\t0180-1234567\t{Rossmarkt 26, 60311 Frankfurt}\tDancer\n"
    +"Anna\tFriedlich\t0163-9999999\t{Zeil 1, 60311 Frankfurt}\tTeacher\n"
    +"Otto\tNorbert\t0190-6666666\t{Igelweg 16, 64293 Darmstadt}\tProgrammer\n"
    +"Timo\tUlbrich\t0170-8888888\t{Irgendwostrasse 9, 80210 Irgendwo}\tPhysician\n"
    +"Data\tBase\t06031-2222222\t{Wallstreet 7, 99551 Stuttgart}\tAstronaut\n"
    +"Karl\tHeinz\t030-1111111\t{Peterstrasse 442, 04504 Berlin}\tPilot";

  /**
   * Set up the database by inserting six values in succession
   */
  @Before
  public void setup() {
    dbase = new Database();
    String msg0 = "Entry was not added to the database.";

    assertTrue(msg0, dbase.addEntry(e1));
    assertTrue(msg0, dbase.addEntry(e2));
    assertTrue(msg0, dbase.addEntry(e3));
    assertTrue(msg0, dbase.addEntry(e4));
    assertTrue(msg0, dbase.addEntry(e5));
    assertTrue(msg0, dbase.addEntry(e6));
  }

  /**
   * Tests that the existing values cannot be re-inserted,
   * but a new element can be inserted
   */
  @Test
  public void addingDuplicates() {
    String msg0 = "Entry was not added to the database.";
    String msg1 = "Entry already exists in the database.";

    assertFalse(msg1, dbase.addEntry(e1));
    assertFalse(msg1, dbase.addEntry(e2));
    assertFalse(msg1, dbase.addEntry(e6));

    assertTrue(msg0, dbase.addEntry(e7));
  }

  /**
   * Checks that the database size is consistent with add / delete
   */
  @Test
  public void getSize() {
    String msg0 = "The database should have 6 elements.";
 
    assertEquals(msg0, 6, dbase.getSize());
  }

  /**
   * test that all values can be deleted, but that re-deleting one is not
   * possible
   */
  @Test
  public void deleteEntry() {
    String msg0 = "Entry could not be deleted from the database.";

    assertTrue(msg0, dbase.deleteEntry(e1));
    assertTrue(msg0, dbase.deleteEntry(e2));
    assertTrue(msg0, dbase.deleteEntry(e3));
    assertEquals(3, dbase.getSize());

    assertFalse(msg0, dbase.deleteEntry(e1));
  }

  /**
   * Check what happens if the database is dropped
   */
  @Test
  public void dropDatabase() {
    String msg0 = "Database was not dropped correctly.";

    assertTrue(msg0, dbase.dropDatabase());
    assertEquals(msg0, "<Database is empty>", dbase.toString());
  }

  /**
   * Validate that getPos works correctly
   */
  @Test
  public void getPos() {
    String msg0 = "Entry is at the wrong position.";
    String msg1 = "Entry could not be deleted from the database.";

    assertEquals(msg0, 0, dbase.getPos(e1));
    assertEquals(msg0, 1, dbase.getPos(e2));

    assertTrue(msg0, dbase.deleteEntry(e1));
    assertEquals(msg0, -1, dbase.getPos(e1));
    assertEquals(msg0, 0, dbase.getPos(e2));
     assertEquals(msg0, 4, dbase.getPos(e6));

    assertTrue(msg1, dbase.deleteEntry(e2));
    assertEquals(msg0, -1, dbase.getPos(e2));
    assertEquals(msg0, 0, dbase.getPos(e3));
    assertEquals(msg0, 3, dbase.getPos(e6));
  }

 
  /**
   * Test the toString method
   */
  @Test
  public void testStringRepresentation() {
    assertEquals(expectedOutput, dbase.toString().trim());
  }
    
 }

/**
 * class: Database (represents the database, which consists of Entry elements)
 *
 * @author Oren Avni, (Tutor for GDI 1 / ICS 1 @ Winterterm: 2008-2009
 *         {TU-Darmstadt}
 * @author Guido Roessling
 * @category Java - Basic Object Operations
 * @version 1.0
 */
public class Database {
  /* the private array containing the elements */
  private Entry[] entries;

  /**
   * initializes the database to an empty entry collection
   */
  public Database() {
    //@TODO
   }


  /**
   * Drops the database and replaces it with one of size 0
   *
   * @return true if database has been deleted correctly, else false.
   */
  public boolean dropDatabase() {
    //@TODO
   }


  /**
   * deletes the entry e if it exists and updates the database
   *
   * @param e the Entry which should be deleted.
   * @return true if Entry has been deleted successfully, else false.
   */
  public boolean deleteEntry(Entry e) {
    //@TODO
   }

  /**
   * resizes the database after the entry at position
   * deletedPos was removed
   *
   * @param deletedPos the position that was deleted
   */
  public void resize(int deletedPos) {
    //@TODO
   }

  /**
   * returns true if an entry matching the parameter exists
   * in the database
   *
   * @param e the Entry that should exist.
   * @return true if the Entry exists in the database, else false.
   */
  public boolean entryExists(Entry e) {
    //@TODO
   }

  /**
   * inserts an entry into the database. Note: entries that already
   * exist will not be inserted again.
   *
   * @param e: the Entry that should be inserted to the database.
   * @return true if Entry has been successfully inserted to the database, else
   * false (if the value is null or already existed).
   */
  public boolean addEntry(Entry e) {
    //@TODO

  }

  /**
   * returns the position of the entry in the database or -1 if not found
   *
   * @param e the Entry for which the position shall be determined.
   * @return either a valid position or -1 if the entry is not contained or
   * the database is empty.
   */
  public int getPos(Entry e) {
       //@TODO

  }

  /**
   * returns the size of this database
   *
   * @return the size of this database.
   */
  public int getSize() {
    //@TODO
   }

  /**
   * Swaps the elements at the two given indices,
   * if both indices are valid
   *
   * As no entries are changed, only their ordering,
   * the database will stay consistent
   * @param pos1 the first position to be swapped
   * @param pos2 the second position to be swapped
   */
  protected void swap(int pos1, int pos2) {
     //@TODO
  }

  /**
   * Returns the complete String representation of this database
   *
   * @return the contents of the database as one formated String.
   */

  public String toString() {
       //@TODO
  }
}

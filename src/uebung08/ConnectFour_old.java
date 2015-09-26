package uebung08;
import acm.program.ConsoleProgram;
import acm.program.DialogProgram;


/**
 * ConnectFour is an implementation of 4-Gewinnt
 *
 * @author Melanie Hartmann, Daniel Schreiber
 * You may use ConsoleProgram or DialogProgram as a base class,
 *         whatever you prefer.
 *
 */
public class ConnectFour_old extends ConsoleProgram /* DialogProgram */{
  // state variables of this object
  int width = 7;
  int height = 6;
  char[][] board = new char[width][height];

  /**
   * Main loop of the program. Let players take turns entering moves until one
   * player wins or the board is full, in which case the game is a draw.
   */
  public void run() {
    int player = 1;
    println("---- 4 GEWINNT -----");

    // no winner yet.
    int winner = 0;

    while (winner == 0 && !isFull()) {
      // print the current board
      printBoard();
      // prompt the current player to enter a move
      promptPlayerMessage(player);
      // read the move from the player
      int x = readInt();

      // terminate when -1 is entered
      if (x == -1)
        System.exit(0);

      // players count from 1, Java from 0
      x--;

      // is input in correct range?
      if (x >= 0 && x < width) {
        // valid move, perform it
        int y = putInColumn(x, player);
        if (y == -1)
          // output row is full message
          rowFullMessage(x);
        else if (hasWon(x, y))
          winner = player;
        else
          // next player
          player = 3 - player;
      } else
        // invalid move
        errorMessage();

    }
    // game has ended, either we have a winner or a draw
    if (winner == 0)
      drawMessage();
    else
      winMessage(winner);
  }

  /**
   * Initializes the Connect Four Game
   *
   */
  public ConnectFour_old() {
    init();
  }

  /**
   * Returns the char that represents a player (i.e. x or o)
   *
   * @param playerNo
   *          number of the player, i.e. 1 or 2
   * @return the char for the player
   */
  public char getPlayerChar(int playerNo) {
    char[] playerChars = { 'x', 'o' };
    return playerChars[playerNo - 1];
  }

  /**
   * Prints the current board For example:
   * |
   * |
   * |
   * | o x
   * | o x x
   * |o x x o x
   * -------------
   *  1 2 3 4 5 6 7
   *
   */
  public void printBoard() {
      StringBuffer sb = new StringBuffer();
      for (int i = 0; i < height; i++) {
        // start of a line
        sb.append("|");
        for (int j = 0; j < width; j++) {
          sb.append(board[j][i]).append(' ');
        }
        // end of a line
        sb.append('\n');
      }
      sb.append(" -------------\n");
      sb.append(" 1 2 3 4 5 6 7");
      println(sb.toString());
  }

  /**
   * Checks whether the game is won and who won the game
   *
   * @return the number of the winner (i.e. 1 or 2) or 0 if no one has yet won
   *         the game
   */
  public boolean hasWon(int x, int y) {
    return (hasFourHorizontally(x, y) || hasFourVertically(x, y)
        || hasFourDiagonally(x, y));
   }

  /**
   * Checks whether another game piece can be added
   *
   * @return true if the board is full
   */
  public boolean isFull() {
    for (int x = 0; x < width; x++)
      if (board[x][0] == '_')
        return false;
    return true;
  }



  /**
   * Test whether there are four gaming pieces with the given char above each
   * other. Only checking column x needed as this is the only column a vertical
   * four-in-a-row could have been created in this turn.
   *
   * @param x
   *          column of the last added piece
   * @param y
   *          row of the last added piece
   * @return whether their are four gaming pieces above each other
   */
  public boolean hasFourVertically(int x, int y) {

		/*
		 * 
		 * // Deklaration boolean result = false;
		 * 
		 * int i = y + 1; // Startposition zur Prüfung
		 * 
		 * // Schleife zur Prüfung while (i < height && board[x][i] ==
		 * board[x][y]) i++;
		 * 
		 * // Prüfung des Ergebnisses if (i - y == 4) result = true;
		 * 
		 * return result;
		 */

  }

  /**
   * Test whether there are four gaming pieces with the given char next to each
   * other. Only checking column x needed as this is the only column a horizontal
   * four-in-a-row could have been created in this turn.
   *
   * @param x
   *          column of the last added piece
   * @param y
   *          row of the last added piece
   * @return whether their are four gaming pieces next to each other
   */
  public boolean hasFourHorizontally(int x, int y) {

		/*
		 * 
		 * // Deklaration boolean result = false; int i = x - 1, j = x + 1;
		 * 
		 * // Schleife zur Prüfung while (i >= 0 && board[i][y] == board[x][y])
		 * i--; // nach links gehen while (j < width && board[j][y] ==
		 * board[x][y]) j++; // nach rechts gehen
		 * 
		 * // Prüfung des Ergebnisses if (j - i - 1 >= 4)
		 * Schleife nochmal prüfen result = true;
		 * 
		 * return result;
		 */
  }


  /**
   * Test whether there are 4 gaming pieces next to each other on a diagonal.
   * Only checking column x needed as this is the only column a horizontal
   * four-in-a-row could have been created in this turn.
   *
   * @param x
   *          column of the last added piece
   * @param y
   *          row of the last added piece
   * @return whether there are 4 gaming pieces next to each other on a diagonal
   */
  public boolean hasFourDiagonally(int x, int y) {

		/*
		 * 
		 * // Deklaration boolean result = false;
		 * 
		 * // 2 Durchläufe nötig // -x -y && +x +y // -x +y && +x -y
		 * 
		 * // Schleife zur Prüfung if (checkDirection(-1, -1, x, y) == true)
		 * result = true; if (checkDirection(-1, 1, x, y) == true) result =
		 * true;
		 * 
		 * // Prüfung des Ergebnisses
		 * 
		 * return result;
		 */

  }


  /**
   * Initialize the board with blanks
   *
   */
  public void init() {
	  for (int y = 0; y < height; y++) {
		  for (int x = 0; x < width; x++) {
			  board[x][y] = '_';
		  }
	  }
  }


  /* messages */
  private void promptPlayerMessage(int p) {
	  println("Spieler " + p + ": ");
  }

  private void rowFullMessage(int x) {
	  println("Reihe " + (x + 1) + " ist bereits voll!");
  }

  private void winMessage(int p) {
	  println("Spieler " + p + " hat gewonnen.");
  }

  private void drawMessage() {
	  println("Unentschieden.");
  }

  private void errorMessage() {
	  println("Fehler im Spiel.");
  }

  /**
   * Put a gaming piece on top of the gaming pieces in the given column by the
   */
  public int putInColumn(int column, int playerNo) {
	  
	  // Deklaration
	  int y, i = height - 1;
	  
	  // Abprüfen der Reihe
	  while (i >= 0 && board[column][i] != '_') i--;
	  
	  // Handling, wie mit der ermittelten Reihe umgegangen wird
	  if ( i >= 0 ) board[column][i] = getPlayerChar(playerNo);
	  y = i;
	  	  
    return y;
  }


  /**
   * Main method. This is automatically called by the environment when your
   * program starts.
   *
   * @param args
   */
  public static void main(String[] args) {
    new ConnectFour_old().run();
  }
}

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
public class ConnectFour extends ConsoleProgram /* DialogProgram */{
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
          columnFullMessage(x);
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
  public ConnectFour() {
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
    //TODO implement
    return false;
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
    //TODO implement
    return false;
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
    //TODO implement
    return false;
  }


  /**
   * Initialize the board with blanks
   *
   */
  public void init() {
    //TODO implement
  }


  /* messages */
  private void promptPlayerMessage(int p) {
    //TODO implement
  }

  private void columnFullMessage(int x) {
    //TODO implement
  }

  private void winMessage(int p) {
    //TODO implement
  }

  private void drawMessage() {
    //TODO implement
  }

  private void errorMessage() {
    //TODO implement
  }

  /**
   * Put a gaming piece on top of the gaming pieces in the given column by the
   */
  public int putInColumn(int column, int playerNo) {
    //TODO put piece of player in column
    return -1;
  }


  /**
   * Main method. This is automatically called by the environment when your
   * program starts.
   *
   * @param args
   */
  public static void main(String[] args) {
    new ConnectFour().start();
  }
}

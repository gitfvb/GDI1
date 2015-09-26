package uebung08;
/*
 ************************************************
 * 
 * UEBUNGSGRUPPE GDI 1 BEI FLORIAN REITH
 * 
 *-----------------------------------------------
 * 
 * WS 2008/2009
 * Florian Friedrichs
 * Uebung 8
 * 
 ************************************************
 */

import acm.program.ConsoleProgram;
import acm.program.DialogProgram;

/**
 * ConnectFour is an implementation of 4-Gewinnt
 * 
 * @author Melanie Hartmann, Daniel Schreiber You may use ConsoleProgram or
 *         DialogProgram as a base class, whatever you prefer.
 *
 * @ModifiedBy Florian Friedrichs - ff1010
 */
public class ConnectFour extends ConsoleProgram /* DialogProgram */{
	// state variables of this object
	int width = 7;
	int height = 6;
	char[][] board = new char[width][height];
	int StonesToWin = 4; // possibility of difficulty

	/**
	 * Main loop of the program. Let players take turns entering moves until one
	 * player wins or the board is full, in which case the game is a draw.
	 */
	public void run() {
		int player = 1;
		println("---- " + StonesToWin + " GEWINNT -----"); // added variable
															// StonesToWin

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
		printBoard(); // added to print the board a last time at the end
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
	 *            number of the player, i.e. 1 or 2
	 * @return the char for the player
	 */
	public char getPlayerChar(int playerNo) {
		char[] playerChars = { 'x', 'o' };
		return playerChars[playerNo - 1];
	}

	/**
	 * Prints the current board For example: | | | | o x | o x x |o x x o x
	 * ------------- 1 2 3 4 5 6 7
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
		return (hasFourHorizontally(x, y) || hasFourVertically(x, y) || hasFourDiagonally(
				x, y));
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
	 * other. Only checking column x needed as this is the only column a
	 * vertical four-in-a-row could have been created in this turn.
	 * 
	 * @param x
	 *            column of the last added piece
	 * @param y
	 *            row of the last added piece
	 * @return whether their are four gaming pieces above each other
	 */
	public boolean hasFourVertically(int x, int y) {
		return checkDirections(0, -1, x, y);
	}

	/**
	 * Test whether there are four gaming pieces with the given char next to
	 * each other. Only checking column x needed as this is the only column a
	 * horizontal four-in-a-row could have been created in this turn.
	 * 
	 * @param x
	 *            column of the last added piece
	 * @param y
	 *            row of the last added piece
	 * @return whether their are four gaming pieces next to each other
	 */
	public boolean hasFourHorizontally(int x, int y) {
		return checkDirections(-1, 0, x, y);
	}

	/**
	 * Test whether there are 4 gaming pieces next to each other on a diagonal.
	 * Only checking column x needed as this is the only column a horizontal
	 * four-in-a-row could have been created in this turn.
	 * 
	 * @param x
	 *            column of the last added piece
	 * @param y
	 *            row of the last added piece
	 * @return whether there are 4 gaming pieces next to each other on a
	 *         diagonal
	 */
	public boolean hasFourDiagonally(int x, int y) {
		return (checkDirections(-1, -1, x, y) || checkDirections(-1, 1, x, y));
	}

	/**
	 * Test whether there are four or more gaming pieces in a direction. The direction
	 * can be checked by two modifiers and it should be positive (1),
	 * negative (-1) or deactivated (0). Activation of both directions results
	 * in a diagonal direction.
	 * 
	 * @param mod_x
	 *            direction to search the char on x-axis (0 deactivates)
	 * @param mod_y
	 *            direction to search the char on y-axis (0 deactivates)
	 * @param x
	 *            column of the last added piece
	 * @param y
	 *            row of the last added piece
	 * @return whether there are 4 gaming pieces next to each other on a defined
	 *         direction
	 */
	private boolean checkDirections(int mod_x, int mod_y, int x, int y) {

		// Declaration
		int loop_x, loop_y, n;
		int i = 0, result_counter = 0;
		
		// running the loop twice (one loop for one direction e.g. left and
		// right)
		for (n = 1; n <= 2; n++) {

			// searching and counting into on direction until the char is not
			// the expected one
			do {
				i++;
				loop_x = x + (i * mod_x);
				loop_y = y + (i * mod_y);
				// compare the origin char with current char, minding the max
				// dimensions of array bound
			} while (loop_x >= 0 && loop_x < width && loop_y >= 0
					&& loop_y < height && board[loop_x][loop_y] == board[x][y]);

			// if this loop is done, the direction will be inverted
			mod_x = mod_x * -1;
			mod_y = mod_y * -1;
			result_counter += i - 1; // saving the result
			i = 0; // reset the counter
		}

		// Checking and returning the result
		return (result_counter >= StonesToWin - 1); // this is (StonesToWin - 1)
		// because the given
		// coordinate
		// is not countered
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

	/************/
	/* messages */
	/************/

	/**
	 * Message for players prompt
	 * 
	 * @param p
	 *            player number, which is on the turn
	 */
	private void promptPlayerMessage(int p) {
		println("Player " + p + ": ");
	}

	/**
	 * Message for a full row
	 * 
	 * @param x
	 *            row, which is full
	 */
	private void columnFullMessage(int x) {
		println("Row " + (x + 1) + " is already full!");
	}

	/**
	 * Message for the winner
	 * 
	 * @param p
	 *            player number, who has won
	 */
	private void winMessage(int p) {
		println("Player " + p + " has won :-)");
	}

	/**
	 * Message for "draw game" (board is full)
	 * 
	 */
	private void drawMessage() {
		println("Draw game");
	}

	/**
	 * Message for errors
	 * 
	 */
	private void errorMessage() {
		println("Error in the game");
	}

	/**
	 * Put a gaming piece on top of the gaming pieces in the given column by the
	 * column
	 * 
	 * @param column
	 *            column of the board, where the stone is wished to be placed
	 * @param playerNo
	 *            player number
	 * 
	 * @return -1 if the column is full. Otherwise returns the first free row in
	 *         the column
	 * 
	 */
	public int putInColumn(int column, int playerNo) {

		// Declaration
		int y, i = height - 1;

		// Checking the row
		while (i >= 0 && board[column][i] != '_')
			i--;

		// Handling for saving the value and returning the result
		if (i >= 0)
			board[column][i] = getPlayerChar(playerNo);
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
		new ConnectFour().start();
	}
}

package uebung08;
import acm.program.ConsoleProgram;

//import acm.program.DialogProgram;

/**
 * ConnectFour is an implementation of 4-Gewinnt
 * 
 * @author Melanie Hartmann, Daniel Schreiber, Andre Munzinger You may use ConsoleProgram or
 *         DialogProgram as a base class, whatever you prefer.
 * 
 * @version 15.12.2008
 * 
 */
public class ConnectFour_andre extends ConsoleProgram /* DialogProgram */{
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
		printBoard();
		if (winner == 0)
			drawMessage();
		else
			winMessage(winner);
	}

	/**
	 * Initializes the Connect Four Game
	 * 
	 */
	public ConnectFour_andre() {
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
	 * Checks if two pieces are equal
	 * 
	 * @param part1
	 *            coordinates of a field
	 * @param part1
	 *            coordinates of a field
	 * @return whether the party are equal or not
	 */
	private boolean isEqual(int part1[], int part2[]) {
		try {
			if (board[part1[0]][part1[1]] == board[part2[0]][part2[1]])
				return true;
			else
				return false;
		} catch (Exception e) {
			System.err.println("Error: " +  e.toString());
			return false;
		}
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
		int down[] = { x, y + 1 };
		int up[] = { x, y - 1 };
		final int lastPiece[] = { x, y };
		int[] tmpPiece = lastPiece;
		int found = 0;

		// Nach unten prüfen
		while (down[1] < height && this.isEqual(down, tmpPiece) && found < 3) {
			found++;
			down[1]++;
			tmpPiece[1]++;
		}

		tmpPiece = lastPiece;

		// Nach oben prüfen
		while (up[1] >= 0 && this.isEqual(up, tmpPiece) && found < 3) {
			found++;
			up[1]--;
			tmpPiece[1]--;
		}

		if (found >= 3)
			return true;
		else
			return false;
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
		int left[] = { x - 1, y };
		int right[] = { x + 1, y };
		final int lastPiece[] = { x, y };
		int[] tmpPiece = lastPiece;
		int found = 0;

		// Linke Seite prüfen
		while (left[0] >= 0 && this.isEqual(left, tmpPiece) && found < 3) {
			found++;
			left[0]--;
			tmpPiece[0]--;
		}

		tmpPiece = lastPiece;

		// Rechte Seite prüfen
		while (right[0] < width && this.isEqual(right, tmpPiece) && found < 3) {
			found++;
			right[0]++;
			tmpPiece[0]++;
		}

		if (found >= 3)
			return true;
		else
			return false;
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
		int leftUp[] = { x - 1, y - 1 };
		int leftDown[] = { x - 1, y + 1 };
		int rightUp[] = { x + 1, y - 1 };
		int rightDown[] = { x + 1, y + 1 };
		final int lastPiece[] = { x, y };
		int[] tmpPiece = lastPiece;
		int found1 = 0;
		int found2 = 0;
				
		// Linksunten nach rechtsoben
		// Linke Seite prüfen
		while (leftDown[0] >= 0 && leftDown[1] < height && this.isEqual(leftDown, tmpPiece) && found1 < 3) {
			found1++;
			leftDown[0]--;
			leftDown[1]++;
			tmpPiece[0]--;
			tmpPiece[1]++;
		}

		tmpPiece = lastPiece;

		// Rechte Seite prüfen
		while (rightUp[0] < width && rightUp[1] >= 0 && this.isEqual(rightUp, tmpPiece) && found1 < 3) {
			found1++;
			rightUp[0]++;
			rightUp[1]--;
			tmpPiece[0]++;
			tmpPiece[1]--;
		}
		
		tmpPiece = lastPiece;
		
		// Rechtsunten nach linksoben
		// Linke Seite prüfen
		while (leftUp[0] >= 0 && leftUp[1] >= 0 && this.isEqual(leftUp, tmpPiece) && found2 < 3) {
			found2++;
			leftUp[0]--;
			leftUp[1]--;
			tmpPiece[0]--;
			tmpPiece[1]--;
		}

		tmpPiece = lastPiece;

		// Rechte Seite prüfen
		while (rightDown[0] < width && rightDown[1] < height && this.isEqual(rightDown, tmpPiece) && found2 < 3) {
			found2++;
			rightDown[0]++;
			rightDown[1]++;
			tmpPiece[0]++;
			tmpPiece[1]++;
		}

		if (found1 >= 3 || found2 >= 3)
			return true;
		else
			return false;
			
	}

	/**
	 * Initialize the board with blanks
	 * 
	 */
	public void init() {
		for (int lauf1 = 0; lauf1 < width; lauf1++) {
			for (int lauf2 = 0; lauf2 < height; lauf2++) {
				board[lauf1][lauf2] = '_';
			}
		}
	}

	/* messages */
	/**
	 * Gibt die Spieleranweisung auf die Konsole aus
	 * 
	 * @param p
	 *            Spielernummer: 1,2,...
	 */
	private void promptPlayerMessage(int p) {
		System.out.println("Spieler " + p + ": Bitte geben Sie Ihren Zug ein.");
	}

	/**
	 * Gibt dem Benutzer eine Meldung aus, dass die von Ihm gewünschte Spalte
	 * bereits voll ist.
	 * 
	 * @param x
	 *            Spaltennummer: 1,2,...
	 */
	private void rowFullMessage(int x) {
		System.out.println("Fehler: Spalte " + x + " ist voll.");
	}

	/**
	 * Gibt dem Benutzer den Gewinner an
	 * 
	 * @param p
	 *            Spielernummer: 1,2,...
	 */
	private void winMessage(int p) {
		System.out.println("Herzlichen Glückwunsch Spieler " + p
				+ "!\nSie haben gewonnen!");
	}

	/**
	 * Gibt Meldung über Unentschieden aus
	 */
	private void drawMessage() {
		System.out.println("Das Spiel ist beendet: Unentschieden.");
	}

	/**
	 * Gibt Fehlermeldung aus
	 */
	private void errorMessage() {
		System.out
				.println("Es ist ein Fehler aufgetreten.\nBitte überprüfen Sie Ihre Eingabe.");
	}

	/**
	 * Put a gaming piece on top of the gaming pieces in the given column by the
	 */
	public int putInColumn(int column, int playerNo) {
		int row = -1;

		for (int lauf = height - 1; lauf >= 0; lauf--) {
			if (board[column][lauf] == '_') {
				board[column][lauf] = this.getPlayerChar(playerNo);
				return lauf;
			}

		}
		return row;
	}

	/**
	 * Main method. This is automatically called by the environment when your
	 * program starts.
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		new ConnectFour_andre().start();
	}
}

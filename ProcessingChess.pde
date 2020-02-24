
///Need to add pawn reaching the end 
int cellSize;
Board gameBoard;
Player playerWhite;
Player playerBlack;
boolean whiteTurn = true; //true = White false = Black
boolean debugMode = false;
int turnCount = 0;
boolean gameOver = false;
///TestmyGit
void setup() {
  size(800, 800);
  imageMode(CENTER);
  cellSize = width/8;
  gameBoard = new Board();
  playerWhite = new Player(true);
  playerBlack = new Player(false);
}

void draw() {
  background(0);
  gameBoard.show();
  playerWhite.run();
  playerBlack.run();
  if (gameOver) {
    gameBoard = new Board();
    playerWhite = new Player(true);
    playerBlack = new Player(false);
    gameOver = false;
    whiteTurn = true;
  }
}

void keyReleased() {
  whiteTurn = !whiteTurn;
  if(key == 'q'){
    debugMode = !debugMode;
  }
}
void mouseReleased() {
  for (int i = 0; i < gameBoard.grid.length; i++) {
    for (int j = 0; j < gameBoard.grid[i].length; j++) {
      if (gameBoard.grid[i][j].containsMouse()) {
        if (whiteTurn) {
          if (gameBoard.grid[i][j].movePiece(playerWhite)) {
            // whiteTurn = false;
          }
        } else {
          if (gameBoard.grid[i][j].movePiece(playerBlack)) {
            //whiteTurn = true;
          }
        }
      }
    }
  }
}

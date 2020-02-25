class Player {
  Piece[] pieces = new Piece[16];
  boolean isWhite;
  Player(boolean inIsWhite) {
    int pRow;
    isWhite = inIsWhite;

    if (isWhite) {
      pRow = 7;
    } else {
      pRow = 0;
    }
    pieces[0] = new Rook(0, pRow, isWhite);
    pieces[1] = new Knight(1, pRow, isWhite);
    pieces[2] = new Bishop(2, pRow, isWhite);
    pieces[3] = new Queen(3, pRow, isWhite);
    pieces[4] = new King(4, pRow, isWhite);
    pieces[5] = new Bishop(5, pRow, isWhite);
    pieces[6] = new Knight(6, pRow, isWhite);
    pieces[7] = new Rook(7, pRow, isWhite);
    if (isWhite) {
      pRow = 6;
    } else {
      pRow = 1;
    }
    for (int i = 0; i < 8; i++) {
      pieces[8+i] = new Pawn(i, pRow, isWhite);
    }
  }


  void show() {
    for (int i = 0; i < pieces.length; i++) {
      pieces[i].show();
    }
    for(int i = 8; i< 16; i++){
      if(pieces[i].atEnd){
        pieces[i] = new Queen(pieces[i].pIndex.x,pieces[i].pIndex.y, pieces[i].isWhite);
      }
    }
  }



  void run() {
    show();
  }
}

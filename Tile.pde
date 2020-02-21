class Tile {
  PVector loc, tIndex;
  color tileColor;
  boolean hasPiece = false;
  int pieceColor = 0; // 0 - No Piece 1 - White 2 - Black;
  Tile(float inX, float inY, int inTC) {
    loc = new PVector(inX * cellSize, inY * cellSize);
    tIndex = new PVector(inX, inY);
    tileColor = inTC;
  }

  void show() {
    //noStroke();
    fill(tileColor);
    if (debugMode) {
      if (pieceColor == 0) {
        fill(0, 0, 255);
      } else if (pieceColor == 1) {
        fill(255, 0, 0);
      } else {
        fill(0, 255, 0);
      }
    }
    rect(loc.x, loc.y, cellSize, cellSize);
  }

  boolean movePiece(Player inP) {
    for (int i = 0; i < inP.pieces.length; i++) {
      if (loc.equals(inP.pieces[i].loc)) {
        inP.pieces[i].makeMoveList();
        inP.pieces[i].moving = true;
        return true;
      }
    }
    return false;
  }

  boolean containsMouse() {
    if (mouseX > loc.x && mouseX < loc.x + cellSize && mouseY > loc.y && mouseY < loc.y + cellSize) {
      return true;
    } else {
      return false;
    }
  }
}

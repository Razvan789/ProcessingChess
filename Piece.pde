class Piece {
  PImage pPic;
  PVector loc, pIndex, oldLoc;
  boolean isWhite;
  int colorOffset = 1; // White is 1, Black is -1 
  boolean moving = false;
  boolean firstMove = true;
  ArrayList<PVector> moveLocs;
  Piece(float x, float y, String type, boolean inIsWhite) {
    loc = new PVector(x * cellSize, y * cellSize);
    oldLoc = new PVector(x * cellSize, y * cellSize);
    pIndex = new PVector(x, y);
    isWhite = inIsWhite;
    gameBoard.grid[floor(pIndex.x)][floor(pIndex.y)].hasPiece = true;
    if (isWhite) {
      gameBoard.grid[floor(pIndex.x)][floor(pIndex.y)].pieceColor = 1;
    } else {
      gameBoard.grid[floor(pIndex.x)][floor(pIndex.y)].pieceColor = 2;
    }


    moveLocs = new ArrayList<PVector>();
    if (isWhite) {
      pPic = loadImage("W" + type);
      colorOffset = 1;
    } else {
      pPic = loadImage("B" + type);
      colorOffset = -1;
    }
    // pPic.resize(85, 85);
  }

  void show() {
    if (moving) {
      tint(0, 255, 0);
    } else {
      noTint();
    }
    update();

    image(pPic, loc.x + (cellSize/2), loc.y+ (cellSize/2), 85, 85);
  }

  void update() {
    boolean cont = false;
    if (moving) {
      loc = new PVector(mouseX - (cellSize/2), mouseY - (cellSize/2));

      showMoveLocs();

      if (mousePressed) {
        /////////////////////////////////////////Putting down a piece///////////////////////////////////////////////////






        //moving = false;
        cont = false;
        loc.x =floor(map(loc.x + (cellSize/2), 0, width, 0, 8) )* cellSize;
        loc.y = floor(map(loc.y + (cellSize/2), 0, height, 0, 8)) * cellSize;
        pIndex = new PVector(loc.x/( width /8), loc.y/( width/8));
        for (PVector mLoc : moveLocs) {
          if (mLoc.equals(pIndex)) {
            cont = true;
          }
        }
        if (!cont) {
          moving = false;
          loc = new PVector(oldLoc.x, oldLoc.y);
          pIndex = new PVector(oldLoc.x/( width /8), oldLoc.y/( width/8));
        } else {
          moving = false;
          pIndex = new PVector(loc.x/( width /8), loc.y/( width/8));
          gameBoard.grid[floor(pIndex.x)][floor(pIndex.y)].hasPiece = true;
          if (isWhite) {
            gameBoard.grid[floor(pIndex.x)][floor(pIndex.y)].pieceColor = 1;
          } else {
            gameBoard.grid[floor(pIndex.x)][floor(pIndex.y)].pieceColor = 2;
          }

          PVector oldLocI = new PVector(int(oldLoc.x/cellSize), int(oldLoc.y/cellSize));
          gameBoard.grid[floor(oldLocI.x)][floor(oldLocI.y)].hasPiece = false;
          gameBoard.grid[floor(oldLocI.x)][floor(oldLocI.y)].pieceColor = 0;
          oldLoc = new PVector(loc.x, loc.y);

          firstMove = false;
          whiteTurn = !whiteTurn;
          makeMoveList();
          if (isWhite) {
            takePieceCheck(playerBlack);
          } else {
            takePieceCheck(playerWhite);
          }
        }
      }
    }
  }











  void takePieceCheck(Player takenP) {
    for (int i = 0; i < takenP.pieces.length; i++) {
      if (this.loc.equals(takenP.pieces[i].loc)) {
        takenP.pieces[i].loc.x = 100000000;
        if (takenP.pieces[i] instanceof King) {
          gameOver = true;
        }
      }
    }
  }













  void removeMoveLoc(PVector rVec) {
    for (int i = 0; i < moveLocs.size(); i++) {
      PVector p = moveLocs.get(i);
      if (p.x == rVec.x && p.y == rVec.y ) {
        moveLocs.remove(i);
        println("REMOVED" + i);
        i--;
      }
    }
  }









  //Recusive Fuction area-----------------------------------------------------------------------------------------



  void addLocRec(PVector inIndex, PVector addVector) {
    PVector tempVec = new PVector(inIndex.x + addVector.x, inIndex.y + addVector.y);
    println(tempVec);
    if (tempVec.y >= 0 && tempVec.y < 8 && tempVec.x >= 0 && tempVec.x < 8) {
      println("Ticked if");
      int colorHolder = gameBoard.grid[floor(tempVec.x)][floor(tempVec.y)].pieceColor;
      println(colorHolder);
      if (this.isWhite && colorHolder == 2) {
        moveLocs.add(tempVec);
      } 
      if (this.isWhite == false && colorHolder == 1) {
        moveLocs.add(tempVec);
      }
      if (colorHolder == 0) {
        moveLocs.add(tempVec);
        addLocRec(tempVec, addVector);
      }
    }
  }
  
  
  void addLoc(PVector inIndex, PVector addVector){
    PVector tempVec = new PVector(inIndex.x + addVector.x, inIndex.y + addVector.y);
    println(tempVec);
    if (tempVec.y >= 0 && tempVec.y < 8 && tempVec.x >= 0 && tempVec.x < 8) {
      //println("Ticked if");
      int colorHolder = gameBoard.grid[floor(tempVec.x)][floor(tempVec.y)].pieceColor;
      println(colorHolder);
      if (this.isWhite && colorHolder == 2) {
        moveLocs.add(tempVec);
      } 
      if (this.isWhite == false && colorHolder == 1) {
        moveLocs.add(tempVec);
      }
      if (colorHolder == 0) {
        moveLocs.add(tempVec);
      }
    }
  }
  


  //void addUp(PVector inIndex) {
  //  PVector tempVec = new PVector(inIndex.x, inIndex.y - 1);

  //  if (tempVec.y >= 0) {
  //    int colorHolder = gameBoard.grid[floor(tempVec.x)][floor(tempVec.y)].pieceColor;
  //   // println(colorHolder);
  //    if (this.isWhite && colorHolder == 2) {
  //      moveLocs.add(tempVec);
  //    } 
  //    if (this.isWhite == false && colorHolder == 1) {
  //      moveLocs.add(tempVec);
  //    }
  //    if (colorHolder == 0) {
  //      moveLocs.add(tempVec);
  //      addUp(tempVec);
  //    }
  //  }
  //}







  //void addDown(PVector inIndex) {
  //  PVector tempVec = new PVector(inIndex.x, inIndex.y + 1);
  //  if (tempVec.y < 7) {
  //    int colorHolder = gameBoard.grid[floor(tempVec.x)][floor(tempVec.y)].pieceColor;
  //    println(colorHolder);
  //    if (this.isWhite && colorHolder == 2) {
  //      moveLocs.add(tempVec);
  //    } 
  //    if (this.isWhite == false && colorHolder == 1) {
  //      moveLocs.add(tempVec);
  //    }
  //    if (colorHolder == 0) {
  //      moveLocs.add(tempVec);
  //      addDown(tempVec);
  //    }
  //  }
  //}








  void makeMoveList() {
  }





  void showMoveLocs() {
    for (PVector p : moveLocs) {
      fill(0, 255, 0, 30);
      rect(p.x * cellSize, p.y * cellSize, cellSize, cellSize);
    }
  }
}









//////////////////////////////////////////////////////////Pawn//////////////////////////////////////////////////////////////////////

class Pawn extends Piece {
  Pawn(float xPos, float yPos, boolean inIsWhite) {
    super(xPos, yPos, "_Pawn.png", inIsWhite);
    makeMoveList();
  }

  void makeMoveList() {
    moveLocs.clear();
    pawnCheck();
    if (firstMove) {
      addLoc(this.pIndex, new PVector(0,- 2 * colorOffset));
    }
  }
  
  
  void pawnCheck(PVector inIndex, boolean inIsWhite){
    //HEIIIIIII
    PVector[] tempVecs = new PVector[2]; /////////////////////////////TURN THIS ALL INTO A FOR LOOP OVER THIS ARRAY STOP BEING SPAGETTI RAZ//////////////////////////
    PVector tempVecLeft = new PVector(inIndex.x - 1, inIndex.y - 1);
    PVector tempVecRight = new PVector(inIndex.x +1, inIndex.y - 1);
    if (tempVecLeft.y >= 0 && tempVecLeft.y < 8 && tempVecLeft.x >= 0 && tempVecRight.x < 8) {
      //println("Ticked if");
      int colorHolderLeft = gameBoard.grid[floor(tempVecLeft.x)][floor(tempVecLeft.y)].pieceColor;
      int colorHolderright = gameBoard.grid[floor(tempVecRight.x)][floor(tempVecRight.y)].pieceColor;
      
    }
  }
}





///////////////////////////////////////////////////////Bishop/////////////////////////////////////////////////////////////////////

class Bishop extends Piece {
  Bishop(float xPos, float yPos, boolean inIsWhite) {
    super(xPos, yPos, "_Bishop.png", inIsWhite);
    makeMoveList();
  }

  void makeMoveList() {
    moveLocs.clear();
    addLocRec(this.pIndex, new PVector(-1, -1));
    addLocRec(this.pIndex, new PVector(1, -1));
    addLocRec(this.pIndex, new PVector(1, 1));
    addLocRec(this.pIndex, new PVector(-1, 1));
  }
}







///////////////////////////////////////////////////////////Rook/////////////////////////////////////////////////////////////////

class Rook extends Piece {
  Rook(float xPos, float yPos, boolean inIsWhite) {
    super(xPos, yPos, "_Rook.png", inIsWhite);
    makeMoveList();
  }

  void makeMoveList() {
    moveLocs.clear();

    addLocRec(this.pIndex, new PVector(0, -1));
    addLocRec(this.pIndex, new PVector(0, 1));
    addLocRec(this.pIndex, new PVector( 1, 0));
    addLocRec(this.pIndex, new PVector(-1, 0));
  }
}



///////////////////////////////////////////////////////////////Knight///////////////////////////////////////////////////////
class Knight extends Piece {
  Knight(float xPos, float yPos, boolean inIsWhite) {
    super(xPos, yPos, "_Knight.png", inIsWhite);
    makeMoveList();
  }


  void makeMoveList() {
    moveLocs.clear();
    for (int i = -1; i <= 1; i+= 2) {
      addLoc(this.pIndex, new PVector(i,  i * 2));
      addLoc(this.pIndex, new PVector(-i, i * 2));
      addLoc(this.pIndex, new PVector(i*2,i   ));
      addLoc(this.pIndex, new PVector(i*2, -i));
    }
  }
}







///////////////////////////////////////////////////King///////////////////////////////////////////////
class King extends Piece {
  King(float xPos, float yPos, boolean inIsWhite) {
    super(xPos, yPos, "_King.png", inIsWhite);
    makeMoveList();
  }
  void makeMoveList() {
    moveLocs.clear();
    addLoc(this.pIndex, new PVector(0, -1));
    addLoc(this.pIndex, new PVector(1, -1));
    addLoc(this.pIndex, new PVector(1,  0));
    addLoc(this.pIndex, new PVector(-1, 1));
    addLoc(this.pIndex, new PVector(1,  1));
    addLoc(this.pIndex, new PVector(0, 1));
    addLoc(this.pIndex, new PVector(-1, 0));
    addLoc(this.pIndex, new PVector(-1, -1));
  }
}









/////////////////////////////////////////////////Queen///////////////////////////////////////////////////
class Queen extends Piece {
  Queen(float xPos, float yPos, boolean inIsWhite) {
    super(xPos, yPos, "_Queen.png", inIsWhite);
    makeMoveList();
  }
  void makeMoveList() {
    moveLocs.clear();

    //Straight ones
    addLocRec(this.pIndex, new PVector(0, -1));
    addLocRec(this.pIndex, new PVector(0, 1));
    addLocRec(this.pIndex, new PVector( 1, 0));
    addLocRec(this.pIndex, new PVector(-1, 0));


    //Diags
    addLocRec(this.pIndex, new PVector(-1, -1));
    addLocRec(this.pIndex, new PVector(1, -1));
    addLocRec(this.pIndex, new PVector(1, 1));
    addLocRec(this.pIndex, new PVector(-1, 1));
  }
}

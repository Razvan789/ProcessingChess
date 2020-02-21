class Board {
  //8 by 8 
  Tile[][] grid = new Tile[8][8];
  Board() {
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        if (i % 2 == 0 ) {
          if (j % 2 == 0) {
            grid[i][j] = new Tile(i, j, 255);
          } else {
            grid[i][j] = new Tile(i, j, 100);
          }
        } else {
          if (j % 2 == 0) {
            grid[i][j] = new Tile(i, j, 100);
          } else {
            grid[i][j] = new Tile(i, j, 255);
          }
        }
      }
    }
  }

  void show() {
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        grid[i][j].show();
      }
    }
  }
}

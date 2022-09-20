import g4p_controls.*;

String[] list;
ArrayList<Block> puzzleSolve = new ArrayList();
ArrayList<Block> puzzleDraw = new ArrayList();
ArrayList<Move> moveList = new ArrayList();
int padding = 50;
int gridSize;
int lastMove = -1;
int distance = 1;
int newBlock = 0;
int xOffset;
int yOffset;
int moving = -1;
int numRecur;
int attempts;
boolean fast;
int delay;

void setup() {
  //Sets simple variables
  size(800, 800);
  createGUI();
  gridSize = (width - 2*padding) / 6;

  //Loads an empty puzzle
  String[] list = loadStrings("Puzzle0.txt");
  loadPuzzle(list);
  
  //Loads the rules
  String[] rules = loadStrings("rules.txt");
  rulesText.setText(rules[0] + "\n" + rules[1]);
}

//Reads a puzzle from a text file an fills arrays with values
void loadPuzzle(String[] list) {
  //Clears all arrays
  puzzleSolve = new ArrayList<Block>();
  puzzleDraw = new ArrayList<Block>();
  moveList = new ArrayList<Move>();
  
  //Fills arrays using previous text file
  for (int i = 0; i < list.length; i++) {
    String[] tempBlock = split(list[i], ",");

    puzzleSolve.add(new Block(int(tempBlock[0]), int(tempBlock[1]), int(tempBlock[2])));
    puzzleDraw.add(new Block(int(tempBlock[0]), int(tempBlock[1]), int(tempBlock[2])));
  }
  
  //Clears the notation box
  note.setText("");
}



//DRAWING
void draw() {
  background(96, 64, 32);
  drawGrid();
  drawPuzzle();
}

//Draws the unmoving background and grid
void drawGrid() {
  fill(191, 128, 64);
  rect(padding, padding, gridSize*6, gridSize*6);

  //Draws vertical lines
  for (int i = 0; i < 7; i++) {
    stroke(96, 64, 32);
    line(i*gridSize + padding, padding, i*gridSize + padding, height - padding);
  }

  //Draws horizontal lines
  for (int i = 0; i < 7; i++) {
    stroke(96, 64, 32);
    line(padding, i*gridSize + padding, width - padding, i*gridSize + padding);
  }

  rect(gridSize*6 + padding, gridSize*2 + padding, gridSize, gridSize);
}

//Draws the puzzle pieces using the puzzleDraw array
void drawPuzzle() {
  stroke(96, 64, 32);
  strokeWeight(2);

  //Draws every block in the array
  for (int i = 0; i < puzzleSolve.size(); i++) {
    float x1;
    float y1;

    //If the block is in the middle of moving, it is offset by how far into the movement it's in
    if (i == moving) {
      x1 = puzzleDraw.get(i).gridX*gridSize + padding + xOffset;
      y1 = puzzleDraw.get(i).gridY*gridSize + padding + yOffset;
    }
    
    else {
      x1 = puzzleDraw.get(i).gridX*gridSize + padding;
      y1 = puzzleDraw.get(i).gridY*gridSize + padding;
    }

    //Draws a different rectangle depending on the blockType
    if (puzzleSolve.get(i).blockType == 0) {
      fill(255, 0, 0); //Starting block
      rect(x1, y1, gridSize*2, gridSize, 20);
    } 
    
    else if (puzzleSolve.get(i).blockType == 1) {
      fill(106, 224, 113); //Green
      rect(x1, y1, gridSize*2, gridSize, 20);
    } 
    
    else if (puzzleSolve.get(i).blockType == 2) {
      fill(227, 76, 81); //Red
      rect(x1, y1, gridSize*3, gridSize, 20);
    } 
    
    else if (puzzleSolve.get(i).blockType == 3) {
      fill(250, 220, 109); //Yellow
      rect(x1, y1, gridSize, gridSize*2, 20);
    } 
    
    else {
      fill(69, 160, 190); //Blue
      rect(x1, y1, gridSize, gridSize*3, 20);
    }
  }
}

//Uses moveList to update puzzleDraw over time, with a smooth animation
void animateSolve() {
  
  //If fast is true (set in dumbAlgorithm), the solution appears 25 times faster
  if (fast == true)
    delay = 1;
    
  else
    delay = 5;
  
  //For every move made
  for (int i = 1; i < moveList.size(); i++) {
    //Define simple variables
    int index = moveList.get(i).index;
    int direction = moveList.get(i).direction;
    int distance = moveList.get(i).distance;
    
    //For the final move, the block is moved outside the grid
    if (i == moveList.size() - 1) {
      distance += 3;
    }
    
    //Keeps track of the currently moving block
    moving = index;
    
    //Checks the blockType to know which direction to animate the movement
    if (puzzleSolve.get(index).blockType <= 2) {  
      //For either every pixel in a single grid, or every fifth, offset the location the block is drawn at
      for (int j = 0; j < delay*gridSize/5; j++) {
        if (direction == 1)
          xOffset += 5*distance/delay;
        else
          xOffset -= 5*distance/delay;
        delay(delay);
      }
      
      if (direction == 1)
        puzzleDraw.get(index).gridX += distance;
      else
        puzzleDraw.get(index).gridX -= distance;
     
      //Resets offset afterwards
      xOffset = 0;
    }
  
    else {
      //For either every pixel in a single grid, or every fifth, offset the location the block is drawn at
      for (int j = 0; j < delay*gridSize/5; j++) {
        if (direction == 1)
          yOffset += 5*distance/delay;
        else
          yOffset -= 5*distance/delay;
        delay(delay);
      }
      
      if (direction == 1)
        puzzleDraw.get(index).gridY += distance;
      else
        puzzleDraw.get(index).gridY -= distance;
      
      //Resets offset afterwards
      yOffset = 0;
    }
  }
}



//ALGORITHM
void solvePuzzle() {
  //Ensures all values are correct before attempting to solve
  resetPuzzle();
  
  //Attempts to solve it with the smart algorithm
  pickNextMove(0, 1, -1, 1);
  
  if (puzzleSolve.get(0).gridX != 4) {
    //If the smart algorithm didn't solve the puzzle, it resets and the random move algorithm attempts to solve it 
    resetPuzzle();
    dumbAlgorithm();
    
    //If the dumb algorithm solves the puzzle, make the notification slightly different and hasten the animation
    if (puzzleSolve.get(0).gridX == 4) {
      note.setText("Solved, in a dumb way. (" + moveList.size() + " moves)");
      fast = true;
    }
    
    //If both algorithms failed, concede defeat
    else
      note.setText("Puzzle could not be solved. Try Again.");
  }

  //If any solution was found, animate it
  if (puzzleSolve.get(0).gridX == 4)
    animateSolve();
}

//Recursive solving function, semi-functional
void pickNextMove(int index, int direction, int previous, int prevDirection) {
  
  //If it's been under 100 moves and the puzzle hasn't yet been solved
  if (puzzleSolve.get(0).gridX != 4 && numRecur <= 200) {
    //Find the index of the block in the way
    int inWay = checkMove(index, direction);
    
    //Increase the recursion count
    numRecur++;
    
    //If the previous block is now unblocked, start the chain from the beginning again
    if (checkMove(previous, prevDirection) == -1) {
      pickNextMove(0, 1, -1, 1);
    }
    
    //If the intended move is unblocked, move block in the proper direction
    else if (inWay == -1) {
      moveBlock(index, direction);
      //Attempt to move the same block again
      pickNextMove(index, direction, previous, prevDirection);
    }
    
    //If the path is blocked
    else if (inWay >= 0) {
      //Try to find a move for the block that is in the way
      prevDirection = direction;
      //Chooses the smarter direction
      direction = findDirection(index, inWay, direction);
      pickNextMove(inWay, direction, index, prevDirection);
    }
    
    //If there is a wall in the way
    else if (inWay == -2){
      //Attempt move in opposite direction
      direction *= -1;
      pickNextMove(index, direction, previous, prevDirection);
    }
  }
  
  //If the puzzle is solved
  else if (puzzleSolve.get(0).gridX == 4) {
    //Change notice to specify number of moves, then exit function
    note.setText("Puzzle solved in " + (moveList.size() - 1) + " moves.");
  }
  
  //If there were over 100 moves and the puzzle is still unsolved
  else {
    resetPuzzle();
    
    //Tries puzzle 20 times before giving up
    if (attempts <= 20) {
      attempts++;
      pickNextMove(0, 1, -1, 1);
    }
  }
}

//Attempts to move random blocks until a solution is found
void dumbAlgorithm() {
  int index;
  int direction;
  numRecur = 0;
  
  //While there is under 1000 moves made
  while (puzzleSolve.get(0).gridX <= 3 && numRecur <= 1000) {
    //Picks a random block
    index = int(random(0,puzzleSolve.size()));
    
    //Picks a random direction
    if (int(random(0,2)) == 1)
      direction = -1;
      
    else
      direction = 1;
    
    //If the move is unblocked, move in that direction
    if (checkMove(index, direction) == -1) {
      moveBlock(index, direction);
      numRecur++;
    }
  }
}

//Determines which direction that a block should move
int findDirection(int index, int inWay, int direction) {
  int blockTypeA = puzzleSolve.get(index).blockType;
  int blockTypeB = puzzleSolve.get(inWay).blockType;
  
  //If the block is horizontal
  if (blockTypeA <= 2) {
    int line = puzzleSolve.get(index).gridY;
    
    //If the block in the way faces the same direction
    if (blockTypeB <= 2) {
      //Move in the same direction
      return direction;
    }
    
    else if (blockTypeB == 3) {
      //If the wall blocks one way, move the other way
      if (line + 2 >= 6) {
        return -1;
      }
      
      else if (line - 2 <= -1){
        return 1;
      }
      
      //If neither direction is blocked by a wall
      else {
        int random = int(random(0,2));
        if (random == 0)
          return direction;
        else
          return -direction;
        //This and one other feature are the hardest parts of the algorithm to code
        //I cannot think of any way to determine a method of moving the block the correct way
        //So I made it random and let it attempt to solve the puzzle 20 times
      }
    }
    
    //If the block in the way faces the other direction
    else {
      //If the wall blocks one way, move the other way
      if (line + 3 >= 6) {
        return -1;
      }
      
      else if (line - 3 <= -1){
        return 1;
      }
      
      //If neither direction is blocked by a wall
      else {
        int random = int(random(0,2));
        if (random == 0)
          return direction;
        else
          return -direction;
        //This and one other feature are the hardest parts of the algorithm to code
        //I cannot think of any way to determine a method of moving the block the correct way
        //So I made it random and let it attempt to solve the puzzle 20 times
      }
    }
  }
  
  //If the block is vertical
  else {
    int line = puzzleSolve.get(index).gridX;
    
    //If the block in the way faces the same direction
    if (blockTypeB >= 3) {
      //Move in the same direction
      return direction;
    }
    
    //If the block in the way faces the other direction
    else if (blockTypeB <= 1) {
      //If the wall blocks one way, move the other way
      if (line + 2 >= 6) {
        return -1;
      }
      
      else if (line - 2 <= -1){
        return 1;
      }
      
      //If neither direction is blocked by a wall
      else {
        int random = int(random(0,2));
        if (random == 0)
          return direction;
        else
          return -direction;
        //This and one other feature are the hardest parts of the algorithm to code
        //I cannot think of any way to determine a method of moving the block the correct way
        //So I made it random and let it attempt to solve the puzzle 20 times
      }
    }
    
    else {
      //If the wall blocks one way, move the other way
      if (line + 3 >= 6) {
        return -1;
      }
      
      else if (line - 3 <= -1){
        return 1;
      }
      
      //If neither direction is blocked by a wall
      else {
        int random = int(random(0,2));
        if (random == 0)
          return direction;
        else
          return -direction;
        //This and one other feature are the hardest parts of the algorithm to code
        //I cannot think of any way to determine a method of moving the block the correct way
        //So I made it random and let it attempt to solve the puzzle 20 times
      }
    }
  }
}

//Checks if a move is blocked by another block
//If it is, it returns the index of the block
//If the move is unblocked, it will return -1 rather than a block index
//If the move is blocked by a wall, it will return -2 rather than a block index
int checkMove(int index, int direction) {
  int line;
  int lineI;
  int blockType;
  
  //To catch if the block doesn't exist, can happen with the previous block portion of pickNextMove
  if (index == -1)
      return -2;
  
  //Checks against every single block
  for (int i = 0; i < puzzleSolve.size(); i++) {
    blockType = puzzleSolve.get(i).blockType;
    
    //Two long horizontal
    if (puzzleSolve.get(index).blockType <= 1) {
      line = puzzleSolve.get(index).gridY;
      lineI = puzzleSolve.get(i).gridY;
      
      //Various checks to see if a block is one ahead of the block
      if (direction == 1 && puzzleSolve.get(i).gridX == puzzleSolve.get(index).gridX + 2) {
        if(line == lineI + 2 && blockType == 4)
          return i;
        else if(line == lineI + 1 && blockType >= 3)
          return i;
        else if(line == lineI)
          return i;
      }
      
      //Various checks to see if a block is one behind the block
      else if (direction == -1 && puzzleSolve.get(i).gridX == puzzleSolve.get(index).gridX - 1) {
        if(line == lineI + 2 && blockType == 4)
          return i;
        else if(line == lineI + 1 && blockType >= 3)
          return i;
        else if(line == lineI)
          return i;
      }
      
      else if (direction == -1 && puzzleSolve.get(i).gridX == puzzleSolve.get(index).gridX - 2 && lineI == line) {
        if (blockType <= 1) {
          return i;
        }
      }
      
      else if (direction == -1 && puzzleSolve.get(i).gridX == puzzleSolve.get(index).gridX - 3 && lineI == line) {
        if (blockType == 2) {
          return i;
        }
      }
    }
    
    //Three long horizontal
    else if (puzzleSolve.get(index).blockType == 2) {
      line = puzzleSolve.get(index).gridY;
      lineI = puzzleSolve.get(i).gridY;
      
      //Various checks to see if a block is one ahead of the block
      if (direction == 1 && puzzleSolve.get(i).gridX == puzzleSolve.get(index).gridX + 3) {
        if(line == lineI + 2 && blockType == 4)
          return i;
        else if(line == lineI + 1 && blockType >= 3)
          return i;
        else if(line == lineI)
          return i;
      }
      
      //Various checks to see if a block is one behind the block
      else if (direction == -1 && puzzleSolve.get(i).gridX == puzzleSolve.get(index).gridX - 1) {
        if(line == lineI + 2 && blockType == 4)
          return i;
        else if(line == lineI + 1 && blockType >= 3)
          return i;
        else if(line == lineI)
          return i;
      }
      
      else if (direction == -1 && puzzleSolve.get(i).gridX == puzzleSolve.get(index).gridX - 2 && lineI == line) {
        if (blockType <= 1) {
          return i;
        }
      }
      
      else if (direction == -1 && puzzleSolve.get(i).gridX == puzzleSolve.get(index).gridX - 3 && lineI == line) {
        if (blockType == 2) {
          return i;
        }
      }
    }
    
    //Two long vertical
    else if (puzzleSolve.get(index).blockType == 3) {
      line = puzzleSolve.get(index).gridX;
      lineI = puzzleSolve.get(i).gridX;
      
      //Various checks to see if a block is one ahead of the block
      if (direction == 1 && puzzleSolve.get(i).gridY == puzzleSolve.get(index).gridY + 2) {
        if(line == lineI + 2 && blockType == 2)
          return i;
        else if(line == lineI + 1 && blockType <= 2)
          return i;
        else if(line == lineI)
          return i;
      }
      
      //Various checks to see if a block is one behind the block
      else if (direction == -1 && puzzleSolve.get(i).gridY == puzzleSolve.get(index).gridY - 1) {
        if(line == lineI + 2 && blockType == 2)
          return i;
        else if(line == lineI + 1 && blockType <= 2)
          return i;
        else if(line == lineI)
          return i;
      }
      
      else if (direction == -1 && puzzleSolve.get(i).gridY == puzzleSolve.get(index).gridY - 2 && lineI == line) {
        if (blockType == 3) {
          return i;
        }
      }
      
      else if (direction == -1 && puzzleSolve.get(i).gridY == puzzleSolve.get(index).gridY - 3 && lineI == line) {
        if (blockType == 4) {
          return i;
        }
      }
    }
    
    //Three long vertical
    else {
      line = puzzleSolve.get(index).gridX;
      lineI = puzzleSolve.get(i).gridX;
      
      //Various checks to see if a block is one ahead of the block
      if (direction == 1 && puzzleSolve.get(i).gridY == puzzleSolve.get(index).gridY + 3) {
        if(line == lineI + 2 && puzzleSolve.get(i).blockType == 2)
          return i;
        else if(line == lineI + 1 && puzzleSolve.get(i).blockType <= 2)
          return i;
        else if(line == lineI)
          return i;
      }
      
      //Various checks to see if a block is one behind the block
      else if (direction == -1 && puzzleSolve.get(i).gridY == puzzleSolve.get(index).gridY - 1) {
        if(line == lineI + 2 && puzzleSolve.get(i).blockType == 2)
          return i;
        else if(line == lineI + 1 && puzzleSolve.get(i).blockType <= 2)
          return i;
        else if(line == lineI)
          return i;
      }
      
      else if (direction == -1 && puzzleSolve.get(i).gridY == puzzleSolve.get(index).gridY - 2 && lineI == line) {
        if (puzzleSolve.get(i).blockType == 3) {
          return i;
        }
      }
      
      else if (direction == -1 && puzzleSolve.get(i).gridY == puzzleSolve.get(index).gridY - 3 && lineI == line) {
        if (puzzleSolve.get(i).blockType == 4) {
          return i;
        }
      }
    }
  }

  //If no block is blocking the move, checks if walls are blocking
  return checkSides(index, direction);
}

//Checks if walls are in wall of move, if they are, returns -2, otherwise returns -1
int checkSides(int index, int direction) {
  int blockType = puzzleSolve.get(index).blockType;
  
  //If block is moving forward
  if (direction == 1) {
    if (blockType <= 1 && puzzleSolve.get(index).gridX == 4)
      return -2;

    else if (blockType == 2 && puzzleSolve.get(index).gridX >= 3)
      return -2;

    else if (blockType == 3 && puzzleSolve.get(index).gridY == 4)
      return -2;


    else if (blockType == 4 && puzzleSolve.get(index).gridY >= 3)
      return -2;
  } 
  
  //If block is moving backward
  else {
    if (blockType <= 2 && puzzleSolve.get(index).gridX == 0)
      return -2;

    else if (blockType >= 3 && puzzleSolve.get(index).gridY == 0) {
      return -2;
    }
  }
  
  //Return -1, meaning the move is free
  return -1;
}

//Changes the x or y position of a chosen block on the grid
void moveBlock(int index, int direction) {
  //If the block is horizontal, change the x-position
  if (puzzleSolve.get(index).blockType <= 2) {
    puzzleSolve.get(index).gridX += direction;
  }
  
  //If the block is vertical, change the y-position
  else {
    puzzleSolve.get(index).gridY += direction;
  }

  //Adds the specific move to the moveList array
  addMove(index, direction);
}

//Adds a move to the moveList array
void addMove(int index, int direction) {
  int L = moveList.size();
  
  //First item in array, serves as a "blank" to avoid errors later
  if (index == -1) {
    moveList.add(new Move(index, direction));
  }
  
  //If the move is the exact same as the previous move, increase the distance of the previous move
  else if (index == moveList.get(L - 1).index && direction == moveList.get(L - 1).direction) {
    moveList.get(L - 1).distance++;
  }
  
  //If the move is "new", add it to the array
  else {
    moveList.add(new Move(index, direction));
  }
}

//Adds new block to puzzleSolve and puzzleDraw
void addBlock(int x, int y) {
  boolean collision = false;
  
  //Checks if there's a collision with any previous block
  for (int i = 0; i < puzzleSolve.size(); i++) {
    int checkBlock = puzzleSolve.get(i).blockType;
    int oldX = puzzleSolve.get(i).gridX;
    int oldY = puzzleSolve.get(i).gridY;
    
    //Various checks depending on the two blocks that determine whether they overlap
    if (newBlock == 1) {
      if (checkBlock <= 1 && x - 1 <= oldX && oldX <= x + 1 && oldY == y)
        //If there is overlap, sets collision to true
        collision = true;
      else if (checkBlock == 2 && x - 2 <= oldX && oldX <= x + 1 && oldY == y)
        collision = true;
      
      else if (checkBlock >= 3) {
        for (int j = x; j < x + 2; j++) {
          if (checkBlock == 3 && oldX == j && y - 1 <= oldY && oldY <= y)
            collision = true;
          else if (checkBlock == 4 && oldX == j && y - 2 <= oldY && oldY <= y)
            collision = true;
        }
      }
      
      if (x >= 5 || x <= -1 || y >= 6 || y <= -1)
        collision = true;
    }
    
    if (newBlock == 2) {
      if (checkBlock <= 1 && x - 1 <= oldX && oldX <= x + 1 && oldY == y)
        collision = true;
      else if (checkBlock == 2 && x - 2 <= oldX && oldX <= x + 2 && oldY == y)
        collision = true;
      
      else if (checkBlock >= 3) {
        for (int j = x; j < x + 3; j++) {
          if (checkBlock == 3 && oldX == j && y - 1 <= oldY && oldY <= y)
            collision = true;
          else if (checkBlock == 4 && oldX == j && y - 2 <= oldY && oldY <= y)
            collision = true;
        }
      }
      
      if (x >= 4 || x <= -1 || y >= 6 || y <= -1)
        collision = true;
    }
    
    if (newBlock == 3) {
      if (checkBlock == 3 && y - 1 <= oldY && oldY <= y + 1 && oldX == x)
        collision = true;
      else if (checkBlock == 4 && y - 2 <= oldY && oldY <= y + 1 && oldX == x)
        collision = true;
      
      else if (checkBlock <= 2) {
        for (int j = y; j < y + 2; j++) {
          if (checkBlock <= 1 && oldY == j && x - 1 <= oldX && oldX <= x)
            collision = true;
          else if (checkBlock == 2 && oldY == j && x - 2 <= oldX && oldX <= x)
            collision = true;
        }
      }
      
      if (y >= 5 || y <= -1 || x >= 6 || x <= -1)
        collision = true;
    }
    
    if (newBlock == 4) {
      if (checkBlock == 3 && y - 1 <= oldY && oldY <= y + 1 && oldX == x)
        collision = true;
      else if (checkBlock == 4 && y - 2 <= oldY && oldY <= y + 2 && oldX == x)
        collision = true;
      
      else if (checkBlock <= 2) {
        for (int j = y; j < y + 3; j++) {
          if (checkBlock <= 1 && oldY == j && x - 1 <= oldX && oldX <= x)
            collision = true;
          else if (checkBlock == 2 && oldY == j && x - 2 <= oldX && oldX <= x)
            collision = true;
        }
      }
      
      if (y >= 4 || y <= -1 || x >= 6 || x <= -1)
        collision = true;
    }
  }
  
  //If collision has not been set to true, allow the block to be placed
  if (!collision) {
    puzzleSolve.add(new Block(x, y, newBlock));
    puzzleDraw.add(new Block(x, y, newBlock));
  }
  
  //Otherwise, notify user
  else {
    note.setText("Placement interference, block cannot be placed.");
  }
}

//When you click the mouse, assigns grid position to current x and y position
void mouseClicked() {
  int xBlock = (mouseX - padding) / gridSize;
  int yBlock = (mouseY - padding) / gridSize;
  
  if (newBlock != 0) {
    addBlock(xBlock, yBlock);
  }
}

//Deletes the last item in the puzzleSolve and puzzleDraw array, provided it's not the red block
void removeLastBlock() {
  if (puzzleSolve.size() > 1 && moveList.size() == 0) {
    puzzleSolve.remove(puzzleSolve.size() - 1);
    puzzleDraw.remove(puzzleDraw.size() - 1);
  }
}

//Replaces puzzleSolve with puzzleDraw, which hasn't changed, and resets important variables
void resetPuzzle() {
  fast = false;
  numRecur = 0;
  attempts++;
  puzzleSolve = new ArrayList<Block>();
  moveList = new ArrayList<Move>();
  addMove(-1,1);
  for (int i = 0; i < puzzleDraw.size(); i++) {
    puzzleSolve.add(new Block(puzzleDraw.get(i).gridX,puzzleDraw.get(i).gridY,puzzleDraw.get(i).blockType));
  }
}

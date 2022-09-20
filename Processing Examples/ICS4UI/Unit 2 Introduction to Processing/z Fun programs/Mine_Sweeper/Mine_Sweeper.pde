//Yash Sheth 
//Minesweeper - Cellular Automata Assignment
//Last Modified: 10/22/2021


// Game width/height
int gameWidth = 30;
int gameHeight = 28;

int[][] gameBoard = new int[gameWidth][gameHeight];

float[][] percentageBoard = new float[gameWidth][gameHeight];

//percentage array that determines the chance of a cell being a mine
//0.05 is easy, 0.1 is medium, and anything above 0.2 is hard. 
float percentageMine = 0.1;

//tracks the number of mines
int totalMines;

//Safety measure; You will not die on your first play if you hit a mine
boolean firstPlay;

//will become true when you win the game
boolean gameWin;

//tracks the cell from which you lose to
int xBoard, yBoard;

void setup()
{
  size(600, 600);
  ellipseMode(CENTER);
  rectMode(CORNER);
  textSize(14);
  firstPlay = true;
  totalMines = 0;
  xBoard = -1;
  yBoard = -1;
  gameWin = false;


  //creates the board randomly with mines
  for (int i = 0; i < gameWidth; i++)
  {
    for (int j = 0; j < gameHeight; j++)
    {
      if (random(0, 1) < percentageMine)
      {
        gameBoard[i][j] = 9;
        totalMines++;
      } else
      {
        gameBoard[i][j] = -1;
      }
    }
  }
}

void draw()
{
  background(224, 155, 76);

  //displays how many tiles are left
  fill(0);
  text("Remaining Mines: "+totalMines, 20, 25);

  stroke(0);
  for (int i = 0; i < gameWidth; i++)
  {
    //if not a mine, a number will be drawn with its corresponding colour
    for (int j = 0; j < gameHeight; j++)
    {
      if (gameBoard[i][j] >= 0 && gameBoard[i][j] <= 8)
      {
        //background colour of the square
        fill(0, 190, 152);
        rect(i*20, 40+(j*20), 20, 20);

        // a colour is determined based on the colour
        switch (gameBoard[i][j])
        {
        case 0: 
          fill(250); 
          break;
        case 1: 
          fill(0, 0, 190); 
          break;
        case 2: 
          fill(0, 190, 190); 
          break;
        case 3: 
          fill(190, 0, 0); 
          break;
        case 4: 
          fill(190, 0, 190); 
          break;
        case 5: 
          fill(190, 190, 0); 
          break;
        case 6: 
          fill(0, 190, 0); 
          break;
        case 7: 
          fill(150, 110, 90); 
          break;
        case 8: 
          fill(138, 148, 33); 
          break;
        default: 
          fill(138, 148, 33); 
          break;
        }

        //This enables the code to not display a number if there's 0 mines beside the cell clicked. It leaves it blank
        if (gameBoard[i][j] != 0)
        {
          text(gameBoard[i][j], 6+(i*20), 55+(j*20));

          //The code below will automatically play obvious moves so the user doesn't have to play obvious moves. 
          if (countNearbyFlags(i, j) == gameBoard[i][j])
          {
            openNearbySafeSpaces(i, j);
          }
        }
        // This creates the flags in circles
      } else if (gameBoard[i][j] == 10 || gameBoard[i][j] == 11)
      {
        fill(190, 0, 0);
        ellipse(10+(i*20), 50+(j*20), 20, 20);

        //the spaces which haven't been clicked yet turn dark
      } else
      {
        fill(101, 96, 230);
        rect(i*20, 40+(j*20), 20, 20);
      }
    }
  }

  //if the user has clicked on a mine
  if (xBoard != -1)
  {
    //will show the remaining mines
    for (int i = 0; i < gameWidth; i++)
    {
      for (int j = 0; j < gameHeight; j++)
      {
        if (gameBoard[i][j] == 9)
        {
          fill(190, 0, 0);
          ellipse(10+(i*20), 50+(j*20), 20, 20);
        }
      }
    }

    //Try again prompt at the top of the screen
    fill(0);
    text("Press Enter to try again!", 275, 25);
    ellipse(10+(xBoard*20), 50+(xBoard*20), 20, 20);
  }

  //test to see if you've won yet
  if (totalMines == 0)
  {

    //will check if you have any false flags
    int falseFlags = 0;
    for (int i = 0; i < gameWidth; i++)
    {
      for (int j = 0; j < gameHeight; j++)
      {
        if (gameBoard[i][j] == 11)
        {
          falseFlags++;
        }
      }
    }

    //if no false flags, you will win
    if (falseFlags == 0)
    {
      fill(190, 0, 190);
      text("YOU WIN! Press Enter to play again!", 200, 25);
      gameWin = true;
    }
  }
}

//button controls
//enter will restart the game only when you've won or lost the game
void keyPressed()
{
  if (keyCode == ENTER && (xBoard != -1 || gameWin))
  {
    setup();
  }
}

void mousePressed()
{
  //prevents mouse input if the game is won or lost
  if (xBoard == -1 && !gameWin)
  {

    int mX = floor(mouseX / 20);
    int mY = floor((mouseY-40) / 20);

    //this prevents the user from hitting a mine on first move
    if (firstPlay && mouseButton == LEFT)
    {
      createSafeZone(mX, mY);
      openSpace(mX, mY);
      firstPlay = false;
    }
    //after you've made your first move, you can now lose the game
    else if (mouseButton == LEFT)
    {
      if (gameBoard[mX][mY] == 9 || gameBoard[mX][mY] == 10)
      {
        gameLoss(mX, mY);
      } else
      {
        openSpace(mX, mY);
      }
    } 
    //when you want to flag a cell
    else if (!firstPlay && mouseButton == RIGHT)
    {
      if (gameBoard[mX][mY] == 9)
      {
        gameBoard[mX][mY] = 10;
        totalMines--;
      } 
      //if you flag a cell that is not a mine, it makes it incorrect
      else if (gameBoard[mX][mY] == -1)
      {
        gameBoard[mX][mY] = 11;
        totalMines--;
      } 
      //if you unflag a correctly flagged cell
      else if (gameBoard[mX][mY] == 10)
      {
        gameBoard[mX][mY] = 9;
        totalMines++;
      } 

      //if you unflag an incorrectly flagged cell
      else if (gameBoard[mX][mY] == 11)
      {
        gameBoard[mX][mY] = -1;
        totalMines++;
      }
    }
  }
}

//function that creates a safe zone for first move
void createSafeZone(int x, int y)
{
  // this section prevents the formula below from using inputs outside of bounds
  for (int i = 0; i < 3; i++)
  {
    for (int j = 0; j < 3; j++)
    {

      if ((x+i-1) < 0 || (y+j-1) < 0 || (x+i-1) >= 30 || (y+j-1) >= 16)
      {
        continue;
      } else
      {
        //updates the number of mines
        if (gameBoard[x+i-1][y+j-1] == 9)
        {
          totalMines--;
        }
        //sets the cleared space to space that's ready to be opened
        gameBoard[x+i-1][y+j-1] = -1;
      }
    }
  }
}

//function that checks if there is anything to be filled in the cell
void openSpace(int x, int y)
{
  if (gameBoard[x][y] == 9)
  {
    gameLoss(x, y);
  }
  //if didn't lose above, fills how many cells have mines surrounding the cell clicked
  gameBoard[x][y] = countNearbyMines(x, y);
  //checks all surrounding cells to fill it in automatically
  if (countNearbyMines(x, y) == 0)
  {
    for (int i = 0; i < 3; i++)
    {
      for (int j = 0; j < 3; j++)
      {
        if ((x+i-1) < 0 || (y+j-1) < 0 || (x+i-1) >= 30 || (y+j-1) >= 16)
        {
          continue;
        } else if (gameBoard[x+i-1][y+j-1] == -1 && countNearbyMines(x+i-1, y+j-1) == 0)
        {
          gameBoard[x+i-1][y+j-1] = countNearbyMines(x+i-1, y+j-1);
          openSpace(x+i-1, y+j-1);
        }
        {
          gameBoard[x+i-1][y+j-1] = countNearbyMines(x+i-1, y+j-1);
        }
      }
    }
  }
}

//function returns the number of mines nearby the cell
int countNearbyMines(int x, int y)
{
  int mineCount = 0;
  for (int i = 0; i < 3; i++)
  {
    for (int j = 0; j < 3; j++)
    {
      if ((x+i-1) < 0 || (y+j-1) < 0 || (x+i-1) >= 30 || (y+j-1) >= 16)
      {
        continue;
      } else
      {
        if (gameBoard[x+i-1][y+j-1] == 9 || gameBoard[x+i-1][y+j-1] == 10)
        {
          mineCount++;
        }
      }
    }
  }
  return mineCount;
}

//function counts and returns the number of nearby flags to a cell
int countNearbyFlags(int x, int y)
{
  int flagCount = 0;
  for (int i = 0; i < 3; i++)
  {
    for (int j = 0; j < 3; j++)
    {
      if ((x+i-1) < 0 || (y+j-1) < 0 || (x+i-1) >= 30 || (y+j-1) >= 16)
      {
        continue;
      } else
      {
        if (gameBoard[x+i-1][y+j-1] == 10 || gameBoard[x+i-1][y+j-1] == 11)
        {
          flagCount++;
        }
      }
    }
  }
  return flagCount;
}

//function that game runs to automatically fill redudant moves
void openNearbySafeSpaces(int x, int y)
{
  for (int i = 0; i < 3; i++)
  {
    for (int j = 0; j < 3; j++)
    {
      if ((x+i-1) < 0 || (y+j-1) < 0 || (x+i-1) >= 30 || (y+j-1) >= 16)
      {
        continue;
      } else
      {
        //if the automatic move is successful
        if (gameBoard[x+i-1][y+j-1] == -1)
        {
          openSpace(x+i-1, y+j-1);
        } 
        //if the automatic move went above a flag resulting in a loss
        else if (gameBoard[x+i-1][y+j-1] == 9)
        {
          gameLoss(x+i-1, y+j-1);
        }
      }
    }
  }
}

//function that stores the x and y coordinates of the cell that caused the user to lose
void gameLoss(int x, int y)
{
  xBoard = x;
  yBoard = y;
}

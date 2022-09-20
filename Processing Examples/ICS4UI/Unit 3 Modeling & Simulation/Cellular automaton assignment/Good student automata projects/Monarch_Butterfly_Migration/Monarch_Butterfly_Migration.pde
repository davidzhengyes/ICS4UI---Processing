//By: Rafay Ahmed

///GLOBAL VARIABLES///

//THESE VARIABLES CAN BE MODIFIED//
int n = 100;   //Grid Size (n*n)
int padding = 50; //Distance each side is from the edges of the screen
float framesPerSec = 100; //FrameRate of Animation

float maxTemp = 30.0; //The maximum temperature a Temperature Cell can be
float minTemp = -25.0; //The minimun temperature a Temperature Cell can be
float safeTemp = 15.0; //Any Temperture Cell above or equal to this value is safe for the butterflies to lay their eggs in
float dangerousTemp = -20.0; //Any Temperature Cell below or equal to this value has a chance to kill a butterfly 
float initalSpawnTemp = -10.0; //The first generation of butterflies will spawn on Temperature Cells below or equal to this value

int maxAge = 100; //The max number of generations a butterfly can live, starts once they form into an egg
int maxNumNeighbours = 5; //The max number of neigbours a butterfly cell can have, if they have more than this value, they might die (max = 8, min = 0)
int chanceDeath = 80; //If a butterflies meets the criteria that says it might die, than there is an chanceDeath % chance it will die in that generation

int butterfliesNeededToLayEgg = 2; //The exact number of butterflies need for them to lay an egg (realistically it would only be 2)
int eggLayingRadius = 1; //The radius in which an empty cell will look for other butterflies and decide wether it should lay an egg or not (1 = 1 cell width) WARNING: Increasing this value can have cool effects but will also slow the program down
//The max this should be is 5
int maxEggNeighbours = 1; //The max number of eggs that can be around another egg cell (Increasing this value and the above value, can lead to cluster egg laying) 
int genToHatchEgg = 5; //After how many generations will an egg hatch
int genToGrowUp = genToHatchEgg + 10; //How many generations after an egg hatches, will it grow into an adult (only change the contstant) 

int initalSpawnRateChance = 50; //What percent chance will a given cell become a butterfly cell at the start

int climateChangeRate = 200; //After how how many generations will the climate will change (if you're going to increase the frameRate, you might also want to increase this value and vice-versa)
int climateChangeSpeed = 5; //How fast the climate will change once the process begins (1 - slow, 5 - normal >=10 - fast)

//THESE VARIABLES CAN'T BE MODIFIED//
int frame = 0, redI, redJ, blueI, blueJ; // Frame counter and the i and j indices of the hottest and coldest temperature cells (will be assigned later) 
float cellSize; //Cell size, determined later once screen dimesnsion have been chosen
color[][] tempCellsNow = new color[n][n], tempCellsNext = new color[n][n]; //Color arrays of current and future temperature cells, can be any value between red and blue
float[][] tempNow = new float[n][n], tempNext = new float[n][n]; //Float arrays of the current and future temperature cells, can be any vale between maximum and minimum temo
color[][] butterflyNow = new color[n][n], butterflyNext = new color[n][n]; //Color arrays of the current and future butterfly cells, since they behave so differently from temperaute cells, they are in a different array
int[][] butterflyAge = new int[n][n]; //The age of the current butterfly cell;
String orientation; //Stores the orientation of the gradient (whether it changes from left to right/up to down)
boolean changeTemp = false; //Decides wether it's time for climate change to begin
color red = color(255, 0, 0), blue = color(0, 0, 255), white = color(255, 255, 255), yellow = color(255, 255, 0), green = color(0, 255, 0); //Red == warm cells, blue == cool cells, white == larvae, yellow == butterflies, green == eggs

//Setup 
void setup() {
  size(800, 800);
  background(0);
  frameRate(framesPerSec);
  noStroke();
  cellSize = (width-2*padding)/n;

  getTempCells(); //Gets initial temperature cells and temperature values
  getFirstGenButterflies(); //Gets initial butterflies cells based off of where the temperature cells are and other factors
}

//Draws the butterflies and temperature cells on screen
void draw() {
  float x, y; // x and y values of the current cell, based on values of padding, cellSize and current index
  updateTempCells(); // Always updates the temperature cells first in case there have been any changes

  //For every single cell in the (n*n) size grid
  for (int i = 0; i < n; i++) { 
    x = padding + i*cellSize; 
    for (int j = 0; j < n; j++) {
      y = padding + j*cellSize;
      fill(tempCellsNow[i][j]);
      square(x, y, cellSize); //First we draw the temperature cells

      if (butterflyNow[i][j] != 0) {
        fill(butterflyNow[i][j]); //If the butterfly cell isn't black fill it with it's value
        butterflyAge[i][j]++; //Increase the age of the butterfly
      } else { //If the butterfly cell is 0, meaning nothing is there, do not fill
        noFill();
      }

      square(x, y, cellSize); // Then we draw the butterfly cells over the temperature cells to make it look like they are in the same array
    }
  }
  if ((frame % climateChangeRate == 0) && (frame != 0) && (changeTemp == false)) { //Checks wether it is time for climate change to begin
    changeTemp = true;
    getTempCells(); //Gets new values for the temperatuere cells
  }
  getNextGenButterflies(); //Gets the new values for butterflies cells
  updateButterflies(); //Replaces cellsNow with cellNext
  frame++; //Frame counter
}

//Gets the intial generation of butterflies
void getFirstGenButterflies() {

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      int randomNum = int(random(0, 100)); //Spawn Chance 
      int randomAge = int(random(0, 15)); //Random Age

      if ((tempNext[i][j]  <= initalSpawnTemp || tempNow[i][j] <= initalSpawnTemp) && randomNum <= initalSpawnRateChance) { //If the cell is within the assinged area the spawn chance is good, a butterfly will be created there
        butterflyNow[i][j] = yellow;
        butterflyAge[i][j] = randomAge; //Give a random age to the given butterfly so they don't die all at once later
      } else {
        butterflyNow[i][j] = 0; // If the criteria aren't met, it's an empty cell
      }
    }
  }
}

//Gets the values of all future generations of butterflies
void getNextGenButterflies() {
  //For every single cell check:
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) { 

      //If it is a butterfly cell
      if (butterflyNow[i][j] == yellow) {
        boolean cellAlive = checkButterflyCells(i, j, "ifAlive");
        //If it is a butterfly, check if it should be alive or not
        if (cellAlive) {
          int numWarmCells = getSurroundingInfo(i, j, "warmCells");
          //If it is alive, check if it is in a warm area
          if (numWarmCells < 8) {
            //If it isn't in a warm area, start moving to a the warm cells
            int warmCellI = moveToWarmestCellIndex(i, j, "i"); //Gets the i and j indices of the neighbouring warmest cell
            int warmCellJ = moveToWarmestCellIndex(i, j, "j");
            try {
              butterflyNext[warmCellI][warmCellJ] = yellow; //Butterfly moves the warmest neighbouring cell
              butterflyAge[warmCellI][warmCellJ] = butterflyAge[i][j]; //Update the age of that cell to match with the butterfly
              if (i != warmCellI || j != warmCellJ) { 
                butterflyNext[i][j] = 0; //Empty out the cell where the butterfly once was, as long as it has actually moved to a different cell
                butterflyAge[i][j] = 0;
              }
            } 
            catch (IndexOutOfBoundsException e) { //If there is an error, just stay in current cell
              butterflyNext[i][j] = yellow;
            }
          } else { //If the butterfly is already in a warm area, move around randomly
            int moveCellI = moveToRandomCellIndex(i, j, "i"); //Find the i and j indices of random nearby cells that are not occupied
            int moveCellJ = moveToRandomCellIndex(i, j, "j");
            try {
              butterflyNext[moveCellI][moveCellJ] = yellow; //Butterfly moves to assingned cell
              butterflyAge[moveCellI][moveCellJ] = butterflyAge[i][j]; //Update age to match with the butterfly
              if (i != moveCellI || j != moveCellJ) {
                butterflyNext[i][j] = 0; //Empty out the cell where the butterfly once was as long it has actually moved
                butterflyAge[i][j] = 0;
              }
            } 
            catch (IndexOutOfBoundsException e) { //If error, stay where you were
              butterflyNext[i][j] = yellow;
            }
          }
        } else { //If the butterfly should not be alive, then kill
          butterflyNext[i][j] = 0;
        }
        //If the current cell is an egg cell
      } else if (butterflyNow[i][j] == green) { 
        boolean hatchEgg = checkButterflyCells(i, j, "ifHatchEgg"); //Checks whether it should hatch

        if (hatchEgg) { //If it should hatch then turn that cell into a larva
          butterflyNext[i][j] = white;
        } else { //If it shouldn't hatch then stay as an egg
          butterflyNext[i][j] = green;
        }
        //If the current cell is a larva cell
      } else if (butterflyNow[i][j] == white) { 
        boolean growUp = checkButterflyCells(i, j, "ifGrowUp"); //Checks whether it should grow up into a butterfly yet
        if (growUp) { //If it should then turn into a butterfly 
          if (butterflyNext[i][j] != yellow) {
            butterflyNext[i][j] = yellow;
          }
        } else { //If it shouldn't then check whether it should be alive, if it should them move around randomly, even if you aren't in a warm area
          boolean cellAlive = checkButterflyCells(i, j, "ifAlive");
          if (cellAlive) { //
            int moveCellI = moveToRandomCellIndex(i, j, "i");
            int moveCellJ = moveToRandomCellIndex(i, j, "j");
            try {
              butterflyNext[moveCellI][moveCellJ] = white; //Updates position and age of larva cell
              butterflyAge[moveCellI][moveCellJ] = butterflyAge[i][j];
              if (i != moveCellI || j != moveCellJ) {
                butterflyNext[i][j] = 0; //Empties out the cell where the larva once was as long it has moved
                butterflyAge[i][j] = 0;
              }
            } 
            catch (IndexOutOfBoundsException e) { //If error stay where you were
              butterflyNext[i][j] = white;
            }
          } else { //If it shouldn't be alive then kill it
            butterflyNext[i][j] = 0;
          }
        }
        //If current cell is empty cell
      } else if (butterflyNow[i][j] == 0) { 
        if (tempNow[i][j] >= safeTemp) { //If the temperature of the current cell is safe
          boolean layEgg = checkButterflyCells(i, j, "ifLayEgg"); //Then check whether a butterfly should lay an egg on the cell

          if (layEgg) { //If it should lay an egg
            if (butterflyNext[i][j] != yellow && butterflyNext[i][j] != white) { //The dead cell becomes an egg cell
              butterflyNext[i][j] = green;
              butterflyAge[i][j] = 0;
            }
          } else { //If it shouldn't lay an egg
            if (butterflyNext[i][j] != yellow && butterflyNext[i][j] != white) //Stay as a dead cell
              butterflyNext[i][j] = 0;
          }
        }
      }
    }
  }
}

//Simply replaces each index of butterflyCellsNow with butteflyCellsNext
void updateButterflies() {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) { 
      butterflyNow[i][j] = butterflyNext[i][j];
    }
  }
}

//Gets the i or j index of the neighbouring warmest cell 
int moveToWarmestCellIndex(int i, int j, String Index) {
  int[] warmestCellI = new int[0];
  int[] warmestCellJ = new int[0];
  float[] temp = new float[0];
  for (int a = -1; a <= 1; a++) {
    for (int b = -1; b <= 1; b++) { //Looks around a choosen cell
      if (!(a == 0 && b == 0)) {
        try {
          temp = append(temp, tempNow[i+a][j+b]); //First we get the neighbouring temperatures cells, in addition to their i and j indices and put them each into respective 1D Arrays
          warmestCellI = append(warmestCellI, (i+a));
          warmestCellJ = append(warmestCellJ, (j+b));
        } 
        catch (IndexOutOfBoundsException e) {
        }
      }
    }
  }
  float maxTemp = minTemp;
  int whichI = 0; //Will return these two values 
  int whichJ = 0;
  for (int a = 0; a < temp.length; a++) { //We then use a for-loop to find the cell with the warmest temperation of the surrounding cells. Then store the i and j indices of this cell into a variable 
    if (temp[a] > maxTemp) {
      maxTemp = temp[a];
      whichI = warmestCellI[a];
      whichJ = warmestCellJ[a];
    } else if (temp[a] == maxTemp) { //If some cells are the same temperature, choose randomly which one to go to.
      int randomNum = int(random(0, 1.5));

      if (randomNum == 1) {
        maxTemp = temp[a];
        whichI = warmestCellI[a];
        whichJ = warmestCellJ[a];
      }
    }
  }
  if (Index.equals("i")) { //Returns the i or j index depending on what you asked for
    return whichI;
  } else {
    return whichJ;
  }
}
//Finds the i and j indices of a neighbouring cell that is unoccupied
int moveToRandomCellIndex(int i, int j, String Index) {
  int whichI = i;
  int whichJ = j;
  boolean foundCell = false;
  for (int a = -1; a <= 1; a++) { //Looks around current cell
    for (int b = -1; b <= 1; b++) {
      if (!(a == 0 && b == 0)) {
        try {
          if ((butterflyNow[i+a][j+b] != yellow && butterflyNow[i+a][j+b] != white) || (butterflyNext[i+a][j+b] != yellow && butterflyNext[i+a][j+b] != white) ) {//If the surrounding cell isn't a butterfly or larva cell it is considered unoccupied
            if (foundCell == false) {
              whichI = i + a;
              whichJ = j + b;
              foundCell = true;
            } else {
              int randomNum = int(random(0, 5)); //If there is more than one occupied cell pick randomly
              if (randomNum == 1) {
                whichI = i + a;
                whichJ = j + b;
              }
            }
          }
        } 
        catch (IndexOutOfBoundsException e) {
        }
      }
    }
  }
  if (Index.equals("i")) { //Return the i or j index depending on what the user asked for
    return whichI;
  } else {
    return whichJ;
  }
}

//Gets the surrounding information of given cells (number of neighbours, cold cells and warm cells) then returns that value
int getSurroundingInfo(int i, int j, String Info) {
  int numNeighbours = 0, numCoolCells = 0, numWarmCells = 0;
  for (int a = -1; a <= 1; a++) { //Looks around current cell
    for (int b = -1; b <= 1; b++) {
      if (!(a == 0 && b == 0)) { 
        try {
          if (butterflyNow[i+a][j+b] == yellow) { //Counts the number of butterfly cells there are around a cell
            numNeighbours++;
          }
          if (tempNow[i+a][j+b] <= dangerousTemp) { //Counts the number of cool cells there are around a given cells (cool Cells are any cells that are equal or below the dangerous temperature value)
            numCoolCells++;
          }
          if (tempNow[i+a][j+b] >= safeTemp) { //Counts the number of warm cells around a given cell (warm cells are any cells that are equal or above the safe temperature value)
            numWarmCells++;
          }
        } 
        catch (IndexOutOfBoundsException e) {
        }
      }
    }
  }
  if (Info.equals("neighbours")) { //Depending on what the user asked for, return the needed value
    return numNeighbours;
  } else if (Info.equals("coolCells")) {
    return numCoolCells;
  } else {
    return numWarmCells;
  }
}

//Checks whether a butterfly should die, lay an egg, hatch into a larva or grow up
boolean checkButterflyCells(int i, int j, String checkWhat) {
  int numCoolCells = getSurroundingInfo(i, j, "coolCells"); //Get the number of surrounding cool cells
  int numNeighbours = getSurroundingInfo(i, j, "neighbours"); //Get the number of surrounding neighbours
  int deathFactor = int(random(0, 100)); //Death chance
  int numButterflies = 0, numEggs = 0; //Value needed for egg laying
  boolean alive = true, layEgg = false, hatchEgg = false, growUp = false; //Various boolean statements that we will return later

  for (int a = -1*eggLayingRadius; a <= eggLayingRadius; a++) { //Check around the given cell depending on choosen radius
    for (int b = -1*eggLayingRadius; b <= eggLayingRadius; b++) { 
      if (!(a == 0 && b == 0)) {
        try {
          if (butterflyNow[i+a][j+b] == yellow) { //Counts number of butterflies surrounding current cell
            numButterflies++;
          }
          if (butterflyNext[i+a][j+b] == green) { //Counts number of eggs surrounding current cell
            numEggs++;
          }
        } 
        catch (IndexOutOfBoundsException e) {
        }
      }
    }
  }
  if (butterflyNow[i][j] != white) { //If the cell isn't a larva, then these are the factors that will impact it's death
    if (((numCoolCells == 8 || numNeighbours >= maxNumNeighbours) && deathFactor <= chanceDeath) || butterflyAge[i][j] > maxAge) { //Checks if there are too many cold cells or too many neighbours, and if the death chance is good or if simply the buttefly is too old
      alive = false;
    }
  } else { //Otherwise, for the larva cell, if it around too many cold cell it dies
    if (numCoolCells >= 1) {
      alive = false;
    }
  }
  if ((numButterflies == butterfliesNeededToLayEgg) && (numEggs <= maxEggNeighbours)) { //Checks if there are enough surrounding butterflies and not too many surrounding eggs. If true, you can lay an egg.
    layEgg = true;
  }
  if (butterflyAge[i][j] >= genToHatchEgg) { //If the egg is past a certain age, it should hatch
    hatchEgg = true;
  }
  if (butterflyAge[i][j] >= genToGrowUp) { //If the larva is past a certain age, it should grow up into a butterfly
    growUp = true;
  }
  if (checkWhat.equals("ifAlive")) { //Returns the true or false value of the variable you asked for
    return alive;
  } else if (checkWhat.equals("ifLayEgg")) {
    return layEgg;
  } else if (checkWhat.equals("ifHatchEgg")) {
    return hatchEgg;
  } else {
    return growUp;
  }
}

//Randomly picks what edge the warmest and coldest cells will be
void getTempCells() {
  int randomNum = int(random(0, 4));
  
  //Using a randomNum randomly pick the sides of the coldest and warmest cell
  //No matter what side they are on, they coldest and warmest side are always opposite to one another
  if (randomNum == 0) {
    redI = (n-1)/2; 
    redJ = n-n;
    blueI = redI; 
    blueJ = (n-1) - redJ;
  } else if (randomNum == 1) {
    redI = n-n; 
    redJ = (n-1)/2;
    blueI = (n-1) - redI; 
    blueJ = redJ;
  } else if (randomNum == 2) {
    redI = (n-1)/2; 
    redJ = n - 1;
    blueI = redI; 
    blueJ = (n-1) - redJ;
  } else {
    redI = n - 1; 
    redJ = (n-1)/2;
    blueI = (n-1) - redI; 
    blueJ = redJ;
  }

  tempCellsNext[redI][redJ] = red; //Gives the hottest cell the color red
  tempNext[redI][redJ] = maxTemp; //Gives the hottest cell the max temperature

  tempCellsNext[blueI][blueJ] = blue; //Gives the coldest cell the color blue
  tempNext[blueI][blueJ] = minTemp; //Gives the coldest cell the min temperature

  if (blueI == redI) { //Determines whether the gradient should transition vertically or horizontally
    orientation = "horizontal";
  } else {
    orientation = "vertical";
  }
  getOtherTempCells(); //Gets the values of all the temperature cells in between the coldest and hottest
}

//Gets the values of all the temperature cells in between the coldest and hottest
void getOtherTempCells() {
  int numCellsBetween;
  float currTemp, startTemp, endTemp, tempIncrement;
  int higherNum, lowerNum;
  color cellColor = color(0);
  color startColor, endColor;

  if (orientation.equals("horizontal")) { //Picks what color appears first from top to bottom or left to right
    higherNum = max(redJ, blueJ); 
    lowerNum = min(redJ, blueJ);
  } else {
    higherNum = max(redI, blueI); 
    lowerNum = min(redI, blueI);
  }

  if (redJ == higherNum || redI == higherNum) { //Based of what color comes first, get a starting and ending value for the gradient, along with starting and ending temperature values
    startColor = blue; 
    endColor = red;
    startTemp = minTemp; 
    endTemp = maxTemp;
  } else {
    startColor = red; 
    endColor = blue;
    startTemp = maxTemp; 
    endTemp = minTemp;
  } 

  numCellsBetween = higherNum - lowerNum;  //Finds how rows or columns are in between the coldest and hottest cells
  tempIncrement = (endTemp - startTemp)/numCellsBetween; //Finds the value of what the temperature increases or decreases by each iteration
  
  //For every cell in the grid
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {

      if (orientation.equals("horizontal")) { //If the orientation is horizontal, the gradient goes from column to column
        cellColor = lerpColor(startColor, endColor, (1.0*j/numCellsBetween)); //LerpColor can be used to easily find the gradient between two colors
        currTemp = startTemp + tempIncrement*j;
      } else {
        cellColor = lerpColor(startColor, endColor, (1.0*i/numCellsBetween)); //If the orientation is vertical, the gradient goes from row to row
        currTemp = startTemp + tempIncrement*i;
      }

      if ((i != redI && i != blueI) || (j != blueJ && j != redJ)) { //As long as it is not the hottest or coldest cell, fill it with the calculated colour and temperature
        tempCellsNext[i][j] = cellColor;
        tempNext[i][j] = currTemp;
      }
    }
  }
}
//Replaces Current temperauture values with future temperature values
void updateTempCells() {
  int count = 0;
  
  //For every cell in the grid
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if (changeTemp == true) { //If climate change is true, the slowly update the old cells with the new cells based of the given value
        int randomNum = int(random(0, climateChangeSpeed)); //Basically just decreases the chance for a cell to change as you increase the value
        if (randomNum == 1) {
          tempCellsNow[i][j] = tempCellsNext[i][j];
          tempNow[i][j] = tempNext[i][j];
        } 
        if (tempCellsNow[i][j] == tempCellsNext[i][j]) { //Counts if all the cells have changed yet
          count++;
        }
      } else { //If climate change isn't true, instantly update
        tempCellsNow[i][j] = tempCellsNext[i][j];
        tempNow[i][j] = tempNext[i][j];
      }
    }
  }
  if (count == n*n) { //Once all cells have changed climate change is no longer true
    changeTemp = false;
  }
}

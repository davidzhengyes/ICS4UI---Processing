//Title: Rain in the Forest
//Name: Sophia Xie
//Teacher: Mr. Schattman
//Course: ICS4UI
//Last Modified: 12/16/2020

//CHANGEABLE VARIABLES
int n = 200; //choose either 200 (bigger trees) or 400 (smaller trees)
//n = 200 runs much smoother.
//any n value above 125 works, however, because of processing's rounding errors, the animation is blurry.
int numTrees = 2; //if n = 200, 5 or less recommended; if n = 400, 25 or less recommended
//my personal favourite is n = 200 and numTrees = 1
String rainfallPattern = "decreasing"; //"increasing", "decreasing", or "constant"
float amountOfRain = 5; //(initial amount) scale from 1 to 5, 5 being the max rain
float framesPerSecond = 60; //recommend between 10 and 60

//COLOURS
//NOTES:
// 1. No two colours can be the same.
// 2. None of the colours can only have green (i.e. 0 red, some green, 0 blue).
// 3. For the most realistic simulation, keep the branchColour and trunkColour as close as possible.
color skyColour = color(128, 225, 255);
color rainColour = color(2, 0, 185);
color branchColour = color(102, 51, 0);
color trunkColour = color(101, 51, 0);
color grassColour = color(1, 190, 0);

//DO NOT CHANGE THESE
int loopNumber = 0;
float probabilityOfRain;

int[] xTree = new int[numTrees];
int[] yTree = new int[numTrees];

color[][] cells = new color[n][n];
color[][] cellsNext = new color[n][n];

int[][] ySpeeds = new int[n][n];
int[][] ySpeedsNext = new int[n][n];

float cellSize;
boolean rainOnScreen;

void setup() {
  size(800, 600);
  frameRate(framesPerSecond);
  cellSize = float(width)/n;
  noStroke();

  //increase or decrease amount of rain each subsequent year, if necessary
  if (loopNumber > 0) {
    if (rainfallPattern == "increasing") {
      amountOfRain = 1.3*amountOfRain;
    } else if (rainfallPattern == "decreasing") {
      amountOfRain = 0.7*amountOfRain;
    }
  }

  if (amountOfRain > 5) {
    amountOfRain = 5; //5 is the maximum
  }

  probabilityOfRain = pow(0.2*amountOfRain, 2);

  if (loopNumber==0) { //if this is the first loop
    for (int i=0; i<numTrees; i++) { //give trees random locations within a certain range
      xTree[i] = round(random(26, n-17));
      yTree[i] = round(random(0.45*n+10, 0.7*n));
    }
  }

  firstRainGeneration(); //create the raindrops
}

//creating the raindrops
void firstRainGeneration() {
  //for the cells in the first 10 rows
  for (int i=0; i<10; i++) {
    for (int j=0; j<n; j++) {

      //determine what colour to make cell (i,j) based on amount of rain
      float randomNum = random(0, 1);

      if (randomNum <= probabilityOfRain) {
        cells[i][j] = rainColour;
        ySpeeds[i][j] = 1;
      } else {
        cells[i][j] = skyColour;
        ySpeeds[i][j] = 0;
      }
    }
  }
}

void scrubNext() {
  cellsNext = new color[n][n];
  ySpeedsNext = new int[n][n];
  //deletes previous raindrops
}

void setNextRainGeneration() {
  scrubNext();

  //for every cell
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {

      //if the cell is a raindrop
      if (cells[i][j] == rainColour) {
        try {
          int iNext = i + ySpeeds[i][j]; //next row is current row + vertical speed
          cellsNext[iNext][j] = rainColour; //column remains the same
          if (i<0.6*n) { //if raindrop is not well into the grass yet
            ySpeedsNext[iNext][j] = ySpeeds[i][j] + round(random(0, 1));
            //there is a 50% chance of increasing the vertical speed by 1
            //this offsets to raindrops to make them look more realistic
          } else {
            cellsNext[iNext][j] = 0; //otherwise, delete the raindrop
          }
        }
        catch (Exception e) {
        }
      }

      if (cellsNext[i][j] != rainColour) { //if the cell is not a raindrop
        if (i<0.45*n) {
          cellsNext[i][j] = skyColour; //draw sky in top portion of screen
        } else {
          cellsNext[i][j] = grassColour; //draw grass in bottom portion of screen
        }
      }
    }
  }
}

void copyNextGenToCurrentGen() {
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      cells[i][j] = cellsNext[i][j];
      ySpeeds[i][j] = ySpeedsNext[i][j];
    }
  }
}

//
void setNextLeavesGeneration() {
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      int leafNeighbours = countGreenNeighbours(i, j);

      //if the cell is neighbouring at least one leaf or branch
      if (leafNeighbours >=1) {
        float random = random(0, 1);
        if (random < probabilityOfRain/2) { //probability of that cell becoming a leaf depends on amount of rain
          if (cells[i][j] == skyColour || cells[i][j] == grassColour) { //if the cell is either part of the sky or grass
            cellsNext[i][j] = color(0, round(random(75, 150)), 0); //turns into any shade of medium green
          }
        }
      }
    }
  }
}

int countGreenNeighbours(int row, int col) {
  int count = 0;

  for (int a=-1; a<=1; a++) {
    for (int b=-1; b<=1; b++) {
      try {
        if (cells[row+a][col+b] == branchColour && (a!=0 || b!=0) || (red(cells[row+a][col+b])==0 && green(cells[row+a][col+b])>0 
          && blue(cells[row+a][col+b])==0 && (a!=0 || b!=0))) { //if the neighbouring cell is either leaf-green or a branch
          count++;
        }
      }
      catch (Exception e) {
      }
    }
  }
  return count;
}

void drawTree() {
  //hard-coded values for the trees; can be in different locations but always the same size and shape
  for (int i=0; i<numTrees; i++) { //for each tree
  
    //trunk
    for (int x=xTree[i]-7; x<=xTree[i]; x++) {
      for (int y=yTree[i]-50; y<=yTree[i]; y++) {
        cellsNext[y][x] = trunkColour;
        ;
      }
    }
    
    //top branch
    for (int x=xTree[i]-4; x<=xTree[i]-2; x++) {
      for (int y=yTree[i]-76; y<=yTree[i]-51; y++) {
        cellsNext[y][x] = branchColour;
      }
    }

    //top right branch
    int a = 0;
    for (int y=yTree[i]-70; y<=yTree[i]-51; y++) {
      for (int x=xTree[i]+8+a; x<=xTree[i]+10+a; x++) {
        cellsNext[y][x] = branchColour;
      }
      if (y%2==0) {
        a-=1;
      }
    }

    //top left branch
    int b = 0;
    for (int y=yTree[i]-74; y<=yTree[i]-51; y++) {
      for (int x=xTree[i]-18+b; x<=xTree[i]-16+b; x++) {
        cellsNext[y][x] = branchColour;
      }
      if (y%2==0) {
        b+=1;
      }
    }

    //middle left branch
    int c = 0;
    for (int y=yTree[i]-66; y<=yTree[i]-48; y++) {
      for (int x=xTree[i]-26+c; x<=xTree[i]-22+c; x++) {
        cellsNext[y][x] = branchColour;
      }
      if (y%2==0) {
        c+=2;
      }
    }

    //bottom right branch
    int d = 0;
    for (int y=yTree[i]-50; y<=yTree[i]-42; y++) {
      for (int x=xTree[i]+11+d; x<=xTree[i]+16+d; x++) {
        cellsNext[y][x] = branchColour;
      }
      d-=2;
    }

    //bottom left branch
    int e = 0;
    for (int y=yTree[i]-43; y<=yTree[i]-38; y++) {
      for (int x=xTree[i]-24+e; x<=xTree[i]-20+e; x++) {
        cellsNext[y][x] = branchColour;
      }
      e+=3;
    }
  }
}

void checkRain() {
  //see if there is still rain on the screen
  //used to determine when to switch to Tree Growth phase

  rainOnScreen = false;
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      if (cells[i][j] == rainColour) {
        rainOnScreen = true;
      }
    }
  }
}

void drawMessage() {
  fill(255);
  strokeWeight(10);
  stroke(0);
  rect(0, 0, 800, 60);
  noStroke();
  fill(0);
  textSize(24);
  textAlign(CENTER);

  int percentRain = round((amountOfRain/5)*100); //convert fraction to percentage
  if (percentRain > 100) {
    percentRain = 100; //cannot be more than 100
  }

  //message at top of screen
  text("YEAR " + int(loopNumber+1) + "             AMOUNT OF RAIN: " + percentRain + "%", 400, 39);

  //let the user know if they're reached the maximum or minimum amount of rain
  textSize(14);
  if (percentRain == 100 && rainfallPattern == "increasing") {
    text("Maximum amount of rain reached.", 650, 10, 140, 60);
  } else if (percentRain == 0 && rainfallPattern == "decreasing") {
    text("Minimum amount of rain reached.", 650, 10, 140, 60);
  }
}

void draw() {

  //draws all the cells to the screen
  float yCoor = 0;

  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      float xCoor = j*cellSize;
      fill(cells[i][j]);
      rect(xCoor, yCoor, cellSize, cellSize);
      if (cells[i][j] == rainColour) { //raindrops are drawn as vertical rectangles
        rect(xCoor, yCoor-cellSize*2, cellSize, cellSize*2);
      }
    }

    yCoor+=cellSize;
  }

  checkRain();
  if (frameCount%60==0) { //when the loop resets, start drawing rain onto the screen
    rainOnScreen=true;
  }

  if (rainOnScreen==true) { //rainfall phase
    setNextRainGeneration();
  } else { //tree growth phase
    frameRate(round(0.6*framesPerSecond)); //slow down frame rate
    setNextLeavesGeneration();
  }

  drawTree();
  drawMessage();
  copyNextGenToCurrentGen();

  if (frameCount%60==0) {
    loopNumber += 1; //years increase by 1
    delay(1500); //pause to show how big the tree(s) grew
    setup(); //restarts the simulation, changing the amount of rain if necessary
  }
}

// USER-DETERMINED VARIABLES

// Grid length and width
int n = 50;

// Number of turns to create/absorb carbon dioxide
int pondCooldown = 100;
int treeCooldown = 20;
int powerCooldown = 1;

// Number of ponds/tiles of a certain land tile
int pondNum = 7;
int treeNum = 30;
int powerNum = 5;

// Upper and lower bound for pond sizes
int pondSmall = 3;
int pondBig = 5;

// Screen padding
float padding = 50;

//USER-DETERMINED VARIABLES END HERE

// To record carbon content
boolean[][] carbonContent = new boolean[n][n];
boolean[][] carbonNext = new boolean[n][n];

// Tile types
boolean[][] water = new boolean[n][n];
boolean[][] trees = new boolean[n][n];                                                                                                                                                                                                                                                                                                                                                                                    
boolean[][] powerPlants = new boolean[n][n];

// Record cooldowns of all tiles
int[][] cooldownAll = new int[n][n];

int neighbours,totalWater;
float cellSizeX,cellSizeY;

void setup() {
  size(600,600);
  cellSizeX = (width-2*padding)/n;
  cellSizeY = (height-2*padding)/n;
  
  generateLand();
  
  frameRate(5);
}


void draw() {
  background(255);
  //strokeWeight(0);
  noStroke();
  
  for(int i = 0; i < n; i++ ) {
    for(int j = 0; j < n; j++) {
      float x = padding + i*cellSizeX;
      float y = padding + j*cellSizeY;
      
      // Colour in based on which land tile
      if(water[i][j]) {
        fill(0, 100, 200);
      } else if(trees[i][j]) {
        fill(31, 127, 31);
      } else if(powerPlants[i][j]) {
        fill(255, 0, 0);
      } else {
        fill(223, 255, 233);
      }
      rect(x, y, cellSizeX, cellSizeY);
      
      // Grey if high carbon dioxide content
      if (carbonContent[i][j]) {
        fill(127,127,127,127);
        rect(x, y, cellSizeX, cellSizeY);
      }
      
    }
  }
  // Carbon Absorption
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
      if(trees[i][j] && carbonContent[i][j]) {
        if(cooldownAll[i][j] == 0) {
          carbonContent[i][j] = false;
          carbonNext[i][j] = false;
          cooldownAll[i][j] = treeCooldown;
        }
      } else if(water[i][j] && carbonContent[i][j]) {
        if(cooldownAll[i][j] == 0) {
          carbonContent[i][j] = false;
          carbonNext[i][j] = false;
          cooldownAll[i][j] = pondCooldown;
        }
      }
    }
  }
  // Carbon Movement
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
      if(carbonContent[i][j]) {
        moveGas(i,j);
      }
    }
  }
  // Carbon Creation
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
      if(powerPlants[i][j] && !carbonNext[i][j]) {
        if(cooldownAll[i][j] == 0) {
          carbonContent[i][j] = true;
          carbonNext[i][j] = true;
          cooldownAll[i][j] = powerCooldown;
        }
      }
    }
  }
  //Set values for next generation
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
      carbonContent[i][j] = carbonNext[i][j];
      if(cooldownAll[i][j] != 0) {
        cooldownAll[i][j]--;
      }
    }
  }
}

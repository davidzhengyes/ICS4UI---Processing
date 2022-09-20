// Adjustable Variables
int n = 120; //number of cells
int forestGrowthRate = 100; //probability of foliage growth
int fireGrowthRate = 6; //the fire has a 1 in "your number" chance of spreading to an adjacent block
float changeInForestGrowthRate = 1; //probability of change of forestGrowthRate   
int FPS = 60; //Frames per second
boolean randomStart = false; // Allows user to start fire randomly without clicking
int chanceRandomStart = 10000; //If randomStart is true then each block has a 1 in "your number" chance of starting a fire

// Setting Variables
color[][] cellsNow;
color[][] cellsNext;
int[][] burnTimer;
float cellSize;
float padding = 50;
int row = 1;
color black = color(0);
color sky = color(75, 175, 255);
color forest = color(0, 150, 0);
color red = color(255,0,0), orange = color(255,100,0), yellow = color(230,220,0);
color[] fire = {red, orange, yellow};
int rand = int(random( 0, fire.length ));
int rand2 = int(random(0, chanceRandomStart));

void setup() {
  cellsNow = new color[n][n];
  cellsNext = new color[n][n];
  burnTimer = new int[n][n];
  size(1000, 1000);
  cellSize = (width-2*padding)/n;
  frameRate(FPS);
  setTimer();
  setSky();
  startForest(); 
  noStroke();
}

void draw() {
  background(255);
  float y = padding;

  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      float x = padding + j*cellSize;

      noStroke();
      fill(cellsNow[i][j]);

      rect(x, y, cellSize, cellSize);
    }
    y += cellSize;
  }
  growForest();
  updateforestGrowthRate();
  charcoal();
  cellsNextToCellsNow();
  spreadFire();
}

// Sets all cells to sky color
void setSky() {
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      cellsNow[i][j] = sky;
      cellsNext[i][j] = sky; }
  }
}

//Sets the next cell values as the current ones so they can be drawn
void cellsNextToCellsNow() {
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      cellsNow[i][j] = cellsNext[i][j];
    }
  }
}

//Starts drawing the forest
void startForest() {
  for (int j = 0; j < n; j++ ) {
    for (int k = 1; k < 4; k ++) {
      cellsNext[n-k][j] = forest;
    }
  }
}

//Continues to grow the forest
void growForest() {
  if (row< n) {
    for (int j = 0; j < n; j++) {
      if (cellsNow[n-row][j] == forest)
        checkNextRow(n-row, j);
    }
    row += 1;
  }
  else {
    if (randomStart) {
      for (int i=0; i<n; i++) {
        for (int j=0; j<n; j++) {
          if (cellsNow[i][j] == forest) {
            rand2 = int(random(0, chanceRandomStart));  
            if (rand2 == 1) {
              int rand = int(random( 0, fire.length ));
              cellsNext[i][j] = fire[rand]; 
            }
          }
        }
      }
    }
  }
}

//Sets the ten frame countdown to draw the burnt remains
void setTimer() {
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      burnTimer[i][j] = 0;
    }  
  }  
}

//Draws burnt remains of the forest
void charcoal() {
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      if (cellsNow[i][j] == red || cellsNow[i][j] == orange || cellsNow[i][j] == yellow) {
        burnTimer[i][j] += 1;
        if (burnTimer[i][j] == 10) {
          cellsNext[i][j] = black; 
        }
      }
    }
  }
}

//Spreads fire
void spreadFire() {
  int fireFraction = 0;
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      if (cellsNow[i][j] == red || cellsNow[i][j] == orange || cellsNow[i][j] == yellow) {
        for(int x = -1; x <= 1; x++) {
          for(int y = -1; y <= 1; y++) {
            try {
              if (cellsNow[i+x][j+y] == forest) {
                fireFraction = int(random(0, fireGrowthRate));
                if (fireFraction == 1) {
                  rand = int(random( 0, fire.length ));        
                  cellsNext[i+x][j+y] = fire[rand]; 
                }
              }
            }
            catch(IndexOutOfBoundsException e) {
            }
          }
        }
      }
    }
  }
}

//Determines if a block should be foliage or sky
//If the random integer is bigger than the forestGrowthRate the block will be sky
void checkNextRow(int i, int j) {
  int growthFraction = 0;
  for (int r = -1; r <= 1; r ++) {
    growthFraction = int(random(0, 100));
    if (growthFraction <= forestGrowthRate) {
      try {
        cellsNext[i-1][j+r] = forest;
      }
      catch(IndexOutOfBoundsException e) {
      }
    } else {
      try {
        cellsNext[i-1][j+r] = sky;
      }
      catch(IndexOutOfBoundsException e) {
      }
    }
  }
}

//Over time the forest growth rate decreases (by chance) from its initial value by a user set value
void updateforestGrowthRate() {
  int updateFraction = 0;
  updateFraction = int(random(0, 10));
  if (updateFraction < 5) {
    forestGrowthRate -= changeInForestGrowthRate;
  }
}

//Sets fire to forest when mouse is clicked
void mouseClicked() {
  if (randomStart == false) {
    int rowWhereWeClicked = int( (mouseY-padding)/cellSize );
    int colWhereWeClicked = int( (mouseX-padding)/cellSize );
    try {
      if (cellsNow[ rowWhereWeClicked ][ colWhereWeClicked ] == forest){
        try {
          rand = int(random( 0, fire.length ));        
          cellsNext[rowWhereWeClicked][colWhereWeClicked] = fire[rand]; 
          cellsNextToCellsNow(); 
          redraw();         
        }
        catch(IndexOutOfBoundsException e) {
        }
      }  
    }
    catch(IndexOutOfBoundsException e) {
    }
  }
}

//Sets fire to forest when mouse is clicked and dragged
void mouseDragged() {
  if (randomStart == false) {
    int rowWhereWeClicked = int( (mouseY-padding)/cellSize );
    int colWhereWeClicked = int( (mouseX-padding)/cellSize );
    try {
      if (cellsNow[ rowWhereWeClicked ][ colWhereWeClicked ] == forest){
        try {
          rand = int(random( 0, fire.length ));        
          cellsNext[rowWhereWeClicked][colWhereWeClicked] = fire[rand]; 
          cellsNextToCellsNow(); 
          redraw();         
        }
        catch(IndexOutOfBoundsException e) {
        }
      }  
    }
    catch(IndexOutOfBoundsException e) {
    }
  }
}

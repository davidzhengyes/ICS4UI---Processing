//Variable Declarations
int n = 100;
int[][] cells;
int[][] newCells;
float cellSize;
float padding = 35;
int blinksPerSecond = 20;
int genCount = 0;
float rand;
String danger;
String cellBehaviour;
float[][] xDist;
float[][] yDist;
float leftValue;
float rightValue;
float upValue;
float downValue;
float frq;
int lightningX;
int lightningY;
int lastStrikeX;
int lastStrikeY;
int r;
boolean tornado;
int tornadoX;
int tornadoY;
int tornadoDirection;
int fracAlive;

// 0 = Empty
// 1 = Alive
// 2 = Lightning
// 3 = Tornado

void setup() {
  //Define Variables
  size(900,900);
  frameRate(blinksPerSecond);
  cellSize = (width - (2 * padding)) / n;
  cells = new int[n][n];
  newCells = new int[n][n];
  xDist = new float[n][n]; //Not distance, but the ratio of distance of a cells to danger compared to n
  yDist = new float[n][n];
  tornado = false;
  
  //CHANGABLE VARIABLES
  frq = 30; //How often lightning strikes
  danger = "tornado"; //Danger can be "lightning" or "tornado"
  cellBehaviour = "scared"; //Cells can be "unaware", "scared", or "curious"
  r = 9; //Radius of danger, doubled for lightning
  fracAlive = 20; //The fraction of people alive at the start of the simulation (1/fracAlive)
  
  //Call starting function
  setStartPosition();
}

void setStartPosition() {
  
  //For every cell
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      //Creates randon number between 0 and 9
      rand = int(random(fracAlive));
      
      //Creates a one in twenty chance that the cell begins alive
      if (rand == 0)
        cells[i][j] = 1;
        
      else 
        cells[i][j] = 0;
    }
  }
}

void draw() {
  background(200,180,100);
  float y = padding;
  
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
      float x = padding + (j * cellSize);
      
      if (cells[i][j] == 0)
        fill(0,100,0);
      
      else if (cells[i][j] == 1)
        fill(230,100,0);
        
      else if (cells[i][j] == 2)
        fill(255,255,80);
        
      else 
        fill(200,200,200);
        
      rect(x, y, cellSize, cellSize);
    }
    y += cellSize;
  }
  
  createNextGeneration();
}

void createNextGeneration() {
  movePopulation();
  
  //If the danger is tornado
  if (danger == "tornado")
    checkTornado();
    
  //If the danger is lightning 
  else if (danger == "lightning")
    checkLightning();
     
  genCount++;
}

void movePopulation() {
  //Call before for loop
  if (genCount > 10 && cellBehaviour != "unaware")
    findDist();
  
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
      
      if (cells[i][j] == 1) {
        //From 0-4, the five values represent moving up, down, left, right, and staying still
        rand = random(5);
        
        //Using the ratios of the length/height to the x/y dist from danger to add
        //a factor of urgency to each direction to simulate running away
        
        if (cellBehaviour != "curious") {
          leftValue = 1 - (yDist[i][j] / 2);
          rightValue = 1 + (yDist[i][j] / 2);
          upValue = 1 - (xDist[i][j] / 2);
          downValue = 1 + (xDist[i][j] / 2);
        }
        
        else {
          leftValue = 1 + (yDist[i][j] / 2);
          rightValue = 1 - (yDist[i][j] / 2);
          upValue = 1 + (xDist[i][j] / 2);
          downValue = 1 - (xDist[i][j] / 2);
        }
          
        //Move in each direction, 0 being up and continuing clockwise
        if (rand < upValue) {
          try {
            if (cells[i - 1][j] != 1) {
              cells[i][j] = 0;
              cells[i - 1][j] = 1;
            }
          }
          
          catch (IndexOutOfBoundsException e) {
          }
        }
          
        //Right
        else if (rand < (upValue + rightValue)) {
          try {
            if (cells[i][j + 1] != 1) {
              cells[i][j] = 0;
              cells[i][j + 1] = 1;
            }
          }
        
          catch (IndexOutOfBoundsException e) {
          }
        }
          
        //Down
        else if (rand < (upValue + rightValue + downValue)) {
          try {
            if (cells[i + 1][j] != 1) {
              cells[i][j] = 0;
              cells[i + 1][j] = 1;
            }
          }
          
          catch (IndexOutOfBoundsException e) {
          }
        }
          
        //Left
        else if (rand < 4) {
          try {
            if (cells[i][j - 1] != 1) {
              cells[i][j] = 0;
              cells[i][j - 1] = 1;
            }
          }
          
          catch (IndexOutOfBoundsException e) {
          }
        }
          
        //Otherwise they stay still and nothing changes
      }
    }
  }
}

void findDist() {
  for(int i = 0; i < n; i++) {
    for(int j = 0; j < n; j++) {
      //This will give the distance of the last strike when compared to the size of the grid
      //This is for the "weighted random" system that takes these ratios and creates sqewed probablities to urge them into a certain direction
      if (danger == "lightning") {
        xDist[i][j] = (i - lastStrikeX) / float(n);
        yDist[i][j] = (j - lastStrikeY) / float(n);
      }
      
      else if (danger == "tornado") {
        xDist[i][j] = (i - tornadoX) / float(n);
        yDist[i][j] = (j - tornadoY) / float(n);
      }
      
      //Subtract their values from one or negative one, depending on if they're positive or negative
      //The goal is to have a closer distance to the last lightning strike make them more urgent
      //Having a magnitude between 0 and 1 makes it very simple
      if (xDist[i][j] < 0)
        xDist[i][j] = -1 + xDist[i][j];
        
      else 
        xDist[i][j] =  1 - xDist[i][j];
        
      if (yDist[i][j] < 0)
        yDist[i][j] = -1 + yDist[i][j];
        
      else 
        yDist[i][j] =  1 - yDist[i][j];
    }
  }
}

void checkLightning() {
  if (genCount % frq == 0)
    createLightning();
  
  else if (genCount % frq == 1)
    deleteLightning();
  
}

void createLightning() {
  lightningX = int(random(n + r));
  lightningY = int(random(n + r));
  
    for (int i = (lightningX - (2*r)); i < (lightningX + (2*r)); i++) {
      for (int j = (lightningY - (2*r)); j < (lightningY + (2*r)); j++) {
        try {
          cells[i][j] = 2;
      }
      
      catch (IndexOutOfBoundsException e) {
      } 
    }
  }
}

void deleteLightning() {
  lastStrikeX = lightningX;
  lastStrikeY = lightningY;
  
    for (int i = (lightningX - (2*r)); i < (lightningX + (2*r)); i++) {
      for (int j = (lightningY - (2*r)); j < (lightningY + (2*r)); j++) {
        try {
          cells[i][j] = 0;
      }
      
      catch (IndexOutOfBoundsException e) {
      }
    }
  }
}

void checkTornado() {
  if (tornado == false)
    createTornado();

  else {
    moveTornado();
  }
  
  assignTornado();
}

//This creates a tornado somewhere on the egde of the screen, and sets it's direction of movement
void createTornado() {
  tornadoDirection = int(random(4));
  
  //Starts at Left
  if (tornadoDirection == 0) {
    tornadoX = 0 - r;
    tornadoY = int(random(n));
  }
  
  //Starts at Right
  else if (tornadoDirection == 1) {
    tornadoX = n + r;
    tornadoY = int(random(n));
  }
  
  //Starts at Top
  else if (tornadoDirection == 2) {
    tornadoX = int(random(n));
    tornadoY = 0 - r;
  }
  
  //Starts at Bottom
  else if (tornadoDirection == 3) {
    tornadoX = int(random(n));
    tornadoY = n + r;
  }
  
  //Makes sure another tornado can't be created for now
  tornado = true;
}

//This function moves the tornado centre once in it's set direction every frame
void moveTornado() {
  //Nested if statements elete tornado when it goes offscreen
  if (tornadoDirection == 0) {
    tornadoX = tornadoX + 1;
    if (tornadoX > (n + r))
      tornado = false;
  }
  
  else if (tornadoDirection == 1) {
    tornadoX = tornadoX - 1;
    if (tornadoX < ( 0 - (r + 1)))
      tornado = false;
  }
  
  else if (tornadoDirection == 2) {
    tornadoY = tornadoY + 1;
    if (tornadoY > (n + r))
      tornado = false;
  }
  
  else if (tornadoDirection == 3) {
      tornadoY = tornadoY - 1;
    if (tornadoY < (0 - (r + 1)))
      tornado = false;
  }
}

//This function creates the tornado blocks around the tornado centre
void assignTornado() {
  if (tornadoDirection == 0) {
    for (int i = (tornadoX - (r + 1)); i < (tornadoX + r); i++) {
      for (int j = (tornadoY - r); j < (tornadoY + r); j++) {
        try {
          if (i < tornadoX - r)
            cells[i][j] = 0;
          else
            cells[i][j] = 3;
        }
      
        catch (IndexOutOfBoundsException e) {
        } 
      }
    }
  }
  
  if (tornadoDirection == 1) {
    for (int i = (tornadoX - r); i < (tornadoX + (r + 1)); i++) {
      for (int j = (tornadoY - r); j < (tornadoY + r); j++) {
        try {
          if (i > tornadoX + (r - 1))
            cells[i][j] = 0;
          else
            cells[i][j] = 3;
        }
      
        catch (IndexOutOfBoundsException e) {
        } 
      }
    }
  }
  
  if (tornadoDirection == 2) {
    for (int i = (tornadoX - r); i < (tornadoX + r); i++) {
      for (int j = (tornadoY - (r + 1)); j < (tornadoY + r); j++) {
        try {
          if (j < tornadoY - r)
            cells[i][j] = 0;
          else
            cells[i][j] = 3;
        }
      
        catch (IndexOutOfBoundsException e) {
        } 
      }
    }
  }
  
  if (tornadoDirection == 3) {
    for (int i = (tornadoX - r); i < (tornadoX + r); i++) {
      for (int j = (tornadoY - r); j < (tornadoY + (r + 1)); j++) {
        try {
          if (j > tornadoY + (r - 1))
            cells[i][j] = 0;
          else
            cells[i][j] = 3;
        }
      
        catch (IndexOutOfBoundsException e) {
        } 
      }
    }
  }
}

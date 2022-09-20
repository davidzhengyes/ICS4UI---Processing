int n = 100;
int hatchingChance = 2;//chance expressed as a percentage
int frameSpeed = 10; //change to make the simulation move quicker or slower
int padding = 0;
float cellSize;

int i;
int j;

color[][] cells = new color[n][n]; //Sets up the cell arrays and the predator speed arrays for later use
color[][] cellsNext = new color[n][n];
int[][] xSpeeds = new int[n][n];
int[][] xSpeedsNext = new int[n][n];

color sand = color(220, 200, 0); //Assigns a easily callable variable to each colour
color turtle = color(0, 255, 0);
color predator = color(255, 0, 0);
color water = color(0, 0, 200);
color egg = color(255);
color plastic = color(255, 185, 185);

void setup() {
  size(800, 800);
  frameRate(frameSpeed);
  noStroke();
  cellSize = (width - 2*padding)/n;
  genFirst();
}

void draw() {
  background(sand);
  float y1 = padding;
  for(int i = 0; i < n; i++){
     for(int j = 0; j < n; j++){
      float x1 = padding + j*cellSize;
      fill(cells[i][j]);
      square(x1, y1, cellSize);
     }
      y1 += cellSize;
   }
    
  setNext();
  replaceNextGenToCurrentGen();
}


void genFirst(){
  int eggSpawnChance;
  for (int i = 0; i<(n/10); i++) { //These loops will generate the turtle eggs
      for (int j = 0; j<n; j++) {
        eggSpawnChance = int(random(1, 6));
        if(eggSpawnChance == 1){
          cells[i][j] = egg;
        }
        else{
          cells[i][j] = sand;
        }
      }
    }
  
  for(int i = n/10; i<(n/5); i++){ //This loop will generate the sand between the hazards and egg spawn zones
    for(int j = 0; j<n; j++){
    cells[i][j] = sand;
    }
  } 
  //generates the predators and plastics
  int hazardSpawnChance;
  for(int i = (n/5); i<n; i++){
    for(int j = 0; j<n; j++){
      hazardSpawnChance = int(random(1, 75));
      if(hazardSpawnChance == 1 && i < 0.7*n){
        cells[i][j] = predator;
        int xDirection = int(random(1, 3));//uses a random number to determine the initial direction of the predators (left or right)
        if(xDirection == 1){
          xSpeeds[i][j] = 1; 
        }
        if(xDirection == 2){
          xSpeeds[i][j] = -1;
        }
      }
      else if(hazardSpawnChance <= 2 && i < 0.7*n){//sets all of the speeds of the stationary cells to zero
        cells[i][j] = plastic;
        xSpeeds[i][j] = 0;
      }
      else if(i > 0.8*n){
        cells[i][j] = water;
        xSpeeds[i][j] = 0;
      }
      else{
        cells[i][j] = sand;
        xSpeeds[i][j] = 0;
      }
    }
  } 
}

void setNext(){
  int predatorsNearby;
  int hatchingPerGen;
  int plasticsNearby;
  int turtlesNearby;
  int eatenChance;
  //this loop replaces all stationary cells (sand, water and plastic)
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++) {
      if(cells[i][j] == sand){
        cellsNext[i][j] = sand;
      }
      if(cells[i][j] == plastic){
        cellsNext[i][j] = plastic;
      }
      if(cells[i][j] == water){
        cellsNext[i][j] = water;
      }
    }
  }
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++) {
      if(cells[i][j] == egg){//hatches and replaces the egg
        hatchingPerGen = int(random(0, (100/hatchingChance)));
        if(hatchingPerGen == 1){
          cellsNext[i][j] = turtle;
        }
        else{
        cellsNext[i][j] = egg;
        }
      }
      
      predatorsNearby = findNearPredators(i, j);
      plasticsNearby = findNearPlastic(i, j);
      if(cells[i][j] == turtle){//Turtle cell interactions with other cells
        if(plasticsNearby > 0){
            cellsNext[i][j] = sand;
        }
        else if(predatorsNearby > 0){
          cellsNext[i][j] = sand;
        }
        else{
          if(i != n-1){
           cellsNext[i+1][j] = turtle;
           cellsNext[i][j] = sand;
          }
          if(i > 0.8*n){
            cellsNext[i][j] = water;
          }
        }
     }
     turtlesNearby = findNearTurtles(i, j);
     if(cells[i][j] == plastic){//plastic cells interactions with other cells
       if(turtlesNearby > 0){
         eatenChance = int(random(0,4));
         if(eatenChance == 1){
           cellsNext[i][j] = sand;
         }
         else{
           cellsNext[i][j] = plastic;
         }
       }
     }
     
     if(cells[i][j] == predator){//Predator movements
       int speedX = xSpeeds[i][j];
       if(j == n-1 && speedX > 0){//checks if the predator cell is on one of the side borders
         speedX = speedX*-1;
       }
       if(j == 0 && speedX < 0){
         speedX = speedX*-1;
       }
       int jx = speedX + j;
       cellsNext[i][jx] = predator;
       xSpeedsNext[i][jx] = speedX;
       cellsNext[i][j] = sand;  
       xSpeedsNext[i][j] = 0;
      }
    }
  }
}



int findNearPredators(int i, int j){//Checks for any predators in the adjacent 8 cells
  int count = 0;
  for(int a = -1; a <= 1; a++) {
    for(int b = -1; b <= 1; b++) {
      try {
        if (cells[i+a][j+b] == predator && !(a==0 && b==0))
          count++;               
      }
      catch( IndexOutOfBoundsException e ) {
      }
    }
  }
  
  return count;
}

int findNearPlastic(int i, int j){//Checks for any plastic in the adjacent 8 cells
  int count = 0;
  for(int a = -1; a <= 1; a++) {
    for(int b = -1; b <= 1; b++) {
      try {
        if (cells[i+a][j+b] == plastic && !(a==0 && b==0))
          count++;               
      }
      catch( IndexOutOfBoundsException e ) {
      }
    }
  }
  
  return count;
}

int findNearTurtles(int i, int j){//Checks for any turtles in the adjacent 8 cells
  int count = 0;
  
  for(int a = -1; a <= 1; a++) {
    for(int b = -1; b <= 1; b++) {
      try {
        if (cells[i+a][j+b] == turtle && !(a==0 && b==0))
          count++;               
      }
      catch( IndexOutOfBoundsException e ) {
      }
    }
  }
  
  return count;
}

void replaceNextGenToCurrentGen() {//sets the new values of both the speeds and the cell colors
  for(int i=0; i<n; i++){ 
    for(int j=0; j<n; j++){
      cells[i][j] = cellsNext[i][j];
      xSpeeds[i][j] = xSpeedsNext[i][j];
    }
  }
}

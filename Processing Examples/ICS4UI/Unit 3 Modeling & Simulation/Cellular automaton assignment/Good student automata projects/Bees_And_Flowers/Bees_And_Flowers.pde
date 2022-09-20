// Changeable Variables //<>//
int frameRate = 10; // 
int depolRate = 150; //how fast the flowers are ready to become pollinated (i.e. how fast "depollinate"). This value denotes that every _ generation, pollinated flowers will become less pollinated.
int gridSize = 50; // Recommended: Roughly twice the amount of bees and flowers.
String setup = "Random"; 
/*
3 Setups: 
Random (specified number of bees and flowers randomly placed), 
Custom (one flower and one bee placed at a specified location), 
Checkerboard Field (flowers arranged in a checkerboard fashion with one bee).
*/

// For Random setup: Ratio of 1:5 nBees to nFlowers recommended.
int nBees = 8; 
int nFlowers = 200; 

// For Custom setup:
int fI = 4; 
int fJ = 6;
int bI = 4;
int bJ = 4;

color [][] cells = new color[gridSize][gridSize];  
color [][] cellsNext = new color[gridSize][gridSize]; 
color bees = color(255, 255, 0);
color flowers = color(255, 200, 200);
color flowPhase1 = color(255, 150, 150);
color flowPhase2 = color(255, 100, 100);
color flowPhase3 = color(255, 50, 50); // flower phases 1, 2, and 3 correlate to how much they have been pollinated (the first phase being the least pollinated and the third being the most)
color pollinatedFlowers = color(255, 0, 0);
color grass = color(0, 255, 0);

float cellSize;
float padding = 60;
int count = 0;
int nGen = 0;

void setup() {
  size(800, 800);
  noStroke();
  cellSize = (width - 2 * padding)/gridSize;
  if ( setup == "Random" )
    setFirstGrid();
  else if (setup == "Custom")
    setFirstGridCustom();
  else if (setup == "Checkerboard Field")
    setFlowerField();
}
void draw () {
  frameRate(frameRate);
  background(0);
  printGrid(); 
  computeNextGeneration();
  overwriteCells();
  nGen++;
}

void printGrid() {
  float y = padding;
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      float x = padding + j * cellSize;
      fill(cells[i][j]);
      square(x, y, cellSize);
    }
    y += cellSize;
  }
  fill(190, 170, 66);
  textFont(createFont("Times New Roman", 16));
  text( "To Pause/Play simulation, press [SPACE]. To increase and decrease the frame rate, press [W] and [S] respectively.", 50, 50); 
}

int[] scanEnvironment(int row, int column) { // a bee "scans" cells around it and returns the coordinates of the nearest flower.
  int[] nearestFlowerCoordinates = new int[2];
  int minDist = 11;    // mininum distance from bee to flower. Set to 11 as it is higher than 10 (maximum number of cells away from the flower).
  int dist = 11;
  for (int a = -5; a < 5; a++) { 
    for (int b = -5; b < 5; b++) {  // scans 5 blocks around the bee both vertically and horizontally.
      try {
        if ((cells[row + a][column + b] == flowers || cells[row + a][column + b] == flowPhase1 || cells[row + a][column + b] == flowPhase2 || cells[row + a][column + b] == flowPhase3) && (a != 0 || b != 0)){  
          if (a == 0 && b != 0) // if the flower is horizontal to the bee. 
            dist = abs(b) - 1;
          else if ( a != 0 && b == 0) // if the flower vertical to the bee.
            dist = abs(a) - 1;
          else // if the flower is diagonal to the bee.
            dist = abs(a); 
          if (dist < minDist){ 
            minDist = dist;
            nearestFlowerCoordinates[0] = row + a;
            nearestFlowerCoordinates[1] = column + b;
          }
        }
      }
      catch (Exception e) {
      }
    }
  }
  if (minDist > 10)
    return null;
  return nearestFlowerCoordinates;
}

void computeNextGeneration() {
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) { 
      if (cells[i][j] == bees) 
        moveBee(i, j); 
      else if (cells[i][j] == pollinatedFlowers || cells[i][j] == flowPhase1 || cells[i][j] == flowPhase2 || cells[i][j] == flowPhase3 ){ // flower becomes "pinker" (produce more pollen and nectar) 
        boolean beeNearby = scanForBee(i, j);
        if (!beeNearby && nGen % depolRate == 0){ 
          if (cells[i][j] == pollinatedFlowers)
            cellsNext[i][j] = flowPhase3;
          else if (cells[i][j] == flowPhase3)
            cellsNext[i][j] = flowPhase2;
          else if (cells[i][j] == flowPhase2)
            cellsNext[i][j] = flowPhase1;
          else if (cells[i][j] == flowPhase1)
            cellsNext[i][j] = flowers;
        }
      }
    }
  }
}
void overwriteCells() {
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      cells[i][j] = cellsNext[i][j];
    }
  }
} 

void moveBee(int i, int j){
  int[] nearestFlowerCoord = new int[2];
  nearestFlowerCoord = scanEnvironment(i, j); 
  if (nearestFlowerCoord != null) { // if there is a flower within its range
    if (abs(nearestFlowerCoord[0] - i) <= 1 && abs(nearestFlowerCoord[1] - j) <= 1) { // if the flower is adjacent (ready to be pollinated).
      int iValue = 0;
      int jValue = 0;
      if (i > nearestFlowerCoord[0] && j > nearestFlowerCoord[1]) {
        iValue = i - 1;
        jValue = j - 1; 
        pollinate(iValue, jValue); 
      } 
      else if (i > nearestFlowerCoord[0] && j < nearestFlowerCoord[1]) {
        iValue = i - 1;
        jValue = j + 1; 
        pollinate(iValue, jValue);
      } 
      else if (i < nearestFlowerCoord[0] && j > nearestFlowerCoord[1]) {
        iValue = i + 1;
        jValue = j - 1; 
        pollinate(iValue, jValue);
      } 
      else if (i < nearestFlowerCoord[0] && j < nearestFlowerCoord[1]) {
        iValue = i + 1;
        jValue = j + 1; 
        pollinate(iValue, jValue);
      } 
      else if (i > nearestFlowerCoord[0]) {
        iValue = i - 1;
        jValue = j; 
        pollinate(iValue, jValue);
      } 
      else if (i < nearestFlowerCoord[0]) {
        iValue = i + 1;
        jValue = j; 
        pollinate(iValue, jValue);
      } 
      else if (j > nearestFlowerCoord[1]) {
        iValue = i;
        jValue = j - 1; 
        pollinate(iValue, jValue);
      } 
      else if (j < nearestFlowerCoord[1]) {
        iValue = i;
        jValue = j + 1; 
        pollinate(iValue, jValue);
      }
      if (cellsNext[i][j] == grass) 
        cellsNext[i][j] = bees;
    }
    else { // if the flower is not adjacent to the bee.
      int iValue = 0;
      int jValue = 0;
      if (i > nearestFlowerCoord[0] && j > nearestFlowerCoord[1]) { // bee is right + below  
        iValue = i - 1;
        jValue = j - 1;
        move(iValue, jValue, i, j);
      } 
      else if (i > nearestFlowerCoord[0] && j < nearestFlowerCoord[1]) { // bee is left + below   
        iValue = i - 1;
        jValue = j + 1;
        move(iValue, jValue, i, j);
      } 
      else if (i < nearestFlowerCoord[0] && j > nearestFlowerCoord[1]) { // bee is right + up   
        iValue = i + 1;
        jValue = j - 1;
        move(iValue, jValue, i, j);
      } 
      else if (i < nearestFlowerCoord[0] && j < nearestFlowerCoord[1]) { // bee is left + up   
        iValue = i + 1;
        jValue = j + 1;
        move(iValue, jValue, i, j);
      } 
      else if (i > nearestFlowerCoord[0]) { // if bee is below flower. 
        iValue = i - 1;
        jValue = j;
        move(iValue, jValue, i, j);
      } 
      else if (i < nearestFlowerCoord[0]) { // if the bee is above the flower
        iValue = i + 1;
        jValue = j;
        move(iValue, jValue, i, j);
      } 
      else if (j > nearestFlowerCoord[1]) { // if bee is to the right of the flower
        iValue = i;
        jValue = j - 1;
        move(iValue, jValue, i, j);
      } 
      else if (j < nearestFlowerCoord[1]) { // if the bee is to the left of the flower
        iValue = i;
        jValue = j + 1;
        move(iValue, jValue, i, j);
      }
    } 
  }
  else // if there is no flower (within the bees detection range).
    moveRandomly(i, j);
}

void moveRandomly(int i, int j){ // takes the coordinates of the bee and moves it to a random cell within 24 nearest cells
  int nextRandI = round(random(-2, 2)); 
  int nextRandJ = round(random(-2, 2));
  try {
    if (cellsNext[i + nextRandI ][j + nextRandJ] == grass && cells[i + nextRandI][j + nextRandJ] == grass){ // makes sure that the next cell is grass and the cell wasn't previously occupied by a bee.
      cellsNext[i][j] = grass;
      cellsNext[i + nextRandI][j + nextRandJ] = bees;
    }
    else 
      cellsNext[i][j] = bees;
  }
  catch (IndexOutOfBoundsException e) {
    cellsNext[i][j] = bees;
  }
}

void keyPressed() {
  if(key == ' ')
    if (count % 2 != 0) 
      noLoop();
    else 
      loop();
    count++;
   if ((key == 'W' || key == 'w') && frameRate <= 55)
     frameRate += 5; 
   else if ((key == 'S' || key == 's') && frameRate >= 10)
     frameRate -= 5;
}

boolean scanForBee (int i, int j){ // flower checks if a bee is adjacent to it.
  for (int a = -1; a < 1; a++) { 
    for (int b = -1; b < 1; b++) {
      try {
        if (cells[i + a][j + b] == bees  && (a != 0 || b != 0))
          return true;
        else 
          return false;
      }
      catch (Exception e){
      }
    }
  }
  return false; 
}

void pollinate(int iValue, int jValue){ // bee pollinates the flower at iValue, jValue.
  if (cells[iValue][jValue] == flowers)
    cellsNext[iValue][jValue] = flowPhase1;
  if (cells[iValue][jValue] == flowPhase1)
    cellsNext[iValue][jValue] = flowPhase2;
  if (cells[iValue][jValue] == flowPhase2)
    cellsNext[iValue][jValue] = flowPhase3;
  if (cells[iValue][jValue] == flowPhase3)
    cellsNext[iValue][jValue] = pollinatedFlowers;
}

void move(int iValue, int jValue, int i, int j){
  if (cellsNext[iValue][jValue] == grass){
    cellsNext[i][j] = grass;
    cellsNext[iValue][jValue] = bees;
  }
  else
    moveRandomly(i, j);
}

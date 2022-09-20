/* Oil Tanker Explosion
By: Matthew Zhou
Date: 3/12/2020
*/

//Can Change
int screenSize = 50; // How many cells we're getting
int fr = 5; // Frame rate

int amtFish = 20; // The lower the more fish there are. Lowest Value: 1
int probabilityOfReproduction = 2; // The higher the number the lower the probability. Lowest Value: 1
int rateOfOilSpread = 5; // The lower the faster. Lowest Value: 1
int amtOilSpills = 4; // How many oil tankers there are.
int maxOilOfTank = 50; // How much oil is in the boats
int maxBoatLife = 120; // How long the boats hang around for before they sink
String oilTankerPosition = "Random"; //Choices: "Random" "Corners" "Center"

//Don't Change
//Cell States//
color[][] cells;
color[][] cellsNext;
color[][] oilCellColor;
color[][] waterCellColor;
color[][] oilWaterCellColor;

int[][] cellAge;

//Oil Tanker Speeds
int xTankerS[][] = new int[screenSize][screenSize];
int xTankerSN[][] = new int[screenSize][screenSize];
int yTankerS[][] = new int[screenSize][screenSize];
int yTankerSN[][] = new int[screenSize][screenSize];

int iNext;
int jNext;

int xCen[] = new int[amtOilSpills];
int yCen[] = new int[amtOilSpills];

//Miscellaneous variables
float cellSize;
int counter = 0;
int random;
float random2;

int aliveFish = 0;
int amtTankers = amtOilSpills;

float padding = 100;

color red = color(255,0,0), blue = color(0,0,200), black = color(0,0,0), magenta = color(250,0,215), brown = color(140,35,35), blueBlack = color(0,0,0),
      orangeRed = color(255,69,0), orange = color(255,140,0), yellow = color(255,215,0);


void setup(){
  cells = new color[screenSize][screenSize];
  cellsNext = new color[screenSize][screenSize];
  cellSize = (width-2*padding)/screenSize;
  cellAge = new int[screenSize][screenSize];
  oilCellColor = new color[screenSize][screenSize];
  waterCellColor = new color[screenSize][screenSize];
  oilWaterCellColor = new color[screenSize][screenSize];
  
  size(1000,1000);
  
  frameRate( fr );
  //Setup first frame
  setWaterandFish();
  
  if (oilTankerPosition.equals("Center"))
    setOilTankersInCenter();
  
  else if (oilTankerPosition.equals("Corners"))
    setOilTankersInCorners();
  
  else
    setOilTankersRandomly();
    
  setOilTankerSpeeds();

}

void draw() {
  background(20);
    
  float y = padding;
  //Update statistics sidebar
  updateText();
  
  //Color each cell according to it's set value
  for(int i=0; i<screenSize; i++) {
    for(int j=0; j<screenSize; j++) {
      float x = padding + j*cellSize;
      
      if (cells[i][j] == black)
        fill(oilCellColor[i][j]);
      
      else if (cells[i][j] == magenta)
        fill(magenta);
        
      else if (cells[i][j] == brown)
        fill(brown);
        
      else if (cells[i][j] == red)
        fill(red);
        
      else if (cells[i][j] == blueBlack)
        fill(oilWaterCellColor[i][j]);
        
      else
        fill(waterCellColor[i][j]);
        
      rect(x, y, cellSize, cellSize);
    }
    y += cellSize;
  }
  
  //Get cell values
  getNextCells();
  
  //Assign cellsNext to cells
  for (int i = 0; i < screenSize; i++) {
    for (int j = 0; j < screenSize; j++) {
      cells[i][j] = cellsNext[i][j];
      xTankerS[i][j] = xTankerSN[i][j];
      yTankerS[i][j] = yTankerSN[i][j];
    }
  }
}

void getNextCells() {
  aliveFish = 0;
  amtTankers = 0;
  
  //A certain algorithm is enacted upon the cell depending on the cell's color
  for (int i = 0; i < screenSize; i++) {
    for (int j = 0; j < screenSize; j++) {
      int alive = countLivingFishNeighbours(i,j);
      int oil = countOilNeighbours(i,j);
      int boats = countBoats(i,j);
          
      //Fish
      if (cells[i][j] == magenta) {
        aliveFish += 1;
        
        //All the ways the fish can die
        if (alive > 3) {
          cellsNext[i][j] = blue;
          aliveFish -= 1;
        }
        
        else if (boats > 0) {
          cellsNext[i][j] = brown;
          aliveFish -= 1;
        }
          
        else if (oil > 3) {
          cellsNext[i][j] = brown;
          aliveFish -= 1;
        }
        
        //Random movement
        else if (alive == 0 || alive == 1) {
          int x = round(random(-1,1));
          int y = round(random(-1,1));
          
          cellsNext[i][j] = blue;
          try {
            for (int z = 0; z < 9; z++) {
              if (cellsNext[i+x][j+y] == black || cellsNext[i+x][j+y] == red) {
                x = round(random(-1,1));
                y = round(random(-1,1));
              }
            }
            cellsNext[i+x][j+y] = magenta;
          }
          catch (Exception e) {
            cellsNext[i][j] = magenta;
          }
        }
      }
      
      //Oil Tankers
      else if (cells[i][j] == red) {
        int yS = yTankerS[i][j];
        int xS = xTankerS[i][j];
        
        //Sinking
        if (counter > maxBoatLife) {
          cellsNext[i][j] = brown;
        }
        
        //Movement
        else {
          try {
            iNext = i;
            jNext = j;
            
            if (counter%3 == 0) {
              iNext = i + yS;
              jNext = j + xS;
            }
            
            if (counter < maxOilOfTank) {
              cellsNext[i][j] = black;
              cellAge[i][j] = 200;
            }
            
            else {
              if (oil > 1)
                cellsNext[i][j] = black;
              else
                cellsNext[i][j] = blue;
            }
            
            if (iNext > screenSize-(2) || iNext < (2)) {
              yS = -yS;
            }
            if (jNext > screenSize-(2) || jNext < (2)) {
              xS = -xS;
            }

            cellsNext[iNext][jNext] = red; 
            xTankerSN[iNext][jNext] = xS;
            yTankerSN[iNext][jNext] = yS;
          }
          
          catch ( Exception e ) {
              cellsNext[i][j] = blue;
              xTankerSN[i][j] = 0;
              yTankerSN[i][j] = 0;
          }
        }
      }
      
      //Oil Cells
      else if (cells[i][j] == black || cells[i][j] == blueBlack) {   
        if (counter % rateOfOilSpread == 0) {
          //Oil growing
          if (counter <= maxOilOfTank*2.25) {
            try {
              try {
                if (cellsNext[i+1][j] != red) {
                  cellsNext[i+1][j] = black;
                  if (200-cellAge[i+1][j] >= 0)
                    cellAge[i+1][j] += 10;
                
                  oilCellColor[i+1][j] = color(0,0,200-cellAge[i+1][j]);
                }
              }
              catch ( Exception e ) {}
              
              try {
                if (cellsNext[i-1][j] != red) {
                  cellsNext[i-1][j] = black;
                  if (200-cellAge[i-1][j] >= 0)
                    cellAge[i-1][j] += 10;
                
                  oilCellColor[i-1][j] = color(0,0,200-cellAge[i-1][j]);
                }
              }
              catch ( Exception e ) {}
              
              try {
                if (cellsNext[i][j+1] != red) {
                  cellsNext[i][j+1] = black;
                    if (200-cellAge[i][j+1] >= 0)
                    cellAge[i][j+1] += 10;
              
                  oilCellColor[i][j+1] = color(0,0,200-cellAge[i][j+1]);
                }
              }
              catch ( Exception e ) {}
              
              try {
                if (cellsNext[i][j-1] != red) {
                  cellsNext[i][j-1] = black; 
                  if (200-cellAge[i][j-1] >= 0)
                    cellAge[i][j-1] += 10;
              
                  oilCellColor[i][j-1] = color(0,0,200-cellAge[i][j-1]);
                }
              }
              catch ( Exception e ) {}
            }
            catch (Exception e) {}
          }
          
          //Oil fading away
          else {
            try {
              try {
                if (cellsNext[i+1][j] == black) {
                  if (cellAge[i+1][j] > 0) {
                    random = round(random(1,3));
                    cellAge[i+1][j] -= random;
                  }
                  else
                    cellsNext[i+1][j] = blue;
                
                  oilWaterCellColor[i+1][j] = color(0,0,200-cellAge[i+1][j]);
                }
              }
              catch ( Exception e ) {}
              
              try {
                if (cellsNext[i-1][j] == black) {
                  if (cellAge[i-1][j] > 0) {
                    random = round(random(1,3));
                    cellAge[i-1][j] -= random;
                  }
                  else
                    cellsNext[i-1][j] = blue;
                  
                  oilCellColor[i-1][j] = color(0,0,200-cellAge[i-1][j]);
                }
              }
              catch ( Exception e ) {}
              
              try {
                if (cellsNext[i][j+1] == black) {
                  if (cellAge[i][j+1] > 0) {
                    random = round(random(1,3));
                    cellAge[i][j+1] -= random;
                  }
                  else
                    cellsNext[i][j+1] = blue;
                  
                  oilCellColor[i][j+1] = color(0,0,200-cellAge[i][j+1]);
                }
              }
              catch ( Exception e ) {}
              
              try {
                if (cellsNext[i][j-1] == black) {
                  if (cellAge[i][j-1] > 0) {
                    random = round(random(1,3));
                    cellAge[i][j-1] -= random;
                  }
                  else
                    cellsNext[i][j-1] = blue;
                
                  oilCellColor[i][j-1] = color(0,0,200-cellAge[i][j-1]);
                }
              }
              catch ( Exception e ) {}
            }  
   
            catch (Exception e) {}
          }
        }
      }
      
      //Water cells 
      else {
        //Wave animation
        random = round(random(200,215));
        waterCellColor[i][j] = color(0,3,random);
        
        //Reproduction
        random = round(random(0,probabilityOfReproduction));
        if (alive == 3 && (random == probabilityOfReproduction || random == 0)) {
          cellsNext[i][j] = magenta;
          aliveFish += 1;
        }
        
        //Oil spreading immediately around the oil tanker
        if (counter < maxOilOfTank) {
          if (insideCircle(i,j, iNext, iNext, counter)) {
            try {
              cellAge[iNext+1][jNext] = 200;
              cellAge[iNext-1][jNext] = 200;
              cellAge[iNext][jNext+1] = 200;
              cellAge[iNext][jNext-1] = 200;
              
              cellsNext[iNext+1][jNext] = black;
              cellsNext[iNext-1][jNext] = black;
              cellsNext[iNext][jNext+1] = black;
              cellsNext[iNext][jNext-1] = black; 
            }
            catch (Exception e) {}
          }
        }
      }
    }
  }
  //Frame count
  counter +=1;
}

int countLivingFishNeighbours(int i, int j) {
  int count = 0;
  for ( int a = -1; a <= 1; a++ ) {
    for (int b = -1; b <= 1; b++) {
      try {
        if (cells[i+a][j+b] == magenta && (b != 0 || a != 0))
          count += 1;
      }
      catch (Exception e) {}
    }
  }
  return count;
}

int countBoats(int i, int j) {
  int count = 0;
  for ( int a = -1; a <= 1; a++ ) {
    for (int b = -1; b <= 1; b++) {
      try {
        if (cells[i+a][j+b] == red && (b != 0 || a != 0))
          count += 1;
      }
      catch (Exception e) {}
    }
  }
  return count;
}

int countOilNeighbours(int i, int j) {
  int count = 0;
  for ( int a = -1; a <= 1; a++ ) {
    for (int b = -1; b <= 1; b++) {
      try {
        if ((cells[i+a][j+b] == black && cellAge[i+a][j+b] >= 160) && (b != 0 || a != 0))
          count += 1;
      }
      catch (Exception e) {}
    }
  }
  return count;
}


boolean insideCircle(int x, int y, int xC, int yC, int r) {
  return sqrt(pow(x-xC,2) + pow(y - yC, 2)) <= r;
}

void setWaterandFish() {
  //For Water and Fish
  for(int i=0; i<screenSize; i++) {
    for(int j=0; j<screenSize; j++) {
      waterCellColor[i][j] = blue;
      oilWaterCellColor[i][j] = blueBlack;
      
      int x = round(random(0,screenSize));
      
      if (x < int(screenSize/amtFish))
        cells[i][j] = magenta;
          
      else
        cells[i][j] = blue;
        
    }
  }  
}

void setOilTankersInCorners() {
  //For each Oil Tanker
  for (int c = 0; c < amtOilSpills; c++) {
    random = round(random(0,3));
    if (random == 0) {
      xCen[c] = 4+c;
      yCen[c] = 4+c;
    }
    
    else if (random == 1) {
      xCen[c] = screenSize - 4-c;
      yCen[c] = 4+c;
    }
    
    else if (random == 2) {
      xCen[c] = screenSize - 4-c;
      yCen[c] = screenSize - 4-c;
    }
    
    else {
      xCen[c] = 4+c;
      yCen[c] = screenSize-4-c;
    }
    
    try {
      cells[xCen[c]+1][yCen[c]] = black;
      cells[xCen[c]-1][yCen[c]] = black;
      cells[xCen[c]][yCen[c]+1] = black;
      cells[xCen[c]][yCen[c]-1] = black;
      cells[xCen[c]][yCen[c]] = red;
    }
    catch ( Exception e ) {}
  }
}

void setOilTankersInCenter() {
  //For each Oil Tanker
  for (int c = 0; c < amtOilSpills; c++) {
    random = round(random(0,1));
    
    if (random == 1) {
      xCen[c] = int(screenSize/2)+c;
      yCen[c] = int(screenSize/2)+c;
    }
    else {
      xCen[c] = int(screenSize/2)-c;
      yCen[c] = int(screenSize/2)-c;
    }
    
    try {
      cells[xCen[c]+1][yCen[c]] = black;
      cells[xCen[c]-1][yCen[c]] = black;
      cells[xCen[c]][yCen[c]+1] = black;
      cells[xCen[c]][yCen[c]-1] = black;
      cells[xCen[c]][yCen[c]] = red;
    }
    catch ( Exception e ) {}
  }
}

void setOilTankersRandomly() {
  //For each Oil Tanker
  for (int c = 0; c < amtOilSpills; c++) {
    xCen[c] = int(random(0,screenSize));
    yCen[c] = int(random(0,screenSize));
    
    try {
      cells[xCen[c]+1][yCen[c]] = black;
      cells[xCen[c]-1][yCen[c]] = black;
      cells[xCen[c]][yCen[c]+1] = black;
      cells[xCen[c]][yCen[c]-1] = black;
      cells[xCen[c]][yCen[c]] = red;
    }
    catch ( Exception e ) {}
  }
}


void setOilTankerSpeeds() {
  //Oil Tanker Speeds 
  for (int a = 0; a < screenSize; a++) {
    for (int b = 0; b < screenSize; b++) {
      if (cells[a][b] == red) {
        random2 = random(0,1);
        if (random2 > 0.5)
          xTankerS[a][b] = 1;
        else
          xTankerS[a][b] = -1;
          
        random2 = random(0,1);
        if (random2 > 0.5)
          yTankerS[a][b] = 1;
        else
          yTankerS[a][b] = -1;
        }
        
      else {
        xTankerS[a][b] = 0;
        yTankerS[a][b] = 0;
      }
    }
  }
}


void updateText() {
  fill(255);
  textSize(12);
  text("Alive fish: " + aliveFish, 15, 200);
}

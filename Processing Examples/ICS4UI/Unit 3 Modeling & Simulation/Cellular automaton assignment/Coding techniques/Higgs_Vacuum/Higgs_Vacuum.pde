//USER CONTROLS
int vacuumRate = 5;
int n = 50;
float blinksPerSecond = 10;
float minBrightness = 80;
boolean greyScale = true;

//GLOBAL VARIABLES
float padding = 50;
float cellSize;
color black = color(0);

color[][] cells = new int[n][n];
color[][] cellsNext = new int[n][n];


void setup(){
  size(600,600); 
  frameRate( blinksPerSecond );
  cellSize = (width-2*padding)/n;
  noStroke();
  plantFirstGen();
}


void draw() {
  background(255);
  float y = padding;
  
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++) {
      float x = padding + j*cellSize;
      
      fill(cells[i][j]);
      stroke(cells[i][j]);
      rect(x, y, cellSize, cellSize);
    }
    
    y += cellSize;
  }
    
  //saveFrame("movie images/Vacuum movie-######.png");
  
  setNextGeneration();
  copyNextGenToCurrentGen();
}


void vacuumNeighbours(int i, int j) {
  for(int a = -1; a <= 1; a++) {
    for(int b = -1; b <= 1; b++) {
      try {
        color nc = cells[i+b][j+a]; //neighbour's colour
                  
        if (nc != black) {
          int R = int( red(nc) );
          int G = int( green(nc) );
          int B = int( blue(nc) );
          
          int avg = (R+G+B)/3;
          
          int rReduced = max( 0, avg - vacuumRate );
          //int gReduced = max( 0, G - vacuumRate );
          //int bReduced = max( 0, B - vacuumRate );
          
          cellsNext[i+b][j+a] = color( rReduced, rReduced, rReduced );
        }
      }
      
      catch( IndexOutOfBoundsException e ) {
      }
    }
  }
}


void setNextGeneration() {
  for(int i=0; i < n; i++) {
    for(int j=0; j < n; j++) {
      cellsNext[i][j] = cells[i][j];
    }
  }
      
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++) {
      if (cells[i][j] == black ) 
        vacuumNeighbours(i, j);
    }
  }
}


void mouseClicked() {
  int col = int((mouseX - padding)/cellSize);
  int row = int((mouseY - padding)/cellSize);
  cellsNext[row][col] = black;
  
  copyNextGenToCurrentGen();
  redraw();   //This forces Processing to re-draw the screen right away, without
              //waiting for the 30-frames-per-second rule to draw for me.
}

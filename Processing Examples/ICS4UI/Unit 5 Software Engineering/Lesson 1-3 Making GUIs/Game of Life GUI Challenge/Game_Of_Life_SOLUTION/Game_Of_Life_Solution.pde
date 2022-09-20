import g4p_controls.*;

int n;
float blinksPerSecond = 1;
int padding = 100;

boolean[][] cells, cellsNext;
int cellSize;
boolean paused = false, start = false;
boolean A = true, D = false;


void setup(){
  size(1000,1000);
  createGUI();
  
  n = int( gridSizeTextField.getText() );
  resetGrid();    
  
  stroke(255,0,0); 
  frameRate( blinksPerSecond );
  //plantFirstGenerationCheckerboard();
}


void resetGrid() {
  cellSize = (width-2*padding)/n;
  cells = new boolean[n][n];
  cellsNext = new boolean[n][n];
}


void draw() {
  if( !paused  ) {
      background(0,0,255);
      
      float y = padding;
      
      for(int i=0; i<n; i++) {
        for(int j=0; j<n; j++) {
          float x = padding + j*cellSize;
          
          if (cells[i][j])
            fill(255);
            
          else
            fill(0);
            
          rect(x, y, cellSize, cellSize);
        }
        y += cellSize;
      }
      
      setNextGeneration();
      copyNextGenerationToCurrentGeneration();
  }
}


void setNextGeneration(){
  int numAliveNeighbours;
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++) {
      numAliveNeighbours = countAliveNeighbours(i,j);
      if (cells[i][j])
        if (numAliveNeighbours == 2 || numAliveNeighbours == 3)
          cellsNext[i][j] = true;
        else
          cellsNext[i][j] = false;
          
      else
        if (numAliveNeighbours == 3)
          cellsNext[i][j] = true;
        else
          cellsNext[i][j] = false;
    }
   }
}


int countAliveNeighbours(int i,int j) {
  int count = 0;
  
  for(int a = -1; a <= 1; a++) {
    for(int b = -1; b <= 1; b++) {
      
      try {
        if (cells[i+a][j+b] && !(a==0 && b==0))
          count++;               
      }
      
      catch( IndexOutOfBoundsException e ) {
      }
    }
  }
  
  return count;
}


void copyNextGenerationToCurrentGeneration() {
    for(int i=0; i<n; i++) 
      for(int j=0; j<n; j++) 
        cells[i][j] = cellsNext[i][j];
}


void setCellValuesRandomly() {
  for(int i=0; i<n; i++) {
    
    for(int j=0; j<n; j++) {      
      int x = round(random(0,1));
      
      if (x == 0)
        cells[i][j] = false;
        
      else
        cells[i][j] = true;
    }
  }
}


void plantFirstGenerationCheckerboard() {
  boolean t = true;
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++) {      
        cells[i][j] = t;
        t = !t;
    }
  } 
}


void pauseSimulation() {
  paused = true;
  if( pauseButton.getText().equals("Pause") )
    pauseButton.setText("Go");
}


void turnOnSelectedCell() {
  int col = (mouseX - padding)/cellSize;
  int row = (mouseY - padding)/cellSize;

  int xUL = padding + cellSize * col;
  int yUL = padding + cellSize * row;
  
  cells[row][col] = true;
  
  fill(255);
  rect(xUL, yUL, cellSize, cellSize);
}


void toggleSelectedCell() {
  int col = (mouseX - padding)/cellSize;
  int row = (mouseY - padding)/cellSize;

  int xUL = padding + cellSize * col;
  int yUL = padding + cellSize * row;
  
  if( cells[row][col] ) {
    cells[row][col] = false;
    fill(0);
  }
  
  else {
    cells[row][col] = true;
    fill(255);
  }
  
  rect(xUL, yUL, cellSize, cellSize);
}


void mouseDragged() {
  pauseSimulation();
  turnOnSelectedCell(); 
}


void mouseClicked() {
  pauseSimulation();
  toggleSelectedCell(); 
}


void mousePressed() {
  pauseSimulation();
}



 

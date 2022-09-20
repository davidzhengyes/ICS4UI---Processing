int n = 40;
float blinksPerSecond = 2;
float padding = 50;
boolean A = true, D = false;

boolean[][] cells, cellsNext;
float cellSize;


void setup(){
  size(1000,1000);  
  frameRate( blinksPerSecond );
  //noStroke();

  cellSize = (width-2*padding)/n;
  cells = new boolean[n][n];
  cellsNext = new boolean[n][n];
  
  //setCellValuesAlternating();
  setCellValuesRandomly();
  //plantFirstGeneration();
}


void draw() {
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


void plantFirstGeneration() {
   cells[0][0] = A; cells[0][1] = D; cells[0][2] = D; cells[0][3] = A;
   cells[1][0] = D; cells[1][1] = A; cells[1][2] = D; cells[1][3] = D;
   cells[2][0] = D; cells[2][1] = A; cells[2][2] = A; cells[2][3] = D;
   cells[3][0] = D; cells[3][1] = A; cells[3][2] = D; cells[3][3] = D;
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
  
  for(int a = -1; a <= 1; a++) {  //a=-1, a = 0, a = 1
    for(int b = -1; b <= 1; b++) {  //b=-1, b=0,   b=1
      
      try {
        if (cells[i+a][j+b] == true && !(a==0 && b==0))
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


void setCellValuesAlternating() {
  boolean t = true;
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++) {      
        cells[i][j] = t;
        t = !t;
    }
  } 
}

 

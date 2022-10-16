int n=30;
float percentOfMines=0.005;
float howManyRocks=8;
int rockSize = 3;

color [][] cells = new color [n][n];
color [][] cellsNext = new color [n][n];

float cellSize;
float padding = 50;  
color currentCell;

void setup(){
  size(800,800);
  
  cellSize = (width-2*padding)/n;
  
  plantFirstGeneration();
  stroke(255);
  frameRate(3);
}




void draw() {
  
  
  background(255, 255, 0);
  float y = padding;

  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      float x = padding + j*cellSize;

      fill( cells[i][j] );        
      rect(x, y, cellSize, cellSize);
    }

    y += cellSize;
  }
  setNextGeneration();
  copyNextCellsToCells();
}


void plantFirstRocks(){
  for (int i=0; i<howManyRocks; i++){
    int xpos=round(random(0,n));
    int ypos=round(random(0,n));
    for (int j=0; j<rockSize; j++){
      for (int k=0; k<rockSize; k++){
        try{
          
          currentCell = cells[xpos+j][ypos+k];
          
          if (currentCell != color(255,255,0)){
            
          cells[xpos+j][ypos+k] = color(100);
          cellsNext[xpos+j][ypos+k]=color(100);
          
          }
        }
        catch (Exception e){
        }
        
        
      }
    }
  }
}
void plantFirstGeneration(){
  for(int i=0; i<n; i++){
    for (int j=0; j<n; j++){
      
      float rand = random(0,1);
      
      if (rand<percentOfMines){
        
        cells[i][j]=color(255,255,0);
        cellsNext[i][j]=color(255,255,0); //fills both arrays so dont have to calculate every single cell every iteration of draw()
        
      }
      
      else{
        cells[i][j]=color(0,255,0);
        cellsNext[i][j]=color(0,255,0);
      }
    }
  }
  
  plantFirstRocks();
  
  
}

void copyNextCellsToCells(){
  for (int i=0; i<n; i++){
    for (int j=0; j<n; j++){
      cells[i][j]=cellsNext[i][j];
    }
  }
}

void setNextGeneration () {
  for (int i=0; i<n; i++){
    for (int j=0; j<n; j++){
      color colour = cells[i][j];
      
      
      if (red(colour)>0 && green(colour) >=0 && blue(colour)==0 ){
      
        for (int k=-1; k<2; k++){
          for (int l=-1; l<2; l++){
            
            try {
              if (cells[i+k][j+l] == color(0,255,0)){
                cellsNext[i+k][j+l]=color(red(colour)-75,0,0);
              }
            }
            catch(Exception e){
            }
            
          }
          
        }
        
      }
    }
  }
}

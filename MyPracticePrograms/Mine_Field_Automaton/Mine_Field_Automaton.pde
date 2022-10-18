int n=30;
int numberOfMines=1; 
float howManyRocks=15;
int rockSize = 5;
int blastRadius=5;


int[] minePos = new int [numberOfMines*2];
color [][] cells = new color [n][n];
color [][] cellsNext = new color [n][n];

float cellSize;
float padding = 50;  
color currentCell;
int blastTime=1;

void setup(){
  size(800,800);
  
  cellSize = (width-2*padding)/n;
  
  plantFirstGeneration();
  printArray(minePos);
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
        cells[i][j]=color(0,255,0);
        cellsNext[i][j]=color(0,255,0);
      
    }
  }
  
  for (int i=0; i<numberOfMines;i++){
    int x=int(random(0,n));
    int y=int(random(0,n));
    cells[x][y]=color(255,255,0);
    cellsNext[x][y]=color(255,255,0);
    minePos[i*2]=x;
    minePos[i*2+1]=y;
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


void setNextGeneration(){
  for (int i=0; i<n; i++){
    for (int j=0; j<n; j++){
      color colour = cells[i][j];
      
      
      if (red(colour)>0 && green(colour) >=0 && blue(colour)==0 ){
      
        for (int k=-1; k<2; k++){
          for (int l=-1; l<2; l++){
            
            try {
              if (cells[i+k][j+l] == color(0,255,0) && (k==0 || l==0)){
                cellsNext[i+k][j+l]=color(red(colour)-15,0,0);
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




//** Circular explosion motion but doesn't model going around rocks as well**//
//void setNextGeneration () {
//  print("run");
//  for (int i=0; i<numberOfMines; i++){
//    int x=minePos[i*2];
//    int y=minePos[i*2+1];
//    for (int j=(x-blastTime-2); j<(x+blastTime+2);j++){
//      for (int k=(y-blastTime-2); k<(y+blastTime+2); k++){
//        try{
//          color colour=cells[j][k];
//          float distance=sqrt(pow((j-x),2)+pow((k-y),2));
//          if (colour==color(0,255,0) && distance<blastTime+1){
//            cellsNext[j][k]=color(255,0,0);
//          }
//        }
//        catch(Exception e){
//        }
//      }
//    }
    
//  }
//  if (blastTime<blastRadius)
//  blastTime++;
//}

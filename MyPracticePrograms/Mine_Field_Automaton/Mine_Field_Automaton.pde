int n=30;
int numberOfMines=1; 
float howManyRocks=15;
int rockSize = 5;
int regenerationRate=20;
int blastRadius=20;

int[] minePos = new int [numberOfMines*2];
color [][] cells = new color [n][n];
color [][] cellsNext = new color [n][n];

int blastTime=1;
float cellSize;
float padding = 50;  
color currentCell;

int redDelta,greenDelta,blueDelta;

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
      
      
      if (red(colour)>0 && green(colour) >=0 && blue(colour)!=100 && blastTime<blastRadius){
      
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
      
      
      
      
      color nextColour=cellsNext[i][j];
      if (green(nextColour)!=255 && nextColour!=color(100) && blue(colour)!=255){ //59,30,8
        if (red(nextColour)-regenerationRate>59){
          redDelta = -1*regenerationRate;
          
        }
        else if (red(nextColour)+regenerationRate<59){
          redDelta = regenerationRate;
          
        }
        else{
          redDelta=0;
        }
        
        if (green(nextColour)-regenerationRate>30){
          greenDelta = -1*regenerationRate;
        }
        else if (green(nextColour)+regenerationRate<30){
          greenDelta = regenerationRate;
        }
        else{
          greenDelta=0;
        }
        
        if (blue(nextColour)-regenerationRate>8){
          blueDelta = -1*regenerationRate;
        }
        else if (blue(nextColour)+regenerationRate<8){
            blueDelta = regenerationRate;
        }
        else{
          greenDelta=0;
        }
        
       cellsNext[i][j]=color(red(nextColour)+redDelta,green(nextColour)+greenDelta,blue(nextColour)+blueDelta);
        
      }
      
    }
  }
  blastTime++;
  
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

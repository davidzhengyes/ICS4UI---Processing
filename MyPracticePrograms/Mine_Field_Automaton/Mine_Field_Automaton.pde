int n=30;
int numberOfMines=8; 
float howManyRocks=15;
int rockSize = 5;
int regenerationRate=20;
int explosionRadius = 17;

//stil have to do 
//uniform bomb placement? , add in regeneration; probability of explode maybe change colour

boolean stillExploding = true;

color [][] cells = new color [n][n];
color [][] cellsNext = new color [n][n];
int [][] robotVisits = new int [n][n];
int currentRobotX=0, currentRobotY=0;

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
  frameRate(10);
}




void draw() {
  
  
  background(255, 255, 0);
  float y = padding;

  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      float x = padding + j*cellSize;
      
      if(i==currentRobotX && j==currentRobotY){
        fill(color(255));
      }
      else{
        fill( cells[i][j] );  
      }
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
          
          if (currentCell != color(0,0,255)){
            
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
    cells[x][y]=color(0,0,255);
    cellsNext[x][y]=color(0,0,255);

  }
  
  plantFirstRocks();
  robotVisits[0][0]=1;

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
      boolean interactCheck=false;
      
      if (red(colour)>0  && blue(colour)!=100){
      //if the current cell being checked has "energy", as in if it has some red, but not a rock
      
        for (int k=-1; k<2; k++){
          for (int l=-1; l<2; l++){
            
            try {
              if ( (k==0 || l==0)){ 
                //checking cells around, if the current cell is more red than the next cell's neighbour but is not a rock or an unexploded mine
                if (red(cells[i][j]) > red(cellsNext[i+k][j+l]) && cells[i+k][j+l]!=color(100) && blue(cellsNext[i+k][j+l])!=255) {
                  //then reduce the red by a step of the next cell by a factor of the explosion radius
                  cellsNext[i+k][j+l]=color(red(colour)-255/(explosionRadius-1),0,0);
                }
              }
              
              if (blue(cells[i+k][j+l]) ==255 && red(cells[i+k][j+l])==0){
                int distanceFromExplosion = int((255-red(colour))/(255/explosionRadius-1))+1;
                
                float rand=random(0,0.6);
                
                if (rand>(float(distanceFromExplosion)/explosionRadius) && interactCheck ==false) {
                  println(frameCount, distanceFromExplosion,rand);
                  cellsNext[i+k][j+l]=color(255,255,0);
                  
                }
                interactCheck=true;
              }
              
            
            }
            catch(Exception e){
            }            
          }          
        } 
      }
      
      
      
      
      color nextColour=cellsNext[i][j];
      if (green(nextColour)!=255 && nextColour!=color(100) && blue(colour)!=255 && stillExploding ==false){ //59,30,8
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
  
  
  int[]robotNeighbours=new int[9];
  for (int i=-1; i<2; i++){
    for (int j=-1; j<2; j++){
      try{
        
        //robotNeighbours array is sequentially through the 3x3 grid of neighbours
        robotNeighbours[(i+1)*3+j+1]=999; //set every index to 999
        robotNeighbours[(i+1)*3+j+1] = robotVisits[currentRobotX+i][currentRobotY+j]; //overwrite the ones that actually have a value (not in the border)
        
      }
      catch(Exception e){ 
      }
    }
  }
  robotNeighbours[4]=999; //don't consider center cell
  
  int minimum=999;
  for (int i=0; i<robotNeighbours.length;i++){
    if (robotNeighbours[i]<minimum){
      minimum=robotNeighbours[i];
    }
  }
  
  
  int minimumIndex=0;
  
  int randIndex=int(random(0,9));
  for (int i=randIndex; i<randIndex+robotNeighbours.length; i++){
    if(robotNeighbours[i%9]==minimum){
      minimumIndex=i%9;
      break; 
    }
    
  }
  
  //after choosing random, goes back to grid position with these formulas
  int i = (minimumIndex-(minimumIndex%3))/3-1;
  int j= minimumIndex%3-1;
  
  robotVisits[currentRobotX+i][currentRobotY+j]+=1;
  currentRobotX+=i;
  currentRobotY+=j;
 
  
  
}

//Controls
//SPACE - Pause/Unpause
//ENTER - Step by 1 generation

int n = 100;                 //Sets how many cells high and wide the simulation will be
int waterLevel = 30;         //Sets the initial water level
float heat1 = 0.05;          //Sets the probability that a bottom row water cell will be heated (single or double)
float heat2 = heat1 * 0.05;  //Sets the probability that a bottom row water cell will be double heated
int fps = 30;                //Sets the frame rate
boolean open = true;         //Sets whether or not steam will be able to escape from the top of the window
boolean paused = false;      //Sets whether the simulation starts out in a paused or unpaused state

//Change the colors for any of the possible states
color thinSteam   = 255;
color denseSteam  = 135;
color air         = 0;
color hotWater   = color(0,0,255);
color warmWater   = color(0,0,180);
color coldWater    = color(0,0,128);
color[] colors = { thinSteam, denseSteam, air, hotWater, warmWater, coldWater };

int[][] cells;
float cellSize;

void setup(){
  cells = new int[n][n];
  size(600,600);
  cellSize = float(width)/n;
  frameRate( fps );
  noStroke();
  
  for (int row = 0; row<n; row++){
    for (int col = 0; col<n; col++){
      if (row > n-waterLevel-1){
        cells[row][col] = 5;
      }
      else{
        cells[row][col] = 2;
      }
    }
  }
  if (paused) noLoop();
}


void draw() {
  for (int row = 0; row<n; row++){
    for (int col = 0; col<n; col++){
      float x = col*cellSize;
      float y = row*cellSize;
      fill(colors[cells[row][col]]);
        
      rect(x, y, cellSize, cellSize);
    }
  }
  cells = getNextGen(cells);
  
  
}

int[][] getNextGen( int[][] thisGen ){
  
  //Make a copy of thisGen without having nextGen refer to the same array
  int[][] nextGen = new int[n][n];
  for (int i = 0; i<n; i++){
    for (int j = 0; j<n; j++){
      nextGen[i][j] = thisGen[i][j];
    }
  }
  
  
  //Handles top and bottom layer
  for (int i = 0; i < n; i++){
    
    
    //Heating bottom layer
    float chance = random(0,1);
    
    //Double Heating
    if ( chance<heat2){
      if( nextGen[n-1][i] == 5 || nextGen[n-1][i] == 3){
        nextGen[n-1][i] -= 2;
      }
      else if ( nextGen[n-1][i] == 4){
        nextGen[n-1][i] -= 3;
      }
    }
    
    //Single heating
    else if ( chance < heat1 ){
      if (  nextGen[n-1][i] == 4 || nextGen[n-1][i] == 5 ){
        nextGen[n-1][i]-=1;
      }
      else if (nextGen[n-1][i] == 3){
        nextGen[n-1][i]-=2;
      }
    }
    
    //Removing top layer
    if(open){
      nextGen[0][i] = 2;
    }
  }

  

  for (int row = 1; row<n; row++){
    for (int col = 0; col<n; col++){
      
      
      //Handles steam expansion
      boolean expanded = false;
      if( thisGen[row][col] == 1 ) {
        
        boolean water = false;
        
        for( int a=-1; a<=1; a++ ) {
          for( int b=-1; b<=1; b++ ) {
            
            //Checks for water in nearby cells
            try {
              if( thisGen[row+a][col+b] >= 3 && thisGen[row+a][col+b] <= 5 ) {
                water = true;
              }
            }
            catch( Exception e ){
            }
          }
        }
        //Expands steam if there's no water nearby
        if( !water ) {
          expanded = true;
          for( int a=-1; a<=1; a++ ) {
            for( int b=-1; b<=1; b++ ) {
              try {
                nextGen[row+a][col+b] = 0;
              }
              catch( Exception e ) {
              }
            }
          }
        }
      }
      
      
      //Makes lower density cells rise
      if( thisGen[row][col] < thisGen[row-1][col] && !expanded) {
        nextGen[row][col] = thisGen[row-1][col];
        nextGen[row-1][col] = thisGen[row][col];
      }
    }
  }

  return nextGen;
}

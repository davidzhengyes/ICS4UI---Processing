//User settings
int n = 30;       
float cellSize;
int padding = 50;
float frames = 1;
color yellow = color(255, 229, 153);
color crop = color(173, 132, 100);
color dirt = color(61, 29, 9);
int q = 3;

//global variables
color[][] cells = new color[n][n];
color[][] nextCells = new color[n][n];

int[][] ySpeed = new int[n][n];
int[][] ySpeedNext = new int[n][n];

int[][] xSpeed = new int[n][n];
int[][] xSpeedNext = new int[n][n];
boolean[][] hasLocust = new boolean[n][n]; //not really needed?


void setup() {
  size(500, 500);
  frameRate(1);
  cellSize = (width-2*padding)/n;
  setCrops();
}

void setCrops() {
  //hasLocust[1][1] = true;
  
  for(int i=0; i<n; i++){
    for(int j=0; j<n; j++){
      
      float rand = random(0,1);
      if(rand < 0.04) {
        hasLocust[i][j] = true;
        cells[i][j] = yellow;
        xSpeed[i][j] = round(random(-1, 1));
        ySpeed[i][j] = round(random(-1, 1));
        
        if(xSpeed[i][j] == 0 && ySpeed[i][j] == 0)
          xSpeed[i][j] = 1;        
      }
      
      else {
        cells[i][j] = dirt;
        xSpeedNext[i][j] = 0;
        ySpeedNext[i][j] = 0;
        if(rand <= 0.8)
          cells[i][j] = crop;
      } 
    }
  }
}


void draw(){
  float y = padding;
  
  for(int i=0; i<n; i++){
    for(int j=0; j<n; j++){
      float x = padding + j*cellSize;
      
      fill(cells[i][j]);
      square(x,y, cellSize);
    }
    
    y+=cellSize;
  }
  
  //setCrops();
  nextGen();
  moveArrays();
}


void nextGen(){
  scrubNext();
  
  for(int i=0; i<n; i++){
    for(int j=0; j<n; j++){
      //makes this move up by one
      //ySpeed[i][j], I also have ySpeedNext[i][j]
      if(cells[i][j] == yellow){
        try{
          int ii = i + ySpeed[i][j];
          int jj = j + xSpeed[i][j];
         
          nextCells[ii][jj] = yellow;
          ySpeedNext[ii][jj] = ySpeed[i][j];
          xSpeedNext[ii][jj] = xSpeed[i][j];
        }
        catch(Exception e){
          nextCells[i][j] = dirt;
          xSpeedNext[i][j] = 0;
          ySpeedNext[i][j] = 0;
        }
        //change the x and y positistion. 
        //then if its around crop eat crops.(that means change it to dead colour)
        
        if( nextCells[i][j] != yellow ) {  //TURN WHATEVER CELL THE LOCUST JUST LEFT INTO DIRT (AS LONG AS ANOTHER LOCUST HASN'T ALSO MOVED ONTO THAT CELL FROM ANOTHER DIRECTION)
          nextCells[i][j] = dirt;
          xSpeedNext[i][j] = 0;
          ySpeedNext[i][j] = 0;
        }
      }
      
      
      else {
        nextCells[i][j] = cells[i][j];
        xSpeedNext[i][j] = 0;
        ySpeedNext[i][j] = 0;
      }
      
     
    }
  }
}

void moveArrays() {
  for(int i = 0; i<n; i++){
    for(int j = 0; j<n; j++){
      cells[i][j] = nextCells[i][j];
      xSpeed[i][j] = xSpeedNext[i][j];
      ySpeed[i][j] = ySpeedNext[i][j];
    }
  }
}

void scrubNext() {
  nextCells = new color[n][n];
  xSpeedNext = new int[n][n];
  ySpeedNext = new int[n][n];
}

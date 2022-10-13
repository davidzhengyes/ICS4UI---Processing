int n=10;
float percentOfMines=0.01;
float howManyRocks=5;
int rockSize = 2;

color [][] cells = new color [n][n];
color [][] cellsNext = new color [n][n];

float cellSize;
float padding = 50;  


void setup(){
  size(800,800);
  
  cellSize = (width-2*padding)/n;
  
  plantFirstGeneration();
  
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
}


void plantFirstGeneration(){
  for(int i=0; i<n; i++){
    for (int j=0; j<n; j++){
      
      float rand = random(0,1);
      
      if (rand<percentOfMines){
        
        cells[i][j]=color(255,255,0);
      }
    }
  }
}

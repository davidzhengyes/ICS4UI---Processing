int n = 20;
boolean[][] cells = new boolean[n][n];
float pad = 50;
float cellSize;

void setup(){
  size(500,500);
  cellSize = (width-2*pad)/n;
  frameRate( 2 );  
  
  setCellValuesRandomly();  //SETS THE CELLS RANDOMLY FOR THE FIRST GENERATION
}

void draw() {
  background(0);
  
  float y = pad; //the top of the grid
  
  for(int i = 0; i < n; i++) {  //
    float x = pad;
    
    for(int j = 0; j < n; j++) {
      if ( cells[i][j] == true ) 
        fill(255,0,255);
        
      else
        fill(255);
        
      square(x, y, cellSize);   
      
      x += cellSize;
    }
    
    y += cellSize;
  }
  
  
  setCellValuesRandomly();  //IN Game of Life, WE'LL REPLACE THIS RANDOMIZED RE-SETTING
                            //WITH A PROCEDURE THAT USES THE RULES OF THE GAME
                            //TO SET THE NEXT GENERATION'S CELLS
}


void setCellValuesRandomly() {
  for(int i = 0; i < n; i++) {
    
    for(int j = 0; j < n; j++) {      
      int x = round(random(0, 1));
      
      if (x == 0)
        cells[i][j] = false;
        
      else
        cells[i][j] = true;
    }
  }
}

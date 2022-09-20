int n = 10;
float blinksPerSecond = 0.5;

//STARTING COLOURS
boolean randomStart = true;
color startingColour = color(255,0,0);

//REBELLION
float probabilityOfRebellion = 0.00;
color rebelColour = color(255,255, 0); //yellow

float padding = 90;
float cellSize;

color[][] cells = new color[n][n];
color[][] cellsNext = new color[n][n];


void setup(){
  size(800,800); 
  frameRate( blinksPerSecond );
  noStroke();
  cellSize = (width-2*padding)/n;
  
  plantFirstGeneration();
  //noLoop();
}


void draw() {
  background(10);
  float y = padding;
  
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++) {
      float x = padding + j*cellSize;
      
      fill( cells[i][j] );        
      rect(x, y, cellSize, cellSize);
    }
    
    y += cellSize;
  }
  
  setNextGeneration();
  copyNextGenerationToCurrentGeneration();
}


void plantFirstGeneration()  {
    color reddish = color(150,20,20), myFavGreen = color(10,255,120), blue = color(0,0,255), 
          yellow = color(255,255,0),  someGrey = color(50,50,50),     pink = color(255, 200, 200), 
          magenta = color(255,0,255), cyan = color(0,255,255),        burntOrange = color(219,112,4);
    
    if( randomStart ) {
      color[] initialChoices = {reddish, myFavGreen, someGrey, 
                                burntOrange, blue, yellow, 
                                magenta, cyan, pink};
                                
      for (int i = 0; i < n; i++) 
        for (int j = 0; j < n; j++) {
           int rand = int(random( 0, initialChoices.length ));
           cells[i][j] = initialChoices[ rand ];           
        }  
    }
                
    else {
      for (int i = 0; i < n; i++) 
         for (int j = 0; j < n; j++)                   
            cells[i][j] = startingColour; 
    }
}


void setNextGeneration(){
  float randX;
  
  for(int i=0; i<n; i++) {
  
    for(int j=0; j<n; j++) {
      randX = random(0,1);
      
      if( randX <= probabilityOfRebellion)
        cellsNext[i][j] = rebelColour;
        
      else
        cellsNext[i][j] = getSurroundingAverageColour(i, j); 
    }
  }
}


color getSurroundingAverageColour(int i, int j) {
    float r = 0, g = 0, b = 0;
    int count = 0;
    
    for(int x = -1; x <= 1; x++) {
      for(int y = -1; y <= 1; y++) {
        try {
            r += red(cells[i+x][j+y]); 
            g += green(cells[i+x][j+y]); 
            b += blue(cells[i+x][j+y]); 
            count++;
        }
        
        catch( IndexOutOfBoundsException e ) {
        }
      }
    }
    
    float avgRed = r/count;
    float avgGreen = g/count;
    float avgBlue = b/count;
    
    return color(avgRed, avgGreen, avgBlue);
}


void copyNextGenerationToCurrentGeneration() {
    for(int i=0; i<n; i++) 
      for(int j=0; j<n; j++) 
        cells[i][j] = cellsNext[i][j];
}


void mouseDragged() {
  int col = int((mouseX - padding)/cellSize);
  int row = int((mouseY - padding)/cellSize);
  cellsNext[row][col] = rebelColour;
  copyNextGenerationToCurrentGeneration();
  redraw(); //this forces Processing to re-draw the screen right away, withou
            //waiting for the 30-frames-per-second rule to draw for me.
}

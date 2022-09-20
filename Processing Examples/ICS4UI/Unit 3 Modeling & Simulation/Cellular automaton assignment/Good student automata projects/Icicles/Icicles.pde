int n = 100;
float meltingProbability = 0.01;
int animSpeed = 30;
float IcicleSize;
int padding = 0;
float wallProbability = 0.10;

color[][] cells = new color[n][n];
color[][] cellsNext = new color[n][n];

color LightBlue = color(173, 216, 230);
color White = color(255);
color DarkBlue = color(0, 100, 255);


void setup() {
  size(600, 600);
  frameRate(animSpeed);
  noStroke();
  IcicleSize = (width-2*padding)/n;

  plantFirstGeneration();
}


void draw() {  
  background(225, 225, 225);  
  float y1 = padding;      

  for (int i = 0; i < n; i++ ) {
    for (int j=0; j< n; j++) {
      float x1 = padding + j*IcicleSize;  
      fill( cells[i][j] );
      square(x1, y1, IcicleSize);
    }
    y1 += IcicleSize;
  }
 
  setNextGen();
  copyNextGenIntoCurrentGen();
  meltTips();
}


void plantFirstGeneration() {
  println("First");
  for (int i = 0; i<n; i++) {
    for (int j =0; j<n; j++) {

      if (i == 0) 
        cells [i][j] = LightBlue;
      
      else {
        if (cells[i-1][j] == LightBlue) {
          float r = random(0, 1);
          
          if (r <= wallProbability) 
            cells[i][j] = White;
          
          else 
            cells[i][j] = LightBlue;
          
        } 
        else 
          cells[i][j] = White;
        
      }
    }
  }
}


void meltTips() {
  for (int j=0; j<n; j++) {
    int i = 0;

    while (cells[i][j] == LightBlue) {
      if( i != n-1  ) 
        i++;
    }  
   
    if (i > 0) {
      float rand = random(0,1);
      if( rand < meltingProbability )
        cells[i-1][j] = DarkBlue;   
    }
  }
}


void setNextGen() {
  for (int i = 0; i < n; i++){
    for (int j = 0; j < n; j++){
          
       if (cells[i][j] != DarkBlue ) {
         if ( cellsNext[i][j] != DarkBlue ) 
           cellsNext[i][j] = cells[i][j];
       }

       else {
         if( i != n - 1 )
           cellsNext[i + 1][j] = DarkBlue;
           
         cellsNext[i][j] = White;
       }
    }
  }
}


void copyNextGenIntoCurrentGen() {
  for (int i = 0; i<n; i++){      
      for (int j = 0; j<n; j++){            
        cells[i][j] = cellsNext[i][j];  
    }
  }
}

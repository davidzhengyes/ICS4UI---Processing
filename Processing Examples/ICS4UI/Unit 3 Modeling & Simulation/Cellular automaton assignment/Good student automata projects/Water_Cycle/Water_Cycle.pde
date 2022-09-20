//This page just runs the program and holds global variables

int FramesPerSecond=3;
int n=20;
color ground = color(173,107,66), rain = color(91,66,173), Lake= color(66,68,173), River= color(66,95,173), Sea= color(66,148,173), waterVapor= color(201,201,255), cloud= color(232,232,255), sky= color(4,0,255);
color[][] cells= new color[n][n];
color[][] NextCells= new color[n][n];

float cellSize;

void setup() {
  size(800, 800); 
  frameRate( FramesPerSecond );
  cellSize = width/n;
  noStroke();
  
  setStart();//sets up the first frame
  cells[12][19]=rain; //used to test the rain and river. Will be taken out in final product
  
}

void draw(){
  background(4,0,255);

  float y = 0;
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      float x = j*cellSize;
      
        fill(cells[i][j]);
      
      
      
      rect(x,y, cellSize, cellSize);
      
    }
    y+= cellSize;
  }
  
  testCells(); //Makes changes to the next generation
  NextGen();//loads the next generation
}

void NextGen(){
  for (int i=0; i<n; i++) {

    for (int j=0; j<n; j++) {  
      cells[i][j]=NextCells[i][j];  
    }
  }
  

}

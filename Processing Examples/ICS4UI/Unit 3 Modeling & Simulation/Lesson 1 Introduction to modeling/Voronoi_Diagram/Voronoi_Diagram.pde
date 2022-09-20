PVector[] p;
int numPoints;
int maxNumPoints = 150;
int numShades = 150;
boolean drawSeeds = true;
int n;
color[] colorSet;
color[][] pixelColors;


void setup(){
  size(500,500);
  background(255);
  noLoop();
  p = new PVector[maxNumPoints];
  colorSet = new color[maxNumPoints];
  
  makeColorsRandom( numShades );
  //makeColorsBW( numShades );
  //makeColorsContinuous( numShades );
  
  n = 0; 
    
  pixelColors = new color[width][height];
  setInitialPixelColors();
  
  //setPointsLine(0, 400, width, 400);
  setPointsCircle( numShades, width/2, 1);
  calculatePixelColors();
}


void makeColorsBW(int numShades){
  for(int i=0; i < numShades; i++){
    if (i % 2 == 0 ){
      colorSet[i] = color(0,0,0);
    }
    
    else {
      colorSet[i] = color(255,255,255);
    }
  }
}


void makeColorsContinuous(int numShades){
  float r1 = 0; //255;
  float g1 = 0; //150;
  float b1 = 0; //50;
  
  float r2 = 255; //100;
  float g2 = 255; //0;
  float b2 = 255; //255;
  
  float dr = (r2-r1)/numShades;
  float dg = (g2-g1)/numShades;
  float db = (b2-b1)/numShades;
  
  float red = r1;
  float green = g1;
  float blue = b1;
  
  for(int i=0; i < numShades; i++){
    red += dr; 
    green += dg;
    blue += db;
    colorSet[i] = color(red,green,blue);
  }
}


void makeColorsRandom(int numShades){
  for(int i=0; i < numShades; i++){
    int red = int(random(1,254));
    int green = int(random(1,254));
    int blue = int(random(1,254));
    colorSet[i] = color(red,green,blue);
  }
}


void setInitialPixelColors() {
  for(int i=0; i<width; i++){
      for(int j=0; j<width; j++){
        pixelColors[i][j] = color(255);
    }
  }
}


void draw() {
    background(0);
    println("Calling draw");
    for(int i=0; i < width; i++){
      for(int j=0; j< height; j++){
        stroke(pixelColors[i][j]);        
        point(i,j);
      }
    }
    
    fill(0);
    noStroke();
    
    if( drawSeeds ) {
      for(int k=0; k<n; k++){
        ellipse(p[k].x, p[k].y, 5, 5);
        println("y", p[k].x);
      }
    }
}

void setPointsLine(float x1, float y1, float x2, float y2) {
  float x=x1, y=y1;
  float dx = (x2-x1)/maxNumPoints, dy = (y2-y1)/maxNumPoints;
  n=1;
  p[0] = new PVector(width/2, height/2);
  for(int i=1; i<maxNumPoints; i++){
    p[i] = new PVector(x, y);
    x += dx;
    y += dy;
    n++;
  }
}


void calculatePixelColors() {
  for(int i=0; i< width; i++){
    for(int j=0; j< height; j++){
      
      float minDist = 2*width;
      int kBest = n;
      
      for(int k=0; k < n; k++){
        float d = dist(i, j, p[k].x, p[k].y);
        if (d < minDist){
          kBest = k;
          minDist = d;
        }
      }
      
      pixelColors[i][j] = colorSet[kBest];
    }
  }
}


void mouseClicked(){
  p[n] = new PVector(mouseX, mouseY);
  n++;
  calculatePixelColors();
}


void setPointsCircle(int numPoints, float r, float numWraps){
  float dTheta = 2*PI/numPoints*numWraps;
  float a = pow(0.1, (float)1/numPoints);
  float dRadius = r/numPoints;
  float xC = width/2;
  float yC = height/2;
 
  for(int k=0; k < numPoints; k++){
    n++;
    float x = -70+k*width/(numPoints-70); x = xC + r*cos(k*dTheta); x = k*width/numPoints;//
    float y = yC - r/3*sin(3*k*dTheta);
    p[k] = new PVector(x,y);
    //r = r*a;
    //r -= dRadius;
  }
}

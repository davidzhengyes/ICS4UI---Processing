float[][] myData;
boolean animate = false;
float a = 0.0;

void setup() {
  size(600,600);
  myData = new float[3200][2];
  
  if( animate ) {
    a = 0;
  }
  
  else {
    a = 0.2;
    noLoop();
  }
}

void draw() {
  
  for(int i=0; i < myData.length; i++) {
    float x = i*0.5;
    float y = f(x);
    myData[i][0] = x;
    myData[i][1] = y;    
  } 
  
  background(0);
  fill(255);
  noStroke();
  
  for(int i=0; i < myData.length; i++) {
    ellipse( myData[i][0], myData[i][1], 2, 2);
  }
  
  a += .0005;
}


float f(float x) {
  return 0.001*pow(x,2)*sin(a*x)+300;
}

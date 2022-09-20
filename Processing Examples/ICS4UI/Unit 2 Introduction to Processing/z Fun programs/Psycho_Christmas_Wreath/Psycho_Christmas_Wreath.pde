
//PARAMETERS - TRY CHANGING THESE
int n = 200;
float maxFreq = 12;
float minFreq = 0.25;
float radialRatio = .75; //RATIO OF THE INNER RADIUS TO THE OUTER RADIUS. SHOULD BE 0-1
color[] colors = {color(255,0,0), color(0,100,0), color(255)};

//CALCULATED VALUES - DON'T CHANGE THESE
float xC; 
float yC;
float[] r;
float A; 
float R_mid;
float minRadius, maxRadius;
float[] B;
float ballSize;
float t = 0.0;
float timeBetweenFrames = .06;
float freqDiff = (maxFreq-minFreq)/(2*n-1);
float dTheta = 2*PI/n;


void setup(){
  noStroke();
  size(800,800);
  maxRadius = height/2.1;
  minRadius = radialRatio * maxRadius;
  A = (maxRadius-minRadius)/2;
  R_mid = (maxRadius+minRadius)/2;
  ballSize = 2*PI*maxRadius/n;
  
  xC = width/2;
  yC = height/2;
  r = new float[n];
  B = new float[n];
  
  float b = minFreq;
  
  for( int i = 0; i < n/2; i++ ){
    B[i] = b;
    b += freqDiff;
  }
  
  for( int i = n/2; i < n; i++ ){
    B[i] = b;
    b -= freqDiff;
  }
}


void draw() {
  background(0);
  noStroke(); 
  float theta = 0;
  
  for( int i = 0; i < n; i++ ){
    float radius = A * sin(B[i]*t) + R_mid;
    float xBall = xC + radius*cos(theta); 
    float yBall = yC - radius*sin(theta); 
    
    color c = color(colors[i%colors.length]);     
    fill( c );
    circle( xBall, yBall, ballSize );
    
    theta += dTheta;
  }
  
  fill(0);
  circle(xC, yC, 1.9*minRadius);
    
  t = t + timeBetweenFrames;
}

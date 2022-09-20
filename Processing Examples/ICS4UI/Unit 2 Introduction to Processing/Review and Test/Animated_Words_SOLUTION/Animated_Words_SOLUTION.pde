String [] words = {"I", "got", "an", "A+", "on", "the", "test"};

float[] xPositions = new float[ words.length];
float[] yPositions = new float[ words.length];
float[] urgencies = new float[words.length];
PFont myFont;


void setup() {
  size(600,600);
  
  myFont = createFont("Times New Roman", 24);
  
  for(int i=0; i< words.length; i++) {
    xPositions[i] = random(0, width);
    yPositions[i] = random(0, height);
    urgencies[i] = 0.006 * i + 0.01;
  }
}


void draw() {
  background(0);
  textFont(myFont);
  stroke(255,255,0);
  
  for(int i=0; i< words.length; i++) {
    text( words[i], xPositions[i], yPositions[i] );
    
    xPositions[i] += urgencies[i] * (mouseX - xPositions[i]);
    yPositions[i] += urgencies[i] * (mouseY - yPositions[i]);
  }
}
  

import g4p_controls.*;

//Declare main objects in the simulation
Fluid fluid;
Ball ball;

//Time interval between frames
float dt = 0.001; //Keep dt <= 0.02 for accurate simulation

//GUI variables
boolean start = false;
boolean pause = false;
boolean gui = true;  //true = on

//Camera view parameters
PVector center = new PVector(0, 0, 0);
PVector frame = new PVector(2, 18, 4);
int border = 20;

//Initial values for simulation
float fluidDensity = 1.29;

PVector initialPosition = new PVector(0.6, 0.8, 1.6);
PVector initialVelocity = new PVector(-3.6, 70, -1);
float initialSpeedMPH = 105;
PVector axisRotation = new PVector(4, 0, 1);
float revolutionPS = 0.5;

void setup() {
  size(800, 500);
  
  //Initialize main objects
  fluid = new Fluid(fluidDensity); 
  
  if (gui) {
    createGUI();
    setControllerValues(new PVector(-3.6, 70, -1), 105, new PVector (4, 0, 1), 0.5);
  }
  else {
    float initialSpeedMPS = initialSpeedMPH * 0.447;
    ball = new Ball(initialPosition, initialVelocity.setMag(initialSpeedMPS), 0.2, axisRotation, revolutionPS, 0.1, fluid);
  }
}

void draw() {
  drawBackground(center, frame, border, true);
  if (!start && gui) {
    //Read GUI controllers for changes to initial parameters
    readGUIvalues();
  }
  else if (!pause && ball.getPosition().z > 0 && ball.getPosition().y <= center.y+frame.y) {
    //Update the ball if it is in the frame and above the ground
    ball.update(dt);
  }
  else if (ball.getPosition().z <= 0 || ball.getPosition().y > center.y+frame.y) {
    //End the simulation if the ball hits the ground or hits
    delay(1000);
    if (gui) {
      restart();
    }
    else {
      exit();
    }
  }
  
  //Render the ball
  ball.render(center, frame, 100);   
  
  //Pause function if GUI is turned off
  if (keyPressed) {
    pause = !pause;
    delay(100);
  }
}

void restart() {
  //Reset the variables to restart the simulation
  start = false;
  pauseButton.setText("START");
}

void drawBackground(PVector center, PVector frame, int border, boolean grid) {
  background(204);
  
  float screenX, screenY, screenZ;
  float screenWidth, screenHeight;
  
  //Top View
  //Ground
  noStroke();
  fill(130, 211, 122);
  rectMode(CENTER);
  rect(width/4, height/2, width/2-2*border, height-2*border);
  
  fill(0);
  stroke(0);
  //Grid
  if (grid) {
    textSize(11);
    for (float x = center.x-frame.x; x <= center.x+frame.x; x++) {
      if (x == 0) {
        strokeWeight(2);
      }
      else {
        strokeWeight(1);
      }
      stroke(0);
      
      screenX = map(x, center.x-frame.x, center.x+frame.x, border, width/2-border);
      line(screenX, border, screenX, height-border);
      textAlign(CENTER, TOP);
      text((int) x, screenX, height-border);    
    }
    
    for (float y = center.y; y <= center.y+frame.y; y++) {
      if (y == 0) {
        strokeWeight(2);
      }
      else {
        strokeWeight(1);
      }
      fill(0);
      
      screenY = map(y, center.y, center.y+frame.y, height-border, border);
      line(border, screenY, width/2-border, screenY);
      textAlign(RIGHT, CENTER);
      text((int) y, border/2, screenY);
    }
  }
  
  //Box
  strokeWeight(2);
  screenX = map(0, center.x-frame.x, center.x+frame.x, border, width/2-border);
  screenY = map(18, center.y, center.y+frame.y, height-border, border); 
  screenWidth = map(0.4318, 0, 2*frame.x, border, width/2-border)/2;
  line(screenX-screenWidth, screenY, screenX+screenWidth, screenY);
  
  textSize(18);
  textAlign(TOP, LEFT);
  text("TOP", 2*border, 2*border);

  //Head-on View
  //Sky
  noStroke();
  fill(186, 212, 256);
  rectMode(CENTER);
  rect(3*width/4, height/2, width/2-2*border, height-2*border);
  //Grid
  if (grid) {
    textSize(11);
    for (float x = center.x-frame.x; x <= center.x+frame.x; x++) {
      if (x == 0) {
        strokeWeight(2);
      }
      else {
        strokeWeight(1);
      }
      stroke(0);
      
      screenX = map(x, center.x-frame.x, center.x+frame.x, width/2+border, width-border);
      line(screenX, border, screenX, height-border);
      textAlign(CENTER, TOP);
      text((int) x, screenX, height-border);    
    }
    
    for (float z = center.z; z <= center.z+frame.z; z++) {
      if (z == 0) {
        strokeWeight(2);
      }
      else {
        strokeWeight(1);
      }
      fill(0);
      
      screenY = map(z, center.z, center.z+frame.z, height-border, border);
      line(width/2+border, screenY, width-border, screenY);
      textAlign(LEFT, CENTER);
      text((int) z, width-border/2, screenY);
    }
  }
  
  //Box
  strokeWeight(2);
  fill(225, 225);
  screenX = map(0, center.x-frame.x, center.x+frame.x, width/2+border, width-border);
  screenZ = map(1.05, 0, frame.z, height-border, border);
  screenWidth = map(0.4318, 0, 2*frame.x, border, width/2-border);
  screenHeight = map(0.5588, 0, frame.z, border, height-border);
  rectMode(CENTER);
  rect(screenX, screenZ, screenWidth, screenHeight);
  
  textSize(18);
  textAlign(TOP, LEFT);
  fill(0);
  text("HEAD ON", width/2+2*border, 2*border);
  
  //Border
  strokeWeight(2);
  noFill();
  rectMode(CENTER);
  rect(width/2, height/2, width-2*border, height-2*border);
  
  //Divider
  line(width/2, border, width/2, height-border);
}
  
void setControllerValues(PVector intialVelocity, float initialSpeed, PVector axisRotation, float rps) {
  //Set GUI controller values when examples are chosen from the droplist
  initialVelocity.setMag(1);
  axisRotation.setMag(1);
  xVelocitySlider.setValue(intialVelocity.x);
  yVelocitySlider.setValue(intialVelocity.y);
  zVelocitySlider.setValue(intialVelocity.z);
  initialSpeedSlider.setValue(initialSpeed);
  xAxisSlider.setValue(axisRotation.x);
  yAxisSlider.setValue(axisRotation.y);
  zAxisSlider.setValue(axisRotation.z);
  spinSpeedSlider.setValue(rps);
}

void readGUIvalues() {
  //Read the current values from the GUI controllers
  PVector initialPosition = (handCheckbox.isSelected()) ? new PVector(-0.6, 0.8, 1.6) : new PVector(0.6, 0.8, 1.6);

  PVector initialVelocity = new PVector(xVelocitySlider.getValueF(), yVelocitySlider.getValueF(), zVelocitySlider.getValueF());
  initialVelocity.setMag(initialSpeedSlider.getValueF()*0.447);

  PVector axisRotation = new PVector(xAxisSlider.getValueF(), yAxisSlider.getValueF(), zAxisSlider.getValueF());
  if (spinDirectionCheckbox.isSelected()) {
      axisRotation.mult(-1);
  }
  axisRotation.setMag(spinSpeedSlider.getValueF());
  
  revolutionPS = spinSpeedSlider.getValueF();
  
  ball = new Ball(initialPosition, initialVelocity, 0.2, axisRotation, revolutionPS, 0.1, fluid);
}
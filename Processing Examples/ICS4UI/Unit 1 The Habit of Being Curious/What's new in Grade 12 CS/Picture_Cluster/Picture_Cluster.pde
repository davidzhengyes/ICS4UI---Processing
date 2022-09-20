int numStudents = 20;
int numStudentsInner = 0; //numStudents/3;
int numStudentsOuter = numStudents - numStudentsInner;

float aspectRatio = 1.85;

float ellipseHeight = 100;
float ellipseWidth = ellipseHeight * aspectRatio;

float studentOrbitHeight = 300;
float studentOrbitWidth =  studentOrbitHeight * aspectRatio;

int pictureWidth = 100;
float frameSizeFactor = 1.15;

float rateOfLineBrightnessChange = 2;   //How quickly each line dims or brightens)
float rateOfFrameColourChange = 2;      //How quickly each frame's colour evolves)

float pinwheelSpeed = -0.006;
float groupSpeed = 0.006;

//FRAME SHADES
color startingShade = color(255, 120, 0);  //RED
color endingShade = color(0,180,0);        //GREEN

//EMPTY ARRAYS FOR THE PICTURES
PImage[] studentPics = new PImage[ numStudents ]; 
float[] x = new float[ numStudents ];                 
float[] y = new float[ numStudents ];

color[] lineShades = new color[256];
color[] frameShades = new color[256];         //will contain the picture colours
int[] lineIndices = new int[ numStudents ];
int[] frameIndices = new int[ numStudents ];
int[] lineDirections = new int[ numStudents ];   //will store  +1 or -1 for each line.  +1 means it's currently getting brighter. -1 means it's getting dimmer
int[] frameDirections = new int[ numStudents ];   //will store  +1 or -1 for each frame.  +1 means it's currently getting brighter. -1 means it's getting dimmer

float[] angles = new float[ numStudents ];
float[] rMajor = new float[ numStudents ];
float[] rMinor = new float[ numStudents ];

float xC, yC;
float groupAngle = 0;

float pictureHeight = pictureWidth * 1.3;
float frameWidth = pictureWidth * frameSizeFactor;
float frameHeight = pictureHeight * frameSizeFactor;

int screenWidth = int(2*(ellipseWidth + studentOrbitWidth + frameWidth/2));
int screenHeight = int(2*(ellipseHeight + studentOrbitHeight + frameHeight/2));

PFont font;


void settings() {
  size(screenWidth, screenHeight);
  
  xC = width/2;
  yC = height/2;
}


void setup() {
  rectMode(CENTER);
  imageMode(CENTER);

  for(int n = 0; n < 256; n++){
    lineShades[n] = n;
    
    float percentage = n/256.0;
    frameShades[n] = lerpColor(startingShade, endingShade, percentage);  
  }
  
  float thetaInner = 0;
  float thetaOuter = 0;
  float deltaThetaInner = TWO_PI/numStudentsInner;
  float deltaThetaOuter = TWO_PI/numStudentsOuter;
  
  for(int i=0; i < numStudents; i++) {
    
    if( i < numStudentsInner ) {
      rMajor[i] = studentOrbitWidth / 1.8;
      rMinor[i] = studentOrbitHeight / 1.8;
      lineDirections[i] = 1;
      frameDirections[i] = 1;
      angles[i] = thetaInner; 
      thetaInner += deltaThetaInner;
    }

    else {      
      rMajor[i] = studentOrbitWidth;
      rMinor[i] = studentOrbitHeight;
      lineDirections[i] = 1;
      frameDirections[i] = 1;
      angles[i] = thetaOuter; 
      thetaOuter += deltaThetaOuter;
    }
      
    String imageName = "pic"+i+".jpg";
    studentPics[i] = loadImage(imageName);
    
    lineIndices[i] = round( random(0,255));
    frameIndices[i] = round(255.0*i/numStudents);
  }
  
  font = createFont("Times", 30);
  textFont( font );
  textAlign(CENTER, CENTER);
}


void draw() {
  if( groupAngle <= 4*PI) {
    background(0);
    
    fill(200,200,0);
    text("Welcome to Grade 12 CS!", xC, yC);
    
    stroke(0,255,0);
    noFill();
    ellipse(xC, yC, 2*ellipseWidth, 2*ellipseHeight);
    
    float xGroupCenter = xC + ellipseWidth * cos( groupAngle );
    float yGroupCenter = yC - ellipseHeight * sin( groupAngle );
    
    //DRAWS LINES
    for(int i=0; i < numStudents; i++) {
      float xStudent = xGroupCenter + rMajor[i]*cos(angles[i]);
      float yStudent = yGroupCenter - rMinor[i]*sin(angles[i]);
          
      stroke( lineShades[ lineIndices[i] ]);
      line(xGroupCenter, yGroupCenter, xStudent, yStudent);
    }
    
    noStroke();
    
    //DRAWS STUDENT IMAGES AND THE RED-GREEN FRAMES
    for(int i=0; i < numStudents; i++) {
      float xStudent = xGroupCenter + rMajor[i] * cos(angles[i]);
      float yStudent = yGroupCenter - rMinor[i] * sin(angles[i]);;
          
      fill( frameShades[ frameIndices[i]] );
      rect( xStudent, yStudent, frameWidth, frameHeight );
      
      image( studentPics[i], xStudent, yStudent, pictureWidth, pictureHeight);
    }
    
    //UPDATES VARIABLES
    for(int i=0; i < numStudents; i++) {  
      angles[i] += pinwheelSpeed;
  
      lineIndices[i] += lineDirections[i] * rateOfLineBrightnessChange;
      
      if( lineIndices[i] >= 255 ) {
        lineIndices[i] = 255;
        lineDirections[i] = -1;
      }
      
      else if( lineIndices[i] <= 80 ) {
        lineIndices[i] = 80;
        lineDirections[i] = 1;   
      }
  
      frameIndices[i] += frameDirections[i] * rateOfFrameColourChange;
      
      if( frameIndices[i] >= 255 ) {
        frameIndices[i] = 255;
        frameDirections[i] = -1;
      }
      
      else if( frameIndices[i] <= 0 ) {
        frameIndices[i] = 0;
        frameDirections[i] = 1;   
      }  
    }
    
    groupAngle += groupSpeed;
    //saveFrame("frames/####.jpg");
  }
  
  else
    exit();
}

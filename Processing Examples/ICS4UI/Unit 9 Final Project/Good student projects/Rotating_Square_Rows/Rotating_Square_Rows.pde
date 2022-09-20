/***********************************************************************************************************
USER CONTROLS.  TRY CHANGING THESE.  TO CREATE THE QUEEN'S GAMBIT EFFECT, SET THE LAST BOOLEAN VALUE TO true
************************************************************************************************************/

int squaresPerRow = 30;                        //NUMBER OF VISIBLE SQUARES ACROSS A ROW.  THERE'S ACTUALLY 1 EXTRA SQUARE OFF-SCREEN TO THE LEFT
int numRows = 15;                              //NUMBER OF VISIBLE ROWS.  THERE'S ACTUALLY 1 EXTRA ROW THAT'S OFF SCREEN ABOVE THE TOP EDGE

float rotationSpeed = 0.05;                   //MEASURED IN RADIANS PER FRAME.  AT 30 FRAMES/SEC, 0.01 IS ABOUT 18 DEGREES/SEC.
float xSpeed = 0.0;                           //HOW FAST THE ROWS SLIDE LEFT OR RIGHT (0 is actually my favourite setting)
float overlapFactor = 1.42;                    //1.0 MEANS THE SQUARES JUST BARELY TOUCH.  MORE THAN 1 MEANS THEY OVERLAP.  1.41 (roughly sqrt(2)) MEANS THE GAPS CLOSE COMPLETELY BETWEEN ROTATIONS. 
float rectangleAspectRatio = 1.0;

boolean alternateSpinDirectionsInRow = true;  //WHETHER EACH SQUARE SPINS IN THE OPPOSITE WAY FROM ITS *LEFT* NEIGHBOUR
boolean alternateSpinDirectionsInCol = false;  //WHETHER EACH SQUARE SPINS IN THE OPPOSITE WAY FROM ITS *TOP* NEIGHBOUR
boolean alternateSpeedsByRow = true;          //WHETHER ADJACENT ROWS SLIDE IN OPPOSITE DIRECTIONS (relevant only if xSpeed > 0 )

boolean reverseDirections = false;            //WHETHER SQUARES REVERSE THEIR HORIZONTAL SPEEDS AFTER EACH 90 DEGREE ROTATION (OR WHATEVER reverseAngleThreshold IS SET TO)
boolean reverseColours = false;               //WHETHER SQUARES & THE BACKGROUND SWAP COLOURS AFTER EACH 90 DEGREE ROTATION (OR WHATEVER reverseAngleThreshold IS SET TO)
float reverseAngleThreshold = HALF_PI;        //USED ONLY IF AT LEAST 1 OF THE 2 "REVERSE" OPTIONS ABOVE IS SET TO true

color squareCol1 = color(255);
color squareCol2 = squareCol1; //color(255,255,0);
color backgroundCol = color(0);//color(130, 130, 140);

float deltaRowPhaseShift = 0.0;
float deltaSquarePhaseShift = 0.0;

float deltaRowFreq = 0;//3*HALF_PI/(numRows-1);
float deltaSquareFreq = 0; //4*HALF_PI/(squaresPerRow-1);


boolean useQueensGambitSettings = true;      //IF true, THEN THE ABOVE SETTINGS WILL BE OVERWRITTEN WITH THE ONES NEEDED 
                                              //TO CREATE THE ANIMATION SEEN IN THE QUEEN'S GAMBIT CLOSING CREDITS VIDEO AT 0:22-0:24.
                                              //HOWEVER, I FOUND THE DEFAULT SETTINGS ABOVE EVEN MORE INTERESTING TO WATCH.

/******************************************
OTHER GLOBAL VARIABLES.  DON'T CHANGE THESE
*******************************************/

Row[] rows = new Row[ numRows + 1 ];                                         //THE +1 IS FOR THE EXTRA ROW, WHICH IS NOT VISIBLE AT THE START
float theta = 0;                                                             //THE CURRENT ANGLE OF ROTATION THE SQUARES HAVE GONE THROUGH
float squareDiagonalLength, halfDiagonalLength, squareWidth, squareLength;  //THESE 4 VALUES ARE SET WITH THE PROCEDURE setSquareLengths() IN THE Helper_Functions TAB  
float squareRadius;
boolean oppositeSquareColours = (squareCol1 != squareCol2);

float aspectRatio = float(squaresPerRow)/numRows;
int screenWidth = 1600;
int screenHeight = round( screenWidth / aspectRatio );
PImage plusImg;


/****************************************************************************************************
MAIN PROGRAM.  USE settings() TO SET size() WHEN width AND height ARE VARIABLES RATHER THAN CONSTANTS
*****************************************************************************************************/

void settings() {
  size( screenWidth, screenHeight, P2D );
}

void setup() {
  //frameRate(1);
  println(screenHeight, height);
  noStroke();
  rectMode( CENTER );  //SEE www.processing.org REFERENCE PAGE TO SEE WHAT rectMode() DOES :^)
  imageMode( CENTER );
  plusImg = loadImage("plus sign.png");
  setSquareLengths();  //DEFINED IN Helper_functions

  if( useQueensGambitSettings )
    setQueensGambitSettings(); 
    
  createRows();        //DEFINED IN Helper_functions
}


/*************************************************************************************************
NOTICE HOW SIMPLE draw() IS! ONE OF THE BENEFITS OF OBJECT ORIENTED PROGRAMMING IS THAT
WE CAN STORE ALL THE DATA ABOUT THE OBJECTS INSIDE THEIR FIELD VALUES, AND ALL THE FORMULAS 
FOR HOW THEY MOVE INSIDE THEIR METHODS, MAKING THE REST OF THE PROGRAM EASIER TO READ (AND WRITE!)
**************************************************************************************************/

void draw() {
  background( backgroundCol );
  //println(squaresPerRow, numRows);
  
  for(int i=0; i < rows.length; i++) {
    rows[i].drawMe();
    rows[i].updatePosition();
  }  
  
  if( reverseColours || reverseDirections ) 
    goInReverse();
  
  theta += rotationSpeed;
}

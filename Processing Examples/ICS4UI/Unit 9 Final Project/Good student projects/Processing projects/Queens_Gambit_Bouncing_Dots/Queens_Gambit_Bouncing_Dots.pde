//////////////////////////////////////////////////////////////////
//                                                              //
//                      Queen's Gambit Credits                  //
//                        Made by Kenny Lin                     //
//                         January 31 2021                      //
//                                                              //
//////////////////////////////////////////////////////////////////

import g4p_controls.*;              // the defult values of the drag bars
int sceneMode = 1;                  //scene 1 is squares, scene 2 is circles
int n = 9;
int colourChange1 = 255;
int colourChange2 = 25;
float speedOne = 30;
int speedTwo = 10;
int circleDelay = 10;
boolean outLine = false;
ArrayList<SquareShuffling> squares = new ArrayList(); 
ArrayList<CircleWave> circles = new ArrayList(); 

void setup() {                //creates 50 different classes for squares and circles
  createGUI();
  size(1500,1000);
  frameRate(30);
  for (int i = 0; i < 50; i ++){
    SquareShuffling s = new SquareShuffling(i);
    CircleWave c = new CircleWave(i);
    squares.add(s);
    circles.add(c);
  }
}

void draw() {
  background(colourChange2);           //for n number, create the patterns
  for (int i = 1; i < n; i ++){
    if (sceneMode == 1) {              //if scene is 1 draw the squares
      squares.get(i).moveSquares();
      square(650, 400, 200);
    }
    else if (sceneMode == 2) {         //if scene is 2 draw the circles
      circles.get(i).drawCircles();
    }
  }
}

void reset(){                          //resets all the circles and squares when the bar is moved
  for (int i = 0; i < 50; i ++){
    squares.get(i).gridShufflingInitialize();
    circles.get(i).circleSetUp(i);
    circles.get(i).circlesInitialize();
  }
}

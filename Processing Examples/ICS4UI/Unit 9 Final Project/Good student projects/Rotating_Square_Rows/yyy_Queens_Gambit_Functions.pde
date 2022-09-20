
/***********************************************************************************************************
THESE ARE THE USER SETTINGS NEEDED TO CREATE THE EFFECT SHOWN IN THE QUEEN'S GAMBIT VIDEO AT 0:22-0:25.
THIS PROCEDURE OVERWRITES THE DEFAULT USER SETTINGS GIVEN AT THE TOP OF THE MAIN TAB.
***********************************************************************************************************/
void setSquareLengths() {
  squareDiagonalLength = width / squaresPerRow;  
  halfDiagonalLength = squareDiagonalLength / 2;
  squareWidth = squareDiagonalLength / sqrt(2) * overlapFactor;  //Computing the square's width from its diagonal using Pythagorean theorem. Try proving this formula if you're curious, which you are, of course.
  squareLength = squareWidth * rectangleAspectRatio;
  squareRadius = squareWidth/2;
  plusImg.resize(int(squareWidth*1.075), int(squareWidth*1.075));  
}

void setQueensGambitSettings() {
   squaresPerRow = 9;
   numRows = 5;
   
   rows = new Row[ numRows + 1 ];     
  
   alternateSpinDirectionsInRow = true;   
   alternateSpinDirectionsInCol = true;   
   alternateSpeedsByRow = false; 
   
   reverseDirections = true;
   reverseColours = true;
   reverseAngleThreshold = QUARTER_PI;  //45 degrees
  
   overlapFactor = 1.0;  
   squareDiagonalLength = width / squaresPerRow;  
   halfDiagonalLength = squareDiagonalLength / 2;
   squareWidth = squareDiagonalLength / sqrt(2);
   squareLength = squareWidth;
   squareRadius = squareWidth/2;
   rotationSpeed = 0.01;
   
   /* To get each square to line up perfectly with the square above it by the time it rotates 45 degrees,
      the square has to slide exactly 1 halfDiagonalLength to the right or left over the course of that rotation.  
      To make that happen, we must calculate its xSpeed precisely! The formula is given by these 2 lines.  Can you see why it works? */ 
      
   float timeToFinishOneQuarterRotation = QUARTER_PI / rotationSpeed;
   xSpeed = halfDiagonalLength / timeToFinishOneQuarterRotation;  
  
   squareCol1 = color(240,240,240);
   squareCol2 = squareCol1;
   backgroundCol = color(20);
}


//GETS CALLED AFTER EVERY ROTATION OF 45 DEGREES (or whatever reverseAngleThreshold has been set to)
void goInReverse() {
  if ( theta > reverseAngleThreshold  || theta < -reverseAngleThreshold) {
    
    if( useQueensGambitSettings ) {
      shiftAllSquares(  halfDiagonalLength );  //A key to creating the optical illusion in the video!
    }
    
    if( reverseColours )
      invertColours();
     
    if ( reverseDirections ) 
      for( Row r : rows )
        r.xSpeed *= -1;
          
    rotationSpeed *= -1;  //Reversing the direction of rotation (which you can think of as the direction of "time")
  }
}


void invertColours() {
  color temp = backgroundCol;
  backgroundCol = rows[0].squares[0].col;
  
  for( Row r : rows )
    for( Square s : r.squares ) 
      s.col = temp;
}


void shiftAllSquares( float dist ) {
  for( Row r : rows )
    for( Square s : r.squares ) {
      s.yC -= dist;     //UP SHIFT 
      
      if( rotationSpeed > 0 )
        s.xC -= dist;  //RIGHT SHIFT IF TIME IS GOING FORWARD
         
      else
        s.xC += dist;  //LEFT SHIFT IF TIME IS GOING IN REVERSE       
    }
}

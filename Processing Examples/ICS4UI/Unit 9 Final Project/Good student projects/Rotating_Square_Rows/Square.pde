class Square {
  float xC, yC;            //Centre of the square. Not to be confused with the performance hall in Kitchener.
  int spinDirection;       //Can be different from the row's default spin direction if alternateSpinDirectionsInRow = true
  color col, oppositeCol;  //This square's colour, and the opposite colour (needed because sometimes a square switches to the opposite colour)
  Row myRow;               //Included so that the code below can access all the field values of the row that the square is in, such as the row's xSpeed
  float phaseShift, freq;
  
  Square( float x, float y, int sd, color c, float ps, float f, Row r ){
    this.xC = x;
    this.yC = y;
    this.spinDirection = sd;
    this.col = c;
    this.phaseShift = ps;
    this.myRow = r;
    this.freq = f;
  }
  
  
  void updateXPos() {
    this.xC += this.myRow.xSpeed;  //Isn't it cool how we can access the field values of the row that the square is a part of? :^)
    
    //IF THE SQUARE MOVES OFF SCREEN, RECYCLE IT BY TELEPORTING IT TO THE OPPOSITE SIDE OF THE SCREEN (and possibly changing its colour)
    recycleIfOffScreen();
  }
  
  
  void drawMe() {
    fill( this.col );

    pushMatrix();                        //Starts an empty list (called a "matrix") of translations & rotations 
                                         //that will be applied to the object.
   
    translate( this.xC, this.yC );       //This moves the origin of the drawing window to (xC, yC) so that Processing 
                                         //will draw everything relative to (xC, yC) instead of (0, 0).

    rotate( (this.freq*theta+this.phaseShift)*this.spinDirection );  //The rotate() command rotates the object about the current origin (which is now (xC, yC)!)
                                         //NOT the centre of the object! So to spin the object about its centre, we must create 
                                         //the square at (0, 0) instead of (xC, yC).
                                         
    noStroke();
    rect(0, 0, squareWidth, squareLength);           //Note that we give (0, 0) as the coordinates, NOT (xC, yC)!
    stroke(0,255,255);
    strokeWeight(2);
    line(0, -squareRadius, 0, squareRadius);
    line(-squareRadius, 0, squareRadius, 0);
    strokeWeight(1);
    popMatrix();                         //Clears all translations and rotations from memory, so that the next square to be drawn
                                         //will start with a "clean slate".
  }   
  
  
  void recycleIfOffScreen() {
    
    if ( this.myRow.xSpeed > 0 && this.xC > width + halfDiagonalLength ) {  //If we slide off-screen to the right...
      this.xC = -halfDiagonalLength;   //...then teleport to the left side, just off-screen
      
      if ( oppositeSquareColours && this.myRow.hasOddLength ) //...and possibly switch colours to maintain the alternating-colour pattern.
        this.switchColours();                                 //...Can you see why this is necessary if the row length is odd? :^)
    }
      
    if ( this.myRow.xSpeed < 0 && this.xC < -halfDiagonalLength  ) {       //If we slide off-screen to the left...
      this.xC = width + halfDiagonalLength;
      
      if ( oppositeSquareColours && this.myRow.hasOddLength )
        this.switchColours();
    }
              
    if( this.yC < -halfDiagonalLength )    
      this.yC = height + halfDiagonalLength;     
    
  }
  
  
  void switchColours() {
    color tempCol = this.col;
    this.col = this.oppositeCol;
    this.oppositeCol = tempCol;
  }
}

class Demo {
  //Parameters
  String title;
  int duration;
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
  boolean shiftSquaresDown = false;
  boolean useQueensGambitSpeed = false;
  float reverseAngleThreshold = HALF_PI;        //USED ONLY IF AT LEAST 1 OF THE 2 "REVERSE" OPTIONS ABOVE IS SET TO true  
  color squareCol1 = color(255);
  color squareCol2 = squareCol1; //color(255,255,0);
  color backgroundCol = color(0);//color(130, 130, 140); 
  boolean linesOn = false;
  float deltaRowPhaseShift = 0.0;
  float deltaSquarePhaseShift = 0.0;  
  float deltaRowFreq = 0;//3*HALF_PI/(numRows-1);
  float deltaSquareFreq = 0; //4*HALF_PI/(squaresPerRow-1);
  
  //Dependent fields
  Row[] rows;                                         //THE +1 IS FOR THE EXTRA ROW, WHICH IS NOT VISIBLE AT THE START
  float theta = 0;                                                             //THE CURRENT ANGLE OF ROTATION THE SQUARES HAVE GONE THROUGH
  float squareDiagonalLength, halfDiagonalLength, squareWidth, squareLength;  //THESE 4 VALUES ARE SET WITH THE PROCEDURE setSquareLengths() IN THE Helper_Functions TAB  
  float squareRadius;
  boolean oppositeSquareColours;
  float aspectRatio = float(squaresPerRow)/numRows;
  int screenWidth = 1600;
  int screenHeight = round( screenWidth / aspectRatio );
  
  
  Demo(String t, int dur, int spr, int nr, float rotSp, float xsp, float ov, float asp, boolean altsdirR, boolean altsdirC, boolean altSp,
      boolean revDir, boolean revCol, boolean shift, boolean QG, float revAngTh, color sc1, color sc2, color bgCol, boolean lines, 
      float drowps, float dsqps, float drf, float dsf) {
     this.title = t;
     this.duration = dur;
     this.squaresPerRow = spr;
     this.numRows = nr;
     this.rotationSpeed = rotSp;
     this.xSpeed = xsp;
     this.overlapFactor = ov;
     this.rectangleAspectRatio = asp;
     this.alternateSpinDirectionsInRow = altsdirR;
     this.alternateSpinDirectionsInCol = altsdirC;
     this.alternateSpeedsByRow = altSp;
     this.reverseDirections = revDir;
     this.reverseColours = revCol;
     this.shiftSquaresDown = shift;
     this.useQueensGambitSpeed = QG;
     this.reverseAngleThreshold = revAngTh;
     this.squareCol1 = sc1;
     this.squareCol2 = sc2;
     this.backgroundCol = bgCol;
     this.linesOn = lines;
     this.deltaRowPhaseShift = drowps;
     this.deltaSquarePhaseShift = dsqps;
     this.deltaRowFreq = drf;
     this.deltaSquareFreq = dsf;
     
     rows = new Row[nr+1];
     this.oppositeSquareColours = (this.squareCol1 != this.squareCol2);
     this.setScreenDimensions();
     this.setSquareLengths(); 
     
     if( this.useQueensGambitSpeed )
       this.setSpeedForQueensGambit();
       
     this.createRows();        //DEFINED IN Helper_functions
  }
  
  
  void setSquareLengths() {
    this.squareDiagonalLength = float(this.screenWidth) / this.squaresPerRow;  
    this.halfDiagonalLength = this.squareDiagonalLength / 2;
    this.squareWidth = this.squareDiagonalLength / sqrt(2) * this.overlapFactor;  //Computing the square's width from its diagonal using Pythagorean theorem. Try proving this formula if you're curious, which you are, of course.
    this.squareLength = this.squareWidth * this.rectangleAspectRatio;
    this.squareRadius = this.squareWidth/2;
    //plusImg.resize(int(this.squareWidth*1.075), int(this.squareWidth*1.075));  
  }
  
  
  void setScreenDimensions() {  
    this.aspectRatio = float(this.squaresPerRow)/this.numRows;
    this.screenWidth = 1600;
    this.screenHeight = round( this.screenWidth / this.aspectRatio );
  }

  void createRows() {
    //HEIGHT, SPIN DIRECTION, SLIDING DIRECTION & STARTING COLOUR OF THE FIRST ROW
    float yC = this.halfDiagonalLength;                       
    int spinDirection = 1;
    float slidingDirection = 1;
    color colour = this.squareCol1;
    float phaseShift = 0;
    float freq = 1;
    
    //BUILDING THE ROWS
    for( int i = 0; i < rows.length; i++ ) {
      float velocity = this.xSpeed * slidingDirection;  
      
      this.rows[i] = new Row( this.squaresPerRow, yC, spinDirection, velocity, phaseShift, freq, colour, this ); 
      
      yC += this.squareDiagonalLength;          //RESETTING THE HEIGHT FOR THE NEXT ROW
      
      if( this.alternateSpinDirectionsInCol )   //MAKING THE NEXT ROW'S FIRST SQUARE START WITH THE OPPOSITE SPIN DIRECTION
        spinDirection *= -1;
        
      if( this.alternateSpeedsByRow )           //MAKING THE NEXT ROW SLIDE IN THE OPPOSITE DIRECTION (IF xSpeed > 0 )
        slidingDirection *= -1;
        
      if( colour == this.squareCol1 )           //MAKING THE NEXT ROW'S FIRST SQUARE START WITH THE OPPOSITE COLOUR
        colour = this.squareCol2;
        
      else 
        colour = this.squareCol1;
        
      phaseShift += this.deltaRowPhaseShift;
      freq += this.deltaRowFreq;
    }
  }  
  
  
  void drawFrame() {
    for( Row r : this.rows ) 
      r.drawMe();
      
    fill(0);
    noStroke();
    rectMode(CORNER);
    rect(0,screenHeight,width,height);
    rectMode(CENTER);
  }
  
  
  void updatePositions() {
    for( Row r : this.rows ) 
      r.updatePosition();
    
    if( this.reverseColours || this.reverseDirections ) 
      this.goInReverse();
    
    this.theta += this.rotationSpeed; 
  }

  
  void goInReverse() {
    if ( this.theta > this.reverseAngleThreshold  || this.theta < -this.reverseAngleThreshold) {
      
      if( this.shiftSquaresDown ) {
        shiftAllSquares(  halfDiagonalLength );  //A key to creating the optical illusion in the video!
      }
      
      if( this.reverseColours )
        this.invertColours();
       
      if ( this.reverseDirections ) 
        for( Row r : rows )
          r.xSpeed *= -1;
            
      this.rotationSpeed *= -1;  //Reversing the direction of rotation (which you can think of as the direction of "time")
    }
  }


  void invertColours() {
    color temp = this.backgroundCol;
    this.backgroundCol = this.rows[0].squares[0].col;
    
    for( Row r : rows )
      for( Square s : r.squares ) { 
        s.col = temp;
      }
  }


  void shiftAllSquares( float dist ) {
    for( Row r : this.rows )
      for( Square s : r.squares ) {
        s.yC -= dist;     //UP SHIFT 
        
        if( this.rotationSpeed > 0 )
          s.xC -= dist;  //RIGHT SHIFT IF TIME IS GOING FORWARD
           
        else
          s.xC += dist;  //LEFT SHIFT IF TIME IS GOING IN REVERSE       
      }
  }
  
  
  void setSpeedForQueensGambit() {
    float timeToFinishOneQuarterRotation = this.reverseAngleThreshold / this.rotationSpeed;
    this.xSpeed = this.halfDiagonalLength / timeToFinishOneQuarterRotation;  
  }
  
}

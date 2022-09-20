class Row {
  float yC;                      //Height of the centre line of the row
  float xSpeed;                  //How fast the row slides right or left
  int spinDirection;             //Spin direction of the 1st square in the row.  1 = clockwise, -1 = counterclockwise
  Square[] squares;              //Contains all the squares in this row
  boolean hasOddLength = false;  //Needed for when the square at the end of the row teleports to the other side and has to change colour to maintain the illusion of alternating colours
  float phaseShift, freq;
  Demo myDemo;
  
  Row(int numSquares, float y, int dir, float speed, float ps, float f, color c, Demo d) {
    this.yC = y;
    this.spinDirection = dir;
    this.xSpeed = speed;
    this.phaseShift = ps;
    this.freq = f;
    this.myDemo = d;
    
    this.squares = new Square[ numSquares + 1 ];   //We actually create 1 extra square, off-screen to the left, 
                                              //so that if xSpeed > 0, we'll see a continuous flow of squares as the 
                                              //row slides to the right. When a square leaves the right edge, it gets "recycled" back to the
                                              //back to the left side, again off-screen by 1 halfDiagonal length,
                                              //creating the illusion of an infinite parade of squares.
                                              
    //if( this.squares.length % 2 == 1 )
    //  this.hasOddLength = true;
    
    //BUILDING THE squares[] ARRAY
    float x = -d.halfDiagonalLength;                        //The first square is off-screen by 1 halfDiagonalLength
    int spinDirectionForNextSquare = this.spinDirection;  //The first square will inherit this row's given spin direction.
    color squareColour = c;
    
    float squarePhaseShift = this.phaseShift;
    float squareFreq = f;
    
    for(int i = 0; i < this.squares.length; i++) {
      if( this.myDemo.linesOn )
        squares[i] = new LinedSquare( x, this.yC, spinDirectionForNextSquare, squareColour, squarePhaseShift, squareFreq, this );
        
      else
        squares[i] = new Square( x, this.yC, spinDirectionForNextSquare, squareColour, squarePhaseShift, squareFreq, this );
      
      //MAKING EACH SQUARE SPIN IN THE OPPOSITE DIRECTION FROM ITS LEFT NEIGHBOUR, IF DESIRED
      if( d.alternateSpinDirectionsInRow )
        spinDirectionForNextSquare *= -1;
        
      //GIVING EACH SQUARE THE OPPOSITE COLOUR FROM ITS LEFT NEIGHBOUR, IF DESIRED
      if( squareColour == d.squareCol1 )
        squareColour = d.squareCol2;
        
      else
        squareColour = d.squareCol1;
        
      //SPACING THE SQUARES BY THEIR DIAGONAL LENGTH, SO THAT THEY JUST BARELY TOUCH AT THE CORNERS WHEN ROTATED 45 DEGREES (assuming overlapFactor = 1.0)
      x += d.squareDiagonalLength;
      squarePhaseShift += d.deltaSquarePhaseShift;
      squareFreq += d.deltaSquareFreq;
    }
  }
  
  
  void updatePosition() {
    for( Square s : this.squares )
      s.updateXPos();  //ONLY APPLIES IF xSpeed > 0
  }
  
  
  void drawMe() {
    for( Square s: this.squares )
      s.drawMe();
  }
}

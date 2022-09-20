
//WE SPACE THE SQUARES BY THEIR DIAGONAL LENGTHS INSTEAD OF THEIR SIDE LENGTHS,
//SO THAT THE SQUARES WILL JUST BARELY TOUCH EACH OTHER AT THE CORNERS WHEN ROTATED 45 DEGREES (ASSUMING overlapFactor = 1)


void createRows() {
  //HEIGHT, SPIN DIRECTION, SLIDING DIRECTION & STARTING COLOUR OF THE FIRST ROW
  float yC = halfDiagonalLength;                       
  int spinDirection = 1;
  float slidingDirection = 1;
  color colour = squareCol1;
  float phaseShift = 0;
  float freq = 1;
  
  println(rows.length);
  
  //BUILDING THE ROWS
  for( int i = 0; i < rows.length; i++ ) {
    float velocity = xSpeed * slidingDirection;  
    println(i, yC);
    
    rows[i] = new Row( squaresPerRow, yC, spinDirection, velocity, phaseShift, freq, colour ); 
    
    yC += squareDiagonalLength;          //RESETTING THE HEIGHT FOR THE NEXT ROW
    
    if( alternateSpinDirectionsInCol )   //MAKING THE NEXT ROW'S FIRST SQUARE START WITH THE OPPOSITE SPIN DIRECTION
      spinDirection *= -1;
      
    if( alternateSpeedsByRow )           //MAKING THE NEXT ROW SLIDE IN THE OPPOSITE DIRECTION (IF xSpeed > 0 )
      slidingDirection *= -1;
      
    if( colour == squareCol1 )           //MAKING THE NEXT ROW'S FIRST SQUARE START WITH THE OPPOSITE COLOUR
      colour = squareCol2;
      
    else 
      colour = squareCol1;
      
    phaseShift += deltaRowPhaseShift;
    freq += deltaRowFreq;
      
  }
}

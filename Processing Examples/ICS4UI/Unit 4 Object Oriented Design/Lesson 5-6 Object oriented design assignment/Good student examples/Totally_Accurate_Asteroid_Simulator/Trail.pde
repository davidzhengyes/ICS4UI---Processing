class Trail {
  
  ArrayList<PVector> trailPoints = new ArrayList<PVector>();
  
  
  Trail( float x, float y ) {
    
    //Initialize trail points to all be at asteroid center
    for( int i=0; i<trailLength; i++ ) {
      trailPoints.add( new PVector( x, y ) );
    }
    
  }
  
  
  void update( float x, float y ) {
    
    //Removes first and last point
    trailPoints.remove(trailLength-1);
    trailPoints.remove(0);
    
    //Adds current position twice
    trailPoints.add( new PVector( x, y ) );
    trailPoints.add( new PVector( x, y ) );
    
  }
  
  
  void display() {
    
    noFill();
    stroke(trailColor);
    beginShape();
    
    for( int i=0; i<trailLength; i++ ) {
      PVector tp = trailPoints.get(i);    
      curveVertex( tp.x, tp.y );
    }
    
    endShape();
    
  }
  
  
}

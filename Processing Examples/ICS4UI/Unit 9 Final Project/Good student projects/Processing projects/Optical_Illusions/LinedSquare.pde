class LinedSquare extends Square {
  
  LinedSquare(float x, float y, int sd, color c, float ps, float f, Row r) {
    super(x, y, sd, c, ps, f, r);
  }
  
  void drawMe() {
  Demo d = this.myRow.myDemo;
    
    fill( this.col );

    pushMatrix();  
    
    translate( this.xC, this.yC ); 
    rotate( (this.freq*d.theta + this.phaseShift)*this.spinDirection );  
                                         
    noStroke();
    rect(0, 0, d.squareWidth, d.squareLength);           
    stroke(this.myRow.myDemo.backgroundCol);
    strokeWeight(2);
    line(0, -d.squareRadius, 0, d.squareRadius);
    line(-d.squareRadius, 0, d.squareRadius, 0);
    strokeWeight(1);
    popMatrix();                         
  }
  
}

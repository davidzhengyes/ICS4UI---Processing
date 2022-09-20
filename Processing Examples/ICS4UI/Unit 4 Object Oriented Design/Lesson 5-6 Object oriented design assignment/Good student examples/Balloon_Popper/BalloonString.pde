class BalloonString{
  Balloon balloon;
  int size;
  int numTurns;
  int widthTurns;
 
  BalloonString(int s, int nT, int wT){
    this.size = s;
    this.numTurns = nT;
    this.widthTurns = wT;
  }
 
  BalloonString(){
    this.size = round(random(minStringSize, maxStringSize));
    this.numTurns = round(random(minStringTurns, maxStringTurns));
    this.widthTurns = round(random(minStringTurnWidth, maxStringTurnWidth));
  }
 
  void drawString(){
    int sHeight = size / (numTurns * 4);
    int currHeight = 0;
    float startX = this.balloon.position.x;
    float startY = this.balloon.position.y + this.balloon.radius;
    stroke(255);

    for(int i = 0; i < numTurns; i++){
      noFill();
      beginShape();
      curveVertex(startX, startY + currHeight);
      curveVertex(startX, startY + currHeight);
      curveVertex(startX - this.widthTurns, startY + sHeight + currHeight);
      curveVertex(startX, startY + sHeight * 2 + currHeight);
      curveVertex(startX + this.widthTurns, startY + sHeight * 3 + currHeight);
      curveVertex(startX, startY + sHeight * 4 + currHeight);
      curveVertex(startX, startY + sHeight * 4 + currHeight);
      endShape();
      currHeight += sHeight * 4;
    }

  }
}

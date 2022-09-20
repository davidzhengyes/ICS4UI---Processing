class Player {
  float points;
  float pieAngle;
  color col;
  
  Player(color c) {
    this.col = c;
    this.points = startPoints;
  }
  
  void setPieAngle() {
    this.pieAngle = TWO_PI * this.points / totalPoints;
  }
  
  float getRandomScore() {
    return random(0, this.points);
  }
}

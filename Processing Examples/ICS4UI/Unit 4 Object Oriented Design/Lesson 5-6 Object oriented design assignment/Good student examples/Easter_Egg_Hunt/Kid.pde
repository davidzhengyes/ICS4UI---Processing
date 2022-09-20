class Kid {
  PVector Location = new PVector();
  int speed;
  int score;
  int place;
  color colour;
  int size;
  float currDist;
  int target;
  boolean stillEggs;
  int countSpeed;
  boolean showScore;
  
  Kid (int sc, int si, int sp, int col, boolean ss){
    this.score = sc;
    this.size = si;
    this.speed = sp;
    this.colour = col;
    this.countSpeed = 0; 
    this.showScore = ss;
  }
  
  
  void drawKid(){ 
    fill (colour);
    rect (Location.x, Location.y, size, size);
    if (this.showScore == true){
      fill(0);
      textSize(10);
      text(score, Location.x, (Location.y)-(size/2));
    }
  }
  
  
  void moveKid(){
    stillEggs = false;
    for (int i=0; i<numEggs; i++){//checking for eggs
      if (eggs[i].picked == false){
        stillEggs = true;
        break;
      }
    }
    if (stillEggs == false){//no more eggs, go to ending
      s.decision = "EndGame";
    }
    else {
      if (countSpeed%pickupEggSpeed==0){//if u just picked up an egg, you can't move for pickupEggSpeed number of updates/frames
      this.decideMoveNextEgg(eggs);
      }
      else{
        this.Location.x = Location.x;
        this.Location.y = Location.y;
        countSpeed++;
      }
    }
  }
  
  
  void decideMoveNextEgg(Egg[] egg){
    float smolDist = sqrt( pow(width,2) + pow (height,2) );
    
    for (int i=0; i<egg.length; i++){
      if (egg[i].picked == false){// if the egg has not been picked
        currDist = findDist(egg[i].Location.x, egg[i].Location.y, Location.x, Location.y);
        if (currDist<smolDist){//find the smallest distanced egg
          smolDist = currDist;
          target = i;
        }
      }
    }
    float xd = egg[target].Location.x - Location.x;
    float yd = egg[target].Location.y - Location.y;
    
    float xDirection = xd/smolDist;
    float yDirection = yd/smolDist;
    
    //moving now
    if (smolDist > speed){
      Location.x += speed*xDirection;
      Location.y +=speed*yDirection;    
    }
    else{
      Location.x = egg[target].Location.x;
      Location.y = egg[target].Location.y;
      countSpeed++;
      this.pick(egg[target]);
    } 
  }
  
  
  float findDist(float x, float y, float x1, float y1){
    float dist = sqrt(pow(x - x1, 2) + pow(y - y1, 2));
    return dist;
  }
  
  
  void pick(Egg egg){
    egg.picked = true;
    score++;
  }
    
  
  void infoKid(int rangeX1, int rangeX2, int rangeY1, int rangeY2){
    this.Location.x = round(random(rangeX1, rangeX2));
    this.Location.y = round(random(rangeY1, rangeY2));
  }
}

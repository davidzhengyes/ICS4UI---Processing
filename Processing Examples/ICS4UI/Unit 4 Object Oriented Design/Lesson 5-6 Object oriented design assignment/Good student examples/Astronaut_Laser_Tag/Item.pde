class Item {
  float xPos;
  float yPos;
  int itemChoice;
  boolean hasBeenUsed = false;
  int frameCounter = 0;
  
  //Constructor method.
  Item (float x, float y) {
   this.xPos = x; 
   this.yPos = y;
   this.itemChoice = round(random(1,3));
  }
  
  //Draws item.
  void drawItem() {
    if (this.itemChoice == 1 && !hasBeenUsed) {
     image(health, this.xPos, this.yPos-10);
    }
    
    if (this.itemChoice == 2 && !hasBeenUsed) {
     image(heart, this.xPos, this.yPos);    
    }
    
    if (this.itemChoice == 3 && !hasBeenUsed) {
     image(meteorIcon, this.xPos, this.yPos);
    }
    
    updateItem();
  }
  
  //Updates item if it has been used or not.
  void updateItem() {
    if (this.hasBeenUsed == true) {
      frameCounter ++;
      fill(0,255,255);
      arc(this.xPos+20, this.yPos + 10, 30, 30, 0, frameCounter*PI/180);
    }
    
    if (frameCounter == 360) {
     frameCounter = 0;
     this.hasBeenUsed = false;
    }
    
    this.yPos += sin(0.2*frameCount);
  }
  
  
}

class SquareShuffling {
  float x, y, x2, y2, sqrSize, speedPerFrame;
  int squareNum;
  boolean moveX = true;
  boolean[] addingMovement = {false, false, true, true};
  int squareStage = 1;
  float movementCount = 0; 
  boolean finishMovement = false;
  int rotationCount = 0;
  

  SquareShuffling(int num) {
    this.squareNum = num;
    gridShufflingInitialize();
  }

  void gridShufflingInitialize() {    //sets all location of the squares
    moveX = true;
    rotationCount = 0;
    squareStage = 1;
    movementCount = 0;
    if (squareNum == 0) {
      x = 650;
      y = 400;
    } 
    else {
      float sum = 0;
      int j = squareNum;
      float k = 400;
      while (j >= 1) {
        sum += k/2;
        k /= 2;
        j --;
      }
      sqrSize = k/2;
      x = sum + 650;
      y = sum + 400;
      x2 = x;
      y2 = y;
    }
  }

  float squareMovementCalculations() {       //determines how far each square should go
    float totalDistance, distance;           //so they will be in the same location at the same time
    //speedPerFrame = 30 + speedOne;
    if (squareStage == 1) {                  //what squares should do in stage 1 (see the google doc for explanation)
      distance = 400;
      totalDistance = 0;
      for (int i = 0; i < squareNum; i ++) {
        distance /= 2;
        totalDistance += distance;
      }
      if (squareNum % 2 == 1){
        distance /= 2;
        totalDistance += distance;
      }
      return totalDistance;
    }
    else if (squareNum >= 2){                //stage 2
      int specialNum;
      distance = 200;
      totalDistance = 0;
      if (squareNum == 1)
        specialNum = squareNum + 1;
      else
        specialNum = squareNum;
      for (int i = 1; i < specialNum; i ++) {
        distance /= 2;
        totalDistance += distance;
      }
      if (squareNum % 2 == 0){
        distance /= 2;
        totalDistance += distance;
      }
      else if (specialNum == 1)
        totalDistance = 0;

      return totalDistance;
    }
    else {
      return 0;
    }
  }
  
  void expectedLocation(float moveValue){        //the location of which the squares should be at
    if (moveX == true){                          //incase if the squares goes too fast and goes out of pattern
      if(addingMovement[rotationCount] == true)
        x2 += moveValue;
      else
        x2 -= moveValue;
    }
    else{
      if (addingMovement[rotationCount] == true)
        y2 += moveValue;
      else
        y2 -= moveValue;
    }
    //println(x2, y2);
  }
  
  void moveSquares() {                     //the function that gets called in draw
    float moveValue = squareMovementCalculations();
    if (outLine == true) {                 //changes the looks when buttons are pressed
      stroke(colourChange1);
      fill(colourChange2);
    }
    else 
      fill(colourChange1);
    
    square(x, y, sqrSize);
    
    if (movementCount == 0)                //where "x += speed" etc.
      expectedLocation(moveValue);
    if (finishMovement == false){
      //println(moveValue);/////////////////////////////////////////////////
      if (moveX == true) {
        if(addingMovement[rotationCount] == true && x < x2)
          x += moveValue/speedOne;
        else if (addingMovement[rotationCount] == false && x > x2)
          x -= moveValue/speedOne;
        else {
          x = x2;
          finishMovement = true;
        }
      }
      else if (squareNum > 1){                
        if(addingMovement[rotationCount] == true && y < y2)
          y += moveValue/speedOne;
        else if (addingMovement[rotationCount] == false && y > y2)
          y -= moveValue/speedOne;
        else {
          y = y2;
          finishMovement = true;
        }
      }
      else {                                  
        if (squares.get(2).squareStage == 1) {
          if(addingMovement[rotationCount] == true && y < y2)
            y += moveValue/speedOne;
          else if (addingMovement[rotationCount] == false && y > y2)
            y -= moveValue/speedOne;
          else {
            y = y2;
            finishMovement = true;
          }
        }
      }
      movementCount ++;
    }
    else {                           //when the square goes from stage 1 to 2
      if (squareStage == 1){
        squareStage ++;
        movementCount = 0;
        finishMovement = false;
      }
      else{                          //when stage 2 goes to 1
        movementCount = 0;
        moveX = !moveX;
        moveValue *= -1;
        squareStage --;
        finishMovement = false;
        if (rotationCount < 3)
          rotationCount ++;
        else
          rotationCount = 0;
      }
    }
  }
}

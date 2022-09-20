class CircleWave {
  int rowNum, numCircles;
  float[] x, y;
  float a = 0;
  int movementRecorder = 5;
  
  CircleWave(int num) {
    circleSetUp(num);
  }
  
  void circleSetUp(int num) {        //since rows must be a odd number, we must seperate odd and even
    if (n % 2 == 0) {
      this.rowNum = num - (n)/2;
      if (rowNum > 0)
        this.numCircles = n/2 - rowNum; 
      else
        this.numCircles = n/2 - rowNum * -1; 
    }
    else {
      this.rowNum = num - (n+1)/2;
      if (rowNum > 0)
        this.numCircles = (n + 1)/2 - rowNum; 
      else
        this.numCircles = (n + 1)/2 - rowNum * -1; 
      n += 1;
    }
    
    if (numCircles > 0){                //since only the ones with 1 or more circles are important
      this.x = new float[numCircles];   //we will open up the amount of circle of x values 
      this.y = new float[numCircles];
    }
    else {
      this.x = new float[10];    //and all other x and y will have enough for index to not be out of range
      this.y = new float[10];
    }
    circlesInitialize();
  }
  
  void circlesInitialize() {      //here we sets x and y values of each circles
    int locationAdder, j;
    int circlePairs = 1;
    a = 0;
    movementRecorder = 5;
    
    if (numCircles % 2 == 0) {    //for even number rows, there is no circle in the middle
      locationAdder = 50;
      j = 0;
    }
    else {                        //odd rows have circles in the middle
      locationAdder = 100;
      x[0] = 750;
      y[0] = 500 + 50 * rowNum;
      j = 1;
    }
    for (int i = j; i < numCircles; i ++){          //for the amount of circles, calculate their location
      if (circlePairs == 1 || circlePairs == 0) {
        x[i] = locationAdder + 750;
        circlePairs ++;
      }
      
      else if (circlePairs == 2) {
        x[i] = 750 - locationAdder;
        locationAdder += 100;
        circlePairs = 1;
      }
      y[i] = 500 + 50 * rowNum;        //circles have the same value for y
    }
  }
  
  void drawCircles() {          //function that is called in draw
    if (numCircles > 0) {
     for (int i = 0; i < numCircles; i ++){
        if (outLine == true) {
          stroke(colourChange1);
          fill(colourChange2);
        }
        else 
        fill(colourChange1);
        
        circle(x[i], y[i]+a, 25);
     }
     a = sin(radians(movementRecorder + rowNum * circleDelay))*50;    //my beautiful formulia
     movementRecorder +=speedTwo;
    }
  }
}

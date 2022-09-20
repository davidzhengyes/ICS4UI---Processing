class Cube {
  float size1;
  float size2;
  int row;
  int col;

  Cube(float sz, int sze, int r, int c) {
    this.size1 = sz;
    this.size2 = sze;
    this.row = r;
    this.col = c;
  }

//Sets up each side of the Cube.
  void drawMe() {
    for (int l=0; l<3; l++) {
      for (int m=0; m<3; m++) {
        for (int n=0; n<6; n++) {
          if (n==0) { //green
            pushMatrix();
            translate(1.5*this.size1, 0, 0);
            rotateY(PI/2);
            colored(block[l][m][n]);
            rect(this.size1*(l-1), this.size1*(m-1), this.size2, this.size2);
            popMatrix();
          }
          if (n==1) { //blue
            pushMatrix();
            translate(-1.5*this.size1, 0, 0);
            rotateY(PI/2);
            colored(block[l][m][n]);
            rect(this.size1*(l-1), this.size1*(m-1), this.size2, this.size2);
            popMatrix();
          }
          if (n==2) { //yellow
            pushMatrix();
            translate(0, 1.5*this.size1, 0);
            rotateX(PI/2);
            colored(block[l][m][n]);
            rect(this.size1*(l-1), this.size1*(m-1), this.size2, this.size2);
            popMatrix();
          }
          if (n==3) { //purple
            pushMatrix();
            translate(0, -1.5*this.size1, 0);
            rotateX(PI/2);
            colored(block[l][m][n]);
            rect(this.size1*(l-1), this.size1*(m-1), this.size2, this.size2);
            popMatrix();
          }
          if (n==4) { //red
            pushMatrix();
            translate(0, 0, 1.5*this.size1);
            colored(block[l][m][n]);
            rect(this.size1*(l-1), this.size1*(m-1), this.size2, this.size2);
            popMatrix();
          }
          if (n==5) { //orange
            pushMatrix();
            translate(0, 0, -1.5*this.size1);
            colored(block[l][m][n]);
            rect(this.size1*(l-1), this.size1*(m-1), this.size2, this.size2);
            popMatrix();
          }
        }
      }
    }
  }

//Actions associated with each key.
  void keys() {
    if (key == 'n') {
      restart();
    }
    if (key == 'r') {
      rightClockwise();
    }
    if (key == 'R') {
      rightCounterClockwise();
    }
    if (key == 'm') {
      middleUpZ();
    }
    if (key == 'M') {
      middleDownZ();
    }
    if (key == 'l') {
      leftClockwise();
    }
    if (key == 'L') {
      leftCounterClockwise();
    }
    if (key == 'u') {
      topClockwise();
    }
    if (key == 'U') {
      topCounterClockwise();
    }
    if (key == 'e') {
      middleLeftX();
    }
    if (key == 'E') {
      middleRightX();
    }
    if (key == 'd') {
      bottomClockwise();
    }
    if (key == 'D') {
      bottomCounterClockwise();
    }
    if (key == 'f') {
      frontClockwise();
    }
    if (key == 'F') {
      frontCounterClockwise();
    }
    if (key == 's') {
      middleRightY();
    }
    if (key == 'S') {
      middleLeftY();
    }
    if (key == 'b') {
      backClockwise();
    }
    if (key == 'B') {
      backCounterClockwise();
    }
    if (key == 'x') {
      rightClockwise();
      middleUpZ();
      leftCounterClockwise();
    }
    if (key == 'X') {
      rightCounterClockwise();
      middleDownZ();
      leftClockwise();
    }
    if (key == 'y') {
      topClockwise();
      middleLeftX();
      bottomCounterClockwise();
    }
    if (key == 'Y') {
      topCounterClockwise();
      middleRightX();
      bottomClockwise();
    }
    if (key == 'z') {
      frontClockwise();
      middleRightY();
      backCounterClockwise();
    }
    if (key == 'Z') {
      frontCounterClockwise();
      middleLeftY();
      backClockwise();
    }
    if (key == 't') {
      rightClockwise();
      middleUpZ();
    }
    if (key == 'T') {
      rightCounterClockwise();
      middleDownZ();
    }
    if (key == 'i') {
      topClockwise();
      middleLeftX();
    }
    if (key == 'I') {
      topCounterClockwise();
      middleRightX();
    }
    if (key == 'g') {
      frontClockwise();
      middleRightY();
    }
    if (key == 'G') {
      frontCounterClockwise();
      middleLeftY();
    }
  }

//Picks a colour for each side.
  void colored(int COLOR) {
    if (COLOR==0) {
      fill(0, 0, 255);
    }
    if (COLOR==1) {
      fill(0, 255, 0);
    }
    if (COLOR==2) {
      fill(255, 255, 0);
    }
    if (COLOR==3) {
      fill(127, 0, 255);
    }
    if (COLOR==4) {
      fill(255, 0, 0);
    }
    if (COLOR==5) {
      fill(255, 128, 0);
    }
    if (COLOR==6) {
      fill(150);
    }
  }
  
  //Restarts the program.
  void restart() {
    for (int l=0; l<this.row; l++) {
      for (int m=0; m<this.col; m++) {
        for (int n=0; n<6; n++) {
          block[l][m][n]=n;
        }
      }
    }
  }


//Shift blocks in each arrary according to the direction required.
  void rightClockwise() {
    sub = block[0][0][2];
    block[0][0][2]=block[0][2][4];
    block[0][2][4]=block[0][2][3];
    block[0][2][3]=block[0][0][5];
    block[0][0][5]= sub;

    sub = block[0][1][2];
    block[0][1][2]=block[0][1][4];
    block[0][1][4]=block[0][1][3];
    block[0][1][3]=block[0][1][5];
    block[0][1][5]= sub;

    sub = block[0][2][2];
    block[0][2][2]=block[0][0][4];
    block[0][0][4]=block[0][0][3];
    block[0][0][3]=block[0][2][5];
    block[0][2][5]= sub;
    //edges
    sub = block[2][1][1];
    block[2][1][1] = block[1][2][1];
    block[1][2][1] = block[0][1][1];
    block[0][1][1] = block[1][0][1];
    block[1][0][1] = sub;
    //corners
    sub = block[2][0][1];
    block[2][0][1] = block[2][2][1];
    block[2][2][1] = block[0][2][1];
    block[0][2][1] = block[0][0][1];
    block[0][0][1] = sub;
  }
  void middleUpZ() {
    sub = block[1][0][2];
    block[1][0][2]=block[1][2][4];
    block[1][2][4]=block[1][2][3];
    block[1][2][3]=block[1][0][5];
    block[1][0][5]= sub;

    sub = block[1][1][2];
    block[1][1][2]=block[1][1][4];
    block[1][1][4]=block[1][1][3];
    block[1][1][3]=block[1][1][5];
    block[1][1][5]= sub;

    sub = block[1][2][2];
    block[1][2][2]=block[1][0][4];
    block[1][0][4]=block[1][0][3];
    block[1][0][3]=block[1][2][5];
    block[1][2][5]= sub;
  }
  void leftCounterClockwise() {
    sub = block[2][0][2];
    block[2][0][2]=block[2][2][4];
    block[2][2][4]=block[2][2][3];
    block[2][2][3]=block[2][0][5];
    block[2][0][5]= sub;

    sub = block[2][1][2];
    block[2][1][2]=block[2][1][4];
    block[2][1][4]=block[2][1][3];
    block[2][1][3]=block[2][1][5];
    block[2][1][5]= sub;

    sub = block[2][2][2];
    block[2][2][2]=block[2][0][4];
    block[2][0][4]=block[2][0][3];
    block[2][0][3]=block[2][2][5];
    block[2][2][5]= sub;

    //edges
    sub = block[2][1][0];
    block[2][1][0] = block[1][2][0];
    block[1][2][0] = block[0][1][0];
    block[0][1][0] = block[1][0][0];
    block[1][0][0] = sub;
    //corners
    sub = block[2][0][0];
    block[2][0][0] = block[2][2][0];
    block[2][2][0] = block[0][2][0];
    block[0][2][0] = block[0][0][0];
    block[0][0][0] = sub;
  }
  void rightCounterClockwise() {
    sub = block[0][2][5];
    block[0][2][5]=block[0][0][3];
    block[0][0][3]=block[0][0][4];
    block[0][0][4]=block[0][2][2];
    block[0][2][2]= sub;

    sub = block[0][1][5];
    block[0][1][5]=block[0][1][3];
    block[0][1][3]=block[0][1][4];
    block[0][1][4]=block[0][1][2];
    block[0][1][2]= sub;

    sub = block[0][0][5];
    block[0][0][5]=block[0][2][3];
    block[0][2][3]=block[0][2][4];
    block[0][2][4]=block[0][0][2];
    block[0][0][2]= sub;

    //edges
    sub = block[1][0][1];
    block[1][0][1] = block[0][1][1];
    block[0][1][1] = block[1][2][1];
    block[1][2][1] = block[2][1][1];
    block[2][1][1] = sub;
    //corners
    sub = block[0][0][1];
    block[0][0][1] = block[0][2][1];
    block[0][2][1] = block[2][2][1];
    block[2][2][1] = block[2][0][1];
    block[2][0][1] = sub;
  }
  void middleDownZ() {
    sub = block[1][2][5];
    block[1][2][5]=block[1][0][3];
    block[1][0][3]=block[1][0][4];
    block[1][0][4]=block[1][2][2];
    block[1][2][2]= sub;

    sub = block[1][1][5];
    block[1][1][5]=block[1][1][3];
    block[1][1][3]=block[1][1][4];
    block[1][1][4]=block[1][1][2];
    block[1][1][2]= sub;

    sub = block[1][0][5];
    block[1][0][5]=block[1][2][3];
    block[1][2][3]=block[1][2][4];
    block[1][2][4]=block[1][0][2];
    block[1][0][2]= sub;
  }
  void leftClockwise() {
    sub = block[2][2][5];
    block[2][2][5]=block[2][0][3];
    block[2][0][3]=block[2][0][4];
    block[2][0][4]=block[2][2][2];
    block[2][2][2]= sub;

    sub = block[2][1][5];
    block[2][1][5]=block[2][1][3];
    block[2][1][3]=block[2][1][4];
    block[2][1][4]=block[2][1][2];
    block[2][1][2]= sub;

    sub = block[2][0][5];
    block[2][0][5]=block[2][2][3];
    block[2][2][3]=block[2][2][4];
    block[2][2][4]=block[2][0][2];
    block[2][0][2]= sub;

    //edges
    sub = block[1][0][0];
    block[1][0][0] = block[0][1][0];
    block[0][1][0] = block[1][2][0];
    block[1][2][0] = block[2][1][0];
    block[2][1][0] = sub;
    //corners
    sub = block[0][0][0];
    block[0][0][0] = block[0][2][0];
    block[0][2][0] = block[2][2][0];
    block[2][2][0] = block[2][0][0];
    block[2][0][0] = sub;
  }
  /*8*8*8*8*8*8*8*8*8*            *8*8*8*8*8*8**8*8*8*8*8*8*8*8*8*        *8*8*8*8*8*8*8*8*8*/
  void topClockwise() {
    sub = block[0][2][0];
    block[0][2][0]=block[0][2][4];
    block[0][2][4]=block[2][2][1];
    block[2][2][1]=block[2][2][5];
    block[2][2][5]= sub;

    sub = block[1][2][0];
    block[1][2][0]=block[1][2][4];
    block[1][2][4]=block[1][2][1];
    block[1][2][1]=block[1][2][5];
    block[1][2][5]= sub;

    sub = block[2][2][0];
    block[2][2][0]=block[2][2][4];
    block[2][2][4]=block[0][2][1];
    block[0][2][1]=block[0][2][5];
    block[0][2][5]= sub;

    //edges
    sub = block[0][1][2];
    block[0][1][2] = block[1][0][2];
    block[1][0][2] = block[2][1][2];
    block[2][1][2] = block[1][2][2];
    block[1][2][2] = sub;
    //corners
    sub = block[0][0][2];
    block[0][0][2] = block[2][0][2];
    block[2][0][2] = block[2][2][2];
    block[2][2][2] = block[0][2][2];
    block[0][2][2] = sub;
  }
  void middleLeftX() {
    sub = block[0][1][0];
    block[0][1][0]=block[0][1][4];
    block[0][1][4]=block[2][1][1];
    block[2][1][1]=block[2][1][5];
    block[2][1][5]= sub;

    sub = block[1][1][0];
    block[1][1][0]=block[1][1][4];
    block[1][1][4]=block[1][1][1];
    block[1][1][1]=block[1][1][5];
    block[1][1][5]= sub;

    sub = block[2][1][0];
    block[2][1][0]=block[2][1][4];
    block[2][1][4]=block[0][1][1];
    block[0][1][1]=block[0][1][5];
    block[0][1][5]= sub;
  }
  void bottomCounterClockwise() {
    sub = block[0][0][0];
    block[0][0][0]=block[0][0][4];
    block[0][0][4]=block[2][0][1];
    block[2][0][1]=block[2][0][5];
    block[2][0][5]= sub;

    sub = block[1][0][0];
    block[1][0][0]=block[1][0][4];
    block[1][0][4]=block[1][0][1];
    block[1][0][1]=block[1][0][5];
    block[1][0][5]= sub;

    sub = block[2][0][0];
    block[2][0][0]=block[2][0][4];
    block[2][0][4]=block[0][0][1];
    block[0][0][1]=block[0][0][5];
    block[0][0][5]= sub;

    //edges
    sub = block[0][1][3];
    block[0][1][3] = block[1][0][3];
    block[1][0][3] = block[2][1][3];
    block[2][1][3] = block[1][2][3];
    block[1][2][3] = sub;
    //corners
    sub = block[0][0][3];
    block[0][0][3] = block[2][0][3];
    block[2][0][3] = block[2][2][3];
    block[2][2][3] = block[0][2][3];
    block[0][2][3] = sub;
  }
  void topCounterClockwise() {
    sub = block[2][2][5];
    block[2][2][5] = block[2][2][1];
    block[2][2][1] = block[0][2][4];
    block[0][2][4] = block[0][2][0];
    block[0][2][0] = sub;

    sub = block[1][2][5];
    block[1][2][5] = block[1][2][1];
    block[1][2][1] = block[1][2][4];
    block[1][2][4] = block[1][2][0];
    block[1][2][0] = sub;

    sub = block[0][2][5];
    block[0][2][5] = block[0][2][1];
    block[0][2][1] = block[2][2][4];
    block[2][2][4] = block[2][2][0];
    block[2][2][0] = sub;

    //edges
    sub = block[1][2][2];
    block[1][2][2] = block[2][1][2];
    block[2][1][2] = block[1][0][2];
    block[1][0][2] = block[0][1][2];
    block[0][1][2] = sub;
    //corners
    sub = block[0][2][2];
    block[0][2][2] = block[2][2][2];
    block[2][2][2] = block[2][0][2];
    block[2][0][2] = block[0][0][2];
    block[0][0][2] = sub;
  }
  void middleRightX() {
    sub = block[2][1][5];
    block[2][1][5] = block[2][1][1];
    block[2][1][1] = block[0][1][4];
    block[0][1][4] = block[0][1][0];
    block[0][1][0] = sub;

    sub = block[1][1][5];
    block[1][1][5] = block[1][1][1];
    block[1][1][1] = block[1][1][4];
    block[1][1][4] = block[1][1][0];
    block[1][1][0] = sub;

    sub = block[0][1][5];
    block[0][1][5] = block[0][1][1];
    block[0][1][1] = block[2][1][4];
    block[2][1][4] = block[2][1][0];
    block[2][1][0] = sub;
  }
  void bottomClockwise() {
    sub = block[2][0][5];
    block[2][0][5] = block[2][0][1];
    block[2][0][1] = block[0][0][4];
    block[0][0][4] = block[0][0][0];
    block[0][0][0] = sub;

    sub = block[1][0][5];
    block[1][0][5] = block[1][0][1];
    block[1][0][1] = block[1][0][4];
    block[1][0][4] = block[1][0][0];
    block[1][0][0] = sub;

    sub = block[0][0][5];
    block[0][0][5] = block[0][0][1];
    block[0][0][1] = block[2][0][4];
    block[2][0][4] = block[2][0][0];
    block[2][0][0] = sub;

    //edges
    sub = block[1][2][3];
    block[1][2][3] = block[2][1][3];
    block[2][1][3] = block[1][0][3];
    block[1][0][3] = block[0][1][3];
    block[0][1][3] = sub;
    //corners
    sub = block[0][2][3];
    block[0][2][3] = block[2][2][3];
    block[2][2][3] = block[2][0][3];
    block[2][0][3] = block[0][0][3];
    block[0][0][3] = sub;
  }
  /*8*8*8*8*8*8*8*8*8*            *8*8*8*8*8*8**8*8*8*8*8*8*8*8*8*        *8*8*8*8*8*8*8*8*8*/
  void frontClockwise() {
    sub = block[0][0][0];
    block[0][0][0] = block[0][2][3];
    block[0][2][3] = block[0][2][1];
    block[0][2][1] = block[2][2][2];
    block[2][2][2] = sub;

    sub = block[0][1][0];
    block[0][1][0] = block[1][2][3];
    block[1][2][3] = block[0][1][1];
    block[0][1][1] = block[1][2][2];
    block[1][2][2] = sub;

    sub = block[0][2][0];
    block[0][2][0] = block[2][2][3];
    block[2][2][3] = block[0][0][1];
    block[0][0][1] = block[0][2][2];
    block[0][2][2] = sub;

    //edges
    sub = block[0][1][4];
    block[0][1][4] = block[1][2][4];
    block[1][2][4] = block[2][1][4];
    block[2][1][4] = block[1][0][4];
    block[1][0][4] = sub;
    //corners
    sub = block[0][0][4];
    block[0][0][4] = block[0][2][4];
    block[0][2][4] = block[2][2][4];
    block[2][2][4] = block[2][0][4];
    block[2][0][4] = sub;
  }
  void middleRightY() {
    sub = block[1][0][0];
    block[1][0][0] = block[0][1][3];
    block[0][1][3] = block[1][2][1];
    block[1][2][1] = block[2][1][2];
    block[2][1][2] = sub;

    sub = block[1][1][0];
    block[1][1][0] = block[1][1][3];
    block[1][1][3] = block[1][1][1];
    block[1][1][1] = block[1][1][2];
    block[1][1][2] = sub;

    sub = block[1][2][0];
    block[1][2][0] = block[2][1][3];
    block[2][1][3] = block[1][0][1];
    block[1][0][1] = block[0][1][2];
    block[0][1][2] = sub;
  }
  void backCounterClockwise() {
    sub = block[2][0][0];
    block[2][0][0] = block[0][0][3];
    block[0][0][3] = block[2][2][1];
    block[2][2][1] = block[2][0][2];
    block[2][0][2] = sub;

    sub = block[2][1][0];
    block[2][1][0] = block[1][0][3];
    block[1][0][3] = block[2][1][1];
    block[2][1][1] = block[1][0][2];
    block[1][0][2] = sub;

    sub = block[2][2][0];
    block[2][2][0] = block[2][0][3];
    block[2][0][3] = block[2][0][1];
    block[2][0][1] = block[0][0][2];
    block[0][0][2] = sub;

    //edges
    sub = block[0][1][5];
    block[0][1][5] = block[1][2][5];
    block[1][2][5] = block[2][1][5];
    block[2][1][5] = block[1][0][5];
    block[1][0][5] = sub;
    //corners
    sub = block[0][0][5];
    block[0][0][5] = block[0][2][5];
    block[0][2][5] = block[2][2][5];
    block[2][2][5] = block[2][0][5];
    block[2][0][5] = sub;
  }
  void frontCounterClockwise() {
    sub = block[2][2][2];
    block[2][2][2] = block[0][2][1];
    block[0][2][1] = block[0][2][3];
    block[0][2][3] = block[0][0][0];
    block[0][0][0] = sub;

    sub = block[1][2][2];
    block[1][2][2] = block[0][1][1];
    block[0][1][1] = block[1][2][3];
    block[1][2][3] = block[0][1][0];
    block[0][1][0] = sub;

    sub = block[0][2][2];
    block[0][2][2] = block[0][0][1];
    block[0][0][1] = block[2][2][3];
    block[2][2][3] = block[0][2][0];
    block[0][2][0] = sub;

    //edges
    sub = block[1][0][4];
    block[1][0][4] = block[2][1][4];
    block[2][1][4] = block[1][2][4];
    block[1][2][4] = block[0][1][4];
    block[0][1][4] = sub;
    //corners
    sub = block[2][0][4];
    block[2][0][4] = block[2][2][4];
    block[2][2][4] = block[0][2][4];
    block[0][2][4] = block[0][0][4];
    block[0][0][4] = sub;
  }
  void middleLeftY() {
    sub = block[2][1][2];
    block[2][1][2] = block[1][2][1];
    block[1][2][1] = block[0][1][3];
    block[0][1][3] = block[1][0][0];
    block[1][0][0] = sub;

    sub = block[1][1][2];
    block[1][1][2] = block[1][1][1];
    block[1][1][1] = block[1][1][3];
    block[1][1][3] = block[1][1][0];
    block[1][1][0] = sub;

    sub = block[0][1][2];
    block[0][1][2] = block[1][0][1];
    block[1][0][1] = block[2][1][3];
    block[2][1][3] = block[1][2][0];
    block[1][2][0] = sub;
  }
  void backClockwise() {
    sub = block[2][0][2];
    block[2][0][2] = block[2][2][1];
    block[2][2][1] = block[0][0][3];
    block[0][0][3] = block[2][0][0];
    block[2][0][0] = sub;

    sub = block[1][0][2];
    block[1][0][2] = block[2][1][1];
    block[2][1][1] = block[1][0][3];
    block[1][0][3] = block[2][1][0];
    block[2][1][0] = sub;

    sub = block[0][0][2];
    block[0][0][2] = block[2][0][1];
    block[2][0][1] = block[2][0][3];
    block[2][0][3] = block[2][2][0];
    block[2][2][0] = sub;

    //edges
    sub = block[1][0][5];
    block[1][0][5] = block[2][1][5];
    block[2][1][5] = block[1][2][5];
    block[1][2][5] = block[0][1][5];
    block[0][1][5] = sub;
    //corners
    sub = block[2][0][5];
    block[2][0][5] = block[2][2][5];
    block[2][2][5] = block[0][2][5];
    block[0][2][5] = block[0][0][5];
    block[0][0][5] = sub;
  }
}

import g4p_controls.*;

Cube Rubik = new Cube(100, 80, 3, 3);

int l;
int m;
int n;
int sub;
int [][][]block = new int [Rubik.row][Rubik.col][6];
void setup() {
  size(600, 600, P3D);
  //noStroke();
  strokeWeight(10);
  noFill();
  rectMode(CENTER);
  for (int l=0; l<3; l++) {
    for (int m=0; m<3; m++) {
      for (int n=0; n<6; n++) {
        block[l][m][n]=n;
      }
    }
  }
  createGUI();
}
void draw() {
  background(127, 127, 127);
  translate(width/2, height/2);
  rotateX(-mouseY*PI/300);
  rotateY(-mouseX*PI/300);
  noFill();
  box(2.99*Rubik.size1);
  Rubik.drawMe();
}
void keyPressed() {
  Rubik.keys();
}

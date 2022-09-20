boolean F = false, T = true;
float w0 = 0.005, w1 = 0.01, w2 = 0.015, w3 = 0.04;
int f0 = 0, qp0 = round(HALF_PI/w0), qp1 = round(HALF_PI/w1), qp2 = round(HALF_PI/w2), hp1 = round(HALF_PI/w1), hp2 = round(HALF_PI/w2);
int framesToFinish = 1256;
float phaseShift = PI/(2*framesToFinish*w1);
Demo d1 = new Demo("QG", 3*qp1, 9, 5, w1, 0, 1.0, 1.0, F, T, T, T, T, T, T, QUARTER_PI, color(240), color(240), color(40), F, 0, 0, 0, 0);
Demo d2 = new Demo("QG", 4*qp1, 9, 5, w2, 0, 1.01, 1.0, T, T, F, F, F, F, F, QUARTER_PI, color(0), color(255), color(70), F, 0, 0, 0, 0);
Demo d3 = new Demo("QG", 4*qp2, 15, 9, w2, 0, 1.40, 1, T, T, T, F, F, F, F, HALF_PI, color(0), color(0), color(0, 120, 0), F, 0, 0, 0, 0);
Demo d4 = new Demo("QG", 4*qp1, 12, 7, w1, 0, 1.25, 1.25, T, F, F, F, F, F, F, QUARTER_PI, color(255, 160, 200), color(255, 160, 200), color(0), F, 0, 0, 0, 0);
Demo d5 = new Demo("QG", 4*qp1, 12, 7, w1, 0, 1.25, 1.25, T, F, F, F, F, F, F, QUARTER_PI, color(0), color(0), color(255, 160, 200), F, 0, 0, 0, 0);
Demo d6 = new Demo("QG", 4*qp1, 20, 12, w1, 0, 0.5, 4, T, T, F, F, F, F, F, QUARTER_PI, color(0), color(255), color(0, 160, 0), F, 0, 0, 0, 0);
Demo d7 = new Demo("QG", 4*qp1, 20, 12, w2, 0, 0.05, 30, T, T, F, F, F, F, F, QUARTER_PI, color(0), color(255), color(0, 160, 0), F, 0, 0, 0, 0);
Demo d8 = new Demo("QG", 4*qp1, 30, 22, w3, 0, 1.25, 1, T, T, F, F, F, F, F, QUARTER_PI, color(255), color(255), color(0), F, 0.1, 0.1, 0, 0);
Demo d9 = new Demo("QG", framesToFinish, 30, 20, w1, 0, 1.38, 1, F, F, F, F, F, F, F, QUARTER_PI, color(0), color(255, 255, 0), color(0, 220, 255), F, 0, 0, phaseShift, phaseShift);
Demo d10 = new Demo("QG", framesToFinish, 20, 12, w1, 0, 0.5, 4, T, T, F, F, F, F, F, QUARTER_PI, color(0), color(255), color(0, 160, 0), F, 0, 0, phaseShift, phaseShift);

Demo[] demos = {d1, d2, d3, d4, d5, d6, d7, d8, d9, d10};
int i = 0; //demo number being run
int frame = 0;

void settings() {
  size( 1400, 700 );
}

void setup() {
  noStroke();
  rectMode( CENTER );  
  imageMode( CENTER );
  frameRate(30);
}


void draw() {
  background( demos[i].backgroundCol );

  demos[i].drawFrame();
  demos[i].updatePositions();

  if ( frame > demos[i].duration ) {
    if ( i < demos.length-1 ) {
      i++;
      frame = 0;
    } else
      noLoop();
  }

  frame++;
  //saveFrame("frames/#####.jpg");
}

int numRows = 5;                   //Number of rows of marchers
int rowLength = 20;                //Number of marchers per row
float xSpeed = 3;                  //x-speed of the marchers on pavement
float m = 1.5;                     //Initial slope of the rows
float separation = 8;              //Horizontal spacing between marchers
float separationBetweenRows = 15;  //Vertical spacing between rows
float speedReductionFactor = 0.5;  //The ratio of the marchers' speed in syrup over their speed on pavement
Marcher[][] theBand;
int yMapleSyrup;

float ySpeed = xSpeed/m;          //Why is this formula true?


void setup() {
  frameRate(20);
  size(1200, 700);
  yMapleSyrup = 2*height/3;

  theBand = new Marcher[numRows][rowLength];

  for (int row = 0; row < numRows; row++) {
    for (int person = 0; person < rowLength; person++) {
      float x = person*separation - row * xSpeed * separationBetweenRows;
      float y = 350 - person*m*separation - row * ySpeed * separationBetweenRows;
      theBand[row][person] = new Marcher( x, y, xSpeed, ySpeed );
    }
  }
}


void draw() {
  background(200, 200, 200);
  fill(#cc9900);
  rect(0, yMapleSyrup, width, height-yMapleSyrup);

  fill(0, 0, 255);
  noStroke();


  for (int row=0; row < numRows; row++) {
    for (int person=0; person < rowLength; person++) {

      Marcher m = theBand[row][person];
      m.drawMe();
      m.updatePosition();

      if ( m.yPos >= yMapleSyrup && m.inMapleSyrup == false ) {  //if m has just entered the syrup...

        m.slowDown( speedReductionFactor );
        m.inMapleSyrup = true;
      }
    }
  }
}

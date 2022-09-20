int maximumLevel = 7;
int padding = 50;
int currLevel = 1;

void setup() {
    size(600,600);
    frameRate(1);
    fill(255,255,0);
}


void draw() {
  if( currLevel <= maximumLevel) {
      background(0);
      
      Point2D a = new Point2D( width/2, padding ); //top most point
      Point2D b = new Point2D( padding, height-padding); //lower-left-most point
      Point2D c = new Point2D( width-padding, height-padding ); //lower-right-most point
      
      drawSierpinskiTriangle(currLevel, a, b, c);  
      currLevel++;
  }
  
  else
    noLoop();
}


void drawSierpinskiTriangle(int level, Point2D a, Point2D b, Point2D c) {
   //BASE CASE
   if (level == 1) 
        triangle( a.x, a.y,  b.x, b.y,  c.x, c.y );   //DRAWS A SINGLE SOLID TRIANGLE BETWEEN POINTS a, b, AND c 
   
    //RECURSIVE CASE
    else {
        //CALCULATE THE 3 MIDPOINTS 
        Point2D m12 = midpoint(a, b);
        Point2D m23 = midpoint(b, c);
        Point2D m31 = midpoint(c, a);

        // 3 RECURSIVE CALLS
        fill(255,220,220);
        drawSierpinskiTriangle( level - 1,   a,   m12, m31 );  //The top third
        fill(0,205,195);
        drawSierpinskiTriangle( level - 1,   m12, b,   m23 );  //The lower-left third
        fill(255,120,0);
        drawSierpinskiTriangle( level - 1,   m31, m23, c );    //The lower-right third
    }
}

//CALCULATES THE MIDPoint2D BETWEEN TWO GIVEN POINTS
Point2D midpoint(Point2D a, Point2D b) {
    return new Point2D( (a.x + b.x)/2, (a.y + b.y)/2 ); //ARITHMETIC MEAN
 }

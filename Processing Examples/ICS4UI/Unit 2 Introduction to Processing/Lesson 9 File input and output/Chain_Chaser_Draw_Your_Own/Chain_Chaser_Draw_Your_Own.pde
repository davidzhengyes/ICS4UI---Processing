float ballSize = 20;
float k = 0.50;

PVector[] balls; //not committing to the size yet
PrintWriter pw;
boolean mouseDown = false, mouseReleased = false;
int numPoints = 0;

void setup() {
  size(900,800);
  background(0);
  noStroke();
  pw = createWriter("Your points.txt");
}


void draw() {
  if( mouseReleased ) {
    background(0);
    fill(255);
    
    //draws the balls in their current positions
    for( int i=0; i < numPoints; i++ )
      ellipse(balls[i].x, balls[i].y, ballSize, ballSize);
    
    balls[0].x += (mouseX-balls[0].x)*k;
    balls[0].y += (mouseY-balls[0].y)*k;
      
    //makes each non-leader ball chase the ball ahead of it
    for(int i=1; i<numPoints; i++){
      balls[i].x += (balls[i-1].x - balls[i].x)*k;
      balls[i].y += (balls[i-1].y - balls[i].y)*k;
    }
  }
}


void mouseReleased(){
  if ( !mouseReleased ) {
    pw.close();
    
    String[] lines = loadStrings( "Your points.txt" );
    numPoints = lines.length;
    
    balls = new PVector[ numPoints ];
    
    for (int i=0; i < numPoints; i++ ) {
      int j = numPoints - 1 - i;
      String[] xyVals = lines[j].split(",");
      
      balls[i] = new PVector();
      balls[i].x = parseInt(xyVals[0]);
      balls[i].y = parseInt(xyVals[1]);
    }
  
  mouseReleased = true;
  }
}


void mouseDragged(){  //different from mouseMoved, which is only triggered when the mouse isn't down
  if (!mouseReleased) {
     fill(255);
     ellipse(mouseX, mouseY, ballSize, ballSize);
     pw.println(mouseX + "," + mouseY);
  }
}


void mousePressed() {
  background(0);
  mouseReleased = false;
  pw = createWriter("Your points.txt");
}

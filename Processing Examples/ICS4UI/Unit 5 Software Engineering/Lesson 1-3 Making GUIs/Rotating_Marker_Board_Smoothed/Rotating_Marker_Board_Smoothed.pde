import g4p_controls.*;

//DECLARING THE OBJECTS
Marker myMarker = new Marker( color(120,0,255) ) ;  //Purple marker
ArrayList<Dot> dots;
Dot[] edgedots;
float tolerance = 10;

//OTHER GLOBAL VARIABLES
float wheelRotationalFreq;
int numEdgedots = 8;
PVector center;
boolean paused = false;
boolean mouseDown = false;
boolean showShape = true;
float t = 0;
float wheelRadius;
int wheelDirection = 1;
float diameter;
float xC, yC;


//MAIN PROCEDURE
void setup(){
  size(500,500);
  background(0);
  noStroke();
    
  createGUI();

  getControllerValues();  //Reads all values from the slider bars
  
  xC = width/2;
  yC = height/2;
 
  center = new PVector(xC, yC);
  wheelRadius = width/2.05;
  diameter = 2 * wheelRadius;
  
  dots = new ArrayList<Dot>();
  edgedots = new Dot[10];
  
  createEdgedots();
}


void createEdgedots() {
  float theta = 0;
  for ( int i = 0; i < numEdgedots; i++ ) {
    float x = width/2 + wheelRadius*cos(theta);
    float y = width/2 - wheelRadius*sin(theta);
    edgedots[i] = new Dot( x, y, center, color(255,120,0), 10);
    theta += 2*PI/numEdgedots;
  }
}


//DRAWING PROCEDURE
void draw() {
  if (paused == false) {
    
    //Draws the main wheel
    background(0);
    fill(255);
    noStroke();
    circle( xC, yC, diameter );
    
    //Draws the curve created so far, then rotates it 
    fill( myMarker.colour );
    stroke( myMarker.colour );
    strokeWeight( myMarker.strokeSize );
    
    int n = dots.size();
    
    if (myMarker.motionType.equals("mouse")) {
      for( Dot d : dots ) 
        d.drawMe();
    }
    
    else  {
      if(n >= 2) {
        Dot d0 = dots.get(0);
        Dot d1 = dots.get(1);
        line(d0.location.x,d0.location.y, d1.location.x,d1.location.y);
        Dot dEnd1 = dots.get(dots.size()-2);
        Dot dEnd2 = dots.get(dots.size()-1);
        line(dEnd1.location.x,dEnd1.location.y, dEnd2.location.x,dEnd2.location.y);
      }
      
      if(n >= 4) {   
        //if( !patternFinished() ) {
          for(int i = 0; i < dots.size()-3; i++ ) {
            Dot dA = dots.get(i);
            Dot dB = dots.get(i+1);
            Dot dC = dots.get(i+2);
            Dot dD = dots.get(i+3);
            
            if( dB.distFromCenter < wheelRadius &&  dC.distFromCenter < wheelRadius)  
                curve( dA.location.x, dA.location.y, dB.location.x, dB.location.y, dC.location.x, dC.location.y, dD.location.x, dD.location.y );
          }
        //}
      }
    }
    
 
    
    for( Dot d : dots ) 
        d.rotate( wheelRotationalFreq * wheelDirection );  
    
    //Draws and rotates the edge dots
    for( int i = 0; i < numEdgedots; i++ ) {
      edgedots[i].drawMe();
      edgedots[i].rotate( wheelRotationalFreq * wheelDirection );
    }
    
    //Moves the marker
    myMarker.updatePosition(); 
    
    //Creates a new coloured dot where the marker currently is and adds it to the list of dots to be drawn next frame
    Dot newDot;
    
    if ( ! myMarker.motionType.equals("mouse") && myMarker.distFromCenter < wheelRadius ) {  
        newDot = new Dot( myMarker.x, myMarker.y, center, myMarker.colour, 5); 
        dots.add( newDot ); 
    }
    
    //Draws the marker
    myMarker.drawMe();
    
    //Draws the generator shape (pretzel, figure 8, square, etc.)
    if( showShape )
      showGeneratorShape();

    t += 1; //INCREMENTS THE GLOBAL TIMER
    
    //saveFrame("frames/#####.jpg");
  }
}


void mouseDragged() {
  if( myMarker.motionType.equals("mouse") && myMarker.distFromCenter < wheelRadius ) {
    Dot newcurrDot = new Dot(mouseX, mouseY, center, myMarker.colour, 10); 
    dots.add( newcurrDot );
  }
}


void showGeneratorShape() {
  stroke(0,200,255);
  strokeWeight(2);
  
  if ( myMarker.motionType.equals("sinusoidal") ) {
      float xLeft = width*myMarker.xCentrePercent - myMarker.amplitude;
      float xRight = xLeft + 2*myMarker.amplitude;
      float y = height*myMarker.yCentrePercent;
      line(xLeft, y, xRight, y);
  }
    
  else if ( myMarker.motionType.equals("circular") ) { 
      noFill();
      circle( width*myMarker.xCentrePercent, height*myMarker.yCentrePercent, 2*myMarker.amplitude );
  }
    
  else if ( myMarker.motionType.equals("figure8") || myMarker.motionType.equals("pretzel") || myMarker.motionType.equals("parabola")) { 
      float x, y, xPrev=0, yPrev=0;
      float A = myMarker.amplitude;
      float xC = width * myMarker.xCentrePercent;
      float yC = height * myMarker.yCentrePercent;
      int a, b;
      float phaseShift = 0;
      
      if( myMarker.motionType.equals("figure8") ) {
        a = 2; b = 1;
      }
      
      else if( myMarker.motionType.equals("pretzel") ) {
        a = 4; b = 3;
      }
      
      else { //PARABOLA
        a = 1; b = 2;
        phaseShift = HALF_PI;
      }

      for(float theta = 0; theta <= 2*PI+0.05; theta+=.05 ) {
        x = xC + A*sin( a*theta );
        y = yC - A*sin( b*theta + phaseShift );
        if(theta > 0) 
          line(x, y, xPrev, yPrev);
        xPrev = x;
        yPrev = y;
      }
  } 
    
  else if ( myMarker.motionType.equals("square") ) { 
      noFill();
      float A = myMarker.amplitude;
      square( width*myMarker.xCentrePercent-A, height*myMarker.yCentrePercent-A, 2*A);
  }
}


void getControllerValues() {
  myMarker.motionType = motionTypeDropList.getSelectedText();
  wheelRotationalFreq = wheelSpeedSlider.getValueF() / 100;
  myMarker.frequency = markerFrequencySlider.getValueF() / 100;
  myMarker.amplitude  = ampSlider.getValueF();
  myMarker.xCentrePercent = xSlider.getValueF() / 100;
  myMarker.yCentrePercent = ySlider.getValueF() / 100;
  myMarker.strokeSize = strokeSizeSlider.getValueI();
  myMarker.getSquareParameters();
}


void setControllerValues( int motionType, int wheelSpeed, int markerSpeed, int acurrDot, int xC, int yC, int ss ) {
  motionTypeDropList.setSelected( motionType );
  wheelSpeedSlider.setValue( wheelSpeed );
  markerFrequencySlider.setValue( markerSpeed );
  ampSlider.setValue( acurrDot );
  xSlider.setValue( xC );
  ySlider.setValue( yC );
  strokeSizeSlider.setValue( ss );
}


void clear() {
   dots = new ArrayList<Dot>();
}


boolean patternFinished() {
  int n = dots.size();
  PVector firstPoint = dots.get(0).location;
  PVector lastPoint = dots.get( n-1).location;
  
  if ( dist( firstPoint.x, firstPoint.y, lastPoint.x, lastPoint.y ) < tolerance ) {
    println("Done", n, firstPoint.toString(),lastPoint.toString() );
    return true;
  }
  
  else return false;

}

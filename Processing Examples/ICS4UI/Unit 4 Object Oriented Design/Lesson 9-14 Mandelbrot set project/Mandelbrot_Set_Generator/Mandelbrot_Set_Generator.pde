import g4p_controls.*;

String coloringMethod = "escape count";  //"basic", "bands", "escape count"
float aMin, aMax, bMin, bMax;
float zoomFactor = 1.50;

boolean animateZoom = false;
float animatedZoomFactor = 1.10;


float aRange, bRange;
float aCentre, bCentre;
float unitsPerPixel; //the ratio (aMax-aMin)/width;
float k = PI/512;

color[] bands; 


void setup() {
  size(500, 500);
  stroke(255,235,235);
  createGUI();
  
  resetStartingValues(); //Sets aMin=-1.8, aMax = 0.5, bMin = -1.15, bMax = 1.15
  resetRatios();         //Recalculates aRange, bRange, aCentre, bCentre and unitsPerPixel based on the 
                         //the latest values of aMin, aMax, bMin and bMax
  
  noLoop();
  
  if (coloringMethod.equals( "bands" ) ) {
    bands = new color[256];
    
    for (int i=0; i < 256; i++) {
      bands[i] = color(i,255-i,0);
    }
  }
}


void draw() {
  background(255);
  stroke(0); //Points will be black

  if (coloringMethod.equals( "basic" )) {

    ComplexNumber c, z;
    int n;
    
    for (float x = 0; x < width; x++) {
      float a = get_a_value(x);

      for (float y = 0; y < height; y++) {
        float b = get_b_value(y);

        c = new ComplexNumber(a, b);
        z = c;
        n = 1;

        while ( z.absoluteValueSquared() < 4 && n < 300) {
          z = z.square().add(c);
          n++;
        }

        if (n >= 300)       
          point(x, y);        
      }
    }
  } 
  
  else if (coloringMethod.equals( "escape count" )) { 
    
    ComplexNumber c, z;
    int n;

    for (float x = 0; x < width; x++) {
      float a = get_a_value( x );

      for (float y = 0; y < height; y++) {
        float b = get_b_value( y );
        
        c = new ComplexNumber(a, b);
        z = c;
        n = 0;

        while (z.absoluteValueSquared() < 4 && n < 255) {
          z = z.square().add(c);
          n++;
        }
        
        color dotcolor;
        
        if( n >= 254 )
          dotcolor = color(0);//we're in the M.S.
        
        else {
          dotcolor = color(n);
        } 
        
        stroke( dotcolor );
        point (x, y);
      }
    }
  } 
  
  else if (coloringMethod.equals("bands")) {        

    ComplexNumber c, z;
    int n;
    
    for (float x = 0; x < width; x++) {
      float a = get_a_value(x);

      for (float y = 0; y < height; y++) {
        float b = get_b_value(y);

        c = new ComplexNumber(a, b);
        z = c;
        n = 0;

        while (z.absoluteValueSquared() < 4 && n < 255) {
          z = z.square().add(c);
          n++;
        }

        color dotcolor = bands[n]; 
        stroke( dotcolor );
        point (x, y);
      }
    }
  }
  
  if( animateZoom ) {
    zoomIn( animatedZoomFactor );
  }
}

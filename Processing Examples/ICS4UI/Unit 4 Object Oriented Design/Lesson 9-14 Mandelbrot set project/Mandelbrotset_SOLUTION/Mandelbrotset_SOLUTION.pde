float aMin, aMax, bMin, bMax;
float zoomFactor = 1.50;

boolean animateZoom = false;
float animatedZoomFactor = 1.10;

float aRange, bRange;
float aCentre, bCentre;
float unitsPerPixel; //the ratio (aMax-aMin)/width;
float k = PI/512;

void setup() {
  size(1000,1000);
  noLoop();
  resetStartingValues(); //Sets aMin=-1.8, aMax = 0.5, bMin = -1.15, bMax = 1.15
  resetRatios();     
}

void draw() {
    background(255);
  
    ComplexNumber c, z;
    int n;

    for (float x = 0; x < width; x++) {
      float a = get_a( x );

      for (float y = 0; y < height; y++) {
        float b = get_b( y );
        
        c = new ComplexNumber(a, b);
        z = c;
        n = 0;

        while (z.absoluteValueSquared() < 4 && n < 200) {
          z = z.multiply(z).add(c);
          n++;
        }
        
        if( n >= 200) {  //IN MANDELBROT 
          stroke(0);  //draw black dot
          point(x,y);
        }
        
        else { //NOT IN MANDELBROT SET
          //do nothing
        }
      }
    }
  
}

void resetRatios() {
  unitsPerPixel = (aMax-aMin)/width;
  
  aRange = aMax - aMin;
  bRange = bMax - bMin;
  
  aCentre = (aMin + aMax)/2;
  bCentre = (bMin + bMax)/2;
}


void resetStartingValues() {
  aMin = -1.8;
  aMax = 0.5;
  bMin = -1.15;
  bMax = 1.15;
  
 //aMin = 0.3770; //left edge of screen
 //aMax = 0.37705; //right edge of screen
 //bMax = 0.1730; //top edge of screen
 //bMin = 0.17295; //bottom edge of screen

  resetRatios();
}


float get_a(float x) {
  return aMin + x*unitsPerPixel;
}


float get_b(float y) {
  return bMax - y*unitsPerPixel;
}

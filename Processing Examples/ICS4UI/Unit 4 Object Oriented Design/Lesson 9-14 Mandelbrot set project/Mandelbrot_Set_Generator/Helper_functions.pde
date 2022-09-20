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
  resetRatios();
}


float get_a_value(float x) {
  return aMin + x*unitsPerPixel;
}


float get_b_value(float y) {
  return bMax - y*unitsPerPixel;
}


void zoomIn(float factor) {
  aRange /= factor;
  bRange /= factor;
  
  aMin = aCentre - aRange/2;
  aMax = aCentre + aRange/2;
      
  bMin = bCentre - bRange/2;
  bMax = bCentre + bRange/2;
    
  resetRatios();
  redraw();
}


void zoomOut(float factor) {
  aRange *= factor;
  bRange *= factor;
  
  aMin = aCentre - aRange/2;
  aMax = aCentre + aRange/2;
      
  bMin = bCentre - bRange/2;
  bMax = bCentre + bRange/2;
    
  resetRatios();
  redraw();
}



float getColor(int x) {
  return 256*cos(k*x);
}

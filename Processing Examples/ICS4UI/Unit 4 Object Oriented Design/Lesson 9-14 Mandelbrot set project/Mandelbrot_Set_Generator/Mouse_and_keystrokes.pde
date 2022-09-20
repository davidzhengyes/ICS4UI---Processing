void mouseClicked() {
  float a_centreNew = get_a_value( mouseX );
  float aHalfRange = (aMax-aMin)/2;
  aMin = a_centreNew - aHalfRange;
  aMax = a_centreNew + aHalfRange;

  float b_centreNew = get_b_value(mouseY);
  float bHalfRange = (bMax-bMin)/2;
  bMin = b_centreNew - bHalfRange;
  bMax = b_centreNew + bHalfRange;

  resetRatios();
  redraw();
}


void keyPressed() {
  if (key=='r') {
    resetStartingValues();
    redraw();
  }
    
  else if (key == 'i') 
      zoomIn( zoomFactor );
       
  else if (key == 'o') 
      zoomOut( zoomFactor );
}

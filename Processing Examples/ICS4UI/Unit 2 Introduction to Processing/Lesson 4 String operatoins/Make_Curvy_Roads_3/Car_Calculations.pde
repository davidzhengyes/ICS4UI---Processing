void drawCar(float x, float y, float angle){
  fill(255,0,0);
  
  pushMatrix();
  
  translate(x, y);
  rotate(angle);
  //rect(0, 0, 60, 30); 
  image(carImg, 0,0);
  popMatrix();
}


float getDerivative(float p1, float p2, float p3, float p4, float t) {
  float deltaT = 0.4;
  float f_of_t_plus_dt = curvePoint(p1, p2, p3, p4, t + deltaT );
  float f_of_t = curvePoint(p1, p2, p3, p4, t );
  
  return (f_of_t_plus_dt - f_of_t) / deltaT;
}


void resetCar() {
  dotNum = 0;
  t = 0.0;
}

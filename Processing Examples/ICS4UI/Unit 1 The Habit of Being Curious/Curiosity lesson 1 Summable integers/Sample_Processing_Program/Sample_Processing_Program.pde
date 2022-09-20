float t=0.0;

void setup(){
  size(800,400);
  background(200,200,0);
}

void draw(){
  
  if (t < 200) {
    pushMatrix();
    translate(width/3 + 2.5*t, height/2);
    rotate(t/2.5);
    stroke(0);
    fill(255,0,0);
    rect(0,0,200-t,100-t/2);
    popMatrix();
    
    pushMatrix();
    translate(2*width/3 - 2.5*t, height/2);
    rotate(-t/2.5);
    stroke(255);
    fill(0);
    rect(0,0,200-t,100-t/2);
    popMatrix();
  }
  
  t += .1;
}

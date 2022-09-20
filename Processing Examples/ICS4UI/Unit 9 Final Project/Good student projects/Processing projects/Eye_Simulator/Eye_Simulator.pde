import g4p_controls.*;
Eye e;
Image img;
Image lensedImg;
Lens l;

void setup() {
  frameRate(5);
  textAlign(CENTER);
  rectMode(CENTER);
  createGUI();

  e = new Eye(width-50, 100);
  l = new Lens(0, e);
  e.addLens(l);
  img = new Image(0.25, e, 256, "blue.png", e.nearPoint, e.farPoint);
  lensedImg = new Image(0.25, e, 256, "blue.png", e.lensedNP, e.lensedFP);

  background(0);
  size(700, 700);
}

void draw() {
  noStroke();
  background(0);
  stroke(255);
  line(0, 100, width, 100);

  //text
  fill(255);
  textSize(24);
  text("Ray Diagram", width/2, 50);
  text("Vision Simulation", width/2, 200);
  text("Values", width/2, 550);

  textSize(16);
  text("Without Lens", 222, 225);
  text("With Lens", 478, 225);
  text("Current Distance: "+str(img.dist)+" m", 212, 575);
  text("Current Eye Power: "+str(e.power)+" D", 212, 600);
  text("Current Lens Power: "+str(l.power)+" D", 212, 625);
  text("Total Power (with Lens): "+str(e.lensedPower)+" D", 212, 650);
  text("Near Point: "+str(e.nearPoint)+" m", 488, 575);
  text("Far Point: "+str(e.farPoint)+" m", 488, 600);
  text("N. Pt. (Lensed): "+str(e.lensedNP)+" m", 488,625);
  text("F. Pt. (Lensed): "+str(e.lensedFP)+" m", 488,650);

  e.drawSelf();
  l.drawSelf();
  img.drawRepresentation(100);
  img.drawSelf(94, 240);
  lensedImg.drawSelf(350, 240);
  img.blurE();
  lensedImg.blurE();
}

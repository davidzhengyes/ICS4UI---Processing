Plane random; 
Plane FB;
Plane BF;
Plane alternating; 
int PEOPLESIZE;
int WAITTIME;

void setup() {
  PEOPLESIZE = 10;
  WAITTIME = 50;
  size(1000,800);
  

  BF = new Plane(40,6,200,300);
  BF.fillPlane("sectionsBF");
  
  random = new Plane(40,6,200,100);
  random.fillPlane("random");

  alternating = new Plane(40,6,200,500);
  alternating.fillPlane("alternating");
  
  FB = new Plane(40,6,200,700);
  FB.fillPlane("rowTB");
  
  frameRate(150);
}

void draw() {
  clear();
  random.update();
  FB.update();
  BF.update();
  alternating.update();
}

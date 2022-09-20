class Ball extends Body {
  PVector angularVelocity;
  PVector effectiveVelocity;
  float radius;
  Fluid fluid;
  ArrayList<Node> nodes;
  
  Ball(PVector p, PVector v, float m, PVector a, float s, float r, Fluid f) {
    //Create new ball object using arguments
    super(p, v.add(f.getVelocity(p)), m);  //Call the Body constructor
    this.fluid = f;
    this.angularVelocity = a.setMag(s); //CCW is positive
    this.updateVelocity();
    this.radius = r;
    this.nodes = new ArrayList<Node>();
  }
  
  void updateVelocity() {
    //Recalculate velocity of the fluid perpendicular to the axis of rotation
    PVector fluidVelocity = this.getVelocity().sub(this.getFluid().getVelocity(this.getPosition()));
    PVector velocityProjection = this.getAngularVelocity().mult(fluidVelocity.dot(this.getAngularVelocity())/pow(this.getAngularVelocity().mag(), 2));
    this.effectiveVelocity = this.getVelocity().sub(velocityProjection);
  }
  
  void update(float dt) {
    //Set a new node at the current position
    this.nodes.add(new Node(this.getPosition(), this.getVelocity()));
    //Update the velocity and position of the ball
    this.applyGravity(9.8);
    this.applyMagnus();
    this.angularVelocity.add(this.getFluid().getCurl(this.getPosition()).mult(dt));
    super.update(dt);
  }
  
  void render(PVector center, PVector frame, float perspective) {  
    //Render all the recorded nodes
    for (Node n: nodes) {
      n.render(center, frame, 3);
    }
    
    //Top View
    if (this.getPosition().x > center.x-frame.x && this.getPosition().x < center.x+frame.x) {
      PVector xyVelocity = new PVector(this.getVelocity().x, this.getVelocity().y, 0);
      strokeWeight(1);
      fill(map(xyVelocity.mag(), 30, 50, 50, 255), 0, 0, 255);
      float screenX = map(this.getPosition().x, center.x-frame.x, center.x+frame.x, border, width/2-border);
      float screenY = map(this.getPosition().y, center.y, center.y+frame.y, height-border, border);
      float screenZ = map(this.getPosition().z, 0, frame.z, this.getRadius()*100, this.getRadius()*100+perspective);
      ellipse(screenX, screenY, screenZ, screenZ);
      
      //Head-on View
      PVector xzVelocity = new PVector(this.getVelocity().x, 0, this.getVelocity().z);
      strokeWeight(1);
      fill(map(xzVelocity.mag(), 0, 20, 50, 255), 0, 0, 255);
      screenX = map(this.getPosition().x, center.x-frame.x, center.x+frame.x, width/2+border, width-border);
      screenY = map(this.getPosition().y, center.y, center.y+frame.y, this.getRadius()*100+perspective, this.getRadius()*100);
      screenZ = map(this.getPosition().z, 0, frame.z, height-border, border);
      ellipse(screenX, screenZ, screenY, screenY);
    }
  }
  
  void applyGravity(float g) {
    //Add the force of gravity to the instantaneous force on the ball
    PVector gravityForce = new PVector(0, 0, -g*this.getMass());
    this.force.add(gravityForce);
  }
  
  void applyMagnus() {
    //Add the magnus force to the instantaneous force on the ball
    //Update the effective velocity for most recent information
    this.updateVelocity();
    if (this.getAngularVelocity().mag() != 0 && this.getVelocity().mag() != 0) {
      //Integrate along the axis of rotation
      float scalar = 16 / 3 * pow(PI, 2) * pow(this.getRadius(), 3) * this.getAngularVelocity().mag() * this.getFluid().getDensity() * this.getEffectiveVelocity().mag();
      PVector magnusForce = this.getAngularVelocity().cross(this.getEffectiveVelocity()).setMag(scalar);
      this.force.add(magnusForce);
    }
  }
  
  //Retreival functions to prevent unnecessary manipulation of fields
  PVector getAngularVelocity() {
    return new PVector(this.angularVelocity.x, this.angularVelocity.y, this.angularVelocity.z);
  }
  
  PVector getEffectiveVelocity() {
    return new PVector(this.effectiveVelocity.x, this.effectiveVelocity.y, this.effectiveVelocity.z);
  }
  
  float getRadius() {
    return this.radius;
  }
  
  Fluid getFluid() {
    return this.fluid;
  }
}
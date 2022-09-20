class Body {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector force;
  float mass;
  
  Body(PVector p, PVector v, float m) {
    //Create new Body object using arguments
    this.position = p;
    this.velocity = v;
    this.acceleration = new PVector(0, 0, 0);
    this.force = new PVector(0, 0, 0);
    this.mass = m;
  }
  
  void update(float dt) {
    //Calculate the acceleration based on Newton's Second Law of Motion
    this.acceleration = this.getForce().div(this.getMass());
    //Scale acceleration and velocity by dt (time interval between frames)
    PVector accelerationTime = PVector.mult(this.getAcceleration(), dt);
    this.velocity.add(accelerationTime);
    PVector velocityTime = PVector.mult(this.getVelocity(), dt);
    this.position.add(velocityTime);
    
    //Reset instantaneous acceleration and force
    this.acceleration = new PVector(0, 0, 0);
    this.force = new PVector(0, 0, 0);
  }
  
  //Retreival functions to prevent unnecessary manipulation of fields
  PVector getPosition() {
    return new PVector(this.position.x, this.position.y, this.position.z);
  }
  
  PVector getVelocity() {
    return new PVector(this.velocity.x, this.velocity.y, this.velocity.z);
  }
  
  PVector getAcceleration() {
    return new PVector(this.acceleration.x, this.acceleration.y, this.acceleration.z);
  }
  
  PVector getForce() {
    return new PVector(this.force.x, this.force.y, this.force.z);
  }
    
  float getMass() {
    return this.mass;
  }
}
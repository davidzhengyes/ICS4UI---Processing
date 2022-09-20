class Wolf {
  /*  How many days can wolf last from 1 sheep
   *
   *
   *
   */

  float fedForDays;
  float fedFromFood;
  float fedThreshold;

  float lifespan;
  float maxLifespan;

  float birthCycle;

  PVector pos;
  PVector vel;
  float maxVel;
  PVector acc;
  float maxAcc;

  int findCount;
  Sheep closest;


  Wolf(PVector pos_, float fedForDays_) {
    fedForDays = fedForDays_;
    fedFromFood = 15;
    fedThreshold = 20;

    lifespan = 0;
    maxLifespan = 7 * 365;

    birthCycle = (365*1.6) *random(0.9, 1.1);

    pos = pos_;
    vel = PVector.random2D();
    maxVel = 10;
    acc = new PVector(0, 0);
    maxAcc = 50;

    findCount = 10;
    closest = findClosest();
  }

  Wolf() {
    this(new PVector(random(field.fieldSize), random(field.fieldSize)), random(5)+6);
    lifespan = random(maxLifespan);
    birthCycle = random(birthCycle);
  }


  void update() {
    ++lifespan;
    --birthCycle;
    fedForDays -= 1;

    move();
    out();

    eatSheep();
    birth();
  }

  void move() { 
    pos.add(vel);
    vel.add(acc);
    //vel.limit(maxVel);
    acc.set(seekForce());
  }

  void out() {
    if (pos.x<=0) {
      vel.set(-vel.x, vel.y);
      pos.set(0, pos.y);
      return;
    } else if (pos.y<=0) {
      vel.set(vel.x, -vel.y);
      pos.set(pos.x, 0);
      return;
    } else if (pos.x>=field.fieldSize) {
      vel.set(-vel.x, vel.y);
      pos.set(field.fieldSize, pos.y);
      return;
    } else if (pos.y>=field.fieldSize) {
      vel.set(vel.x, -vel.y);
      pos.set(pos.x, field.fieldSize);
      return;
    }
  }

  boolean dead() {
    return fedForDays<=0 || lifespan >= maxLifespan;
  }

  void eatSheep() {
    if (fedForDays<fedThreshold) {
      for (int i=sheeps.size()-1; i>=0; i--) {
        Sheep s = sheeps.get(i);
        if (dist(pos.x, pos.y, s.pos.x, s.pos.y)<=field.R) {
          sheeps.remove(i);
          fedForDays += fedFromFood;
          findCount=0;
          return;
        }
      }
      /*if (sheeps.size()>0) {        GOD-LIKE POWERS
        sheeps.remove(floor(random(sheeps.size())));
        fedForDays += fedFromFood;
        findCount=0;
      }*/
      return;
    }
  }

  void birth() {
    if (birthCycle<0 && fedForDays>=fedThreshold) {
      wolves.add(new Wolf(pos.copy(), fedForDays*2/3));
      birthCycle = (365*1.6) *random(0.9, 1.1);
      fedForDays = fedForDays * 2/3;
    }
  }

  PVector seekForce() {
    if (findCount-- < 0 || closest==null) closest = findClosest();
    if (closest==null) return new PVector();

    PVector desired = PVector.sub(closest.pos.add(closest.vel), pos);
    desired.setMag(maxVel);
    PVector steering = PVector.sub(desired, vel);
    steering.limit(maxAcc);

    return steering;

    /*PVector start = new PVector(0, 0);
     start.add(pos);
     start.add(vel);
     PVector end = new PVector(0, 0);
     end.add(closest.pos);
     
     PVector force = end.copy().sub(start);
     //force.mult(Field(fedForDays, 0, fedThreshold, 1, 0));
     
     return force;*/
  }

  Sheep findClosest() {
    if (sheeps.size()==0) return null;
    float closestDist = dist(this.pos.x, this.pos.y, sheeps.get(0).pos.x, sheeps.get(0).pos.y);
    int closestSheep = 0;
    for (int i = 1; i < sheeps.size(); i++) {
      float currentDist = dist(this.pos.x, this.pos.y, sheeps.get(i).pos.x, sheeps.get(i).pos.y);
      if (currentDist < closestDist) {
        closestDist = currentDist;
        closestSheep = i;
      }
    }
    findCount = 10;
    return sheeps.get(closestSheep);
  }
}

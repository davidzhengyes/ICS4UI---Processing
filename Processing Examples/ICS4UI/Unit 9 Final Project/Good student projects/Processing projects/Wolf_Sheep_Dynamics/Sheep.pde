class Sheep {

  float fedForDays;
  float fedThreshold;
  float foodForDay;

  float lifespan;
  float maxLifespan;

  float birthCycle;

  PVector pos;
  PVector vel;
  float maxVel;
  PVector acc;

  //consume 10m^2 a day

  Sheep(PVector pos_, float fedForDays_) {
    fedForDays = fedForDays_;
    fedThreshold = 5;
    foodForDay = 2.4;

    lifespan = 0;
    maxLifespan = 12 * 365;

    birthCycle = 243*random(0.9,1.1);

    pos = pos_;
    vel = PVector.random2D();
    acc = new PVector(0, 0);
    maxVel = 1;
  }

  Sheep() {
    this(new PVector(random(field.fieldSize), random(field.fieldSize)), random(1.5));
    lifespan = random(maxLifespan);
    birthCycle = random(birthCycle);
  }

  void update() {
    move();
    out();

    eatGrass();
    birth();

    ++lifespan;
    --birthCycle;
    --fedForDays;
  }

  void move() {
    pos.add(vel);
    vel.add(acc);
    vel.setMag(maxVel);
    acc.set(PVector.random2D());
    acc.mult(0.1);
  }

  void out() {
    if (pos.x<=1) {
      vel.set(-vel.x, vel.y);
      pos.set(1, pos.y);
    } 
    if (pos.y<=1) {
      vel.set(vel.x, -vel.y);
      pos.set(pos.x, 1);
    }
    if (pos.x>=field.fieldSize-1) {
      vel.set(-vel.x, vel.y);
      pos.set(field.fieldSize - 1, pos.y);
    }
    if (pos.y>=field.fieldSize-1) {
      vel.set(vel.x, -vel.y);
      pos.set(pos.x, field.fieldSize-1);
    }
  }

  void eatGrass() {
    Grass g = lawn[floor(pos.x)][floor(pos.y)];
    if (fedForDays<fedThreshold) {
      fedForDays += g.quantity/foodForDay;
      g.quantity = 0;
    }
  }

  boolean dead() {
    return fedForDays<=0 || lifespan>=maxLifespan;
  }

  void birth() {
    if (birthCycle<0 && fedForDays>fedThreshold) {
      sheeps.add(new Sheep(pos.copy(), fedForDays/2));
      fedForDays /= 2;
      birthCycle = 243*random(0.9,1.1);
    }
  }
}

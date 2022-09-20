class Driver{
  //fields
  String name;
  Car myCar;
  int revengeFactor;  //level from 1-10
  int alertness;   //level from 1-10
  
  //constructors
  Driver(String n, int r, int a, Car c){
    this.name = n;
    this.revengeFactor = r;
    this.alertness = a;
    this.myCar = c;
  }
  
  Driver(String n, Car c){
    this.name = n;
    this.revengeFactor = round(random(0,10));
    this.alertness = round(random(0,10));
    this.myCar = c;
  }
  
  Driver(String n, int r, int a){
    this.name = n;
    this.revengeFactor = r;
    this.alertness = a;
  }
  
  void chooseCar(Car c){
    this.myCar = c;
    c.owner = this;
    println("You have chosen the", c.model, "to be your car. Good choice!");
    println();
  }
  
  void hitPedestrian(Pedestrian p, Cop c){
    if (p.alive == true){
      
      if (p.crossingRoad == true){
        if (this.alertness > 7){
          println("You really want to hit", p.relationToDriver, "but you see that there is a cop near by, so you don't do anything stupid.");
          println("Good eye!");
          println();
        }
        
        else{
          println("You attempt to hit", p.relationToDriver + ".");
          println();
          if (p.abilityToDodgeCar < 7){
            println("You successfully hit", p.relationToDriver + ".");
            println();
            p.getsHitByCar(c, this);
          }
          else{
            println("Uh oh,", p.relationToDriver, "dodged your car! They are going to call the police on you.");
            println();
            c.catchesDriver(p, this);
          }
        }
      }
      else{
        println(p.relationToDriver, "is not crossing the road, so you can't hit them. Keep your road rage to yourself until they decide to cross. \n");
        println("--------------------------------------------------------------------------------------- \n");
      }
    }
    else{
      println("You're really trying to kill someone whos already dead? \n");
      println("----------------------------------------------------------------------------------------- \n");
    }
  }
  
  void doNotHitPedestrian(Pedestrian p){
    println("You are too nice to run", p.relationToDriver, "over, so you just keep driving. \n");
    println("----------------------------------------------------------------------------------- \n");
  }
  
}

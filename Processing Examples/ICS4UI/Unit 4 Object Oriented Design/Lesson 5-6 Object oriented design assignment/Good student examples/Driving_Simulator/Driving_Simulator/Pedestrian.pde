class Pedestrian{
  //fields
  String relationToDriver;
  int abilityToDodgeCar;  //level from 1-10
  boolean alive;
  boolean crossingRoad;
  
  //constructors
  Pedestrian(String r, int a){
    this.relationToDriver = r;
    this.abilityToDodgeCar = a;
    alive = true; 
    crossingRoad = false;
  }
  
  Pedestrian(String r){
    this.relationToDriver = r;
    this.abilityToDodgeCar = round(random(0,10));
    alive = true; 
  }
  
  void walksAcrossRoad(Driver d){ 
    if (this.alive == true){
      println("Now", this.relationToDriver, "is walking aross the road.");
      println();
      println("You need to choose whether or not to run over", this.relationToDriver + ".");
      println("Just so you know, your revenge level is", d.revengeFactor + "/10");
      println();
      this.crossingRoad = true;
    }
    
    else{
      println(this.relationToDriver, "is dead, so they obviously can't cross a road.");
      println();
    }
    
  }
  
  void getsHitByCar(Cop c, Driver d){
    println(this.relationToDriver, "is now dead, let's see if any cops saw you...");
    println();
    this.alive = false;
    c.doesTheirJob(d);  
  }
}

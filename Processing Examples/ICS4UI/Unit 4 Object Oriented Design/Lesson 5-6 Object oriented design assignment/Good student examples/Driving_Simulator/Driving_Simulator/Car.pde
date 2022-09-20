class Car{
  //fields
  String colour;
  int speed;  //level from 1-10
  String model;
  Driver owner;
  ArrayList<Car> cars = new ArrayList<Car>();
  
  //constructors
  Car(String c, int s, String m, Driver d){
    this.colour = c;
    this.speed = s;
    this.model = m;
    this.owner = d;
    cars.add(this);
  }
  
  Car(String c, int s, String m){
    this.colour = c;
    this.speed = s;
    this.model = m;
  }
  
  void getsOwner(Driver d){
    this.owner = d;
    d.myCar = this;
  }
  
  void describeCar(){
      println("  -", this.colour + " " + this.model);
  }
}

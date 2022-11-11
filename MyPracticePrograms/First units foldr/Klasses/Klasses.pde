void setup(){
  Dog ben = new Dog("ben",3,"golden retriever","male");
  
  println(ben.gender);
  ben.describe();
  
  
  Human ryan = new Human("ryan");
  
  ryan.adopt(ben);
  ryan.describe();
  
  Human aaron = new Human("aa ron");
  
  aaron.describe();
  aaron.adopt(ben);
  aaron.describe();
  ben.describe();
  
  Dog snoopy = new Dog ("snoopy", 76, "beagle","male");
  aaron.adopt(snoopy);
  aaron.describe();
  
  Ball redBall = new Ball (100,100,color(0,0,255));
  aaron.thro(redBall);
  snoopy.retrieve(redBall);
  
  
  Chihuahua rat = new Chihuahua("rat",2);
  rat.describe();
}

void setup() {
  Dog haley = new Dog("Haley", 50, "female", "husky");
  Dog sully = new Dog("Sully", 90, "male", "golden retriever");
  Dog rachael = new Dog("Rachael", 40, "female", "Australian shepherd");
   
  haley.describe();
  haley.getTreat();
  haley.describe();
  
  sully.describe();
  sully.takeToVet();
  sully.describe();
   
  rachael.describe();
  
  haley.bark();
  sully.bark();
  rachael.bark();
}

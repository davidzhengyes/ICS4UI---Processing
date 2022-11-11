

void setup(){
  Meathead antoun = new Meathead("Antoun",5,5,5,5);
  Meathead Ronnie = new Meathead("Ronnie Coleman", 5,5,5,5);
  Machine benchPress = new Machine ("Bench Press", 5, 20, 0);
  Machine tricepsExtension = new Machine ("Triceps Extension",3,30,0);
  
  antoun.addWeight(5);
  antoun.useMachine(benchPress);
  antoun.change();
  antoun.useMachine(benchPress);
  antoun.doSet(300);
  
  Ronnie.change();
  
  Ronnie.useMachine(benchPress);
  Ronnie.useMachine(tricepsExtension);
  Ronnie.doSet(15);
  Ronnie.useMachine(benchPress);
  
}

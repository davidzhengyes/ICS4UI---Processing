
ArrayList <Worker> workers = new ArrayList<Worker>();
void setup(){
  
  
  Worker david = new Worker("David", 25, 15);
  Worker jamal = new Worker ("Jamal", 50, 17);
  workers.add(david);
  workers.add(jamal);
  Meathead antoun = new Meathead("Antoun",5,5,5,5);
  Meathead Ronnie = new Meathead("Ronnie Coleman", 5,5,5,5);
  Meathead Pranav = new Meathead ("Pranav");
  Meathead Eddie = new Meathead("Eddie", 191, 164, 10, 80);
  Machine benchPress = new Machine ("Bench Press", 5, 20, 0);
  Machine tricepsExtension = new Machine ("Triceps Extension",3,30,0);
  Machine latPulldown = new Machine ("Lat Pulldown", 4, 40, 0);
  
  antoun.addWeight(5);
  antoun.useMachine(benchPress);
  antoun.change();
  antoun.useMachine(benchPress);
  antoun.doSet(15);
  antoun.doSet(15);
  antoun.doSet(15);
  antoun.doSet(15);
  
  
  
  Ronnie.change();
  Pranav.change();
  Eddie.change();
  
  Pranav.useMachine(benchPress);
  Pranav.addWeight(20);
  Pranav.doSet(20);
  
  
  Ronnie.useMachine(tricepsExtension);
  Ronnie.doSet(15);
  Ronnie.useMachine(benchPress);
  
  Eddie.useMachine(latPulldown);
  Eddie.doSet(10);
  Eddie.doSet(10);
  Eddie.useMachine(benchPress);
  Ronnie.useMachine(benchPress);
  Ronnie.dropWeights();
  
}

void setup() {
  exit();
  
  Owner bob = new Owner("Bob", 10000); 
  Farm amazingMilkFarm = new Farm("Amazing Milk Farm", bob);
  bob.acquireFarm(amazingMilkFarm.farmName);
  
  println("WELCOME TO THE AMAZING MILK FARM");
  println("\n------------------------------------------------------------------------------------\n");
  
  amazingMilkFarm.addCow(new Cow("Dog", "male", 8, 143.0));
  amazingMilkFarm.addCow(new Cow("ScoobyDoo", "female", 6, 123.0));
  amazingMilkFarm.breedCows("Dog", "ScoobyDoo", "Ruff");
  
  println("Let's print the cows in the barn:\n");
  amazingMilkFarm.printCows();
  
  println("\nLet's feed and shampoo all of the cows:");
  amazingMilkFarm.feedAll(4.0);
  amazingMilkFarm.shampooAllCows();
  
  println("Let's sell some milk:\n");
  println("ScoobyDoo has outputted: " + (amazingMilkFarm.getCow("ScoobyDoo").litresMilk) + "L of milk");
  println("Check the balance:\n" + amazingMilkFarm);
  amazingMilkFarm.sellMilk("ScoobyDoo", 3); 
  println("ScoobyDoo has outputted: " + (amazingMilkFarm.getCow("ScoobyDoo").litresMilk) + "L of milk");
  println("Check the balance:\n" + amazingMilkFarm);
  
  println("Let's print a cow:\n");
  amazingMilkFarm.printCow("ScoobyDoo");
  
  println("\nPrinting parents...");
  amazingMilkFarm.getCow("Ruff").printParents();
  println("Let's celebrate a birthday: ");
  amazingMilkFarm.getCow("Ruff").happyBirthday();
  amazingMilkFarm.printCow("Ruff");
  
  println("\nLet's print the cows again:");
  println(amazingMilkFarm);
  println("Let's print the owner: ");
  println(bob);
  
  println("\n------------------------------------------------------------------------------------\n");
  
  Owner minnie = new Owner("Minnie", 500000);
  Farm minnieFarm = new Farm("Minnie's Mediocre Milk Farm", minnie);
  minnie.acquireFarm(minnieFarm.farmName);
  CowStore cowStore = new CowStore(minnieFarm);
  
  println("Welcome to Minnie's Mediocre Milk Farm, I guess...");
  println("\n------------------------------------------------------------------------------------\n");
  
  minnieFarm.printCowModel();
  
  println("Let's take a look at the cows for sale at the cow store:\n");
  cowStore.printCows();
  
  println("\nLet's purchase Vlad, Chad, and Sicily:\n");
  cowStore.buyCow("Vlad");
  cowStore.buyCow("Chad");
  cowStore.buyCow("Sicily");
  
  println("Let's breed Vlad and Sicily:\n");
  minnieFarm.breedCows("Vlad", "Sicily", "Pencil");
  minnieFarm.printCows();
  
  println("\nLet's sell Pencil to the cow store: \n");
  cowStore.sellCow("Pencil");
  minnieFarm.printCows();
  
  println("\nLet's check up on Pencil at the store:\n");
  cowStore.printCows();
  
  println("\nOh, I see Pencil there!\n");
  
  println("Let's pet a cow: ");
  minnieFarm.getCow("Chad").petCow();
  
  println("Let's print the owner and the farm:");
  println(minnie);
  println(minnieFarm);
  
  println("Let's test some cases:\n");
  cowStore.sellCow("bobby"); // trying to sell a cow that does not exist
  cowStore.buyCow("bobby"); // trying to buy a cow that does not exist
  
  minnieFarm.feedAll(-1); // feeding a negative amount of food
  minnieFarm.breedCows("Chad", "Vlad", "bobby"); // breeding two male cows
  minnieFarm.breedCows("bobby", "victoria", "highlighter"); // breeding cows that don't exist
  
  minnieFarm.getCow("bob"); // trying to get a cow that does not exist
  minnieFarm.sellMilk("rob", 10); // trying to milk a cow that does not exist
  minnieFarm.sellMilk("Sicily", 10000); // 
  minnieFarm.printCow("bob");
  
  println("\n------------------------------------------------------------------------------------\n");
}

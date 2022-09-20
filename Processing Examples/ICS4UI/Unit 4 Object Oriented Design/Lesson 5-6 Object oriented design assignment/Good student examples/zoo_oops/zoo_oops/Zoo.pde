class Zoo {
  String name;
  int sales = 50; //initial amount of money zoo has
  ArrayList<Animal> animals = new ArrayList<Animal>();
  String [] possibleAnimalNames = {"Bob", "Mickey", "McDonalds", "Lemon Tree", "Bipbop", "Kaka", "Ring Ding Ding", "Ah Choo", "Bless You", "Burp", "Crosh"}; //Possible names of new animals in the zoo
  String [] possibleSpecies = {"lion", "tiger", "liger", "cheetah", "black-footed ferret", "tree kangaroo", "giant panda", "red panda", "polar bear", "wolf", "giraffe", "cobra", "hippo", "bald eagle"};//Possible species of new animals in the zoo

  Zoo(String name) {
    this.name = name;
  }


  void describeAnimals() {//describes all of the animals in the zoo using a for loop
    println("*********************************************************************************");
    println("Here are the animals currently in the zoo:");
    println("");
    for (Animal animal : animals) { 
      println(animal.name, "is a", animal.gender, animal.species, "that is feeling", animal.mood);
    }
    println("*********************************************************************************");
  }

  void declareBankruptcy() {
    println(this.name, " has just went bankrupt. All their money is gone. The poor owner must be throwing a fit right now. Better luck next time!");
    exit();
  }

  void buyAnimal() {
    this.sales -= 10; //Animal costs money to buy
    String gender;
    String name = possibleAnimalNames[round(random(0, possibleAnimalNames.length+1))]; //Name is taken from a random index of the list possibleAnimalNames
    String species = possibleSpecies[round(random(0, possibleSpecies.length+1))]; //Species is taken from a random index of the list possibleSpecies

    int a = round(random(0, 1)); //Randomly decides new animal's gender
    if ( a ==0) {
      gender = "female";
    } else {
      gender = "male";
    }
    Animal newAnimal = new Animal(name, gender, species);
    animals.add(newAnimal);
    println("The zoo has just bought a new animal named", newAnimal.name+"!");
  }

  void sellAnimal(Animal a) {
    println("The zoo is not doing so well. Poor", a.name, "just got sold! Hopefully they find a better home, this zoo is a little funky anyways.");
    this.sales += 10; //Zoo makes money selling animal
    animals.remove(a);
  }
}

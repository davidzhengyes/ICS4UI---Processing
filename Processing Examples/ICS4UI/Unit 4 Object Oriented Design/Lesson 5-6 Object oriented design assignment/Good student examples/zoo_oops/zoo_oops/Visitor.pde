class Visitor {
  String name;
  float money;
  boolean hasFastReflexes;
  boolean isTroubleMaker;
  int scrumptiousness; //Scale from 1 to 10, with 10 being the most scrumptious-looking
  boolean hasBoughtFood = false;

  Visitor(String name, float money, boolean hasFastReflexes, boolean isTroubleMaker, int scrumptiousness) {
    this.name = name;
    this.money = money;
    this.hasFastReflexes = hasFastReflexes;
    this.isTroubleMaker = isTroubleMaker;
    this.scrumptiousness = scrumptiousness;
  }

  void describe() {
    if (isTroubleMaker == true)
      println(name, "is a new visitor at the zoo. Watch out, he's a troublemaker!");

    else
      println(name, "is a new visitor at the zoo.");
  }

  void buyFood(Zoo z) {
    this.money -= 3;
    z.sales += 3;
    hasBoughtFood = true;

    println(name, "has just bought food for an animal");
  }

  void stirUpTrouble(Zoo z) {
    println(this.name, " has decided to stir up some trouble...");
    if (isTroubleMaker = true) {
      int ran = round(random(0, 1)); //Decides what trouble the visitor is going to stir up
      if (ran == 0) {
        int moneyAmount = round(random(0, 70)); //Steals a random amount of money
        if (moneyAmount >= z.sales) { //If zoo has less than the amount of money visitor was planning to steal
          moneyAmount = z.sales; //Visitor steals all the zoo has
          println("Louie has just stolen", moneyAmount, "dollars from the zoo! This zoo should hire better security guards next time.");
          z.declareBankruptcy(); //Zoo is bankrupt
        } else {
          println("Louie has just stolen", moneyAmount, "dollars from the zoo! This zoo should hire better security guards next time.");
        }

        this.money += moneyAmount;
        z.sales -= moneyAmount;
      } else { //Other trouble-making option, visitor tries to steal an animal

        println(name, "wanted to pull off an elaborate stunt and steal one of the zoo's awesome animals!");
        println("Fortunately, the cops came in time and stuffed him into the police car.");
        println("His last words were... 'I will be back mwa ha ha ha!'");
      }
    }
  }

  void petAnimal(Animal a) {

    println(name, "just petted", a.name, "the", a.species);
    if (a.mood == "angry")
      a.kickHuman(this); //Animal kicks human if they are angry

    else {
      a.mood = "happy";
      println(a.name, "is now feeling", a.mood);
    }
  }


  void feedAnimal(Animal a) {

    if (hasBoughtFood == true) {
      println(name, "just fed", a.name, "the", a.species, "food!");
      int random = round(random(1, 10)); 


      if (random < scrumptiousness) { // Chance of animal wanting to eat the human (depending on how scrumptious the human is)
        a.biteHuman(this);
      } else {
        println("Although the human did not look very tasty, the food tasted amazing!", a.name, "is very pleased.");
        a.mood = "happy";
        this.hasBoughtFood = false;
      }
    } else
      println(name, "does not have any food to feed the animal with.", name, "decided to take off their socks and feed it to the animal instead."); //If human did not buy food first
  }
}

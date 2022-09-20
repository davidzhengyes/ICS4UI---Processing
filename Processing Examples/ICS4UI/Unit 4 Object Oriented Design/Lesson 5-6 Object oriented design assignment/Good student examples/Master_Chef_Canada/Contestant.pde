class Contestant {
  //FIELDS
  //user sets these
  String name;
  String location;
  int skill;
  int creativity;
  int clumsiness;
  int stubbornness;
  int bribery;
  int teamplayer;
  String funfact;
  
  // user doesn't set this
  boolean begattempt;
  int score;
  Judge judge;
  
  // true = eliminated, false = not eliminated
  boolean status;
  
  //CONSTRUCTOR
  Contestant (String n, String loca, String fact, int s, int cre, int clum, int stub, int b, int team) {
    this.name = n;
    this.location = loca;
    this.funfact = fact;
    this.skill = s;
    this.creativity = cre;
    this.clumsiness = clum;
    this.stubbornness = stub;
    this.bribery = b;
    this.teamplayer = team;
    
    this.begattempt = false;
    this.score = 0;
    
 // true = eliminated, false = not eliminated
    this.status = false;    
  }
 
 
 //METHODS
  void introduce() {
    println("•", this.name, "from", this.location, "who", this.funfact);
  }
 
  void makeDish(Dish d) {
    if (d.name == "") {
      println(this.name, "has decided to make a", d.main, "with a side of", d.side1, "and", d.side2, "with a", d.sauce, "sauce.");
    }
    
    else {
      println(this.name, "has decided to make", d.name + ".");
    }
    
    if (this.skill >= d.difficulty && this.creativity >= d.creativity) {
      println(this.name, "is very confident that they will put out a great dish.");
    }
    
    else {
      println(this.name, "is not very confident about executing the dish that they chose.");
    }
    
    
    //initial base score is determined based on the contestant's skill and creativity
    this.score = int(float(this.skill + this.creativity)/2);
    
    if (this.skill < d.difficulty) {
      int chance = int(round(random(0, 100)));
      
      if (chance < this.clumsiness) {
        callForMedic();
      }
    }
    
    // The contestant will ask another contestant for an ingredient as if they aren't creative enough to think of the ingredient and collect it themselves during the alloted time to get the ingredients before cooking
    if (this.creativity < d.creativity) {
      int chance = int(round(random(0, 100)));
      
      if (chance > this.creativity) {
        askForIngredient();
      }
    }
    

    println();
    
  }
  
  
  void getEliminated(Judge j) {
    println();
    println(this.name, "has been eliminated by", j.name, ":(");
    this.status = true;
    this.removeContestant();
    
    int stubbornchance = int(round(random(0,100)));
    int bribechance = int(round(random(0,100)));
    if (stubbornchance <= this.stubbornness) {
      
      if (bribechance <= this.bribery) {
        println("Wait a minute!", this.name, "is trying to beg", j.name, "to stay in the competition!");
        
        if (this.bribery > j.canbeBribed && this.begattempt == false) {
          println("Success!", this.name, "has been able to stay in the competition!");
          this.status = false;
          //a contestant can only successfully beg once during the competition
          this.begattempt = true;
          this.addContestant();
        }
        
        else {
          println("Unfortunately,", this.name, "was unable to stay in the competition.");
        }
      }
      
      else {
        println(this.name, "was so furious that they stomped out of the kitchen and threatened to shut down the show.");
      }
  }
    
    else {
      println(this.name, "graciously accepted their defeat and wished all the other contestants best of luck for the competition.");
    }
    
  println();
    
  }
  
  
  void dropFood() {
    println("OH NO!", this.name, "has dropped their plate when bringing it up to the judges!");
    this.score = 0;
  
  }
  
    
  
  
  void askForIngredient() {
    int contestant = currentContestants.indexOf(this);
    int chance = int(random(currentContestants.size()));
    
    while (chance == contestant) {
      chance = int(random(currentContestants.size()));    
    }
    
    Contestant victim = currentContestants.get(chance);
    
    String[] ingredients = {"salt", "sugar", "water", "flour", "oil", "eggs", "truffle", "caviar", "butter", "milk"};
    int choice = int(random(ingredients.length));
    
    println(this.name, "has asked", victim.name, "for some", ingredients[choice] + "!");
    
    float willingness = float(100-victim.stubbornness + victim.teamplayer)/2;
    
    if (willingness >= 70) {
      println(victim.name, "has agreed to lend the", ingredients[choice] + "!");
    }
    
    else {
      println(victim.name, "did not agree to lend the", ingredients[choice] + "!");  
      
      // the contestant's score is negatively impacted if they didn't get the ingredient
      if (score >= 20) {
        this.score -=20;
      }
    }
  
  }
  
  
  void callForMedic () {
    String[] injuries = {"cut their finger", "got food poisoning", "burned their hand", "scraped their hand", "scorched their hand", "sprained their ankle", "lit their hair on fire", "slipped on water"};
    int choice = int(random(injuries.length));
    println(this.name, "has", injuries[choice], "and has called a medic!");
    
    if (this.score >= 5) {
      this.score -= 5;
    }
    
  }

  
  //ADDS A CONTESTANT TO THE SYSTEM
  void addContestant () {
    if (this.status == false) {
      currentContestants.add(this);
    }
    
    else {
      println(this.name, "cannot be re-entered into the competition as they are eliminated.");
    }
  }
  
  //REMOVES A CONTESTANT FROM THE SYSTEM
  void removeContestant () {
    if (this.status == true) {
      currentContestants.remove(this);
    }
    
    else {   
      println(this.name, "cannot be removed from the competition as they are not eliminated.");
    }   
  }
  
  void presentWinner () { 
    println("****************************************************");
    println("After many grueling rounds (and a few fingers slashed), we have a winner!");
    println("****************************************************");
    println("Masterchef Canada presents that", this.name, "is the winner and has won $100,000!");
  
  }  
}

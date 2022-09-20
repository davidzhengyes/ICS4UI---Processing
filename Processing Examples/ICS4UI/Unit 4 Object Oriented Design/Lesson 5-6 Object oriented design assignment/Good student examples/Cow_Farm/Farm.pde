class Farm {
  String farmName;
  Owner owner;
  ArrayList<Cow> cows;
  
  Farm(String farmName, Owner owner) { // sets the farm name, assigns the owner to this farm, and initializes the list of cows
    this.farmName = farmName;
    this.owner = owner;
    cows = new ArrayList<Cow>();
  }
  
  void addCow(Cow cow) { // allows the user to add cows in setup()
    owner.balance -= cow.price; // because nothing is free
    cows.add(cow);     
  }
  
  void feedAll(float food) { // feeds all cows a specified amount of food
    if (food < 0) {
      println("Sorry, no negative amounts of food. Don't worry, we went ahead and fed your cows the |absolute value| of your input!"); // if the amount of food happens to be negative, this message is printed
    }
      for (Cow cow : cows) {
        owner.balance -= (food/10); // each kg of food costs the owner $0.1
        cow.feedCow(abs(food)); // feeds the cows the absolute value of the user's input
      }
  }
  
  void shampooAllCows() { // shampoos all cows (every cow is now a happier and fluffier cow)
    for (Cow cow : cows) {
      owner.balance -= 0.1; // shampooing a cow costs the owner $0.1
      cow.shampooCow();
    }
  }
  
  void breedCows(String name1, String name2, String name) { // breeds two cows if the conditions are right
    owner.addBalance(-5.0); // costs the owner $5
    Cow cow1 = getCow(name1); 
    Cow cow2 = getCow(name2);
    
    if (cow1 != null || cow2 != null) { // makes sure that both cows exist to prevent a null pointer exception from being thrown
      if (!cow1.gender.equals(cow2.gender) && ((cow1.age >=2 && cow2.age >=2) ||(cow1.age <= 10 && cow2.age <= 10))) { // makes sure the cows are not the same gender and that they are a good age to be bred
        String gender;
        float weight = determineWeight(0); // determines a random birth weight
        
        if (int(random(0, 2)) == 1) { // determines the cow's gender
          gender = "female";
        } else {
          gender = "male";
        }
        
        Cow baby = new Cow(name, gender, 0, weight, cow1, cow2); // creates the calf
        
        cows.add(baby); // adds the calf to the farm
        
      } else if (cow1.gender.equals(cow2.gender)) {
        println("Sorry, can't breed two " + cow1.gender + " cows."); // if the owner attempts to breed two cows of the same gender, this message is printed
      } else if ((!(cow1.age >=2 && cow2.age >=2) ||(cow1.age <= 10 && cow2.age <= 10))) { // if the owner attempts to breed cows that are not the right age, this message is printed
        println("Sorry, one or both cow(s) is/are not the right age to be bred");
      }
    }
  }
  
  void sellCow(Cow cow) { // only called by CowStore
    owner.addBalance(cow.price);
    cows.remove(cow);
  }
  
  void buyCow(Cow cow) { // only called by CowStore
    cows.add(cow);
    owner.addBalance(-1 * cow.price);
    
  }
  
  void printCows() { // prints all of the cows in the farm
    for (Cow cow : cows) {
      println(cow); // prints their toString return value
      println("....................................");
    }
  }
  
  Cow retrieveCow(String name) {
    for (Cow cow : cows) {
      if (cow.name.equals(name)) {
        return cow;
      }
    }
    return null;
  }
  
  Cow getCow(String name) { // returns the cow of the specified name (if it exists)
    for (Cow cow : cows) {
      if (cow.name.equals(name)) {
        return cow;
      }
    }
    println("There does not exist a cow named " + name); // prints this message if a cow of the specified name cannot be found
    return null;
  }
  
  void sellMilk(String name, int milk) { // milks the cow of the specified name (if it exists) and sells the milk for some profit
    if (getCow(name) == null) { // if the cow does not exist
    } else if (getCow(name).gender.equals("male")) { // if the owner tries to milk a male cow
      println("Sorry, only female cows can produce milk");
    } else if (milk > getCow(name).weight/5) { // if the owner tries to milk too much 
      println("Sorry, the cow can produce a maximum of " + getCow(name).weight/5 + "L of milk in a day");
    } else if (getCow(name).age < 2 || getCow(name).age > 10) { // if the cow is not the right age
      println("Sorry, the cow is not the right age to produce milk");
    } else { 
      Cow cow = getCow(name);
      cow.litresMilk += milk; // adds the amount milked to the cow's value of litres produced
      owner.addBalance(0.5*milk); // adds the profit to the owner's balance
    }
  }
  
  void printCowModel() { // prints a lovely picture of a cow
    print("\n   ^__^\n   (oo)\\_______\n   (__)\\       )\\/\\\n       ||--WWW |\n       ||     ||\n\n");
  }
  
  float determineWeight(int age) { // determines a random weight based on the cow's age
    if (age <= 5) {
      return roundToHundredth(random(40, 100));
    } else if (age <= 10) {
      return roundToHundredth(random(100, 200));
    } else {
      return roundToHundredth(random(200, 800));
    } 
  }
  
  float roundToHundredth(float number) { // rounds the number to the nearest hundredth
    int exponent = str(number).indexOf(".") - 1;
    int numberRound = int(number * pow(10, exponent));
   
    return float(numberRound) / pow(10, exponent);
  }
  
  void printCow(String name) { // prints the specified cow
    if (retrieveCow(name) != null) { // as long as the specified cow exists
      println("\t--------------------");
      println(retrieveCow(name));
      println("\t--------------------");
  } else { // printed if the specified cow cannot be found
      println("Cow Not Found...Error 4M004");
    }
  }
  
  @Override
  String toString() { // prints this return value when println(farm) is used
    String printedBalance = str(owner.balance);
    if (str(owner.balance).indexOf(".") == (str(owner.balance).length() - 2)) // if the number rounds to the nearest tenth, this adds an extra 0 at the end
      printedBalance = str(owner.balance) + "0";
    
    return "\n\t--------------------\n\tFarm name: " + farmName + "\n\tOwner: " + owner.name + "\n\tNumber of Cows: " + cows.size() + "\n\tBalance: " + printedBalance + "\n\t--------------------\n"; // basic information of the farm
  }
}

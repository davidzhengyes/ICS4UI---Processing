class Cow {
  String name;
  String gender;
  int age;
  float weight;
  float litresMilk; // the litres of milk the cow has outputted in its lifetime
  float price;
  Cow[] parents = new Cow[2]; // holds the cow's parents
  
  Cow(String name, String gender, int age, float weight, Cow cow1, Cow cow2) { // the last two parameters allow the user to include the cow's parents
    this.name = name;
    this.gender = gender.toLowerCase();
    this.age = age;
    this.weight = weight;
    litresMilk = 0; // Assumes 0L since this cow will be new to the farm
    price = calculatePrice();
    parents[0] = cow1;
    parents[1] = cow2;
  }
  
  Cow(String name, String gender, int age, float weight) { // does not include the option to include the cow's parents
    this.name = name;
    this.gender = gender.toLowerCase();
    this.age = age;
    this.weight = roundToHundredth(weight);
    price = calculatePrice();
  }
  
  Cow(String name, String gender, int age) { // does not include the option to include the cow's parents, or the weight of the cow --- instead, the weight is calculated by determineWeight()
    this.name = name;
    this.gender = gender.toLowerCase();
    this.age =age;
    weight = determineWeight(age);
    price = calculatePrice();
  }
  
  void feedCow(float food) { // feeds the cow a specified amount (weight) of food, which increases the cow's value and weight
    weight += food;
    price = calculatePrice();
    
    roundToHundredth(weight);
  }
  
  void shampooCow() { // shampooing your cow will result in a happier and fluffier cow
    println("\n\t" + name + " says: " + "Happy Cow MoOooO~~~\n");
  }
  
  void petCow() { // petting your cow will result in a happier cow
    println("\n\t" + name + " says: " + "MooOoo <3\n");
  }
  
  void printParents() { // prints the cow's parents (if they are known)
    if (parents[0] == null) { // if the cow does not have parents, this message is printed
      println("Sorry, the parents of this cow are unkown.");
    } else {
    println("\n\tParents: " + parents[0].name + ", " + parents[1].name + "\n"); // if the cow has parents, its parents are printed
    }
  }
  
  float calculatePrice() { // calculates a cow's price (even though every cow is priceless and precious) based on its age and weight
    if (age >= 15 || age <= 5) { // baby cows and senior cows tend to have lower prices since they cost more to care for/don't produce as much milk
      price = (age/2) + (weight/4);
    } else {
      price = age + (weight/2);
    }
    return roundToHundredth(price);
  }
  
  float determineWeight(int age) { // weight is randomly chosen based on the age of the cow 
    if (age <= 5) {
      return roundToHundredth(random(40, 100));
    } else if (age <= 10) {
      return roundToHundredth(random(100, 200));
    } else {
      return roundToHundredth(random(200, 800));
    } 
  } 
  
  float roundToHundredth(float number) { // rounds the number to two decimal places
    int exponent = str(number).indexOf(".") - 1;
    int numberRound = int(number * pow(10, exponent));
    
    return float(numberRound) / pow(10, exponent);
  }
  
  void happyBirthday() { // increments the cow's age by one year (happy birthday!) 
    age++;
    println("\n\tHappy birthday, " + name + " !\n");
  }
 
  @Override 
  String toString() { // typing println(cow) will print the returned string
    String printedWeight = str(weight);
    String printedPrice = str(price);
    
    if (str(weight).indexOf(".") == (str(weight).length() - 2)) // if the number rounds to the nearest tenth, this adds an extra 0 at the end
      printedWeight = str(weight) + "0";
    
    if (str(price).indexOf(".") == (str(price).length() - 2)) // if the number rounds to the nearest tenth, this adds an extra 0 at the end
      printedPrice = str(price) + "0";
    
    return "\tName: " + name + "\n\tGender: " + gender + "\n\tAge: " + age + "\n\tWeight: " + printedWeight + "kg" + "\n\tPrice: $" + printedPrice; // basic information of the cow
  }  
}

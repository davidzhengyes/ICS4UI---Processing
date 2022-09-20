import java.util.List;

class CowStore { // a store with unlimited funds and an unknown owner
  Farm primaryCustomer; // each farm has its own supplier, so each Farm object has its own unique CowStore object
  ArrayList<Cow> cowsForSale = new ArrayList<Cow>();
  
  CowStore(Farm farm) { 
    // cows that can be purchased at the store
      cowsForSale.add(new Cow("Vlad", "Male", 6, determineWeight(6)));
      cowsForSale.add(new Cow("Ilya", "Male", 4, determineWeight(4)));
      cowsForSale.add(new Cow("Sicily", "Female", 9, determineWeight(9)));
      cowsForSale.add(new Cow("JoshDaniel", "Female", 2, determineWeight(2)));
      cowsForSale.add(new Cow("Chad", "Male", 8, determineWeight(8)));
      cowsForSale.add(new Cow("Katie", "Female", 5, determineWeight(5))); 
      cowsForSale.add(new Cow("Joseph", "Male", 15, determineWeight(15)));
      cowsForSale.add(new Cow("Josh", "Male", 3, determineWeight(3))); 
      cowsForSale.add(new Cow("Daniel", "Male", 12, determineWeight(12))); 
      cowsForSale.add(new Cow("Oana", "Female", 1, determineWeight(1))); 
      cowsForSale.add(new Cow("Richard", "Male", 22, determineWeight(22)));
      cowsForSale.add(new Cow("Mikaela", "Female", 7, determineWeight(7)));
      cowsForSale.add(new Cow("Rachel", "Female", 9, determineWeight(9)));
      
      primaryCustomer = farm; 
  }    

  
  void printCows() { // prints all cows that are currently being sold
    for (Cow cow : cowsForSale) {
      println(cow);
      println("\t------------------");
    }
  }
  
  void sellCow(String name) { // allows the farm owner to sell their cow to the cow store
    boolean cowFound = false; 
    
    for (Cow cow : primaryCustomer.cows) {
      if (cow.name.equals(name)) { // tries to find the cow 
        cowFound = true;
        cowsForSale.add(cow); // adds the owner's cow to the shop's list of cows for sale
        primaryCustomer.sellCow(cow); // removes the cow from the farm
        break;
       }
     }
     
     if (!cowFound) 
       println("Cow Not Found...Error 4M004"); // if the cow is not found in the owner's farm, this error message is printed
   
 }
  
  void buyCow(String name) {  
    boolean cowFound = false;
    
    for (Cow cow : cowsForSale) {
      if (cow.name.equals(name)) { // tries to find the cow
        cowFound = true;
        primaryCustomer.buyCow(cow); // adds the cow to the new owner's farm
        cowsForSale.remove(cow); // removes the cow from the shop's list
        break;
      }
    }
    
    if (!cowFound) 
       println("Cow Not Found...Error 4M004"); // if the cow is not found in the owner's farm, this message is printed
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
}

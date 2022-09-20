class Owner { // Owns a farm (maximum of one farm)
  String name;
  Farm farm;
  float balance;
  
  Owner(String name) { // if the owner's balance is not specified, they will have a balance of 100
    this.name = name;
    balance = 100;
  }
  
  Owner(String name, float balance) { // allows the owner's balance to be specified
    this.name = name;
    this.balance = balance;
  }
  
  void addBalance(float amount) { // adds/subtracts to the owner's balance
    balance += amount;
  }
  
  void acquireFarm(String farmName) { // allows the owner to purchase a farm
    Farm farm = new Farm(farmName, this);
    balance -= 10; // farm tax
    
    this.farm = farm;   
  }
  
  @Override 
  String toString() { // prints the return value when println(owner) is used 
    return "\n\t---------------\n\tHello, my name is " + name + ", and I own a ~~*~*~Cow Farm~*~*~~ called " + farm.farmName + "\n\t---------------\n"; // introduces the owner
  }
}

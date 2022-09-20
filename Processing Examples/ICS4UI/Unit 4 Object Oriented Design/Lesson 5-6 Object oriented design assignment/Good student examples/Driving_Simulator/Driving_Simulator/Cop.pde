class Cop{
  //field
  int alertness;  //level from 1-10
  int hunger;  //level from 1-10
  ArrayList<Cop> cops = new ArrayList<Cop>();
  
  //constructor
  Cop(int a, int h){
    this.alertness = a;
    this.hunger = h;
    //add all cops to arraylist 
    cops.add(this);
  }
  
  void doesTheirJob(Driver d){
    if (this.hunger >= 7){
      eatsDonut(d);
    }
    else{
      if (alertness >= 5){
        catchesDriver(d);
      }
      else{
        println("There was a cop around, but they didn't see you run anyone over. Lucky you!");
        println();
        println("_______________________________________________________________________________________");
        println();
      }
    }
  }
  
  void catchesDriver(Driver d){
    println("A cop saw you commit a hit and run causing death.");
    println("Have fun spending the rest of your life in prison... maybe you can get parole?");
    println();
    println("   _________________________");
    println("      ||   ||     ||   ||");
    println("      ||   ||, , ,||   ||");
    println("      ||  (||/|/(\\||/  ||");
    println("      ||  ||| _'_`|||  ||");
    println("      ||   || o o ||   ||");
    println("      ||  (||  - `||)  ||");
    println("      ||   ||  =  ||   ||");
    println("      ||   ||\\___/||   ||");
    println("      ||___||) , (||___||");
    println("     /||---||-\\_/-||---||\\");
    println("    / ||--_||_____||_--|| \\");
    println("   (_(||)-| ", d.name, " |-(||)_)");
  }
  
  void catchesDriver(Pedestrian p, Driver d){
    println("You have been arresting for the attempted murder of", p.relationToDriver + ".");
    println("Looks like you'll being seeing the inside of a cell for the next *checks notes* ... rest of your life.");
    println();
    println("    _________________________");
    println("      ||   ||     ||   ||");
    println("      ||   ||, , ,||   ||");
    println("      ||  (||/|/(\\||/  ||");
    println("      ||  ||| _'_`|||  ||");
    println("      ||   || o o ||   ||");
    println("      ||  (||  - `||)  ||");
    println("      ||   ||  =  ||   ||");
    println("      ||   ||\\___/||   ||");
    println("      ||___||) , (||___||");
    println("     /||---||-\\_/-||---||\\");
    println("    / ||--_||_____||_--|| \\");
    println("   (_(||)-| ", d.name, " |-(||)_)");
  }
  
  void eatsDonut(Driver d){
    if (this.alertness >= 7){
      catchesDriver(d);
    }
    else{
      println("Lucky for you, the cop is eating a donut and didn't see you run anyone over.");
      println();
      println("        _.-''``'-.               ");
      println("       '._ __{}_(       ____      ");
      println("         |'--.__\\    .'` __ `'.  ");
      println("        (   ^_\\^     |  '--'  | ");
      println("         |   _ |     \\`------`/ ");
      println("         )\\___/       `------'  ");
      println("     .--'`:._]                   ");
      println("    /  \\      '-.               ");
      println();
      println("_______________________________________________________________________________");
      println();

    }
  }
}

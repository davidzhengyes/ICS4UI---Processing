class Pet {

  // Fields
  String name;          // Pet's name
  String petSpecies;    // Cat or Dog?
  int age;              // Current age of pet
  int ageBaby;          // Age of an infant of the pet's species (does do age of the pet makes it a puppy/kitten?)
  String gender;        // Gender
  int health;           // Health
  int cute;             // Cuteness level
  int fun;              // Funness level
  int toughness;        // Toughness level
  int patient;          // Patience level
  int adaptable;        // Adaptability level
  boolean owned;        // Whether they are owned or not
  Customer owner;       // Owner's name
  int cost;             // Cost to adopt
  PetActivity play;    // Needs to play
  PetActivity walk;    // Needs to walk
  PetActivity clean;   // Needs to clean

  // Constructor
  Pet( String n, int a, String g, String petSpecies ) {
    this.name = n;
    this.petSpecies = petSpecies;
    allAnimals.add(this);
    this.age = a;
    this.gender = g;
    this.cute = round ( random(3, 17) );
    this.fun = round ( random(3, 17) );
    this.toughness = round ( random(3, 17) );
    this.patient = round ( random(3, 17) );
    this.adaptable = round ( random(3, 17) ); 
    this.health = 20;
    this.owned = false;
    // These needs are random and different among different pets
    if ( random(0, 1) < 0.8 ) this.play = new PetActivity ( "play", true, round(random(1, 3)) );
    else this.play = new PetActivity ( "play", false );
    this.clean = new PetActivity ( "clean", true, round(random(10, 25)) );
    if ( random(0, 1) < 0.6 ) this.walk = new PetActivity ( "walk", true, round(random (1, 2)) );  
    else this.walk = new PetActivity ( "walk", false );    

    // Cats & dogs will have different base prices
    if ( this.petSpecies == "cat" ) {
      this.ageBaby = 6;
      this.cost = 295;
    } else if (this.petSpecies == "dog" ) {
      this.ageBaby = 18;
      this.cost = 515;
    }

    //Infant animals can be a slight be different from adults in cost and characteristics
    if ( this.age <= this.ageBaby ) {
      this.cute += round ( random(0, 3) );
      this.fun += round ( random(0, 3) );
      this.toughness += round ( random(-2, 0) );
      this.patient += round ( random(-2, 0) );
      this.adaptable += round ( random(-3, 0) );
      this.cost = this.cost + round(float(this.age) / float(this.ageBaby)/2 * 100);
    }
  }

  // Pet description
  void portfolio() { 
    println("************(V●^●V)************");
    println("Name:       \t", this.name);
    println("petSpecies:    \t", this.petSpecies);
    println("Gender:     \t", this.gender);
    print("Age (m):      \t", this.age, "months" );
    if ( this.age <= this.ageBaby ) println( "(baby)" );
    else println( "(adult)" );
    println( "Cost:         \t $" + this.cost );
    println("Health:     \t", this.health + "/20");
    println("cuteness:    \t", this.cute + "/20");
    println("Humor:      \t", this.fun + "/20");
    println("Toughness:  \t", this.toughness + "/20");
    println("Patience:   \t", this.patient + "/20");
    println("Adaptability:\t", this.adaptable + "/20");
    print("Needs: ");
    if (this.play.needActivity == true) println("\tplaytime (" + this.play.activityTime + " hours/day)" );
    if (this.clean.needActivity == true) println("\tgrooming (" + this.clean.activityTime + " minutes/day)" );
    if (this.walk.needActivity == true) println("\twalks (" + this.walk.activityTime + " hours/day)" );
    println();
  }


  // Methods
  void update() { // changing stats for characteristics based on the most recent evaluation from its new owner

    println( "Here are", this.name + "'s new stats based on", this.owner.name + "'s feedback!" );
    if ( this.owner.feedback[0] < 3 ) {
      this.cute -= this.owner.feedback[0];
      if ( this.cute > 20 ) this.cute = 20;
    } else {
      this.cute += this.owner.feedback[0];    
      if ( this.cute < 0 ) this.cute = 0;
    }

    if ( this.owner.feedback[1] < 3 ) {
      this.fun -= this.owner.feedback[1];
      if ( this.fun > 20 ) this.fun = 20;
    } else {
      this.fun += this.owner.feedback[1];  
      if ( this.fun < 0 ) this.fun = 0;
    }

    if ( this.owner.feedback[2] < 3 ) {
      this.toughness -= this.owner.feedback[2];
      this.patient -= this.owner.feedback[2];
      if ( this.toughness > 20 ) this.toughness = 20;
      if ( this.patient > 20 ) this.patient = 20;
    } else {
      this.toughness += this.owner.feedback[2];    
      this.patient += this.owner.feedback[2];
      if ( this.toughness < 0 ) this.toughness = 0;
      if ( this.patient < 0 ) this.patient = 0;
    }

    if ( this.owner.feedback[3] < 3 )
      this.adaptable -= this.owner.feedback[3];
    if ( this.adaptable > 20 ) this.adaptable = 20;
    else
      this.adaptable += this.owner.feedback[3];
    if ( this.adaptable < 0 ) this.adaptable = 0;

    this.portfolio();
  }
}

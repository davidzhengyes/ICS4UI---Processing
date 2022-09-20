class Customer {

  // Fields
  String name;            // Name of customer
  Pet newPet;             // New pet
  boolean foundPet;       // Whether they have a pet or not 
  int strictness;         // Standards for pet
  String typePrefer;      // Cat or Dog?
  String gPrefer;         // Preferred gender of pet
  int cutePrefer;         // Preferred cuteness level
  int funPrefer;          // Preferred funness level
  int toughnessPrefer;    // Preferred toughness level
  int patientPrefer;      // Preferred patience level
  int adaptablePrefer;    // Preferred adaptability level
  int budget;             // Amount of money in pocket
  String comment;         // Comments during evaluation
  int[] feedback;         // Feedback in email (update method)
  int freetime;           // Amount of freetime (in hours)

  // Constructor 1 (customer which well rounded expectations)
  Customer( String n, String g, String p, int c, int f, int d, int pa, int a, int s, int b, int ft ) {
    this.name = n;
    this.gPrefer = g;
    this.typePrefer = p;
    this.cutePrefer = c;
    this.funPrefer = f;
    this.toughnessPrefer = d;
    this.patientPrefer = pa;
    this.adaptablePrefer = a;
    this.strictness = s;
    this.foundPet = false;
    this.budget = b;
    this.feedback = new int[4];
    this.freetime = ft;
  }

  // Constructor 2 (rich kid-no budget)
  Customer( String n, String g, String p, int c, int f, int d, int pa, int a, int s, int ft ) {
    this.name = n;
    this.gPrefer = g;
    this.typePrefer = p;
    this.cutePrefer = c;
    this.funPrefer = f;
    this.toughnessPrefer = d;
    this.patientPrefer = pa;
    this.adaptablePrefer = a;
    this.strictness = s;
    this.foundPet = false;
    this.budget = 0;
    this.feedback = new int[4];
    this.freetime = ft;
  }

  // Constructor 3 (customer with next to no standards)
  Customer( String n, String g, String p, int b, int ft ) {
    this.name = n;
    this.gPrefer = g;
    this.typePrefer = p;
    this.cutePrefer = 0;
    this.funPrefer = 0;
    this.toughnessPrefer = 0;
    this.patientPrefer = 0;
    this.adaptablePrefer = 0;
    this.strictness = 0;
    this.foundPet = false;
    this.budget = b;
    this.feedback = new int[4];
    this.freetime = ft;
  }


  // Methods
  // Declaring that a person is entering a building
  void enter() {
    println( this.name, "enters the building, looking for a", this.typePrefer, "to adopt." );
  }

  // Customer compares the pet's characteristics to their own expectations
  void interview() {

    // There is only one condition for "cutePrefer" to =0 since if this variable is 0, the rest will also be 0 (from constructor 3).
    // In constructor 1 & 3, the customer will have an input of preference from when the customer object was declared.
    if ( this.cutePrefer == 0 ) 
      comment = "\t 0 means the customer have no expectations ◄(▀¯▀◄)";
    else
      comment = "";

    // Printing the customer's preferences
    println();
    println( this.name, "is a", this.typePrefer, "lover who is looking for:" );
    println( "  ♥  Gender:  \t", this.gPrefer );
    println( "  ♥  cuteness:  \t", this.cutePrefer + "/20", comment );
    println( "  ♥  Funness:  \t", this.funPrefer + "/20", comment );
    println( "  ♥  Toughness:  \t", this.toughnessPrefer + "/20", comment );
    println( "  ♥  Patience:  \t", this.patientPrefer + "/20", comment );
    println( "  ♥  Adaptability:\t", this.adaptablePrefer + "/20", comment );
    println();

    // Pet rubric
    for ( Pet p : allAnimals ) {

      int valueCount = 0;       // Number of characteristics that meets the customer's expectations

      if ( p.owned == false && p.petSpecies == this.typePrefer ) {

        println( "'" + this.name + ", meet", p.name+ ",' said a random volunteer." );
        println("Criteria:\t\tAnimal's Mark\tRequirement\tComments" );

        // Checking gender
        print( "Gender:\t\t" + p.gender + "\t\t" + this.gPrefer + "\t\t" );
        if ( this.gPrefer == p.gender ) {
          println( "Great!", p.name + " is the gender I preferred!" );
          valueCount++;
        } else {
          print( "Hmm. I rather have a", this.gPrefer );
          if ( this.gPrefer == "male" ) println( ". I have too many sisters." );
          else println ( ". No hard feelings." );
        }

        // Checking cuteness
        print( "cuteness:\t\t" + p.cute + "\t\t" + this.cutePrefer + "\t\t" );
        if ( this.cutePrefer == 0 ) {
          println( p.name, "is rather cute!" );
          valueCount++;
        } else if ( p.cute >= this.cutePrefer ) {
          println( this.name, "is rather pleased with how cute", p.name + " is." );
          valueCount++;
        } else {
          println( "I guess it will grow cuter overtime :P" );
        }

        // Checking funness
        print( "Funness:\t\t" + p.fun + "\t\t" + this.funPrefer + "\t\t" );
        if ( this.funPrefer == 0 ) {
          println( "How fun!" );
          valueCount++;
        } else if ( p.fun >= this.funPrefer ) {
          println( "I think we will have lots of fun together!" );
          valueCount++;
        } else {
          print( "Quite a stoic one, isn't " );
          if ( p.gender == "male" ) println( "he?" );
          else println ( "she?" );
        }

        // Checking toughness
        print( "Toughness:\t\t" + p.toughness + "\t\t" + this.toughnessPrefer + "\t\t" );        
        if ( this.toughnessPrefer == 0 ) {
          println( "I don't care about toughness :P" );
          valueCount++;
        } else if ( p.toughness >= this.toughnessPrefer  ) {
          print( "Nice!" );
          if ( p.gender == "male" ) println( "He could beat up the squirrels who are destroying my flower garden!" );
          else println ( "She could scare away all the rabbits eating my tomatos!" );
          valueCount++;
        } else {
          println( "A bit of a scaredy-cat aren't you. Guess that's part of your charm." );
        }

        // Checking patience
        print( "Patience:\t\t" + p.patient + "\t\t" + this.patientPrefer + "\t\t" );
        if ( this.patientPrefer == 0 ) {
          println( "Nice" );
          valueCount++;
        } else if ( p.patient >= this.patientPrefer  ) {
          println( "Looks like", p.name, "can easily pass the marshmellow test." );
          valueCount++;
        } else {
          println( "Whoa! You don't like to wait do you! How impatient (– _ –) " );
        }

        // Checking adaptability
        print( "Adaptability:\t" + p.adaptable + "\t\t" + this.adaptablePrefer + "\t\t" );
        if ( this.adaptablePrefer == 0 ) {
          println( "No matter what, you'll love my place!" );
          valueCount++;
        } else if ( p.adaptable >= this.adaptablePrefer ) {
          println( "Its nice that you're so adaptable!" );
          valueCount++;
        } else {
          println( "I guess it takes time for you to adapt to new environments..." );
        }
        
        // Care time...
        int totalCareTime = round(p.play.activityTime + (p.clean.activityTime/60) +p.walk.activityTime);
        print( "Care Time Needed:\t" + totalCareTime + "\t\t" + this.freetime, "\t\t" );
        if ( this.freetime >= totalCareTime ) {
          println( "I will have enough time to care for you!" );
          valueCount++;
        }
        else println( "I only have", this.freetime, "hours of freetime per day..." );
        
        // Deciding whether the customer will adopt the pet
        println( "Final Evaluation:", p.name, "meets", valueCount, "out of 7 of", this.name + "'s requirements." );
        if ( valueCount >= strictness ) {
          println( this.name, "is happy with", p.name + "." );
          this.adopt(p);
          if ( this.foundPet == true)
            break;
        } else
          println( "I don't think I'm compatible with", p.name + "." );
      } 

      // Pet is not the desired species
      else if ( p.petSpecies != this.typePrefer )
        println( "'I don't really want to look at", p.petSpecies + "s. Sorry,", p.name + "!'" ); 

      // Pet is already adopted and getting ready to be brought to a new home
      else
        println( "'Sorry, but", p.name, "is already adopted.' a random volunteer said." );
    }

    // Failed to find a pet
    if ( this.foundPet == false ) {
      println();
      println( this.name, "left the building, dejected to have not found a pet", this.typePrefer, "to bring home." );
    }

    println();
    println( "■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■" );
  }

  // Adopting a pet
  void adopt( Pet p ) {

    // Not enough money to buy the pet
    if ( budget < p.cost && budget != 0 )
      println( this.name, "only has $" + this.budget + ".00. So", p.name + ", costing $" + p.cost + ".00 is out of budget." );

    else {
      this.newPet = p;
      this.foundPet = true;
      p.owned = true;
      p.owner = this;

      // Have enough money to buy the pet
      if ( budget != 0 )
        println( this.name, "has a budget of $" + this.budget + ".00, which can afford", p.name + ", who costs $" + p.cost + ".00." );
      // So rich that they don't need to check the price
      else
        println( this.name, "has no budget and swipes a gold ranked mastercard--transferring $" + p.cost + ".00 for", p.name + "." );

      println( this.name, "has adopted", this.newPet.name + ", and left the building happily." );
    }
  }

  // Check-in email to discuss satisfaction with pet, which changes the pet's stats
  void updateSurvey() {

    println( "---------------------------------------------------------------------------------------" );
    println( "Hello,", this.name + "." );

    // Feedback is based on the difference between the pet's characteristics and the cuteness level
    if ( this.foundPet == true ) {
      feedback[0] = round( random(1, this.cutePrefer - this.newPet.cute) );
      feedback[1] = round( random(1, this.funPrefer - this.newPet.fun) );
      feedback[2] = round( random(abs(this.patientPrefer - this.newPet.patient), this.toughnessPrefer - this.newPet.toughness) );
      feedback[3] = round( random(1, this.adaptablePrefer - this.newPet.adaptable) );

      // Feedback can't be more than 5. It could be less than 0 though, if the customer is really annoyed with something
      for ( int i = 0; i<4; i++ ) {
        if ( feedback[i] > 5 ) feedback[i] = 5;
      }

      println( "The Humane Society just want to check up on your progress with", this.newPet.name + ".\n" );

      println( "Please answer the following questions on a scale from 1 to 10." );
      println( "1#\tWas", this.newPet.name, "a compatible animal?\t\t\t", feedback[0] + "/5" );
      println( "2#\tWas", this.newPet.name, "a fun pet to play with?\t\t", feedback[1] + "/5" );
      println( "3#\tWas", this.newPet.name + "'s attitude compatible to you?\t\t", feedback[2] + "/5" );
      println( "4#\tDid", this.newPet.name + "adapt to you home?\t\t\t", feedback[3] + "/5" );

      // An attempt to draw pets
      if ( this.newPet.petSpecies == "dog" )
        println("(___()'`;\n/,    /`\n\\\\'--\\\\");
      else if ( this.newPet.petSpecies == "cat" )
        println("  _ _/|\n  \'o.0'\n =(___)=\n    U");

      println( "Thank you for your input,\n\tThe Humane Society of KW" );

      this.newPet.update();
    } 

    // If the customer did not get a pet, they are given other possible pets of a different species to adopt.
    else {
      println( "\nWe recognize that you were not able to find a desired pet among our", this.typePrefer + "s." );
      print( "If you are still interested in adopting an animal from us, why not consider our " );
      if ( this.typePrefer == "cat" ) {
        println( "dogs? Here are some of our dogs who were not adopted yet!" );
        for ( int i = 0; i < allAnimals.size(); i++ ) {
          if (  allAnimals.get(i).owned == false &&  allAnimals.get(i).petSpecies == "dog" ) {
            allAnimals.get(i).portfolio();
          }
        }
      } else {
        println( "cats? Here are some of our cats who were not adopted yet!" );
        for ( int i = 0; i < allAnimals.size(); i++ ) {
          if ( allAnimals.get(i).petSpecies == "cat" && allAnimals.get(i).owned == false ) {
            allAnimals.get(i).portfolio();
          }
        }
      }
      println( "We hope to see you again,\n\tThe Humane Society of KW" );
    }
    println( "---------------------------------------------------------------------------------------" );
  }
}

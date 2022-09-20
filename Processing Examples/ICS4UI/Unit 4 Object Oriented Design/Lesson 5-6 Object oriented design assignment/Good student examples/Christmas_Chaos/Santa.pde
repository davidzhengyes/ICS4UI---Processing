class Santa {
  //FIELDS
  String name;
  String catchphrase;
  ArrayList<Member> niceList;
  ArrayList<Member> naughtyList;

  //CONSTRUCTOR
  Santa(String n, String cp) {
    this.name = n;
    this.catchphrase = cp;
    this.niceList = new ArrayList<Member>();
    this.naughtyList = new ArrayList<Member>();
  }

  //METHODS
  void introduce() {
    println("For instance, the name of their 'Santa' is '" + this.name + "'.");
  }

  void createList() {
    println();
    println("*******************************************************************************************");
    println();
    println("First, " + this.name + " must create their Naughty or Nice List!");
    println();
    println(this.name + " is going to review everyone's year and determine whether or not they deserve a gift from " + this.name + ".");
    println("This is what " + this.name + " found:");
  }

  void checkNice(Member m) {
    println();
    println("- " + m.name + " " + m.yearHighlight + ".");
    if (m.nice) {
      this.niceList.add(m);
      println("  -> Great job, " + m.name + "! " + m.name + " has been added to the nice list.");
    } else {
      Gift coal = new Gift("coal", "");
      coal.buyer = "Santa :(";
      m.gifts.add(coal);
      this.naughtyList.add(m);
      println("  -> Uh oh! It seems like " + m.name + " has been naughty this year. Sorry " + m.name + "!");
    }
  }

  void printList() {
    println();
    println(this.name + " has finished going through each member of the " + familyName + " family. Here is the official list:");
    println();
    println("NICE LIST");
    println("----------");
    for (int i=0; i<this.niceList.size(); i++) {
      println(this.niceList.get(i).name);
    }
    println();
    println("NAUGHTY LIST");
    println("-------------");
    for (int i=0; i<this.naughtyList.size(); i++) {
      println(this.naughtyList.get(i).name);
    }
    println();
    println("Phew! That was hard work. " + this.name + " is going to take a break before starting their next task. See you later, " + this.name + "!");
  }

  void breakOver() {
    println();
    println("*******************************************************************************************");
    println();
    println("It seems like everyone is finished with their Christmas shopping, and just in time, too!");
    println(this.name + " is well-rested and ready to start directing their elves to make gifts.");
    println("Since " + this.name + " actually thinks ahead, they will avoid giving anyone duplicate gifts.");
  }

  void makeGift(Member m, Gift g) {
    if (m.nice) {
      m.gifts.add(g);
      g.buyer = "Santa";
      println();
      println(" -" + this.name + "'s elves have made " + g.name + " for " + m.name + "!");
      println("   -> " + this.name + " will drop it off the night before Christmas.");
    } else {
      println();
      print(this.name + "'s elves were just about to make " + g.name + " for " + m.name + ", but remembered that " + m.name);
      println(" was on the naughty list this year. Oops! Sorry " + m.name + ".");
    }
  }

  void deliverGifts() {
    println();
    println(this.name + "'s elves have finished making all the gifts! Time to take an 11-month vacation.");
    println("The reindeer are getting ready for their big night. Stay tuned!");
    println();
    println("*******************************************************************************************");
    println();
    println("It's Christmas eve! The " + familyName + " family is spending their day baking cookies and making fun of each other's ugly aprons.");
    println();
    print("Night has fallen and the " + familyName + " family is ready to go to bed after a long day. They are excited to see what ");
    println(this.name + " will bring. See you in the morning!");
    println();
    println("...");
    println();
    println("*thunk*");
    println("*shuffle shuffle*");
    println("*screeeech*");
    println("*CRASH*");
    println();
    println(this.catchphrase + " " + this.name + " has arrived at the " + familyName + " residence!");
    println(this.name + "'s stomach rumbles as they inhale the smell of freshly baked cookies. Delicious!"); 
    println();
    println("After filling up everyone's stockings, " + this.name + " is now hopping on his sleigh to go to the next house.");
    println(this.catchphrase + " Merry Christmas!");
  }
}

class Grinch {
  //FIELDS
  String name;
  Boolean nice;
  ArrayList<Gift> stolenGifts;

  //CONSTRUCTOR
  Grinch(String n, boolean ni) {
    this.name = n;
    this.nice = ni;
    this.stolenGifts = new ArrayList<Gift>();
  }

  //METHODS
  void introduce() {
    println("Also, the name of their 'Grinch' is '" + this.name + "'.");
  }

  void awakens() {
    println();
    println("********************************");
    println("********** PLOT TWIST **********");    
    println("********************************");
    println();
    println("Just as everyone thought the Christmas chaos was finally over, " + this.name + " broke into the " + familyName + " family's house!");
    println(this.name + " absolutely despises Christmas, and wants to ruin it for everybody by stealing presents! Watch out!");
  }

  void stealGift(Member m, Gift g) {
    println();
    if (m.gifts.contains(g)) {
      println(" - Oh no! " + this.name + " has stolen " + g.name + " that " + g.buyer + " got for " + m.name + ".");
      if (this.nice == false) {
        m.gifts.remove(g);
      }
      this.stolenGifts.add(g);
    } else {
      println(this.name + " tries to steal " + g.name + " that is supposed to be for " + m.name + ".");
      println("Jokes on you, " + this.name + "! " + m.name + " did not get " + g.name + " this year.");
    }
  }

  void doneStealing() {
    println();
    println(this.name + " is finished with their crimes. Let's see what " + this.name + " stole this year:");
    if (this.stolenGifts.size() == 0) {
      println("Nothing! How lame.");
    } else {
      for (int i=0; i<stolenGifts.size(); i++) {
        println("- " + stolenGifts.get(i).name);
      }
      println();
      if (this.nice) {
        println("After much contemplation, " + this.name + " decides to return the gifts to their rightful owners. How kind!");
      } else {
        println(this.name + " is so incredibly mean, they threw all of the stolen gifts into the ocean. How rude!");
      }
    }
  }

  void closing() {
    println();
    println("*******************************************************************************************");
    println();
    if (this.nice) {
      println("What a wonderful Christmas! Despite the chaos, everyone was able to spend some quality time together.");
      println(this.name + "'s heart grew three sizes and they learned to love this very special season.");
    } else if (this.stolenGifts.size() == 0) {
      println("What a wonderful Christmas! Despite the chaos, everyone was able to spend some quality time together.");
      println(this.name + " made of fool of themselves by failing to steal any presents. Hopefully he learned his lesson!");
    } else {
      println("Despite the chaos and stolen presents, this was still a very wonderful Christmas.");
      println("Simply having each other is the best wish anyone could ask for. Hopefully " + this.name + " will realize this soon!");
    }
    println();
    println("Happy holidays, everyone!");
  }
}

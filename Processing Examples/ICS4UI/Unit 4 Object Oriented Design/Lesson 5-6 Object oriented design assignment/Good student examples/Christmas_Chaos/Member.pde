class Member {
  //FIELDS
  String name;
  String age;
  String occupation;
  String trait;
  String yearHighlight;
  boolean nice;
  ArrayList<Gift> wishList;
  ArrayList<Gift> gifts;

  //CONSTRUCTOR
  Member(String n, String a, String o, String t, String yh, boolean ni) {
    this.name = n;
    this.age = a;
    this.occupation = o;
    this.trait = t;
    this.yearHighlight = yh;
    this.nice = ni;
    this.wishList = new ArrayList<Gift>();
    this.gifts = new ArrayList<Gift>();
  }

  //METHODS
  void introduce() {
    println("Meet " + this.name + ", a " + this.age + "-year-old " + this.occupation + " who " + this.trait + ".");
  }

  void addToList(Gift g) {
    this.wishList.add(g);
    println("- " + this.name + " added '" + g.name + "' to their wish list.");
  }

  void printWishList() {
    println();
    println(this.name.toUpperCase() + "'S WISH LIST");
    println("-------------------");
    for (int i=0; i<this.wishList.size(); i++) {
      String item = wishList.get(i).name;
      println(item);
    }
  }

  void buyGift(Member m, Gift g, Store s) {
    println();
    println(this.name + " goes to " + s.name + " to buy " + g.name + " for " + m.name + ".");
    if (m.wishList.contains(g)) {
      if (s.onFire) {
        println(" - Oh no! " + this.name + " forgot that there was a fire at " + s.name + ".");
        println(" - The window facing south looks tempting though... just kidding, " + this.name + " would never do such a thing. Or would they?");
      } else if (s.closed) {
        println(" - Oh no! " + this.name + " did not realize that " + s.name + " was closed. What a waste of gas!");
      } else if (g.department == s.department) {
        println(" - Success! ");
        m.gifts.add(g);
        g.buyer = this.name;
      } else {
        println(" - Silly " + this.name + "! " + s.name + " did not have " + g.name + ".");
      }
    } else {
      println(" - Wait a minute! " + m.name + " did not ask for " + g.name + ". How foolish of " + this.name + "!");
    }
  }

  void openGifts() {
    println();
    println(this.name + " opens their gifts! Let's see what " + this.name + " got:");
    if (this.gifts.size() == 0) {
      println("Nothing! Oh no, I guess " + this.name + " was unlucky this year. Sorry " + this.name + "!");
    }
    for (int i=0; i<this.gifts.size(); i++) {
      println("- " + this.gifts.get(i).name + " from " + this.gifts.get(i).buyer);
    }
  }
}

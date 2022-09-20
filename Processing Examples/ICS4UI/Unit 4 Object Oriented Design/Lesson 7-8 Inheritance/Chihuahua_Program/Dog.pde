class Dog {
  String name, breed, gender, emoState;
  int weight;
  boolean isDangerous;

  Dog( String n, String g, String b, int w, boolean id) {
    this.name = n;
    this.gender = g;
    this.breed = b;
    this.weight = w;
    this.isDangerous = id;
    this.emoState = "normal";
  }


  void bark() {
    println("Woof!" + " said " + this.name);
  }


  void describe() {
    String description = this.name + " is a " + this.gender + " " + this.breed  +
                        " and is feeling " + this.emoState + " now.";

    if ( this.isDangerous )
      description += " Caution! May bite!";
   
    println( description);
  }
  
  
  void takeToVet() {
    this.emoState = "nervous";
  }
  
  
  void giveTreat( float weightOfTreat ) {
    this.emoState = "happy";
    this.weight += weightOfTreat;
  }
}

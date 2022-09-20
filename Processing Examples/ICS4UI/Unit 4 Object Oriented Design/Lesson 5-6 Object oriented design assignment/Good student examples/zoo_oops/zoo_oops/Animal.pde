class Animal {
  String name;
  String gender;
  String species;
  String mood = "normal" ;
  boolean hasHurtHuman;


  Animal(String name, String gender, String species) {
    this.name = name;
    this.gender = gender;
    this.species = species;
  }

  Animal(String name, String gender, String species, String mood) { //Different constructor if animal is feeling something other than normal
    this.name = name;
    this.gender = gender;
    this.species = species;
    this.mood = mood;
  }

  void kickHuman(Visitor v) {
    println(this.name, "has just tried to kick", v.name+"!");

    if (v.hasFastReflexes == true) //If the human has fast reflexes
      println("Luckily", v.name, "has superior ninja skills and dodged that kick!");

    else 
    println(this.name, "has brilliant aim! Poor", v.name, "just got socked in the face.");
    hasHurtHuman = true;
  }

  void biteHuman(Visitor v) {
    println(this.name, "just tried to bite", v.name +"!", "I guess", v.name, "looked yummier than the food.");

    if (v.hasFastReflexes == true)
      println("Luckily", v.name, "has taken superhero lessons before.", v.name, "just barely dodged the bite!");

    else {
      println(v.name, "just got bitten in the face! He's missing half an eye and all of his teeth! I guess a hospital visit is coming up.");
      hasHurtHuman = true;
    }
  }
}

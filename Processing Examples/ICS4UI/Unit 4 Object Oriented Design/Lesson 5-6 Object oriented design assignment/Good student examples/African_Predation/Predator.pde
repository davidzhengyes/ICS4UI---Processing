class Predator extends Animal{
 
  int huntingSkills;
  
  Predator(String n, String a, int ag, String g, int i, int ss, int hs){
    super(n, a, ag, g, i, ss);
    this.huntingSkills = hs;
  }
  
  void table(){
   printHeader( this.name);
   println("Species \t" + this.animal);
   println("Gender \t" +this.gender);
   println("Age \t" + this.age, "years old");
   println("Intelligence \t" + this.intelligence+ "/10");
   println("Social skills \t" + this.socialSkills+ "/10");
   println("Hunting Skills \t" + this.huntingSkills+"/10");
   println();

  }
  
   void hunt ( Prey p ){
    if(this.survivalPoints <= 0){
      println("Uh oh,", this.name, "has died! They couldn't survive and can no longer perform any more activities :(");
      println();
     }
    else if (p.survivalPoints <= 0){
      println(p.name, "can't be hunted because they're already dead :(");
      println();
     }
     
    else{
      println(this.name, "is trying to hunt a", p.name);
      int chance = int(random(1, 10));
      if (this.huntingSkills > p.intelligence && chance >= 7){
        println("The hunt was successful!", this.name, "is very happy but", p.name, "isn't doing so well. They just got eaten :(");
        println();
        p.hasDied();
        this.survivalPoints++;
      }
      else {
        println("The hunt wasn't successful.", this.name, "is depressed and hungry but", p.name, "gets to live another day!");
        println();
        this.survivalPoints--;
      }
     }
    }
    
   void breed(Predator P){
    if(this.survivalPoints <= 0){
      println("Uh oh,", this.name, "has died! They couldn't survive and can no longer perform any more activities :(");
      println();
    }
    else if (P.survivalPoints <= 0){
      println(P.name, "can't have babies because they're dead :(");
      println();
    }
     
    else{
     if(this.gender == P.gender){
       println(this.name, "and", P.name, "can't breed because they are the same gender.");
       println();
     }
     else{
       println(this.name, "and", P.name, "were able to have a baby!");
       this.survivalPoints--;
       P.survivalPoints--;
      int chance = int(random(0, 1));

     String babyGender = getBabyGender(chance); 
     String babyName = getBabyName(babyGender, this.name, this.gender, P.name);
     String babyAnimal = getBabyAnimal(this.animal, P.animal);
     int babyAge = 0;
     int babyIntelligence = round((this.intelligence + P.intelligence)/2);
     int babyHuntingSkills = round((this.huntingSkills + P.huntingSkills)/2);
     int babySocialSkills = round((this.socialSkills + P.socialSkills)/2);
 
     printHeader(babyName);
     println("Species \t" + babyAnimal);
     println("Gender \t" + babyGender);
     println("Age \t" + babyAge, "years old");
     println("Intelligence \t" + babyIntelligence+ "/10");
     println("Social skills \t" + babySocialSkills+ "/10");
     println("Hunting skills \t" + babyHuntingSkills+ "/10");
     println();
     }
    
    }  
 } 
}

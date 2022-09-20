class Prey extends Animal{
  
  //Constructor
  Prey(String n, String a, int ag, String g, int i, int ss){
    super(n, a, ag, g, i, ss);
  }
  
  void table(){
   printHeader(this.name);
   println("Species \t" + this.animal);
   println("Age \t" + this.age, "years old");
   println("Intelligence \t" + this.intelligence+ "/10");
   println("Social skills \t" + this.socialSkills+ "/10");
   println();
   
  }
 
  void findFood(){
    if(this.survivalPoints > 0){
      println(this.name, "is going out to find food.");
      int chance = int(random(1, 10));
      if(intelligence >= chance){
       println(this.name, "was able to get food.");
       println();
       survivalPoints++;
      }
      else{
       println(this.name, "wasn't able to get food. If they are continually unsuccesful, they may die!");
       println();
      }
    }
    else{
     println("Uh oh,", this.name, "has died! They couldn't survive and can no longer perform any more activities :(");
     println();
    }
  }
  
  void hasDied(){
    this.survivalPoints-=this.survivalPoints;
  }
  
   void breed(Prey P){
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
     int babySocialSkills = round((this.socialSkills + P.socialSkills)/2);
 
     printHeader(babyName);
     println("Species \t" + babyAnimal);
     println("Gender \t" + babyGender);
     println("Age \t" + babyAge, "years old");
     println("Intelligence \t" + babyIntelligence+ "/10");
     println("Social skills \t" + babySocialSkills+ "/10");
     println();
     }
    
    }  
 }
  
}

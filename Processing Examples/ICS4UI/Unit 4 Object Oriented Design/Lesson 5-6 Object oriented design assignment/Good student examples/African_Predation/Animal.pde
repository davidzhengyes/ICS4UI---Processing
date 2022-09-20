class Animal{
 
  //Fields
  String name;
  String animal;
  int age;
  String gender;
  int intelligence;
  int socialSkills;
  int survivalPoints = 3;
  String babyName;
  String babyGender;
  
  //Constructor
  Animal(String n, String a, int ag, String g, int i, int ss){
   this.name = n;
   this.animal = a;
   this.age = ag;
   this.gender = g;
   this.intelligence = i;
   this.socialSkills = ss;
  }
  
  
  void findWater(){
    if (this.survivalPoints > 0){
      println(this.name, "is going out to find water.");
      if (age >= 3 || socialSkills > 5){
         println("They were able to safely get water.");
         println();
         this.survivalPoints ++;
       } 
       else{
         println("They were not able to find water.");
         println();
         this.survivalPoints--;
       }
    }
    else{
      println("Uh oh,", this.name, "has died! They couldn't survive and can no longer perform any more activities :(");
      println();
    }
  }
    
  void findShelter(){
   if(this.survivalPoints > 0){ 
    if(this.socialSkills >= 5){
      println(this.name, "was able to find shelter with another group of", this.animal +"s.");
      println();
    }
    else if(this.intelligence >= 5){
      println(this.name, "was able to find its own shelter.");
      println();
    }
    else{
     println(this.name, "will have to go without a suitable shelter.");
     println();
    }
   }
   else{
     println("Uh oh,", this.name, "has died! They couldn't survive and can no longer perform any more activities :(");
     println();
   }
   
   
  }
  
 String getBabyGender( int c ){
  if (c == 0){
    return "male";
  }
  else{
   return "female"; 
  }
 }
 
 String getBabyName( String g, String pn1, String pg1, String pn2){
  if (g == pg1){
    return pn1 + " Jr.";
 }
 else{
  return pn2 + " Jr.";
 }
 }
 
 String getBabyAnimal( String p1, String p2){
   if(p1 == p2){
     return p1;
   }
   else{
      int length1 = p1.length();
      int length2 = p2.length();
      String half1 = p1.substring(0, (length1/2));
      String half2 = p2.substring(length2/2);
      return half1 + "-" + half2;
   }
 }
 
 void printHeader( String title ) { 
      String starRow = "";
      
      for(int i=0; i< title.length(); i++) 
        starRow += "*";
      
       println(title);
       println(starRow);
    }
    
 void end(){
   if (this.survivalPoints <= 0){
     println(this.name, "unfortunately died during the program. They finished the program with", this.survivalPoints, "points");
     println();
   }
   else if (this.survivalPoints < 3){
    println(this.name, "was able to survive the program but just barely. They finished the program with", this.survivalPoints, "points"); 
    println();
   }
   else{
     println(this.name, "did very well during the program! They finish the program with", this.survivalPoints, "points");
     println();
   }
 }
 
 
  
}

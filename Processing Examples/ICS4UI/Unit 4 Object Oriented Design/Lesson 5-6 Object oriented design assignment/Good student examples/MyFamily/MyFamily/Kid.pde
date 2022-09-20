class Kid {
//Fields of the class
  String name; 
  int age; 
  String gender;
  int emoState;
  float IQ;
  boolean chores;
  
 //CONSTRUCTOR
 Kid (String n , int a, String g, int e, float q, boolean c){
   this.name = n;
   this.age = a;
   this.gender = g;
   this.emoState = e;
   this.IQ = q;
   this.chores = c;
 }

  //METHODS
  void describe(){
    println(this.name, "is", this.gender,"and is", this.age, "years old");
  }
  
  void wakeup(){
    if (this.age >= 14){
      if (this.emoState >= 7){
        println();
        println(this.name, "woke up late so", this.name, "skipped breakfast");
      }
      
      else{
      println();
      println(this.name,"woke up at 7:00 am so", this.name, "has enough time to enjoy a yummy cereal");
      }
    }
    
    else{
    println(this.name,"have been awaken by mom and dad");
    }   
  }

  void askformoney(){
    println();
    println(this.name, "asked for money");
    if(this.age>=14){
      if(this.chores == true){
        println(this.name, "got the amount they asked for because they did their chores the day before");
      }
      else{
        println(this.name, "didn't get anything because", this.name, "did NOT do any of the chores");
      }
    }
      
    else if(this.age <= 7){
      if(this.chores == true){
        println(this.name, "got $5 they asked for because they did their chores the day before");
      }
      else{
        println(this.name, "only got $1 because", this.name, "did NOT do any of the chores");
      }
    }
    
    else{
      if(this.chores == true){
        println(this.name, "got the amount they asked for because they did their chores the day before");
      }
      else{
        println(this.name, "only got $2 because", this.name, "did NOT do any of the chores");
      }      
    } 
     
   }
 
  void throwAtantrum(){
    println();
    println(this.name, "has decide to throw a tantrum out of nowhere :(");
    this.emoState += 2;   
}

  void school(){
    if(this.age>13){
      println(this.name, "went to Laurel Heights Secondary School and they come back home at 2:40 pm");
    }
    
    else if(this.age < 11){
      println(this.name, "went to Laurelwood Public School and come back home at 3:15 pm ");
    }
    
    else{
    println(this.name, "also went to Laurelwood Public School because this school goes up to the 8th grade");
    }
  }

  void fight(Kid K){
    println();
    println("Things were peacefull until", this.name, "provoked", K.name, "and all hell broke loose");
    println("3....2....1....BEGIN!");
    println(K.name, "threw the first punch!!!");
    println("things are not looking good 0_0");
    int w = int(random(0,10));
    if (w > 6 ){
      println(this.name,"wins the fight against", K.name);
    }
    else{
    println(this.name,"looses the fight that they started with", K.name);
    }
    
    
}
  


}

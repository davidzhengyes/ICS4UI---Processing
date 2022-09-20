class Parent {
//Fields of the class
  String name; 
  int age; 
  String gender;
  int emoState;
  String Occupation;
  
 //CONSTRUCTOR
 Parent(String n , int a, String g, int e, String o){
   this.name = n;
   this.age = a;
   this.gender = g;
   this.emoState = e;
   this.Occupation = o;
 }

  //METHODS
  void describe(){
    println(this.name, "is", this.gender,"and is", this.age, "years old. Their job is", this.Occupation);
  }
  
 void wakeup(){
    if (this.emoState >= 8){
      println();
      println(this.name, "wants to sleep in but is forced to wake up.", this.name, "can't survive without coffee anymore");
    }
      
    else{
    println();
    println(this.name, "woke up with no time to rest as they have to make lunches for the kids");
    }
 
  }

 
 void rage(){
   this.emoState += 10;
   println(this.name,"'s rage has reached over to the sky and made the tempreture of the earth increase sooo high");
   println("The family tries to calm", this.name, "down");
   int r = int(random(0,10));
    if (r > 7 ){
      println("Things were tight but luckly", this.name, "has calmed down and was offered a nice cool iceream");
    }
    else{
    println("The family did not success in calming", this.name, "down and the whole world turn into a burning rock");
    println("BOOOOOOOOOOOOOM!");
    println("Well now everyone is dead x_x");
    println("Remember in your next life to always listen to your parents");
    }
    
 }


}

class Monster{
  //FIELDS
  String name;
  String race;
  int stepsToSummon = 5;

  //CONSTRUCTOR
  Monster(String n, String r){
    this.name = n;
    this.race = r;
  }
  
  //METHODS
  void describe(){
    println(this.name, "is a", this.race+".");
    println();
  }
  
  void playTheTrumpet(){
    println("'Doot Doot!' played", this.name, "on their trumpet.");
    println();
  }
        
  void curseTrickOrTreater( TrickOrTreater T ){
    println(this.name, "cursed", T.name+ "!");
    println();
    T.hasBeenCursed(this);
  }
  
  void grandSummoning( TrickOrTreater T ){
    println(this.name, "is performing the Grand Summoning. The scenario is extremely grimm.");
    println();
    T.hasBeenSacrificed();
    stepsToSummon -= 1;
    
    if(stepsToSummon == 0){
      println("IT IS COMPLETE! THE GRAND SUMMONING WORKED! THE DARK LORD HAS BEEN RETURNED! RUN FOR YOUR LIFE!");
      println();
      int x = 0;
      
      while(x < 4){
        if(x % 2 == 0){
          println("DOOM");
          println();
        }
        else if(x % 2 == 1){
          println("HELLFIRE");
          println();
        }
        
        x += 1;
      }
      
      println("The world ended. And then was reborn. Somehow it's Halloween again. What a weird system. Very suspicious.");
      println("Feel free to manipulate fate once again, oh powerful User.");
      println();
    }
  }
    
}

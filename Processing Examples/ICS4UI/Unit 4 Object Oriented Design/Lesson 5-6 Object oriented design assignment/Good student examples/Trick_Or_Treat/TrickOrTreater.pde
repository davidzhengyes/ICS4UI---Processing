class TrickOrTreater{
  //FIELDS
  String name;
  boolean inAGroup;
  int magicImmunity;
  String fear;
  String costume;
  int haul = 0;

  //CONSTRUCTOR
  TrickOrTreater(String TTn, String TTc, String TTf, int TTmI){
    this.name = TTn;
    this.costume = TTc;
    this.fear = TTf;
    this.magicImmunity = TTmI;
  }
  
  //METHODS
  void describe(){
    println(this.name, "is dressed up as a", this.costume+", and has a fear of", this.fear+".");
    println();
  }
  
  void changeInGroupStatus(Group g){
    String ofGroupName = g.groupName;
    println(this.name, "is now in the", ofGroupName, "group.");
    println();
  }
    
  void complain(){
    if( this.haul < 50 ){
      println(this.name, "is sulking and snapping at people.", this.name, "REALLY wants more goodies.");
      println();
    }
    
    else if( this.haul >= 50){
      if( this.haul % 2 == 1){
        println(this.name, "wants just a few more goodies. Just one more. One more sweet, delicious, precious goodie.");
        println();
      }
    
      else{
        println();
      }
    }
  }
      
  void hasBeenCursed( Monster m ){
    String ofMonsterName = m.name;
    
    if(this.magicImmunity == 1){
      println(this.name, "is immune to magic! All", ofMonsterName, "did was make a fool of themself.");
      println();
    }
    
    else{
      println(this.name, "has been cursed by", ofMonsterName+ "!", this.name, "has lost 2 goodies.");
      println();
      if( this.haul < 2 ){
        this.haul = 0;
      }
      
      if( this.haul >= 2 ){
        this.haul -= 2;
      }
    }
  }


  void hasBeenSacrificed(){
    println(this.name, "burst into flames. They're gone. Just like that. Dust. Don't mess with magic.");
    println("Nothing can be done with", this.name+ ". They're not with us anymore...");
    println();
  }
    
    
  void printHaul(){
    println( this.name, "has a goodie haul of", this.haul + ".");
    println();
  }


  void ringDoorbell() {
    println( this.name, "rang the house's doorbell.");
    int answerDoor = round(random(0,1));
    
    if(answerDoor == 0){
      println("No one answered the door.", this.name, "left, feeling defeated, filled with sadness and an aching sweet tooth.");
      println();
    }
    
    else{
      int likeCostume = round(random(0,1));
      
      if(likeCostume == 0){
        int numSweets = round(random(0,1));
        
        if(numSweets == 0){
          println("The house owner didn't like", this.name + "'s costume.", this.name, "got", numSweets, "goodies :(");
          println();
        }
        
        else{
          println("The house owner didn't like", this.name+"'s costume.", this.name, "only got", numSweets, "goodie :(");
          println();
          this.haul += 1;
        }
      }

      else{
        int numSweets = round(random(3,4));
        println("The house owner loved", this.name+"'s costume.", this.name, "got", numSweets, "goodies :)");
        println();
        this.haul += numSweets;
      }
    }
  }
    
}

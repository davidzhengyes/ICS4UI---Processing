class Human {
  //fields
  String name;
  String DOB;
  Dog myPet;
  Ball theBall;
  
  
  
  //constructor
  Human(String s){
    this.name=s;
    this.DOB="";
    this.myPet=null;
  }
  
  void thro(Ball b){
    this.theBall=b;
    b.throww();
  }
  
  
  //methods
  void adopt(Dog d){
    this.myPet=d;
    d.myOwner=this;  //refers to the entire human object
  }
  
  void describe(){
    println("hi my name is",this.name,"i am a human"); 
    if (this.myPet != null){
      println("my dog's name is", this.myPet.name);
    }
  }
  
}

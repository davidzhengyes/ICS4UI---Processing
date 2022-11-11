class Chihuahua extends Dog{  //subclass, dog superclass
  
  Chihuahua(String n, int age){
    //call the dog constructor
    super(n,age,"chihuahua","male");
  }
  
  
  void describe(){
    super.describe();
    println("i am chihuahuah");
    
  }
}

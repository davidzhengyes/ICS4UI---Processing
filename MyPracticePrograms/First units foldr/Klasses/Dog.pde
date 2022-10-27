class Dog{
  int age;
  String name,breed,gender,emoState;
  float weight;
  Human myOwner;
  Ball theBall;
  
  Dog(String n, int a, String b, String g){
    this.name=n;
    this.age=a;
    this.breed=b;
    this.gender=g;
    this.myOwner=null;
  }
  
  void retrieve(Ball b){
    this.theBall = b;
    print(this.name,"has eaten the ball");
  }
  
  void describe(){
    print("i am", age, "years old");
    if (myOwner!=null){
      
      print("my owner's name is", myOwner.name);
    }
  }
  
  
}

class Meathead{
  String name;
  int heightInCM;
  int weight;
  int exhaustion;
  int fightingSkills;
  int muscleMass;
  int brainClarity;
  boolean isChanged;
  
  Machine currentMachine;
  
  Meathead(String n, int h, int w, int e, int f, int m){
    this.name = n;
    this.heightInCM = h;
    this.weight = w;
    this.exhaustion = e;
    this.fightingSkills = f;
    this.muscleMass = m;
    this.brainClarity = 10;
    this.isChanged = false;
  }
  
  void change(){
    if (isChanged){
      isChanged=false;
    }
    else{
      isChanged=true;
    }
  }
  
  void rest (int time){
    brainClarity+=time;
    exhaustion-=time;
    println(this.name,"has rested for",time,"minutes, they now have an exhaustion level of",exhaustion);
    
  }
  
  void useMachine(Machine m){
    if (isChanged==false){
      println("People stare because",this.name,"is still wearing their winter coat and boots", this.name,"does not start using the machine");
      
    }
  }
  
}

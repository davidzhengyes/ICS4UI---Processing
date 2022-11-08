class Meathead{
  String name;
  int heightInCM;
  int weight;
  int exhaustion;
  int fightingSkills;
  int muscleMass;
  int brainClarity;
  boolean isChanged;
  
  Meathead(String n, int h, int w, int e, int f, int m, int b){
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
  }
  
  void useMachine(Machine m){
    
  }
  
}

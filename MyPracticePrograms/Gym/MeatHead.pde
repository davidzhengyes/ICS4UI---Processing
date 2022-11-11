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
  
  Meathead(String n, int h, int w,  int f, int m){
    this.name = n;
    this.heightInCM = h;
    this.weight = w;
    this.exhaustion = 0;
    this.fightingSkills = f;
    this.muscleMass = m;
    this.brainClarity = 10;
    this.isChanged = false;
    this.currentMachine = null;
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
    brainClarity+=time/2;
    exhaustion-=time;
    println(this.name,"has rested for",time,"minutes, they now have an exhaustion level of",exhaustion);
    
  }
  
  void useMachine(Machine m){
    try{
      this.currentMachine.meathead=null;
    }
    catch(Exception e){  
    }
    if (isChanged==false){
      println("People stare because",this.name,"is still wearing their winter coat and boots,", this.name,"does not start using the machine");
    }
    
    else{
      if (m.isOccupied()){
        println("The machine" ,m.name,"is currently occupied by",m.name,"so",this.name,"can not start using it without a fight");
        
        if (this.brainClarity<4 && m.meathead.brainClarity<4){
          println("they will fight over the machine!");
          Fight f = new Fight(this, m.meathead,m);
          f.startFight();
        }
      }
      
      else{
        this.currentMachine = m;
        m.meathead = this;
        println(this.name,"is now using the",m.name);
      }      
    }  
  }
  
  
  
   
  
  void doSet(int reps){
    if(this.currentMachine == null){
      println("Can't use a machine if not currently at one!");
    }
    else{
      for (int i=0; i<reps; i++){
        this.brainClarity-=1;
        this.exhaustion += int(float(currentMachine.weight)/30 * currentMachine.exhaustionFactor);
        println(this.name,"has done a repitition, brain activity is now decreased to", brainClarity,"and their exhaustion level is now", exhaustion);
        
        if (exhaustion>100){
          println(this.name,"is too tired to continue");
          rest(20);
          decreaseWeight(15);
          break;
        }
      }
    }
  }
  
  void addWeight(int w){
    if (this.currentMachine != null){
      this.currentMachine.weight += w;
    }
  }
  
  void decreaseWeight(int w){
    if (this.currentMachine!= null){
      this.currentMachine.weight +=w;
    }
  }
}

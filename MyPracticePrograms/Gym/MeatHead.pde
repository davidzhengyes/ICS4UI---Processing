class Meathead{
  String name;
  int heightInCM;
  int weight;
  int exhaustion;
  int fightingSkills;
  int muscleMass;
  int brainClarity;
  boolean isChanged;
  int totalExhaustion;
  
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
    this.totalExhaustion = 0;
  }
  
  Meathead(String n){
    this.heightInCM=int(random(150,200));
    this.weight = int(random(100,200));
    this.exhaustion=0;
    this.fightingSkills=int(random(1,10));
    this.brainClarity = int(random(0,20));
    this.isChanged=false;
    this.currentMachine=null;
    this.totalExhaustion=0;
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
        println("The machine" ,m.name,"is currently occupied by",m.meathead.name,"so",this.name,"can not start using it without a fight");
        
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
    if (totalExhaustion>150){
      println(this.name,"is too tired, they will now go home");
      this.change();
      this.exhaustion = 0;
      this.totalExhaustion=0;
      this.currentMachine.meathead=null;
      this.currentMachine = null;
      this.brainClarity = 10; 
    }
    if (this.exhaustion>100){
      println(this.name,"is too tired to continue, so they will take a break and decrease the weight.");
      rest(20);          
      decreaseWeight(15);     
    }
    
    if(this.currentMachine == null){
      println("Can't use a machine if not currently at one!");
    }
    else{
      for (int i=0; i<reps; i++){
        this.currentMachine.dirtiness++;
        this.brainClarity-=1;
        this.exhaustion += int(float(currentMachine.weight)/18 * currentMachine.exhaustionFactor);
        this.totalExhaustion +=  int(float(currentMachine.weight)/18 * currentMachine.exhaustionFactor);  
      }
      println(this.name,"has done a set, brain activity is now decreased to", brainClarity,"and their exhaustion level is now", exhaustion);
    }
  }
  
  void addWeight(int w){
    if (this.currentMachine != null){
      this.currentMachine.weight += w;
      println(this.name, "has increased weight by",w,"on the",this.currentMachine.name);
    }
  }
  
  void decreaseWeight(int w){
    if (this.currentMachine.weight>30){
      if (this.currentMachine!= null){
        this.currentMachine.weight -=w;
      }
    }
  }
}

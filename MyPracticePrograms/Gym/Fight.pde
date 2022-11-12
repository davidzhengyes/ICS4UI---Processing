class Fight{
  Meathead m1,m2;
  int m1points=0, m2points=0;
  Machine machineFoughtOver;
  float differenceInFightCapacity;
  
  Fight(Meathead m1, Meathead m2,Machine m){
    this.m1=m1;
    this.m2=m2;
    this.machineFoughtOver = m;
  }
  
  void startFight(){
    
    float m1FightingCapacity = float(1)/m1.heightInCM * float(m1.weight) / m1.exhaustion * m1.fightingSkills * m1.muscleMass;
    float m2FightingCapacity = float(1)/m2.heightInCM * float(m2.weight) / m2.exhaustion * m2.fightingSkills * m2.muscleMass;
    
    Worker closestWorker = workers.get(int(random(workers.size())));
    
    differenceInFightCapacity = m1FightingCapacity-m2FightingCapacity;
    boolean canStopFight = closestWorker.canStopFight(this);
    
    if (this.differenceInFightCapacity>0 && canStopFight==false){
      m1.currentMachine = machineFoughtOver;
      m2.currentMachine = null;
      machineFoughtOver.meathead = m1;
      println(m1.name,"won the fight, so they get to use the",machineFoughtOver.name);
      println();
    }
    else if (this.differenceInFightCapacity<0 && canStopFight==false){
      m2.currentMachine = machineFoughtOver;
      m1.currentMachine = null;
      machineFoughtOver.meathead=m2;
      println(m2.name,"won the fight, so they get to use the",machineFoughtOver.name);
      println();
    }
    else{
      println("the fight was stopped by",closestWorker.name,"because the skill difference between the two meatheads was minimal");
      println();
      machineFoughtOver.meathead=null;
      m1.currentMachine=null;
      m2.currentMachine=null;
    }
  }
}

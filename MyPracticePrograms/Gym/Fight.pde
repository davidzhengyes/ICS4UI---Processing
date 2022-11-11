class Fight{
  Meathead m1,m2;
  int m1points=0, m2points=0;
  Machine machineFoughtOver;
  
  Fight(Meathead m1, Meathead m2,Machine m){
    this.m1=m1;
    this.m2=m2;
    this.machineFoughtOver = m;
  }
  
  void startFight(){
    float m1FightingCapacity = float(1)/m1.heightInCM * m1.weight / m1.exhaustion * m1.fightingSkills * m1.muscleMass;
    float m2FightingCapacity = float(1)/m2.heightInCM * m2.weight / m2.exhaustion * m2.fightingSkills * m2.muscleMass;
    
    if (m1FightingCapacity>m2FightingCapacity){
      m1.currentMachine = machineFoughtOver;
      m2.currentMachine = null;
      machineFoughtOver.meathead = m1;
      println(m1.name,"won the fight, so they get to use the",machineFoughtOver.name);
    }
    else{
      m2.currentMachine = machineFoughtOver;
      m1.currentMachine = null;
      machineFoughtOver.meathead=m2;
      println(m2.name,"won the fight, so they get to use the",machineFoughtOver.name);
    }
  }
}

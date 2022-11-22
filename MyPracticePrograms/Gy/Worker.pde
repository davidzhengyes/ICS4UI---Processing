class Worker{
  String name;
  int grumpiness;
  int salary;
  
  Worker(String n,int g, int s){
    this.name=n;
    this.grumpiness=g;
    this.salary =s;
  }
  
  
  boolean canStopFight(Fight f){
    
    if (abs(f.differenceInFightCapacity)>1){
      
      println("the fight was too one-sided, so" ,this.name,"was not able to stop it");
      println();
      return false;
    }
    else{
      return true;
    }   
  }
 
  void cleanMachine (Machine m){
    int preClean=m.dirtiness;
    m.dirtiness*=10/grumpiness*float(salary)/15;
    println(this.name,"is not happy today nor are they happy with their wages, so they only cleaned the machine by",float(preClean-m.dirtiness)/preClean,"percent");
    println();
  }
  
}

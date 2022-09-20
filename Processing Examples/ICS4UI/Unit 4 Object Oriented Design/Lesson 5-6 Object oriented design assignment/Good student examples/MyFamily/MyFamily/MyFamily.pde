//Leen Arafeh
//enotional state line
// happy 1-2    normal 3-4                      angry 8-9     depressed 10


void setup(){
  exit();
  
  Kid kid1 = new Kid("Leen",17,"female",5,7,true);      //name, age, gender, mood, intellect level
  Kid kid2 = new Kid("Barra",16,"male",7,5,false);
  Kid kid3 = new Kid("Jana",11,"female",3,4,true);
  Kid kid4 = new Kid("Belal",6,"male",7,3,false);
  Kid kid5 = new Kid("Kinan",4,"male",4,2,true);
  
  Parent parent1 = new Parent("Samer",44,"male",9,"Accountant");      //name, age, gender, mood, occupation
  Parent parent2 = new Parent("Rasha",44,"female",7,"Pharmacy Assistant"); 

  println("Hiiiiiii I am the house!");
  print("\n    /\\\n   /  \\\n  /    \\\n /------\\\n|   __   |\n|  |  |  |\n----------\n");
  println(" "); 
  
  println("There are 7 poeple living here!");
  
  println(" ");
  println("The kids are:");
  kid1.describe();
  kid2.describe();
  kid3.describe();
  kid4.describe();
  kid5.describe();
  println();
  println("The parents are:");
  parent1.describe();
  parent2.describe();
  println();
  
  println("Let's go through how a normal Monday morning looks like.");
  
  println();
  parent1.wakeup();
  parent2.wakeup();
  kid1.wakeup();
  kid2.wakeup();
  kid3.wakeup();
  kid4.wakeup();
  kid5.wakeup();
  
  kid1.askformoney();
  kid3.askformoney();
  kid4.askformoney();
  
  kid5.throwAtantrum();
  
  println();
  kid1.school();
  kid2.school();
  kid3.school();
  kid4.school();
  kid5.school();
  
  println();
  kid4.fight(kid5);
  kid4.fight(kid3);
  
  println();
  parent2.rage();
  
}

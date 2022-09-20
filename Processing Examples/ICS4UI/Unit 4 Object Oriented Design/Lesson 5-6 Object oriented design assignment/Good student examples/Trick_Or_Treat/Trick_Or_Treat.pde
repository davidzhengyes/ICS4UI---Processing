void setup(){
  
  TrickOrTreater Mike = new TrickOrTreater("Mike", "ninja", "candy corn", 0);
  TrickOrTreater Josh = new TrickOrTreater("Josh", "clown", "chemistry", 1);
  TrickOrTreater Daniel = new TrickOrTreater("Daniel", "the last airbender", "Mr. Fish's physics lessons", 1);
  TrickOrTreater Schattman = new TrickOrTreater("Mr. Schattman", "environmnent hero", "plastic water bottles and errors in the code", 0);
  TrickOrTreater Marissa = new TrickOrTreater("Marissa", "doctor", "pesticides", 1);
  TrickOrTreater Oana = new TrickOrTreater("Oana", "straight A student", "the blood portal to hell in the Chatime bathroom", 0);
  
  Monster Lucy = new Monster("Lucy Lucifer", "demon");
  Monster SamPak = new Monster("Sam Pak", "retail appliance salesman");
  
  Group SealTeamSix = new Group("Seal Team Six");
  Group TeamRocket = new Group("Team Rocket");
  Group AlphaCandyCollectors = new Group("Alpha Candy Collectors");
  
  SealTeamSix.addMember(Mike);
  SealTeamSix.addMember(Oana);
  TeamRocket.addMember(Josh);
  TeamRocket.addMember(Daniel);
  AlphaCandyCollectors.addMember(Marissa);
  AlphaCandyCollectors.addMember(Schattman);
  
  Mike.describe();
  Josh.describe();
  Daniel.describe();
  Oana.describe();
  Schattman.describe();
  Marissa.describe();
  Lucy.describe();
  SamPak.describe();
  
  SealTeamSix.printAllMembers();
  TeamRocket.printAllMembers();
  AlphaCandyCollectors.printAllMembers();
  
  Lucy.playTheTrumpet();
  
  Josh.ringDoorbell();
  Josh.printHaul();
  Josh.complain();
  
  SamPak.curseTrickOrTreater(Josh);
  SamPak.curseTrickOrTreater(Mike);
  Mike.printHaul();
  Lucy.grandSummoning(Josh);
  Lucy.grandSummoning(Daniel);
  Lucy.grandSummoning(Mike);
  Lucy.grandSummoning(Schattman);
  Lucy.grandSummoning(Oana);

}

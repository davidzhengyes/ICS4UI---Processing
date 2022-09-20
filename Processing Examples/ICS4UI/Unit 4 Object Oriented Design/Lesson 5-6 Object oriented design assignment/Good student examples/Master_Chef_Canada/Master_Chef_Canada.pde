ArrayList<Contestant> currentContestants = new ArrayList<Contestant>(); 
ArrayList<Judge> judges = new ArrayList<Judge>(); 
ArrayList<Dish> dishes = new ArrayList<Dish>();


void setup() {
  
  // ENTERING DISHES INTO THE SYSTEM
  // SOME OF THESE ARE MADE UP DISHES, AND SOME ARE FROM THE ACTUAL SHOW
  //format:  Dish(String main, String side1 (if not dessert), String s2 (if not dessert), String sauce (if not dessert), int difficulty, int creativity)
  Dish icecream = new Dish("icecream", 20, 20);
  icecream.addDish();
  
  Dish steak = new Dish("steak", "fries", "brussel sprouts", "cream", 50, 30);
  steak.addDish();
  
  Dish cheesecake = new Dish("cheesecake", 80, 50);
  cheesecake.addDish();
  
  Dish pork = new Dish("pork chop", "coleslaw", "beans", "gravy", 55, 35);
  pork.addDish();
  
  Dish bakedalaska = new Dish("baked alaska", 75, 80);
  bakedalaska.addDish();  
  
  Dish cremecaramel = new Dish("crème caramel", 95, 85);
  cremecaramel.addDish();  

  Dish ribs = new Dish("ribs", "mixed vegetables", "cornbread", "BBQ", 35, 35);
  ribs.addDish();  
  
  Dish lamb = new Dish("pistachio-crusted rack of lamb", "sweet potato purée", "figs", "gravy", 80, 75);
  lamb.addDish(); 
  
  
  // STARTING THE COMPETITION
  println("****************************************************");
  println("WELCOME TO MASTERCHEF CANADA (Featuring Your Favourite Disney and TV Characters)!");
  println("A cooking competition where individuals compete to win $100,000!");
  println("****************************************************");
  println();
  
  
  //INTRODUCING THE JUDGES AND ADDING THEM TO THE SYSTEM
  // THESE ARE ALL ACTUAL JUDGES FROM MC CANADA (except for Gordon Ramsay who's a Masterchef US judge)
  println("MEET THE JUDGES");
  
  //format: Judge (String name, String nickname, int restaurants, int michelin stars, int toughness, int bribed)
  Judge gordon = new Judge ("Gordon Ramsay", "Idiot Sandwich", 35, 16, 80, 96);  
  gordon.introduce();
  gordon.addJudge();
  
  Judge alvin = new Judge ("Alvin Leung", "Demon Chef", 5, 3, 76, 80);  
  alvin.introduce(); 
  alvin.addJudge();

  Judge michael = new Judge ("Michael Bonacini", "Storyteller", 13, 1, 20, 30);  
  michael.introduce();   
  michael.addJudge();
  
  Judge claudio = new Judge ("Claudio Aprile", "Can't Handle Spice", 4, 0, 50, 60);  
  claudio.introduce();  
  claudio.addJudge();
  
  println();
  
  //INTRODUCING THE CONTESTANTS AND ADDING THEM TO THE SYSTEM
  // THESE ARE ALL ACUTUAL CONTESTANTS FROM MC CANADA AND DISNEY/TV CHARACTERS
  //format: Contestant (String name, String location, String funfact, int skill, int creativity, int clumsiness, int stubbornness, int bribery, int teamplayer) 

  println("MEET THE CONTESTANTS");
  println("****************************************************");
  Contestant jennifer = new Contestant ("Jennifer", "Halifax, NS", "really wants to be a child again", 60, 80, 50, 0, 10, 100);
  jennifer.introduce();
  jennifer.addContestant();
  
  Contestant trevor = new Contestant ("Trevor", "Edmonton, AB", "thinks he is the best chef", 50, 40, 60, 10, 25, 40);
  trevor.introduce();
  trevor.addContestant();
 
  Contestant sean = new Contestant ("Sean Hickey", "London, ON", "eats everything in sight", 5, 8, 90, 70, 75, 3);
  sean.introduce();  
  sean.addContestant();

  Contestant dale = new Contestant ("Dale", "Toronto, ON", "is only here for the drama", 10, 20, 80, 95, 80, 8);
  dale.introduce(); 
  dale.addContestant();
  
  Contestant elmo = new Contestant ("Elmo", "Seasame Street", "doesn't know why they're here", 30, 50, 20, 55, 35, 80);
  elmo.introduce(); 
  elmo.addContestant();
  
  Contestant mickey = new Contestant ("Mickey", "Disneyland", "has big ears", 45, 60, 60, 85, 25, 50);
  mickey.introduce(); 
  mickey.addContestant();
  
  Contestant remy = new Contestant ("Remy", "France", "is a master when it comes to putting flavours together", 95, 100, 30, 20, 60, 80);
  remy.introduce(); 
  remy.addContestant();
  
  Contestant sully = new Contestant ("Sully", "Monstropolis", "is the best at scaring people", 75, 75, 80, 90, 90, 60);
  sully.introduce(); 
  sully.addContestant();
  
  println();
  
  //STARTING THE COMPETITION
  startCompetition();

} 


//UNIVERSAL FUNCTIONS THAT APPLY TO THE WHOLE PROGRAM
void startCompetition() {
  
  while (currentContestants.size() != 1) {
    Round r;
    
    // an individual challenge will run if there are an even number of contestants and there are more than two contestants
    if (currentContestants.size() == 2 || currentContestants.size() % 2 != 0 ) {
      r = new Round ("INDIVIDUAL CHALENGE", "The contestants will each make a dish, and the individual with the lowest score will be eliminated!");
    
    }
    
    //a team challenge will run otherwise
    else {
      String[] teamNames1 = {"Fireducks", "Foodies", "Gingerbreads"};
      String[] teamNames2 = {"Hot Peppers", "Bananas", "Candycanes"};
      int index1 = int(random(teamNames1.length));
      int index2 = int(random(teamNames2.length));
      
      Team t1 = new Team(teamNames1[index1]);
      Team t2 = new Team(teamNames2[index2]);  
      r = new Round ("TEAM CHALENGE", "The contestants will be randomly split into two teams. The teams will make a dish together and the team with the lowest score will be eliminated!", t1, t2);
      
    }
    
    r.describe();
    r.beginRound();
    r.eliminate();  

    
    if (currentContestants.size() != 1) {
      printCurrentContestants(); 

    }
  }
  
  println();
  //the winner will be presented when there's one contestant left
  currentContestants.get(0).presentWinner();
}


//RANDOM GENERATORS FOR JUDGES AND DISHES
Judge generateJudge() {
  int index = int(random(judges.size()));
  return judges.get(index);
}

Dish generateDish() {
  int index = int(random(dishes.size()));;
  return dishes.get(index);

}


void printCurrentContestants() {
  println();
  println("****************************************************");
  println("CURRENT PARTICIPATING CONTESTANTS");
  println("****************************************************");
  for (int i = 0; i < currentContestants.size(); i++) {
    println(currentContestants.get(i).name);
  }
  println();
}

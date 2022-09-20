class Team {
  
  //FIELDS
  String name;
  ArrayList<Contestant> members;
  int skill;
  int creativity;
  int teamwork;
  int clumsiness;
  int score;
  Judge judge;
  
  //CONSTRUCTOR
  Team (String n) {
    this.name = n;
    this.skill = 0;
    this.creativity = 0;
    this.teamwork = 0;
    this.members = new ArrayList<Contestant>();
    this.score = 50;
  
  }
  
  void addmember (Contestant c) {
    this.members.add(c);
  }
  
  //METHODS
  void setScores() {
    int totalskill = 0;
    int totalcreativity = 0;
    int totalteamwork = 0;
    int totalclumsy = 0;
    for (int i = 0; i < members.size(); i++) {
      Contestant member = members.get(i);
      totalskill += member.skill;
      totalclumsy += member.clumsiness;
      totalcreativity += member.creativity;
      totalteamwork += member.teamplayer;
    }
    
    //a team's overall characteristics are the average of the characteristics of its members
    this.skill = int(float(totalskill)/members.size());
    this.creativity = int(float(totalcreativity)/members.size());      
    this.teamwork = int(float(totalteamwork)/members.size());   
    this.clumsiness = int(float(totalclumsy)/members.size());   
  }

  void makeDish(Dish d) {
    if (d.name == "") {
      println("The", this.name, "have decided to make a", d.main, "with a side of", d.side1, "and", d.side2, "with a", d.sauce, "sauce.");
    }
    
    else {
      println("The", this.name, "have decided to make", d.name + ".");
    }
    
    if (this.skill >= d.difficulty && this.creativity >= d.creativity) {
      println("The", this.name, "are very confident that they will put out a great dish.");
    }
    
    else {
      println("The", this.name, "are not very confident about executing the dish that they chose.");
    }
    
    //the base score is predetermined based on the team's skill, creativity and teamwork
    this.score = int(float((this.skill + this.creativity + this.teamwork))/3);
    
    if (this.skill < d.difficulty) {
      int chance = int(round(random(0, 100)));
      
      if (chance <= 100-this.clumsiness) {
        // a random victim in the group will call for a medic, since everyone's negatively impacted by the low clumsiness score
        callForMedic();
      }
    }
    
    if (this.teamwork <= 60) {
      int chance = int(round(random(0, 100)));
      
      if (chance <= 100-this.teamwork) {
        argue();
      }
    }
    
    println();
  }
  
  void argue() {
    println("The", this.name, "are yelling at eachother and are not being very productive!");
    
    if (this.score >= 10) {
      this.score -= 10;
    }
  }
  
  void callForMedic () {
    Contestant victim;
    int chance = int(random(this.members.size()));
    victim = this.members.get(chance);
    
    String[] injuries = {"cut their finger", "burned their hand", "scorched their hand", "sprained their ankle", "became lightheaded"};
    int choice = int(random(injuries.length));
    println(victim.name, "has", injuries[choice], "and called a medic!");

    if (this.score >= 5) {
      this.score -= 5;
    }
    
  }
}

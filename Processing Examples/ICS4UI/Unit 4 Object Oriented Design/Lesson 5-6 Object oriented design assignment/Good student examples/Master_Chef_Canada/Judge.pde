class Judge {
  //FIELDS
  String name;
  String nickname;
  int restaurantsOwned;
  int numMichelinStars;
  int toughness;
  int canbeBribed;
  ArrayList<Contestant> favContestants;
  
  //CONSTRUCTORS
  Judge (String n, String nick, int rest, int mich, int tough, int bribed) {
    this.name = n;
    this.nickname = nick;
    this.restaurantsOwned = rest;
    this.numMichelinStars = mich;
    this.toughness = tough;
    this.canbeBribed = bribed;
    this.favContestants = new ArrayList<Contestant>();
  }
  
  // METHODS
  
  void introduce() {
    String stars = "";
    
    if (numMichelinStars != 0) {
      for (int i = 0; i < numMichelinStars; i++) {
        stars += "*";
      }
    }
    
    else {
      stars = "None";
    }
    
    println("****************************************************");
    println(this.name, "("+this.nickname+")");
    println("****************************************************");
    
    println("•", this.name, "is a world-renouned chef that owns", this.restaurantsOwned, "restaurants :O");
    println("•", this.name + "'s total Michelin Stars:", stars); 
    
    if (toughness <= 45) {
      println("•", this.name, "is as cool as a cucumber :)");
    }
    
    else if (toughness > 45 && toughness <= 75) {
      println("•", this.name, "can get harsh sometimes :/");      
    }
    
    else {
      println("•", this.name, "hasn't tasted good food in forever >:(");         
    }
    
    println();
    

  }
  
  
  void addJudge () {
    judges.add(this);
  }
  
  void judgeFood(Contestant c) {
    boolean dropfood = false;
    c.judge = this;
    println("****************************************************");
    println(c.name + "'s food is now being judged by", this.name);
    println("****************************************************"); 

    if (c.clumsiness >= 50) {
      int chance = int(round(random(0, 100)));
      
      if (chance >= float(c.clumsiness)/5) {
        c.dropFood();
        dropfood = true;
      }
    }
    
    if (dropfood == false) {
      if (c.score < this.toughness) {
        spitOut(c);
      }
      
      else if (c.score > this.toughness) {
        finishFood(c);
      }
      
      else {
        println();
      }
    }
    
    println();
    println("RESULTS");
    
    if (dropfood == false) {
      println("Presentation:", c.creativity);
      println("Taste:", c.skill);
    }
    
    println("Overall Score:", c.score);
       
    println();
    
  }

  void judgeFood(Team t) {
    t.judge = this;
    println("****************************************************");
    println("The", t.name + "'s food is now being judged by", this.name);
    println("****************************************************"); 
    if (t.score < this.toughness) {
      spitOut(t);
    }
    
    else if (t.score > this.toughness) {
      finishFood(t);
    }
    println();
    println("RESULTS");
    println("Presentation:", t.creativity);
    println("Taste:", t.skill);
    println("Teamwork:", t.teamwork);
    println("Overall Score:", t.score);
    

    
    println();
    
  }
  
  
  void spitOut(Contestant c) {
    println(this.name, "thought that the food was so disgusting that they spit it out!");
    
    if (c.score >= 10) 
      c.score -= 10;
  
  }

  void spitOut(Team t) {
    println(this.name, "thought that the food was so disgusting that they spit it out!");
    
    if (t.score >= 10) 
      t.score -= 10;
  
  }
  
  void finishFood (Contestant c) {
    println(this.name, "thought that the food was so delicious that they licked their plate clean!");
    
    if (c.score <= 90)
      c.score += 10;  
  }
  
  void finishFood (Team t) {
    println(this.name, "thought that the food was so delicious that they licked their plate clean!");
    
    if (t.score <= 90)
      t.score += 10;  
  }
  
  

  

  
}

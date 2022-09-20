class Round {
  
  //FIELDS
  String name;
  String rules;
  Team t1;
  Team t2;
  boolean teamstatus;
  
  //CONSTRUCTORS
  
  // Individual challenge
  Round (String n, String r) {
    this.name = n;
    this.rules = r;
    this.teamstatus = false;

    
     
  }
  
  //Team challenge
  Round (String n, String r, Team t1, Team t2) {
    this.name = n;
    this.rules = r;
    this.t1 = t1;
    this.t2 = t2;
    this.teamstatus = true;
    
     
  }


  //METHODS
  void beginRound() {
    if (teamstatus == true) {
      formTeams(t1, t2);
      t1.setScores();
      t2.setScores();
      t1.makeDish(generateDish());
      t2.makeDish(generateDish());
      generateJudge().judgeFood(t1);
      generateJudge().judgeFood(t2);
    }
    
    else {
      for (int i = 0; i < currentContestants.size(); i++) {
        Contestant contestant = currentContestants.get(i);
        contestant.makeDish(generateDish());
      }

      for (int i = 0; i < currentContestants.size(); i++) {
        Contestant contestant = currentContestants.get(i);        
        generateJudge().judgeFood(contestant);
      }
    }
    
  }
  
  void formTeams (Team t1, Team t2) {
  
  if (currentContestants.size() % 2 == 0) {
    int size = int(currentContestants.size() / 2 );
    
    for (int i = 0; i < currentContestants.size(); i++) {
      int team = int(round(random(0,1)));
      
      if (t1.members.size() == size) {
        team = 1;
      }
      
      if (t2.members.size() == size) {
        team = 0;
      }
    
      if (team == 0) {
        t1.addmember(currentContestants.get(i));
      }
      
      else {
        t2.addmember(currentContestants.get(i));          
      }
    }
    
    println();
    println("THE TEAMS");
    println("****************************************************");
    println("The", t1.name);
    println("****************************************************");
    for (int i = 0; i < t1.members.size(); i++) {
      println(t1.members.get(i).name);
    }
    println();
    
    println("****************************************************");
    println("The", t2.name);
    println("****************************************************");
    for (int i = 0; i < t2.members.size(); i++) {
      println(t2.members.get(i).name);
    }
    println();
    
  }
  
  else { // this won't happen due to the restrictions in the startCompetition function, but just in case :)
    println("There wasn't an even number of contestants, so the team challenge cannot be done.");
  }
  
}

  //DESCRIBES THE ROUND
  void describe() {
    println();
    println("****************************************************");
    println(this.name);
    println("****************************************************");
    println(this.rules);
    println();
  
  }
  
  // THE LOWEST SCORE IS ELIMINATED
  void eliminate() {
    println();
    println("****************************************************");
    println("ELIMINATION");
    println("****************************************************");
    
    if (teamstatus == true) {
      if (t1.score < t2.score) {
        println("The", t1.name, "were eliminated due to having the lowest score.");
        for (int i = 0; i < t1.members.size(); i++) {
          t1.members.get(i).getEliminated(t1.judge);
        }
        
      }
      
      else if (t2.score < t1.score) {
        println("The", t2.name, "were eliminated due to having the lowest score.");
        for (int i = 0; i < t2.members.size(); i++) {
          t2.members.get(i).getEliminated(t2.judge);
        }           
      }
      
      else {
        println("No members were eliminated because the score is tied.");
      }
      
      t1.members = new ArrayList<Contestant>();
      t2.members = new ArrayList<Contestant>();
 
    }
    
    else {
      int[] scores = new int[currentContestants.size()];
      
      for (int i = 0; i < currentContestants.size(); i++) {
        scores[i] = currentContestants.get(i).score;
      }
      
      int lowestscore = min(scores);
      Contestant lowest = null;
      int lowestCount = 0;
      
      for (int i = 0; i < currentContestants.size(); i++) {
        if (currentContestants.get(i).score == lowestscore) {
          lowestCount++;
          
          if (lowestCount == 2) {
            lowest = null;
            break;
          }
          
          else if (lowestCount == 1) {
            lowest = currentContestants.get(i);
          }
        }
      }      
      
      
      if (lowest == null) {
        println("Since there was a tie in the lowest scores, no one will be eliminated.");
      }
      
      else {
        println(lowest.name, "was eliminated due to having the lowest score.");

        lowest.getEliminated(lowest.judge);
          
      }
    }
    
   
  }
  

 

}

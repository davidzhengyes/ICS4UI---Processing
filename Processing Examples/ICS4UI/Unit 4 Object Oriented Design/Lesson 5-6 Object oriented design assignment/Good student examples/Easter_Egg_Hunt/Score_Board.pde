class Score_Board{
  int [] totalScores; // all the scores and done in [0][1][2]
  String decision;
  ArrayList <Integer> firstPlace = new ArrayList();
  ArrayList <Integer> secondPlace = new ArrayList();
  ArrayList <Integer> thirdPlace = new ArrayList();  
  String[] places = {"1st", "2nd", "3rd"};
  
  Score_Board (String d){
    this.totalScores = new int [numKids];
    this.decision = d;
  }
  
  void drawEnding(){
      fill (0,255,255);
      rect (0,0,width, height);//background
      this.drawEndGame();
  }
        
  
  void drawEndGame(){
    for (int i=0; i<numKids; i++){
      totalScores[i] = countScore(i);
    }
    
    for (int i=0; i<numKids; i++){
      if (totalScores[i] ==0){
        firstPlace.add(i);
      }
    }
    
    for (int i=0; i<numKids; i++){
      if (totalScores[i] == firstPlace.size()){
        secondPlace.add(i);
      }
    }
    
    for (int i=0; i<numKids; i++){
      if (totalScores[i] ==((secondPlace.size())+(firstPlace.size()))){
        thirdPlace.add(i);
      }
    }      
      //drawing the basics
      fill(0);
      textSize(60);
      text("Winners", width/3, height/4);
      
      for (int p =0; p<3; p++){
        fill(0);
        textSize(40);
        text(places[p], width/8, (height/4)+(100*(p+1)));
      }
           
      //drawing first
      for (int i=0; i<firstPlace.size(); i++){
         fill (kids[firstPlace.get(i)].colour);
        rect((width/8)+(20*(i+5)), (height/4)+75, 10, 20);
      }
      
      //drawing second
      for (int i=0; i<secondPlace.size(); i++){
        fill (kids[secondPlace.get(i)].colour);
        rect((width/8)+(20*(i+5)), (height/4)+175, 10, 20);
       }
  
      //drawing third
      for (int i=0; i<thirdPlace.size(); i++){
        fill (kids[thirdPlace.get(i)].colour);
        rect((width/8)+(20*(i+5)), (height/4)+275, 10, 20);
      }
  } 
    
  
  int countScore (int i){
    int count = 0;
    for (int j=0; j<numKids; j++){
      if (kids[j].score > kids[i].score){
          count++;
      }
    }
    return (count);
  }
}

int numPlayersAtStart = 20;
int speed = 10;
float betPerPlay = 1;
String rewardType = "winner take one"; //"winner take one" or "winner take all"


int totalPoints = 0;
int startPoints = 100;
float diameter;

boolean printVals = false;

ArrayList<Player> players;

void setup() {
  size(500, 500);
  diameter = 0.8*width;
  frameRate( speed );
  textSize(30);
  
  players = new ArrayList<Player>();
  
  for(int i=0; i < numPlayersAtStart; i++) {
    Player x = new Player(color(random(0,255), random(0,255), random(0,255))); 
    players.add( x );
    totalPoints += startPoints;
  }
}


void draw() {
  playOneRound();
  drawPieGraph();
  eliminateBrokePlayers();
  
  if( players.size() == 1) {
    text("Game over", width/2, height/2);
    noLoop();
  }
}


void playOneRound() {
  float maxSoFar = 0;
  Player bestPlayerSoFar = players.get(0);
  
  for( Player p : players ) { 
    if( rewardType == "winner take all" )
      p.points -= betPerPlay;
    
    float rand = p.getRandomScore();
    if (rand > maxSoFar) {
      maxSoFar = rand; 
      bestPlayerSoFar = p;
    }
  }
  
  if( rewardType == "winner take all" )
    bestPlayerSoFar.points += players.size() * betPerPlay;
    
  else if( rewardType == "winner take one" ) {
    bestPlayerSoFar.points += betPerPlay;
    //totalPoints += costToPlay;
  }
  
  for( Player p : players ) {
    p.setPieAngle();
    if( printVals) println(p.points + "\t\t" + p.pieAngle+ "\t\t" + totalPoints);
  }
  
  println();
}


void drawPieGraph() {
  float lastAngle = 0;
  for (Player p: players) {
    fill(p.col);
    arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle +p.pieAngle );
    lastAngle += p.pieAngle;
  }
}


void eliminateBrokePlayers() {
  int i = 0;
  while( i < players.size() ) {
    Player p = players.get(i);
    
    if( p.points <= 0 )
      players.remove( p );
      
    else
      i++;
  }
}

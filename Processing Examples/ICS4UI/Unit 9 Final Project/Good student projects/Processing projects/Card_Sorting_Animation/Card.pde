class Card {
  float x, y;
  PImage img;
  int sortValue;
  String name;
  int randomizedValue;
  
  Card(float x, float y, PImage p, String n) {
    this.x = x;
    this.y = y;
    this.img = p;
    this.name = n;
    this.sortValue = getValue();
    this.randomizedValue = round(random(1,1000));
  }
  
  void drawMe() {
    fill(240);
    rect(this.x, this.y, cardWidth, cardHeight);
    
    image(this.img, this.x, this.y, cardWidth, cardHeight);
    
    noFill();
    rect(this.x, this.y, cardWidth, cardHeight);
  }
  
  
  int getValue() {
    String[] parts = this.name.split("_");
    String rank = parts[0]; 
    int rankNum;
    
    if( rank.equals("jack") )
      rankNum = 11;
      
    else if( rank.equals("queen") )
      rankNum = 12;
      
    else if( rank.equals("king") )
      rankNum = 13;
      
    else if( rank.equals("ace") )
      rankNum = 14;
      
    else 
      rankNum = int(rank);
    
    String suit = parts[2];
    int suitValue;

    if( suit.equals("clubs.png") )
      suitValue = 1;
      
    else if( suit.equals("diamonds.png") )
      suitValue = 2;
      
    else if( suit.equals("hearts.png") )
      suitValue = 3;
      
    else
      suitValue = 4;
      
      
    return (rankNum-2)*4 + suitValue;
  }
}

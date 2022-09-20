void setup() {
  String x = "abcde"; 
  println(interlace(x, "Z"));
  printAllOrderings( x, "");
  //println("d".substring(0,1));
  exit();
}
 
void printAllOrderings( String players, String currentOrderings){
  if( players == "" ) {
    printArray( currentOrderings.split(",") );
  }
  
  else {
    String nextOrderings = "";
    String nextPlayer = players.substring(0, 1);
    String[] currentOrderingsArray = currentOrderings.split(",");
    
    for (int i=0; i<currentOrderingsArray.length; i++){
      nextOrderings += interlace(currentOrderingsArray[i], nextPlayer) + ",";
    }
    
    String remainingPlayers;
    if(players.length() > 1)
      remainingPlayers = players.substring(1);
    
    else
      remainingPlayers = "";
       
    printAllOrderings( remainingPlayers, nextOrderings );
  }
}


String interlace(String s, String c) {
  String interlacing = "";
  int n = s.length()+1;
  
  for(int i=0; i < s.length(); i++) {
    String firstSection = s.substring(0, i);
    interlacing += firstSection + c + s.substring(i) + ",";
  }
  
  interlacing += s + c;
  return interlacing;
}

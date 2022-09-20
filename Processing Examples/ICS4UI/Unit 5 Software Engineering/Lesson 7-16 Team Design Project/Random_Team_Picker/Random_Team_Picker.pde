String[] ppl = {"Syed", "Audrey", "Ameera", "Stephen", "Jay", "Callum", "Aiden", "Dennis", 
"Sarah B", "Sarah K", "Sohil", "Vithushan", "Emre", "Marcus", "Moid", "Jeffrey", "Raymond", "Nancy", 
"Nethara", "Kegen", "Minseo"};

void setup() {
  ArrayList<String> ppl2 = new ArrayList<String>();
  
  for( String p : ppl ) {
    ppl2.add(p);
  }
  int count = 1;
  while( ppl2.size() > 0 ) {
    print("Team", count + ":\t" );
    for(int i = 0; i < 3; i++) {
      int rand = round(random(0, ppl2.size()-1));
      String victim = ppl2.get( rand );
      print(pad(victim) + "\t");
      ppl2.remove(victim);
    }
    count++;
    
    println();
  }
}

String pad(String n) {
  String finalName = n;
  
  while( finalName.length() < 10 ){
    finalName = finalName + " ";
  }
  
  return finalName;
}

void setup(){
  //alternative to arrays, arraylist
  
  int[]x={6,1,0,-2};
  
  println(x[3]);
  
  String[] placesfIveLived={"Canada","USA","Germany","Austria"};
  
  ArrayList<String> placesIveLived = new ArrayList<String>();
  
  placesIveLived.add("canada");
  placesIveLived.add("USA");
  placesIveLived.add("Austria");
  
  println("I've lived in",placesIveLived.get(1));
  
  for (int i=0; i<placesIveLived.size(); i++){
    println("ive lived in", placesIveLived.get(i));
  }
  
  placesIveLived.add("Braz");
  placesIveLived.remove(0);
  
  for (int i=0; i<placesIveLived.size(); i++){
    println("ive lived in", placesIveLived.get(i));
  }
  
  int t=int(random(0,placesIveLived.size()));
  placesIveLived.get(t);
}

void setup() {
  
  //Arrays vs. Lists
  //Use an ARRAY when the number of items is known and fixed
  //Use a LIST when the number of items will grow or shrink over time
  
  //ArrayList is a data structure that can lengthen or grow over time
  ArrayList<String> placesIveLived = new ArrayList<String>();  //This makes an empty list ready for filling
  placesIveLived.add("USA");
  placesIveLived.add("Austria");
  placesIveLived.add("Canada");
  
  for( int i = 0; i < placesIveLived.size(); i++ )
    println( placesIveLived.get(i) );
    
  placesIveLived.add("Germany");
  placesIveLived.remove("USA");
  println();
  
  for( int i = 0; i < placesIveLived.size(); i++ )
    println( placesIveLived.get(i) );

}

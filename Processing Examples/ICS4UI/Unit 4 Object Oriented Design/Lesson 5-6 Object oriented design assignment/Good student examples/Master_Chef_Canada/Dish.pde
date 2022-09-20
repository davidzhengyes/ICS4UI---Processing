class Dish {
  //FIELDS
  String name = "";
  String main;
  String side1;
  String side2;
  String sauce;
  
  int difficulty;
  int creativity;
  

  //CONSTRUCTORS
  //Savoury dish
  Dish(String m, String s1, String s2, String s, int d, int cre) {
    this.main = m;
    this.side1 = s1;
    this.side2 = s2;
    this.sauce = s;
    this.difficulty = d;
    this.creativity = cre;
  }
  
  //DESSERT
  Dish(String n, int d, int cre) {
    this.name = n;
    this.difficulty = d;
    this.creativity = cre;    
  }

  void addDish () {
    dishes.add(this);
  }
  
}

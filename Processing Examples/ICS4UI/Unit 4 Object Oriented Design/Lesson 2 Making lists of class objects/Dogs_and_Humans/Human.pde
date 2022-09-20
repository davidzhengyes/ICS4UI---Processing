class Human {
  String name;
  int numYearsInBiz;
  ArrayList<Dog> dogsIown;
  
  //Constructor
  Human(String n, int ny) {
    this.name = n;
    this.numYearsInBiz = ny;
    this.dogsIown = new ArrayList<Dog>();//This creates space in RAM for an empty list of Dog objecst
  }
  
  void adopt( Dog d ) {  
    d.owner = this;  
    dogsIown.add( d );
  }
  
  void listAllDogs() {
    for( Dog d : this.dogsIown ) {
      println( this.name, "owns", d.name );
    }
      
  }

}

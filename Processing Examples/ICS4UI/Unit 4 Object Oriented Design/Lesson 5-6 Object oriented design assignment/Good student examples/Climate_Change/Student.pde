class Student{
  String name;
  int age;
  
  Student(String n, int a){
     this.name = n;
     this.age = a;}
     
  void addtolist(){
    stuact.add(this);
    worldcarestat = "newstuact";
    calculateworldcare();}
   
  void printstuact(){
    for (int i = 0; i < stuact.size(); i ++){
      println(stuact.get(i).name);}}
      
  void introduce(){
    if (age == 1){
      println("My name is",name,"and I am", age,"year old. I am an aspiring climate change activist!");}
    else{
      println("My name is",name,"and I am", age,"years old. I am an aspiring climate change activist!");}}
  
  void createchange(){
    String cs;
    int change = int(random(1,5));
    if (change == 1){
      cs = "boycotting water bottle companies";}
    else if (change == 2){
      cs = "campaigning for green roofs";}
    else if (change == 3){
      cs = "educating people on public transportation";}
    else if (change == 4){
      cs = "buying used clothing to reduce textile waste";}
    else {
      cs = "ensuring my electronic waste is recycled ethically";}
    println(pullfirstname(name), "is creating change by",cs);
    worldcarestat = "changecreated";
    calculateworldcare();}
          
  String pullfirstname(String n){
    int x = n.indexOf(" ");
    String fn = n.substring(0,x);
    return fn;}
}

class Student{
  
  String name;
  int ssn;
  int grade;
  ArrayList <Course> Timetable;
  
  Student(String n, int s, int g){
    this.name=n;
    this.ssn=s;
    this.grade=g;
    this.Timetable = new ArrayList<Course>();
  }
  
  void addCourse(Course c){
    this.Timetable.add(c);
  }
  
  void printTimetable(){
    for (int i=0; i<this.Timetable.size();i++){

      println(this.Timetable.get(i).courseCode);
      
    }
  }
  
  void showInfo(){
    this.printTimetable();
    println(this.name, "ssn:" ,this.ssn);
    println("grade:", this.grade);
  }
  
}

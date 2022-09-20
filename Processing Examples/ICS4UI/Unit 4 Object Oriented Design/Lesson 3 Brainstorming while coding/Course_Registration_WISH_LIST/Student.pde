class Student {
  String name;
  Course[] timeTable;
  int courseIndex;
       
  Student(String n){
    this.name = n;
    this.courseIndex = 0;
    this.timeTable = new Course[4];
  }
  
  
  void rateTeacher(Teacher t, float cn, float meanness) {
    t.coolness += cn;
  }
  
  void printTimeTable(){
    
  }
  
  void addCourseToTimeTable( Course c ) {
    this.timeTable[ courseIndex ] = c;
    this.courseIndex++;
  }
}

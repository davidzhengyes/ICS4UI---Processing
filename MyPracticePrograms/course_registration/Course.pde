class Course{
  String courseCode;
  String teacher;
  ArrayList <Student> classList;
  Student currentStudent;
  
  Course(String c, String t){
    this.courseCode=c;
    this.teacher=t;
    this.classList = new ArrayList<Student>();
  }
  
  void addStudent(Student s){
    this.classList.add(s);
    s.addCourse(this);
  }
  
  void showAllStudents(){
    for (Student currentStudent:classList){
      print(currentStudent.name);
    }
  }
  
  
  
}

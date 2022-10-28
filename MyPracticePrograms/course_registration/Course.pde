class Course{
  String courseCode;
  
  ArrayList <Student> classList;
  Student currentStudent;
  Teacher teacher;
  
  Course(String c,Teacher t){
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

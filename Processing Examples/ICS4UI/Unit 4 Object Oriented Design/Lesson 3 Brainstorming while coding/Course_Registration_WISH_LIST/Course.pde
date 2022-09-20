class Course {
  String courseCode;
  int gradeLevel;
  Teacher t;
  int numStudents;
  ArrayList<Student> studentsRegistered;
  String period;
  
  //come back and finish
  Course(String cc, Teacher t) {
    courseCode = cc;
    this.t = t;
    studentsRegistered = new ArrayList<Student>();
  }
  
  void addStudent( Student s ) {
    studentsRegistered.add( s );
    s.addCourseToTimeTable(  );
  }
  
}

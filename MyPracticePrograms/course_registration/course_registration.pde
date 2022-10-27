void setup(){
  
  print("fnet=ma");
  Student Anton = new Student ("Anton", 3341123,13);
  
  Course computerScience = new Course ("ICS4UI", "Mr. Schattman");
  Course yogaAndMeditation = new Course ("YAM4UI", "Mr Anton");
  
  computerScience.addStudent(Anton);
  yogaAndMeditation.addStudent(Anton);
  Anton.printTimetable();
  computerScience.showAllStudents();
  yogaAndMeditation.showAllStudents();
  
  Anton.showInfo();
  
}

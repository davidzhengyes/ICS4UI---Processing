void setup(){
  
  print("fnet=ma");
  Student Anton = new Student ("Anton", 3341123,13);
  Teacher schatty = new Teacher ("Mr Schattman",39,true);
  Teacher antoun = new Teacher ("Mr Anton",99,false);
  
  //String name;
  //int age;
  //float averageRating;
  //int avgVotes;
  //boolean relativelyHappy;
  
  Course computerScience = new Course ("ICS4UI", schatty);
  Course yogaAndMeditation = new Course ("YAM4UI", antoun);
  
  computerScience.addStudent(Anton);
  yogaAndMeditation.addStudent(Anton);
  Anton.printTimetable();
  computerScience.showAllStudents();
  yogaAndMeditation.showAllStudents();
  
  Anton.showInfo();
  antoun.newVote(8);
  antoun.newVote(20);
  antoun.showRating();
  
  
  
}

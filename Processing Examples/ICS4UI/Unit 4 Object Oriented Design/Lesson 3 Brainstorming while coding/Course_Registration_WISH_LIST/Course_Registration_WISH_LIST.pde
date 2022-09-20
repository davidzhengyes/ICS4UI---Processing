void setup() {
  
  //MY "WISH-LIST" FOR THINGS I'D LIKE MY PROGRAM TO BE ABLE TO DO
  Student s1 = new Student("Angela Zhang"); 
  Student s2 = new Student("Luke Janik-Jones"); //later we'll have these 3 constructors take more arguments 

  Teacher kidd = new Teacher("Ms. Kidd", true); 
  Teacher schattman = new Teacher("Mr. Schattman", false);

  Course yam4ui = new Course("YAM4UI", talbot); //this would add yam4ui to talbot's courseLoad array
  
  yam4ui.addStudent(s1);      //this would add e1 to yam4ui's studentsRegistered list, and also add yam4ui to e1's timeTable
  s1.printTimeTable();        //would print yam4ui
  yam4ui.printClassRoster();  //would print e1
  
  e1.rateTeacher( talbot, 8, 10);
  l1.rateTeacher( schattman, 11, 2);
  
  schattman.failStudent( e1 );
  
}

//A satirical look at the American college admissions process, and the dangers Canadian seniors may incur by attempting this high-risk activity. 
//9.5 times out of 10, rated "R" for "Rejected"
//FULL SCREEN RECOMMENDED FOR EASIER READING
//Canadian version coming soon...?

//NOTE: an "extracurriculars option" was not available due to infinite possibilities, and this simulation uses more numerically stable metrics, like GPA and SAT scores.
//however, an incredibly helpful "extracurricular recommender method" can be employed to suggest extracurriculars that have been 100% proven to bolster applications to America's top colleges.
void setup() {
  exit();
  AdmissionsPanel harvard = new AdmissionsPanel("Harvard College", 5);
  AdmissionsPanel columbia = new AdmissionsPanel("Columbia College", 7);
  
  Student andre3000 = new Student("Andre-3000", true, true, 10000000, false, false, 100, 1600, 24, 1600);
  Student yusuke = new Student("Yusuke", false, false, 30000, true, true, 70, 400, 2, 400);
  Student bart = new Student("Bartholomew", true, true, 1700000000, false, true, 85, 1500, 20, 1500);  
  Student chad = new Student("Chad", false, false, 120000, false, false, 95, 1550, 19, 1600);
  Student joe = new Student("Joe", true, false, 70000, false, false, 85, 1400, 16, 1400);
  
  Teacher fish = new Teacher("Mr. Fish", "Physics", "random Tangents (both the mathematical and literary kinds)");
  Teacher schatty = new Teacher("Mr. Schattman", "Computer Science", "striding briskly through the halls");
  Teacher sniatty = new Teacher("Mr. Sniatenchuk", "Chemistry", "pole-vaulting");
  Teacher grant = new Teacher("Mr. Grant", "English", "making strange mouth-noises");
  Teacher walker = new Teacher("Ms. Walker", "Calculus", "exclaiming, 'I'm throwing you out of the nest, my little birds!'");
  Teacher webb = new Teacher("Mr. Webb", "Computer Engineering", "being a demon on the basketball court");
  
  andre3000.addTeacherRecommendation(fish, 1);
  andre3000.addTeacherRecommendation(schatty,1);
  andre3000.addTeacherRecommendation(walker,1);
  
  yusuke.addTeacherRecommendation(walker, 5);
  yusuke.addTeacherRecommendation(webb,4);
  
  chad.addTeacherRecommendation(webb, 2);
  chad.addTeacherRecommendation(grant,2);
  chad.addTeacherRecommendation(sniatty,1);
  
  joe.addTeacherRecommendation(walker,3);
  joe.addTeacherRecommendation(schatty,3);
  joe.addTeacherRecommendation(grant,3);
  
  bart.addTeacherRecommendation(walker,5);
  bart.addTeacherRecommendation(webb,4);
  bart.addTeacherRecommendation(grant,5);
  bart.addTeacherRecommendation(fish, 4);
  
  harvard.addApplicant(andre3000);
  harvard.addApplicant(yusuke);
  harvard.addApplicant(bart);
  
  columbia.addApplicant(chad);
  columbia.addApplicant(joe);
  
  for(int i=0; i<harvard.applicantList.size(); i++) {
    Student s = harvard.applicantList.get(i);
    harvard.evaluateExternal(s);
    harvard.evaluateNumbers(s);
    harvard.evaluateTeacherRecs(s);
    harvard.makeSureStudentHasntKilledAnyone(s);
    harvard.makeDecision(s);
    
    if (s.decision == true) 
      s.bragAboutAcceptance(harvard);
      
    else if (s.decision == false) {
      harvard.suggestExtracurriculars(s);
      s.rantAboutRejection(harvard);
      s.begForAcceptance(harvard);
      s.attemptBribe(harvard);
    }
  }
    
  for(int i=0; i<columbia.applicantList.size(); i++) {
    Student s = columbia.applicantList.get(i);
    columbia.evaluateExternal(s);
    columbia.evaluateNumbers(s);
    columbia.evaluateTeacherRecs(s);
    columbia.makeSureStudentHasntKilledAnyone(s);
    columbia.makeDecision(s);
    
    if (s.decision == true) 
      s.bragAboutAcceptance(columbia);
      
    else if (s.decision == false) {
      columbia.suggestExtracurriculars(s);
      s.rantAboutRejection(columbia);
      s.begForAcceptance(columbia);
      s.attemptBribe(columbia);
    }
  }
}

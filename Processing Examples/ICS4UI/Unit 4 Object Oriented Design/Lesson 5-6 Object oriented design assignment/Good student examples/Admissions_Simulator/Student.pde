class Student {
  //properties that don't count towards admissions (and thank whatever higher-order being for that)
  String name;
  
  //stats that are completely out of your control but are factored anyways (noble to a certain extent)
  boolean citizenship; //domestic or international citizenship status
  boolean legacy; //answer true only if someone in your direct family line has attended the school you're applying for
  int householdIncome; //American dollars per year (just putting Canadian is fine)
  
  //merit-based stats (technically out of your control as well because of differing household financial situations but... I'm not an AO and that would be too complicated to factor in)
  boolean disciplinaryAction; //checkbox for any school/legal trouble
  boolean hasCriminalRecord;
  
  int average; //percentage grade out of a maximum of 100%
  int sat; //out of 1600, put 0 if you didn't write it
  int satEssay; //out of 24, put 0 if you didn't write it
  int satII; //add both scores to get a total out of 1600, put 0 if you didn't write them (if at this point you're thinking, "There's another one?!" then don't worry; there's two)
  
  ArrayList<String> teacherRecs; //students can submit a maximum of three teacher references
  
  int score; //an arbitrary number value used to compare applicant merit
  boolean decision; //true for acceptance, false for rejection
  
  Student(String n, boolean c, boolean l, int $, boolean d, boolean h, int a, int sat, int satEssay, int satII) {
    this.name = n; 
    
    this.citizenship = c;
    this.legacy = l; 
    this.householdIncome = $;
    
    this.disciplinaryAction = d;
    this.hasCriminalRecord = h;
    
    this.average = a; 
    this.sat = sat; 
    this.satEssay = satEssay; 
    this.satII = satII; 
    
    this.teacherRecs = new ArrayList<String>(); 
    
    this.score = 0; 
    this.decision = false;
    
    
  }
  //likeability ranges on a scale of 1-5, how much does the teacher like you (1 being the best student he has ever taught in his lifetime)
  void addTeacherRecommendation(Teacher t, int likeability) {
    String rec = t.writeRecommendation(this, likeability);
    teacherRecs.add(rec);   
  }
  
  void begForAcceptance(AdmissionsPanel a) { //basically lose all chance of going to dream school by prostrating yourself in front of the school
    println("");
    println("*****************************************************************************************************");
    println("Hello, " +this.name+ ", this is acknowledgement from", a.institution, "about your request to matriculate.");
    println("Please keep in mind that a decision has already been made, and we will not accept reasons such as,");
    println("'The admissions office is stupid' or 'Let me in or I will tweet about you.' We receive thousands of");
    println("qualified students each year, and unfortunately cannot accomodate them all. We will ask you to please");
    println("stop calling us every day. In fact, this line should be private. How did you get this number?");
    println("*****************************************************************************************************");  
  }
  
  void attemptBribe(AdmissionsPanel a) { //self-explanatory, will need huge net worth and random chance to bribe a coach to make a strong recommendation
    println("");
    println("*****************************************************************************************************");
    if (this.householdIncome >= 10000000) {
      float chance = random(1.0);
      if (chance <= 0.05) {
        println("*hushed whisper* Hey, I'm Coach Feratu. You got the cash? Okay, I'll put in a good word for you. Remember! It's not bribery; it's quid pro quo.");
        println("*****************************************************************************************************");
        a.accept(this);
      }      
      else
        println("BREAKING NEWS:", this.name.toUpperCase(), "ARRESTED FOR BRIBERY ATTEMPT ON", a.institution.toUpperCase(), "OFFICIALS, FACING SEVERAL YEARS IN PRISON");
        println("*****************************************************************************************************");
    }    
    else { //if you're too poor, you can't make a good bribe. 
      println(this.name+ ", you trying to bribe me? With a $20 Subway Gift Card? Just get out of here, I'll pretend I never saw you.");
      println("*****************************************************************************************************");
    }
  }
      
  void bragAboutAcceptance(AdmissionsPanel a) { //tweet to rejoice!
    int s = second(); //these are to get a current timestamp for your tweet
    int m = minute();
    int h = hour();
    
    println("");
    println("*****************************************************************************************************");
    println("(1) new tweet from", this.name,"at", h+":"+m+":"+s+";");
    println("So thankful to", a.institution, "for accepting me! I'm looking forward to spending the next four years");
    println("at one of the best tennis country clubs in the country! #blessed#rich#throwbackthursday");
    println("*****************************************************************************************************");     
  }
  
  void rantAboutRejection(AdmissionsPanel a) { //tweet to despair.
    int s = second();
    int m = minute();
    int h = hour();
    
    println("");
    println("*****************************************************************************************************");
    println("(1) new tweet from", this.name,"at", h+":"+m+":"+s+";");
    println("How DARE", a.institution, "reject me! They're nothing but a corrupt, elitist tennis country club!");
    println("The admissions office is stupid!!! #mad#disgusted#cheated#throwbackthursday");
    println("*****************************************************************************************************");  
    
  }
  
}

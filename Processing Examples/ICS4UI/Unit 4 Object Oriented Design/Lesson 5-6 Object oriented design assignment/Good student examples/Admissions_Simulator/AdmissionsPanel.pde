class AdmissionsPanel { //Taken from Harvard's system, student statistics are rated on a scale of 1-4, with 1 being exceptional and 4 being nothing special. Thus, a lower score as higher chance of admission.

  String institution;
  int cutoff;
  
  ArrayList<Student> applicantList;
  
  AdmissionsPanel(String institution, int cutoff) {
    this.institution = institution; //name of institution
    this.cutoff = cutoff; //cutoff score (will accept all students that rank below this score)
    this.applicantList = new ArrayList<Student>(); 
  }
  
  void addApplicant(Student s) { //adds a new victi–applicant to the list
    this.applicantList.add(s);
  }
  
  void makeDecision(Student s) { //makes a decision based on the student's overall score
    if (s.score <= this.cutoff) {
      this.accept(s);  
      s.decision = true;
    }
    else {
      this.reject(s);  
      s.decision = false;
    }
  }
  
  void accept(Student s) { //the coveted acceptance letter
    println("");
    println("*****************************************************************************************************");
    println("Hello, " +s.name+ ", congratulations! Your results have the potential to make it to", this.institution, "!");
    println("You have been accepted conditionally, assuming you can cure cancer, maintain a full-time job,");
    println("and make a small loan of $1,000,000 to the building of our new stadium.");
    println("*****************************************************************************************************");
  }
  
  void reject(Student s) { //the dreaded rejection letter
    println("");
    println("*****************************************************************************************************");
    println("Hello, " +s.name+ ", I'm sorry to say we have not chosen you as a potential student at", this.institution, ".");
    println("Please understand that this in no way means you're not good enough for us, except that it does.");
    println("*****************************************************************************************************");  
  }
    
  void evaluateNumbers(Student s) { //evaluate the strictly numerical parts of the student's application: grades & test scores
    println("");
    println("*****************************************************************************************************");
    println("Now reviewing " + s.name + "'s standardized testing scores:");
    println("SAT Score:", s.sat);
    println("SAT-II Cumulative Score:", s.satII);
    println("SAT Essay Score:", s.satEssay);
      
    //judging SAT scores and SAT subject test scores and coming up with something snarky to say
    if (s.sat == 0 || s.satII == 0 || s.satEssay == 0) {
      println("You can't apply without SAT, SAT Essay, and SAT-II scores. Potential applicants to our illustrious institution must show their ability to waste their time on redundant endeavours.");
      s.score += 9001;
    }    
    else if (s.sat < 400 || s.sat > 1600 || s.sat % 10 != 0) {
      println("Wha... how... an SAT score of " +s.sat+ " shouldn't be possible... I tip my hat to you, for achieving the impossi–oh wait, you're lying.");
      s.score += 9001;
    }    
    else if (s.sat == 1600) {
      println("Holy mother of god! A p-p-perfect SAT score! This reminds me of the time I found a four-leaf-clover - it was simultaneously thrilling and wasn't worth all the hours of effort!");
      
      if (s.satII < 400 || s.satII > 1600 || s.satII % 10 != 0) {
        println("Wha... how... an SAT-II score of " +s.satII+ " shouldn't be possible... I tip my hat to you, for achieving the impossi–oh wait, you're lying.");
        s.score += 9001;
      }
      else if (s.satII == 1600) {
        println("Seriously?? Perfect subject tests too?? Whaddaya say you join me instead of going to college? You'd make it big in the robot world!");
        s.score+=1;
      }
      else if (s.satII >= 1500) {
        println("Nice subject test scores too. Not quite a robot, but getting there.");
        s.score+=2;
      }
      else {
        println("Pretty much everyone with your scores gets in. Except the ones that don't.");
        s.score+=2;  
      }   
      println("Oh yeah, thanks for writing the SAT Essay, too. We don't really look at it, we just like wasting your time.");
    }    
    else if (s.sat >= 1500) {
      println("You've checked the box. Move on, never look at another SAT prep book again, never go back to that living nightmare."); 
      
      if (s.satII < 400 || s.satII > 1600 || s.satII % 10 != 0) {
        println("Wha... how... an SAT-II score of " +s.satII+ " shouldn't be possible... I tip my hat to you, for achieving the impossi–oh wait, you're lying.");
        s.score += 9001;
      }
      else if (s.satII == 1600) {
        println("Perfect subject tests, huh? Why couldn't you do this on the regular SAT? Just kidding. Seriously, don't go back.");
        s.score+=2;
      }
      else if (s.satII >= 1500) {
        println("Pretty much everyone with your scores gets in. Except the ones that don't.");
        s.score+=2;
      }
      else {
        println("Pretty much everyone with your scores gets in. Except the ones that don't.");
        s.score+=3;
      }        
      println("Oh yeah, thanks for writing the SAT Essay, too. We don't really look at it, we just like wasting your time.");
    }    
    else if (s.sat >= 1400) {
      println("*chuckles* you're in the dreaded grey area. If you want to be absolutely safe, may as well retake the SAT");
      
      if (s.satII < 400 || s.satII > 1600 || s.satII % 10 != 0) {
        println("Wha... how... an SAT-II score of " +s.satII+ " shouldn't be possible... I tip my hat to you, for achieving the impossi–oh wait, you're lying.");
        s.score += 9001;
      }
      else if (s.satII == 1600) {
        println("Perfect subject tests, huh? Why couldn't you do this on the regular SAT? Just kidding. Seriously, don't go back.");
        s.score+=3;
      }
      else if (s.satII >= 1500) {
        println("Pretty much everyone with your scores gets in. Except the ones that don't.");
        s.score+=3;
      }
      else {
        println("Pretty much everyone with your scores gets in. Except the ones that don't.");
        s.score+=4;
      }       
      println("Oh yeah, thanks for writing the SAT Essay, too. We don't really look at it, we just like wasting your time.");
    }    
    else if (s.sat >= 400) {
      println("If you get rejected, your SAT score of " +s.sat+ " will be one of the reasons. Focus on the SAT before you move on to anything else.");
      s.score+=4;
    }
    println("*****************************************************************************************************");  
    
    //judging the student's school average
    println("");
    println("*****************************************************************************************************");
    println("Now reviewing " +s.name+"'s school performance:");
    println("Cumulative school average: " + s.average);
    
    if (s.average > 100 || s.average < 70) {
      println("Wow. Uh, I don't really know what to say. Martha! Can you come take a look at this one?");
      println("...");
      println("...");
      println("Yeah, I thought so too. This is bogus.");
      s.score+=9001;
    }   
    else if (s.average == 100) {
      println("This perfect school average is a testament to " +s.name+ "'s undying commitment to nothing but the finest of academic standards...");
      println("... Hm? Another 100 average? Oh come on, Martha, I just finished coming up with something to say for " +s.name+" here!");
      s.score+=1;
    }    
    else if (s.average >= 90) {
      println("Outstanding grades, " +s.name+ ". Now work hard to make them seem like the least impressive thing about you.");
      s.score+=2;
    }    
    else if (s.average >= 80) {
      println("Hm. Respectable grades, no doubt. You're going to need a little more, though. Try improving that GPA a bit more... and simultaneously become an entrepeneur based in Silicon Valley.");
      s.score+=3;
    }   
    else {
      println("Hmm... yes.. mhm... well, good luck!");
      s.score+=4;
    }
    println("*****************************************************************************************************");  
  }
  
  void evaluateExternal(Student s) { //evaluate the student's background (citizenship & financial status, connections to the university, etc) 
    println("");
    println("*****************************************************************************************************");
    println("Now examining "+s.name+"'s background:");
 
    println("");
    
    //Americans have a much better chance of getting into American colleges... for top colleges, that chance is 3x higher than their international counterparts. 
    if (s.citizenship == true) {
      println(s.name+"'s Citizenship: American");
      println("Listen, just because you grew up here doesn't mean I'll play by your rules... that being said... take your tripled admissions chances."); 
    }
    
    else {
      println(s.name+"'s Citizenship: International");
      println("Oh, you're not from around here, are ya, stranger? This application pool ain't big enough for two people trying to make a big splash.");
      s.score += 3;
    }

    println("");

    //Using the numbers from the infamous Harvard-Asian Community lawsuit, it seems that legacy applicants are 5x more likely to gain acceptance at top American colleges.
    if (s.legacy == true) { //legacy refers to either applicant's parent having attended the college in question
      println(s.name+"'s Legacy status: eligible");
      println("So, one of your parents attended", this.institution, "or something? Well, I'll have you know that doesn't make ANY difference at all. We pride ourselves on ACADEMIC INTEGRITY after all.");
      println("... now of course, I think your application does deserve a second look. And that has nothing to do with the fact that your dad just paid for our new building.");
      s.score -=5;
    }   
    else {
      println(s.name+"'s Legacy status: non-eligible");
      println("It's okay if your parents didn't attend " +this.institution+ ". After all, all of our students deliver exceptional donatio–ahh, err... talent, in some way!");
      s.score -= 1;
    }    

    println("");

    //Applicants from both extremely disadvantaged and extremely privileged households have a far higher chance of admissions entry than an otherwise equal candidate from an average household
    if (s.householdIncome <= 70000) {
      println(s.name+"'s household income of", s.householdIncome, "is below the US average, so our admissions decision will adjust for that disadvantage.");
      s.score -= ((-1*s.householdIncome) / 17500) + 5; //Linear function, set so low-income households can realistically receive up to 4x more preference compared to the average household
    }
    else
      println(s.name+"'s household income is above the US average. Obviously, such households shouldn't be given preferential treatment. So nothing will happen. On paper, that is.");
      //Just kidding. Statistically, richer households get preferential treatment because of donations that mysteriously appear once their kids get accepted.
      s.score -= 4/(1+exp(-0.000001*(s.householdIncome-2500000))) + 1; //Tweaked a logistic function to what I thought was a reasonable representation:
                                                                       //admissions chances double for children of millionaires, and can quintuple after a certain point (~10 million and up)
    println("*****************************************************************************************************");  
  }
  
  void makeSureStudentHasntKilledAnyone(Student s) { //checking for displinary action / criminal activity
    println("");
    println("*****************************************************************************************************");
    println("Now reviewing " +s.name+"'s legal file:");
    if (s.disciplinaryAction == true) { 
      println("Woah, this kid has really been roughing things up! In-school suspension for calling their teacher a fat loser? I'm going to have to subtract points for that...");
      s.score+=5;
    }
    else
      println("Spotless Record! To be expected, of course. Don't start thinking you're special, kid.");

    if (s.hasCriminalRecord == true) { //Top colleges don't really accept criminals... at least, that I've heard of
      println(s.name, "wrote his Common App Essay about his experiences shoplifting and how he learned to be a more giving person... who does he think he is, Robin Hood??");
      s.score += 9001;
    }
    else
      println("A clean student, no blood on the hands. Just how I like 'em.");
      
    println("*****************************************************************************************************");  
  }
  
  void evaluateTeacherRecs(Student s) { //evaluate the student's list of teacher recommendations
    println("");
    println("*****************************************************************************************************");
    println("Now reviewing " +s.name+"'s teacher recommendations:");
    
    if (s.teacherRecs.size() < 3) { //didn't submit enough teacher recs, so application is no longer considered
      println("Okay, let's get this over with... wait, what? *yells* Martha! Did you lose one again? Well that's a shame... I guess can turn in early tonight.");
      s.score += 9001;
    }
    
    else {
      println("Okay, let's get this over with:"); //read through teacher recs in a sequence
      for (int i=0; i<3; i++) {
        println(s.teacherRecs.get(i));
        println("Hmm... mhm... okay...");
      }
      if (s.teacherRecs.size() > 3) { //this block will run if the student thought more == better (hint: !=) 
      println("I want you to know that you are our least favourite kind of person. Just because we SAY there's no limit doesn't mean there isn't one – take the hint!"); 
      s.score += 2;
      }
    }
    
    println("*****************************************************************************************************");  
  }
  
  void suggestExtracurriculars(Student s) { //some extremely helpful suggestions to bolster one's application
    println("");
    println("*****************************************************************************************************");
    println(s.name, ", while we at", this.institution, "realize that a rejection may be disappointing, keep in mind that grades are the only metric of your worth.");
    println("In order to help you reach your dream school, we have compiled a list of several potential extracurricular activities that, if completed, will guarantee your acceptance to any school:");
    
    println("\t- Win an international fencing title"); 
    println("\t- Recover the crumbling Greek economy");
    println("\t- Reinstate peaceful relations between North and South Korea");
    println("\t- Become the first teenager on the Moon");
    println("\t- Implement a failsafe protocol to cure global pandemics"); 
    
    println("*****************************************************************************************************");  
  }
   
}

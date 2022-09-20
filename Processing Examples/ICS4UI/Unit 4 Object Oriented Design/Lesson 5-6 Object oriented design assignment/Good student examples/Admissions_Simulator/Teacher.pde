class Teacher { 
  String name;
  String subject;
  String expertise;
  
  Teacher(String n, String c, String e) { // teachers get a name, subject, and some statement that reflects their expertise
    this.name = n;
    this.subject = c;
    this.expertise = e;
  }
  
  String writeRecommendation(Student s, int a) { //teachers change their recommendations based on the parameter "a", which is how much they like their students on a scale of 1-5 (1 being the best)
    
    if (a==1) {
      s.score += a;
      return "My name is "+this.name+", I teach "+this.subject+", and as an expert on "+this.expertise+", "+s.name+" is the greatest student I have ever taught in my lifetime!"; 
    }
    else if (a==2) {
       s.score += a;
      return "My name is "+this.name+", I teach "+this.subject+", and as an expert on "+this.expertise+", "+s.name+" is one of my favourite students.";   
    }
    else if (a==3) {
       s.score += a;
      return "My name is "+this.name+", I teach "+this.subject+", and as an expert on "+this.expertise+", "+s.name+" is an all-around excellent guy.";
    }
    else if(a==4) {
       s.score += a;
      return "My name is "+this.name+", I teach "+this.subject+", and as an expert on "+this.expertise+", "+s.name+" is probably pretty good, although I don't really know why he asked me for a reference because I barely know him.";
    }
    else {
       s.score += a;
      return "My name, background, or expertise doesn't matter: DO NOT TAKE THIS STUDENT UNDER ANY COST. I HATE this person!";
    }
  }
  
}

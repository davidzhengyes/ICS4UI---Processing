class Teacher{
  String name;
  int age;
  float averageRating;
  int avgVotes;
  boolean relativelyHappy;
  
  
  
  Teacher(String n,int a,  boolean r){
    this.name=n;
    this.age=a;
    this.averageRating=0;
    this.relativelyHappy=r;
    this.avgVotes=0;
  }
  
  void newVote(int rating){
    averageRating = (rating + averageRating*avgVotes)/(avgVotes+1);
    avgVotes++;
  }
  
  void showRating(){
    print(this.name,"has a rating of" ,averageRating,"over",avgVotes,"votes");
  }
  
  void failStudent(Student s){
    
    
  }
  
}

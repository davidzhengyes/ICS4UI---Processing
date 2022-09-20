class StudentLeader{
 String name;
 String country;
 int age;
 
 StudentLeader(String n, String c,int a){
   this.name = n;
   this.country = c;
   this.age = a;
 }
 
 void speakatevent(){
   if (stuact.size() > 0){
     println("Hi. My name is", name, "and I am a climate activist from", country+". Here are some other activists I know:",listfellowstudents());}
   else{
     println("Hi. My name is", name, "and I am a climate activist from", country+".");}
   println("I have some good news and some bad news regarding the climate emergency. I will start with the good news. The world, as a small number of people have been saying lately, will not end in 11 years. The bad news however is that around the year 2030, if we continue with business as usual, we will likely be in a position where we may pass a number of tipping points. And then we might no longer be able to undo the irreversible climate breakdown.");
   worldcarestat = "speech";
   calculateworldcare();}
    
 void studentstrike(){
   if (stuact.size() > 0){
     println("Today, we report that",stuact.size(),"students have skipped school to strike for climate change awareness. They are lead by",name,"from",country+".");
     worldcarestat = "strike";
     calculateworldcare();}}     
    
 String listfellowstudents(){
   int a = int(random(0,stuact.size()));
   int b = int(random(0,stuact.size()));
   int c = int(random(0,stuact.size()));
   while ((a == b) || (a == c) || (b == c)){
     a = int(random(0,stuact.size()));
     b = int(random(0,stuact.size()));
     c = int(random(0,stuact.size()));}
   String as = stuact.get(a).name;
   String bs = stuact.get(b).name;
   String cs = stuact.get(c).name;
   String list = as+", "+bs+", and "+cs+".";
   return list;}
 
}

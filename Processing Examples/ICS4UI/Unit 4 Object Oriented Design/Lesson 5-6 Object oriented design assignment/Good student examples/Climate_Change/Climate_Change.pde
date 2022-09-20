ArrayList<Student>stuact;
float worldcare = 30.0;
String worldcarestat;
ArrayList<BudgetSect> budget;
boolean printonscreen = false;
 
void calculateworldcare(){
  if (worldcare == 100){}
  else{
    if (worldcarestat.equals("ignored")){
      worldcare -= 5;}
    else if (worldcarestat.equals("statment")){
      worldcare += 0.5;}
    else if ((worldcarestat.equals("newstuact"))||(worldcarestat.equals("changecreated"))|| (worldcarestat.equals("care"))){
      worldcare += 1;}
    else if ((worldcarestat.equals("speech"))||(worldcarestat.equals("strike"))){
      worldcare += 5;}}}

void printworldcare(){
  if (worldcare == 100){
    println("The World Care Meter is full! Isn't that great?");}
  else{
    println(worldcare+"% of people care about our environment.");}}
 
void setup(){
  size(600,600);
  stuact = new ArrayList<Student>();
  StudentLeader greta = new StudentLeader ("Greta Thunberg", "Sweden", 16);
  Student tabitha = new Student ("Tabitha Wong", 17);
  Student eric = new Student("Eric Yu",17);
  Student nabeeha = new Student ("Nabeeha Khan", 17);
  Student olivia = new Student("Olivia Swart",17);
  Student janelle = new Student("Janelle Pretti", 17);
  Student mia = new Student("Mia Lazic", 17);
  Student miranda = new Student("Miranda Perezcano", 17);
  GovLeader justin = new GovLeader ("Justin Trudeau","Canada");
  GovLeader donald = new GovLeader ("Donald Trump", "USA");
  tabitha.addtolist();
  olivia.addtolist();
  nabeeha.addtolist(); 
  mia.addtolist();
  miranda.addtolist();
  janelle.addtolist();
  eric.addtolist();
  donald.ignore();
  justin.care();
  justin.introduce();
  eric.introduce();
  nabeeha.createchange();
  greta.speakatevent();
  greta.studentstrike();
  printworldcare();
  justin.createbudget();
  donald.createbudget();

 //do not delete!
 if (printonscreen == false){
   exit();}
}

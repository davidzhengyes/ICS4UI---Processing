class GovLeader {
  String name;
  String country;
  Boolean care;

  GovLeader(String n, String c) {
    this.name = n;
    this.country = c;
    this.care = false;
  }
  
  void ignore(){
    if (care == false){
    println(name,"expertly dodges questions about climate change. They have avoided eye contact.");
    worldcarestat = "ignored";
    this.care = false;
    calculateworldcare();}}
    
  void makestatement(){
    println("My name is ", name);
    println("We have a national climate plan that will reduce our emissions and hit our 2030 targets in a way that also includes getting a better price for our oil resources that allows us to put the profits directly into the fight against climate change.");
    worldcarestat = "statement";
    calculateworldcare();}

  void care(){
    this.care = true;
    worldcarestat = "care";
    calculateworldcare();}
    
  void introduce(){
    String carestatement;
    if (this.care){
      carestatement = "care";}
    else{
      carestatement = "don't care";}
    println("My name is",name,"from", country,"and I", carestatement,"about climate change!");}
    
  void createbudget(){
    noStroke();
    String[] names = {"Environment","Education","Health Care","Defense","Transportation","Government"};
    budget = new ArrayList<BudgetSect>();
    if (care){
      float [] values1 = {30,20,20,5,10,15};
      BudgetSect en = new BudgetSect(names[0],values1[0]);
      BudgetSect ed = new BudgetSect(names[1],values1[1]);
      BudgetSect hc = new BudgetSect(names[2],values1[2]);
      BudgetSect d = new BudgetSect(names[3],values1[3]);
      BudgetSect t = new BudgetSect(names[4],values1[4]);
      BudgetSect g = new BudgetSect(names[5],values1[5]);
      budget.add(en);
      budget.add(ed);
      budget.add(hc);
      budget.add(d);
      budget.add(t);
      budget.add(g);
      drawbudget(values1);}
    else{
      float [] values2 = {10,10,30,5,20,25};
      BudgetSect en = new BudgetSect(names[0],values2[0]);
      BudgetSect ed = new BudgetSect(names[1],values2[1]);
      BudgetSect hc = new BudgetSect(names[2],values2[2]);
      BudgetSect d = new BudgetSect(names[3],values2[3]);
      BudgetSect t = new BudgetSect(names[4],values2[4]);
      BudgetSect g = new BudgetSect(names[5],values2[5]);
      budget.add(en);
      budget.add(ed);
      budget.add(hc);
      budget.add(d);
      budget.add(t);
      budget.add(g);
      drawbudget(values2);}
    println("This is the Budget under",name+"'s government:");
    for (int x = 0; x < names.length; x++){
      println(budget.get(x).name+":",budget.get(x).percentage+"%");}}

  void drawbudget(float[] v){
    printonscreen = true;
    float onedegree = radians(360/100);
    color[] colours = {color(255,0,0),color(0,255,0),color(0,0,255),color(255,165,0),color(255,255,0),color(255,0,255)};
    float[] endangles = {v[0]*onedegree,v[0]*onedegree+v[1]*onedegree,v[0]*onedegree+v[2]*onedegree+v[1]*onedegree,v[0]*onedegree+v[3]*onedegree+v[2]*onedegree+v[1]*onedegree,v[0]*onedegree+v[4]*onedegree+v[3]*onedegree+v[2]*onedegree+v[1]*onedegree,v[0]*onedegree+v[5]*onedegree+v[4]*onedegree+v[3]*onedegree+v[2]*onedegree+v[1]*onedegree};
    float[] startangles = {0,endangles[0],endangles[1],endangles[2],endangles[3],endangles[4]};
    circle(300,300,300);
    for (int i = 0; i < 6; i++){
      fill(colours[i]);
      arc(300,300,300,300,startangles[i],endangles[i]);}
    printArray(startangles);
    println("");
    printArray(endangles);}}

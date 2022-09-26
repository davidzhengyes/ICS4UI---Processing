void setup() {
  
 PrintWriter pw = createWriter("easy.txt");
 String[] myMedalData = loadStrings("easy.txt");
 println(myMedalData);
 printArray(myMedalData);
 
 String[]  norwayRow = myMedalData[0].split(",");
 pw.println(4);
 
 pw.close();
}

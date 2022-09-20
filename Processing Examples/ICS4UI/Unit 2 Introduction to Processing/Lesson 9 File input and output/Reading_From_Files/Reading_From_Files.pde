void setup() {
  String[] myData = loadStrings("Medal counts.txt");
  PrintWriter pw = createWriter("Total Winnage.txt");
  
  for(int i=0; i<myData.length; i++) {
    String nextRow = myData[i];
    String[] thisRowsItems = nextRow.split(",");
    String countryName = thisRowsItems[0];
    int gold = int(thisRowsItems[1]);
    int silver = int(thisRowsItems[2]);
    int tin = int(thisRowsItems[3]);
    int totalMedals = gold+silver+tin;
    pw.println(countryName + " has won " + totalMedals + " total medals");
  }
  
  pw.close();
}

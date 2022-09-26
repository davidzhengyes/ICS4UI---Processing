float total;
void setup(){
  
  PrintWriter pw = createWriter("howmuchrain.txt");
  
  String[] rainData= loadStrings ("howmuchrain.txt");
  
  for (int i=0; i<rainData.length;i++){
    
    
    String[] cityData=rainData[i].split(",");
    String[] cityNameandvalue = cityData[0].split(": ");
    cityData[0]=cityNameandvalue[1];
    
    
    total=0;
    for (int n=0; n<cityData.length;n++){
      
      total=total+float(cityData[n]);    
      
    }
    
    pw.println(cityNameandvalue[0]+ " had an average of "+str(total/cityData.length)+" mm of rain recently");
    
    
  }
  
  pw.close();
 
}

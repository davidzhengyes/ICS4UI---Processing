

void setup(){
  size(800, 800);
  
  for(int i = 1; i < numRows + 1; i++){
    String nextRowToPrint = str(i) +  " = " + getSummation(i);
    summations[i-1], nextRowToPrint);
  }
  drawSummationsOnScreen();
}

void drawSummationsOnScreen(){
  int yRow = 30;
  
  for(int i = 0; i < numRows; i++){
    fill(255, 255, 0);
    text(summations[i], 50, yRow);
  }
}

String getSummation(int n){
  if(n == 1)
    return "Can't be done";
  
  else if(n % 2 == 1){
    int halfN = int(n / 2);
    return makeSumString(halfN, halfN + 1);
  }
  
  else{
    int x = n;
    
    while (x % 2 == 0)
      x = x / 2;
    
    if(x > 1){
      int anchor = int(n / x);
      int start = anchor - int(x / 2);
      int end = anchor + int(x / 2);
      if (start <= 0)
        start = -1 * start + 1;
      
      return makeSumString(start, end);
    }
    
    else
      return "Can't be done";    
  } 
}

String makeSumString(int start, int end){
  String sumString = "";
  
  for(int x = start; x < end + 1; x++){
    if(x != end)
      sumString = sumString + str(x) + " + ";
    
    else
      sumString = sumString + str(x);
  }
 return sumString;
}

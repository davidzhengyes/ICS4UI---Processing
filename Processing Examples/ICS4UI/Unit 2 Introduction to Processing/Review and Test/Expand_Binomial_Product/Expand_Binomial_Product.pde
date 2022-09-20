String prod = "(5x+6)(x-4)";

void setup() {
  //println(multBinomials(prod));
  String[] myRows = loadStrings("My products.txt");
  int n = myRows.length;
  
  for(int i=0; i<n; i++) {
    String nextRow = myRows[i];
    String[] binomials = nextRow.split(",");
    String prod = binomials[0]+binomials[1];
    println(multBinomials(prod));
  }
}

String multBinomials(String prod) {
  int a, b, c, d;

  int xIndex = prod.indexOf("x");
  
  if (xIndex == 1)
    a = 1;
    
  else
    a = int(prod.substring(1, xIndex));
  
  int bracketIndex = prod.indexOf(")(");
  b = int(prod.substring(xIndex+1, bracketIndex));    
  String rest = prod.substring(bracketIndex+2);  
  int xIndex2 = rest.indexOf("x");
  
  if (xIndex2 == 0)
    c = 1;
    
  else
    c = int(rest.substring(0, xIndex2)); 
    
  int bracketIndex2 = rest.indexOf(")");
  d = int(rest.substring(xIndex2+1, bracketIndex2));

  int A = a*c;
  int B = a*d+b*c;
  int C = b*d;
  
  String strA, strB, strC;
  
  if (A==1)
    strA = "x^2";
    
  else if (A==-1)
    strA = "-x^2";
    
  else
    strA = str(A)+"x^2";
    
    
  if (B==1)
    strB = "+x";
    
  else if (B==0)
    strB = "";
    
  else if (B==-1)
    strB = "-x";
    
  else if (B > 0)
    strB = "+" + str(B) + "x";
    
  else
    strB = str(B) + "x";
    
    
  if (C > 0)
    strC = "+" + str(C);
    
  else
    strC = str(C);  
  
  return strA + strB + strC;
}

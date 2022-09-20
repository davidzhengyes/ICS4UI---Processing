String[] letters = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
String[] digits = {"0","1","2","3","4","5","6","7","8","9"};


//********************************************************************************************
void setup() {
  String pw1 = "CSis#1";          //Bad! Not long enough
  String pw2 = "ILOVEEXAMS";           //Bad! No lower-case letters
  String pw3 = "mrSchattmanIsAwesome";      //Bad! No digits
  String pw4 = "easyAs123";       //Bad! Contains 123
  String pw5 = "now1saidMYabcs";       //Bad! Contains abc
  String pw6 = "ICS4UIisCoolerThanSPH4UI";       //Good! (And also true)

  String[] passwordsToTry = {pw1, pw2, pw3, pw4, pw5, pw6};
  for( String p : passwordsToTry ) {
    println( isGoodPassword(p));
  }

  //Add code here to test the above passwords and print the results
}

boolean isGoodPassword(String p) {
  boolean hasLetter, hasDigit;
  int L = p.length();
  if( L < 8 )
    return false;
    
  else {
    hasLetter = false;
    hasDigit = false;
   
    for(int i=0; i < L; i++){
      for(int j=0; j < 26; j++) {
        if (p.substring(i, i+1).equals(letters[j]))
          hasLetter = true;
      }
      for(int j=0; j < 10; j++) {
        if (p.substring(i, i+1).equals(digits[j])) {
          hasDigit = true;
        }
      }
      
      if( i <= L-3 ) {
        String nextThree = p.substring(i, i+3);
      
        if (nextThree.equals("123") || nextThree.equals( "abc"))
          return false;
      }
    }
  }
  
  return hasLetter && hasDigit;
}

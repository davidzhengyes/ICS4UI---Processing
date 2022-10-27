void setup(){
  String cellNum="(226) 64343443400-3273";
  int L=cellNum.length();
  String areaCode=cellNum.substring(1,4);
  String last4=cellNum.substring(L-4);
  println(last4);
  
  int spaceIndex=cellNum.indexOf(" ");
  int dashIndex=cellNum.indexOf("-");
  
  String middlegroup=cellNum.substring(spaceIndex,dashIndex);
  print(middlegroup);
  
  int aPlus=int (areaCode)+1;
  
}

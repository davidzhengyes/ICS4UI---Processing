void setup() {
  int[] a = {2,4,8,3};
  print(groupSum(a, 0, 7));
  exit();
}

boolean groupSum(int[] a, int i, int t) {
  println(i, t);
  
  if (a[i]==t)
    return true;
    
  if(i==a.length-1)
    return false;
      
  else
    return groupSum(a, i+1, t-a[i]) || groupSum(a, i+1, t);
}

int [] myMarks={92,95,61,87,97,12};

println(myMarks[3]);

for (int i=0; i<myMarks.length;i++){
  
  if(myMarks[i]>30){
    println(myMarks[i]);
  }
  
  
}



float [] x=new float[10];
float [] y=new float[10];


for (int i=0; i<10; i++){
 x[i]=3*i;
 y[i]=6*x[i]+7;
}

println(x);
println(y);

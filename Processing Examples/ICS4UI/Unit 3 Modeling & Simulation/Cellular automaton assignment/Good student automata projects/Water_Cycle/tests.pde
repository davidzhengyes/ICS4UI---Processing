//this page is to test all the cells and makes changes accordingly

void seaTest() //tests sea cells to see if it should make a vapor cell. specificly tests cells that are above a sea cell, but aren't a sea cell. there is a 5% chance to make a vapor cell
{
  int i=16;
    for (int j=0; j<8; j++) {
      try{
      
        for (int a=-1; a<2; a++){  
          
         int b=0;
         if ((cells[ i + a ][ j + b ] == Sea) && ((b !=0) ||( a !=0))&&(cells[i][j]==sky)){
           int r= round(random(0,100));
           
           if (r>95){
             NextCells[i][j]=waterVapor;
           }
         }         
       }
     }
     catch(Exception e){}
   }
 }

void steamTest(){// Tests to see if a cell is a water vapor cell. if it is it will rise.(Only tests iver the sea blocks are because that is where steam forms)
  for (int i=0;i<n;i++){
    for ( int j=0;j<n;j++){
      if ((cells[i][j]==waterVapor)&&(i>3)){
          NextCells[i-1][j]=waterVapor;
          NextCells[i][j]=sky;
        
        
    
      }
    }
  }
}

void cloudTest(){ //tests if vapor is at a high enough level to become a cloud. Also tests if there are any clouds nearby if so it will migrate to them. once 3 adjacent cells are clouds it moves inland.
int i=3;
  for (int j=0; j<n;j++){
    if(cells[i][j]==cloud){ 
      try{
        if ((cells[i][j+2]==cloud)&&(cells[i][j+1]!=cloud)){
          NextCells[i][j+1]=cloud;
          NextCells[i][j]=sky;
        }
      }
      catch(Exception e){}
      
     
      try{

        int z=0;
        if ((cells[i][j-1]==cloud)&&(cells[i][j-2]==cloud)){//this version is takes all clouds
          if (cells[i][j+1]==cloud){
           
          }
          else{
            while(cells[i][j+z]==cloud){
            
                NextCells[i][j+z+1]=cloud;
            
          
            z=z-1;;
          }
          NextCells[i][j+z+1]=sky;
          }
        }
      }
        catch(Exception e){}
      
    }
    if (cells[i][j]==waterVapor){ // This is turning vapor into cloud
      NextCells[i][j]=cloud;
    }
  
  
  }
}

void rainTest(){
  int i=3;
  for ( int j=7;j<n;j++){
    if (cells[i][j]==cloud){ 
      int z = round(random(0,100));
      
      if (z>90){
        NextCells[i+1][j]=rain;
        NextCells[i][j]=sky;
      
      }
      
  
    }
   
  }
  for ( int k=4;k<n;k++){
    for ( int l=7;l<n;l++){
     
      if(cells[k][l]==rain){
        if(cells[k+1][l]==sky){
          NextCells[k][l]=sky;
          NextCells[k+1][l]=rain;
          
        }
        if(cells[k+1][l]==ground){
          cells[k][l]=River; 
        }
      
      }
    }
    
  }
  
       
}


void lakeTest(){  //This tests if rain has fallen into the lake. if so some water spills over onto the hill.
int i=12;
    for (int j=14; j<n; j++) {
      if (cells[i][j]==rain){
      NextCells[13][14]=River;
      NextCells[i][j]=sky;
      
      }
      
    }
  }
void riverTest(){    //This one makes the river physics. falling if there is sky underneath and heading to the sea. The sea is so large(off screen) that once a rive piece enters the sea nothing happens. This also explains why the water vapor isnt taking away from the sea.
  for (int i=0;i<n;i++){
    for ( int j=0;j<n;j++){
      if (cells[i][j]==River){
         if(cells[i+1][j]==sky||cells[i+1][j]==River){
          NextCells[i+1][j]=River;
          NextCells[i][j]=sky;
        }
        else if(cells[i+1][j]==Sea){
          NextCells[i][j]=sky;
        }
        else{
          NextCells[i][j-1]=River;
          NextCells[i][j]=sky;
        }
      }
    }
  }
}

void staySame(){ //this is for all the cells tgat don't change during this frame
  for (int i=0; i<n; i++) {

    for (int j=0; j<n; j++) {  
      NextCells[i][j]=cells[i][j];  
    }
  }
  
}










void testCells(){ //This runs all the tests
 staySame();
 seaTest();
 steamTest();
 cloudTest();
 rainTest();
 riverTest();
 lakeTest();
}
